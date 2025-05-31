package com.RealState.servlets;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import com.google.gson.*;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/register") // Changed to match the form action
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Gson gson = new GsonBuilder().setPrettyPrinting().create();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get form parameters with debug printing
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");
            String userType = request.getParameter("userType");

            System.out.println("Received registration request:");
            System.out.println("firstName: " + firstName);
            System.out.println("lastName: " + lastName);
            System.out.println("email: " + email);
            System.out.println("phone: " + phone);
            System.out.println("userType: " + userType);

            // Get current timestamp
            String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

            // Create user data as a Map
            Map<String, Object> userData = new HashMap<>();
            userData.put("firstName", firstName);
            userData.put("lastName", lastName);
            userData.put("username", email);
            userData.put("phone", phone);
            userData.put("password", password);
            userData.put("userType", userType);
            userData.put("registrationDate", timestamp);

            // Define the data directory path
            String dataDir = "C:/Users/user/Downloads/project/RealState/src/main/webapp/WEB-INF/data";
            String fileName = "agent".equals(userType) ? "estateAgent.json" : "user.json";
            File jsonFile = new File(dataDir, fileName);

            // Create directories if they don't exist
            File dir = new File(dataDir);
            if (!dir.exists()) {
                dir.mkdirs();
                System.out.println("Created directory: " + dir.getAbsolutePath());
            }

            // Initialize users list
            List<Map<String, Object>> usersList = new ArrayList<>();

            // Read existing data if file exists
            if (jsonFile.exists()) {
                try (Reader reader = new FileReader(jsonFile)) {
                    Type listType = new TypeToken<ArrayList<Map<String, Object>>>(){}.getType();
                    usersList = gson.fromJson(reader, listType);
                    if (usersList == null) {
                        usersList = new ArrayList<>();
                    }
                } catch (Exception e) {
                    System.err.println("Error reading existing file: " + e.getMessage());
                    usersList = new ArrayList<>();
                }
            }

            // Add new user
            usersList.add(userData);

            // Write to file
            try (FileWriter writer = new FileWriter(jsonFile)) {
                gson.toJson(usersList, writer);
                writer.flush();
                System.out.println("Successfully wrote to file: " + jsonFile.getAbsolutePath());
                System.out.println("Data written: " + gson.toJson(userData));
                
                // Set session attributes
               /* HttpSession session = request.getSession();
                session.setAttribute("user", userData);
                session.setAttribute("userType", userType);
                session.setAttribute("username", email);
                session.setAttribute("fullName", firstName + " " + lastName);*/

                // Redirect based on user type
                if ("agent".equals(userType)) {
                    response.sendRedirect("AgentLogin.jsp");
                } else {
                    response.sendRedirect("UserLogin.jsp");
                }
                

            } catch (IOException e) {
                System.err.println("Error writing to file: " + e.getMessage());
                e.printStackTrace();
                response.sendRedirect("register.jsp?error=save_failed");
            }

        } catch (Exception e) {
            System.err.println("Registration error: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=registration_failed");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }
}