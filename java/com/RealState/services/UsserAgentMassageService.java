package com.RealState.services;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.RealState.model.UserAgentMassage;

import java.io.*;
import java.lang.reflect.Type;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UsserAgentMassageService {
    private static final Logger LOGGER = Logger.getLogger(UsserAgentMassageService.class.getName());
    
    // Store the JSON file in a reliable location
    private static final String DATA_DIR = System.getProperty("java.io.tmpdir") + File.separator + "RealState";
    private static final String DATA_FILE = DATA_DIR + File.separator + "C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\data\\userAgentMassage.json";
    private static final Gson gson = new GsonBuilder().setPrettyPrinting().create();
    
    public UsserAgentMassageService() {
        // Ensure directory exists when service is initialized
        try {
            Files.createDirectories(Paths.get(DATA_DIR));
            LOGGER.info("Data directory initialized at: " + DATA_DIR);
            
            // Create empty JSON file if it doesn't exist
            if (!Files.exists(Paths.get(DATA_FILE))) {
                try (FileWriter writer = new FileWriter(DATA_FILE)) {
                    writer.write("[]");
                    LOGGER.info("Created empty JSON file at: " + DATA_FILE);
                }
            }
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Failed to initialize data directory", e);
        }
    }

    /**
     * Saves a message to the JSON file
     */
    public boolean saveMessage(UserAgentMassage message) {
        try {
            // Read existing messages
            List<UserAgentMassage> messages = getAllMessages();
            
            // Set unique ID for the new message
            int newId = 1;
            if (!messages.isEmpty()) {
                // Find highest ID and increment
                int maxId = 0;
                for (UserAgentMassage m : messages) {
                    if (m.getMessageId() > maxId) {
                        maxId = m.getMessageId();
                    }
                }
                newId = maxId + 1;
            }
            message.setMessageId(newId);
            
            // Add to the list
            messages.add(message);
            
            // Write back to file
            return writeMessagesToFile(messages);
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error saving message", e);
            return false;
        }
    }

    /**
     * Gets all messages from the JSON file
     */
    public List<UserAgentMassage> getAllMessages() {
        try {
            File file = new File(DATA_FILE);
            if (!file.exists()) {
                return new ArrayList<>();
            }
            
            // Read the file content
            String json = new String(Files.readAllBytes(Paths.get(DATA_FILE)));
            
            // If the file is empty or not valid JSON array, return empty list
            if (json == null || json.trim().isEmpty() || json.trim().equals("null")) {
                return new ArrayList<>();
            }
            
            // Parse the JSON
            Type listType = new TypeToken<ArrayList<UserAgentMassage>>(){}.getType();
            List<UserAgentMassage> messages = gson.fromJson(json, listType);
            return messages != null ? messages : new ArrayList<>();
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error reading messages", e);
            return new ArrayList<>();
        }
    }
    
    /**
     * Writes the list of messages to the JSON file
     */
    private boolean writeMessagesToFile(List<UserAgentMassage> messages) {
        try {
            // Create parent directory if it doesn't exist
            File dir = new File(DATA_DIR);
            System.out.println(dir);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            
            // Write to file
            try (FileWriter writer = new FileWriter(DATA_FILE)) {
                gson.toJson(messages, writer);
                LOGGER.info("Successfully wrote " + messages.size() + " messages to " + DATA_FILE);
                return true;
            }
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error writing to JSON file", e);
            return false;
        }
    }
}