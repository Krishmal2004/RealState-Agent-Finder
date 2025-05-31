package com.RealState.servlets;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.concurrent.locks.ReentrantReadWriteLock;
import java.util.logging.Level;
import java.util.logging.Logger;

@MultipartConfig
public class UserSettingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(UserSettingServlet.class.getName());
    private static final Gson gson = new GsonBuilder().setPrettyPrinting().create();

    // File paths
    private static final String USER_DATA_DIR = "C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\data";
    private static final String USER_SETTINGS_FILENAME = "userSettings.json";
    private static final String USER_DATA_FILENAME = "user.json";

    private final ReentrantReadWriteLock settingsLock = new ReentrantReadWriteLock();
    private final ReentrantReadWriteLock userDataLock = new ReentrantReadWriteLock();

    private String userSettingsPath;
    private String userDataPath;

    @Override
    public void init() throws ServletException {
        super.init();
        
        // Create data directory if it doesn't exist
        File dataDir = new File(USER_DATA_DIR);
        if (!dataDir.exists() && !dataDir.mkdirs()) {
            logger.severe("Failed to create data directory: " + USER_DATA_DIR);
            throw new ServletException("Failed to create data directory");
        }

        userSettingsPath = USER_DATA_DIR + File.separator + USER_SETTINGS_FILENAME;
        userDataPath = USER_DATA_DIR + File.separator + USER_DATA_FILENAME;

        // Initialize files if they don't exist
        initializeJsonFile(userSettingsPath);
        initializeJsonFile(userDataPath);
    }

    private void initializeJsonFile(String filePath) throws ServletException {
        File file = new File(filePath);
        if (!file.exists()) {
            try (FileWriter writer = new FileWriter(file)) {
                writer.write("[]");
            } catch (IOException e) {
                logger.severe("Failed to initialize file: " + filePath);
                throw new ServletException("Failed to initialize file: " + filePath, e);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JsonObject jsonResponse = new JsonObject();

        try {
            String action = request.getParameter("action");
            String username = request.getParameter("username");
            String currentTimestamp = getCurrentTimestamp();

            if (username == null || username.isEmpty()) {
                username = "Krishmal2004"; // Default username
            }

            switch (action) {
                case "saveProfile":
                case "updateProfile":
                    updateUserProfile(username, request, currentTimestamp);
                    break;
                case "saveSettings":
                case "updateSettings":
                    updateUserSettings(username, request, currentTimestamp);
                    break;
                case "saveAll":
                    updateUserProfile(username, request, currentTimestamp);
                    updateUserSettings(username, request, currentTimestamp);
                    break;
                default:
                    throw new IllegalArgumentException("Invalid action: " + action);
            }

            jsonResponse.addProperty("success", true);
            jsonResponse.addProperty("message", "Update successful");
            jsonResponse.addProperty("timestamp", currentTimestamp);

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error processing request", e);
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", e.getMessage());
        }

        out.print(gson.toJson(jsonResponse));
    }

    private void updateUserProfile(String username, HttpServletRequest request, String timestamp) 
            throws IOException {
        userDataLock.writeLock().lock();
        try {
            JsonArray users = readJsonFile(userDataPath);
            JsonObject userProfile = findOrCreateUser(users, username);
            
            // Update all profile fields
            updateJsonField(userProfile, "firstName", request);
            updateJsonField(userProfile, "lastName", request);
            updateJsonField(userProfile, "email", request);
            updateJsonField(userProfile, "phone", request);
            updateJsonField(userProfile, "password", request);
            updateJsonField(userProfile, "userType", request);
            
            userProfile.addProperty("lastUpdated", timestamp);
            if (!userProfile.has("registrationDate")) {
                userProfile.addProperty("registrationDate", timestamp);
            }

            writeJsonFile(userDataPath, users);
            logger.info("Updated user profile for: " + username);
        } finally {
            userDataLock.writeLock().unlock();
        }
    }

    private void updateUserSettings(String username, HttpServletRequest request, String timestamp) 
            throws IOException {
        settingsLock.writeLock().lock();
        try {
            JsonArray settings = readJsonFile(userSettingsPath);
            JsonObject userSettings = findOrCreateUserSettings(settings, username);
            
            // Update settings fields
            updateJsonField(userSettings, "theme", request);
            updateJsonBooleanField(userSettings, "notifications", request);
            updateJsonField(userSettings, "language", request);
            
            // Update preferences object
            JsonObject preferences = userSettings.has("preferences") ? 
                userSettings.getAsJsonObject("preferences") : new JsonObject();
            updateJsonBooleanField(preferences, "emailNotifications", request);
            updateJsonBooleanField(preferences, "pushNotifications", request);
            updateJsonField(preferences, "displayMode", request);
            userSettings.add("preferences", preferences);
            
            userSettings.addProperty("lastUpdated", timestamp);

            writeJsonFile(userSettingsPath, settings);
            logger.info("Updated user settings for: " + username);
        } finally {
            settingsLock.writeLock().unlock();
        }
    }

    private void updateJsonField(JsonObject obj, String fieldName, HttpServletRequest request) {
        String value = request.getParameter(fieldName);
        if (value != null && !value.isEmpty()) {
            obj.addProperty(fieldName, value);
        }
    }

    private void updateJsonBooleanField(JsonObject obj, String fieldName, HttpServletRequest request) {
        String value = request.getParameter(fieldName);
        if (value != null) {
            obj.addProperty(fieldName, Boolean.parseBoolean(value));
        }
    }

    private JsonArray readJsonFile(String filePath) throws IOException {
        try (Reader reader = new FileReader(filePath)) {
            JsonArray array = gson.fromJson(reader, JsonArray.class);
            return array != null ? array : new JsonArray();
        }
    }

    private void writeJsonFile(String filePath, JsonArray data) throws IOException {
        try (Writer writer = new FileWriter(filePath)) {
            gson.toJson(data, writer);
        }
    }

    private JsonObject findOrCreateUser(JsonArray users, String username) {
        for (JsonElement elem : users) {
            JsonObject user = elem.getAsJsonObject();
            if (user.has("username") && user.get("username").getAsString().equals(username)) {
                return user;
            }
        }

        JsonObject newUser = new JsonObject();
        newUser.addProperty("username", username);
        newUser.addProperty("createdAt", getCurrentTimestamp());
        users.add(newUser);
        return newUser;
    }

    private JsonObject findOrCreateUserSettings(JsonArray settings, String username) {
        for (JsonElement elem : settings) {
            JsonObject setting = elem.getAsJsonObject();
            if (setting.has("username") && setting.get("username").getAsString().equals(username)) {
                return setting;
            }
        }

        JsonObject newSettings = new JsonObject();
        newSettings.addProperty("username", username);
        newSettings.addProperty("createdAt", getCurrentTimestamp());
        settings.add(newSettings);
        return newSettings;
    }

    private String getCurrentTimestamp() {
        return LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }
}