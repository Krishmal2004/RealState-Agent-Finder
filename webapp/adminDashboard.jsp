<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="org.json.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%!
    // Inner class to represent a User
    public static class User {
        private String id;
        private String username;
        private String password;
        private String fullName;
        private String email;
        private String role;
        private boolean active = true;
        private String registrationDate;
        private String lastLogin;
        private String contactNumber;
        private String address;
        private boolean emailVerified;
        
        public User() {
            this.id = generateId();
            this.registrationDate = LocalDateTime.now().format(
                DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) + " (UTC)";
            this.active = true;
            this.emailVerified = false;
        }
        
        private String generateId() {
            // Generate a random ID
            Random rand = new Random();
            String prefix = "USR";
            String numbers = String.format("%08d", rand.nextInt(100000000));
            return prefix + numbers;
        }
        
        // Convert User object to JSONObject
        public JSONObject toJson() {
            JSONObject json = new JSONObject();
            json.put("id", id);
            json.put("username", username);
            json.put("password", password);
            json.put("fullName", fullName);
            json.put("email", email);
            json.put("role", role != null ? role : "user");
            json.put("active", active);
            json.put("registrationDate", registrationDate);
            json.put("lastLogin", lastLogin != null ? lastLogin : "");
            json.put("contactNumber", contactNumber != null ? contactNumber : "");
            json.put("address", address != null ? address : "");
            json.put("emailVerified", emailVerified);
            return json;
        }
        
        // Create User from JSONObject
        public static User fromJson(JSONObject json) {
            User user = new User();
            user.setId(json.optString("id", user.getId()));
            user.setUsername(json.optString("username", ""));
            user.setPassword(json.optString("password", ""));
            user.setFullName(json.optString("fullName", ""));
            user.setEmail(json.optString("email", ""));
            user.setRole(json.optString("role", "user"));
            user.setActive(json.optBoolean("active", true));
            user.setRegistrationDate(json.optString("registrationDate", user.getRegistrationDate()));
            user.setLastLogin(json.optString("lastLogin", ""));
            user.setContactNumber(json.optString("contactNumber", ""));
            user.setAddress(json.optString("address", ""));
            user.setEmailVerified(json.optBoolean("emailVerified", false));
            return user;
        }
        
        // Getters and setters
        public String getId() { return id; }
        public void setId(String id) { this.id = id; }
        
        public String getUsername() { return username; }
        public void setUsername(String username) { this.username = username; }
        
        public String getPassword() { return password; }
        public void setPassword(String password) { this.password = password; }
        
        public String getFullName() { return fullName; }
        public void setFullName(String fullName) { this.fullName = fullName; }
        
        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }
        
        public String getRole() { return role; }
        public void setRole(String role) { this.role = role; }
        
        public boolean isActive() { return active; }
        public void setActive(boolean active) { this.active = active; }
        
        public String getRegistrationDate() { return registrationDate; }
        public void setRegistrationDate(String registrationDate) { this.registrationDate = registrationDate; }
        
        public String getLastLogin() { return lastLogin; }
        public void setLastLogin(String lastLogin) { this.lastLogin = lastLogin; }
        
        public String getContactNumber() { return contactNumber; }
        public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }
        
        public String getAddress() { return address; }
        public void setAddress(String address) { this.address = address; }
        
        public boolean isEmailVerified() { return emailVerified; }
        public void setEmailVerified(boolean emailVerified) { this.emailVerified = emailVerified; }
    }
    
    // Methods for user file operations using JSON
    public List<User> getAllUsers(String filePath) {
        List<User> users = new ArrayList<>();
        File file = new File(filePath);
        
        if (!file.exists() || file.length() == 0) {
            // Return empty list if file doesn't exist or is empty
            return users;
        }
        
        try {
            String jsonContent = new String(Files.readAllBytes(Paths.get(filePath)));
            
            // Trim the content to handle any potential whitespace
            jsonContent = jsonContent.trim();
            
            // Check if the content is a valid JSON structure
            if (!jsonContent.startsWith("{")) {
                System.out.println("Warning: Invalid JSON format in file. Creating a new JSON structure.");
                return users; // Return empty list, will be initialized later
            }
            
            JSONObject jsonData = new JSONObject(jsonContent);
            
            // Get metadata (optional fields)
            String currentDate = jsonData.optString("currentDate", "");
            String currentUser = jsonData.optString("currentUser", "System");
            
            // Get users array
            if (jsonData.has("users")) {
                JSONArray usersArray = jsonData.getJSONArray("users");
                
                for (int i = 0; i < usersArray.length(); i++) {
                    JSONObject userJson = usersArray.getJSONObject(i);
                    User user = User.fromJson(userJson);
                    users.add(user);
                }
            }
        } catch (Exception e) {
            System.out.println("Error reading users from JSON: " + e.getMessage());
            e.printStackTrace();
            // Return empty list on error
        }
        
        return users;
    }
    
    public User getUserById(String userId, String filePath) {
        for (User user : getAllUsers(filePath)) {
            if (user.getId().equals(userId)) {
                return user;
            }
        }
        return null;
    }
    
    public User getUserByUsername(String username, String filePath) {
        for (User user : getAllUsers(filePath)) {
            if (user.getUsername().equalsIgnoreCase(username)) {
                return user;
            }
        }
        return null;
    }
    
    public void addUser(User user, String filePath) {
        List<User> users = getAllUsers(filePath);
        users.add(user);
        saveAllUsers(users, filePath);
    }
    
    public void updateUser(User updatedUser, String filePath) {
        List<User> users = getAllUsers(filePath);
        boolean found = false;
        
        for (int i = 0; i < users.size(); i++) {
            if (users.get(i).getId().equals(updatedUser.getId()) || 
                users.get(i).getUsername().equals(updatedUser.getUsername())) {
                users.set(i, updatedUser);
                found = true;
                break;
            }
        }
        
        if (!found) {
            throw new IllegalArgumentException("User not found");
        }
        
        saveAllUsers(users, filePath);
    }
    
    public void deleteUser(String userId, String filePath) {
        List<User> users = getAllUsers(filePath);
        boolean found = false;
        
        for (Iterator<User> iterator = users.iterator(); iterator.hasNext();) {
            User user = iterator.next();
            if (user.getId().equals(userId)) {
                iterator.remove();
                found = true;
                break;
            }
        }
        
        if (!found) {
            throw new IllegalArgumentException("User not found");
        }
        
        saveAllUsers(users, filePath);
    }
    
    private void saveAllUsers(List<User> users, String filePath) {
        try {
            // Create JSON structure
            JSONObject jsonData = new JSONObject();
            JSONArray usersArray = new JSONArray();
            
            // Add current date and user metadata
            String currentDate = "2025-05-02 20:10:12";
            jsonData.put("currentDate", currentDate);
            jsonData.put("currentUser", "IT24103866");
            
            // Add all users to the array
            for (User user : users) {
                usersArray.put(user.toJson());
            }
            
            // Add users array to main JSON object
            jsonData.put("users", usersArray);
            
            // Make sure directory exists
            File file = new File(filePath);
            file.getParentFile().mkdirs();
            
            // Write directly to file
            try (FileWriter writer = new FileWriter(file)) {
                writer.write(jsonData.toString(2)); // Pretty print with 2-space indentation
            }
        } catch (Exception e) {
            System.out.println("Error saving users to JSON: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    public void initializeUserStore(String filePath) {
        File file = new File(filePath);
        if (!file.exists() || file.length() == 0) {
            try {
                // Create sample users
                User admin = new User();
                admin.setId("USR00000001");
                admin.setUsername("admin");
                admin.setPassword("admin123");
                admin.setFullName("System Administrator");
                admin.setEmail("admin@propertyfinder.com");
                admin.setRole("admin");
                admin.setActive(true);
                admin.setEmailVerified(true);
                admin.setLastLogin("2025-05-01 19:30:00 (UTC)");
                
                User manager = new User();
                manager.setId("USR00000002");
                manager.setUsername("manager");
                manager.setPassword("manager123");
                manager.setFullName("Sales Manager");
                manager.setEmail("manager@propertyfinder.com");
                manager.setRole("manager");
                manager.setActive(true);
                manager.setEmailVerified(true);
                manager.setLastLogin("2025-05-01 15:45:20 (UTC)");
                
                User user1 = new User();
                user1.setId("USR00000003");
                user1.setUsername("johndoe");
                user1.setPassword("password123");
                user1.setFullName("John Doe");
                user1.setEmail("john.doe@example.com");
                user1.setRole("user");
                user1.setActive(true);
                user1.setEmailVerified(true);
                user1.setContactNumber("(123) 456-7890");
                user1.setLastLogin("2025-05-01 12:30:45 (UTC)");
                
                User user2 = new User();
                user2.setId("USR00000004");
                user2.setUsername("janesmith");
                user2.setPassword("password456");
                user2.setFullName("Jane Smith");
                user2.setEmail("jane.smith@example.com");
                user2.setRole("user");
                user2.setActive(true);
                user2.setEmailVerified(false);
                user2.setContactNumber("(234) 567-8901");
                
                User user3 = new User();
                user3.setId("USR00000005");
                user3.setUsername("bobwilson");
                user3.setPassword("password789");
                user3.setFullName("Bob Wilson");
                user3.setEmail("bob.wilson@example.com");
                user3.setRole("user");
                user3.setActive(false);
                user3.setEmailVerified(true);
                user3.setLastLogin("2025-04-15 09:20:30 (UTC)");
                
                // Create a list of users
                List<User> users = new ArrayList<>();
                users.add(admin);
                users.add(manager);
                users.add(user1);
                users.add(user2);
                users.add(user3);
                
                // Save to file
                saveAllUsers(users, filePath);
                System.out.println("User store initialized successfully with sample data");
            } catch (Exception e) {
                System.out.println("Error initializing user store: " + e.getMessage());
                e.printStackTrace();
            }
        } else {
            try {
                // Verify if the file contains valid JSON
                List<User> users = getAllUsers(filePath);
                if (users.isEmpty()) {
                    // If the file exists but contains invalid JSON, recreate it
                    file.delete();
                    initializeUserStore(filePath);
                }
            } catch (Exception e) {
                System.out.println("Error validating user store: " + e.getMessage());
                e.printStackTrace();
                // Recreate the file if validation fails
                try {
                    file.delete();
                    initializeUserStore(filePath);
                } catch (Exception ex) {
                    System.out.println("Failed to recreate user store: " + ex.getMessage());
                }
            }
        }
    }
%>

<%
    // Check if user is logged in as admin
    String username = (String) session.getAttribute("username");
    String fullName = (String) session.getAttribute("fullName");
    String userRole = (String) session.getAttribute("userRole");
    
    if (username == null || !"admin".equalsIgnoreCase(userRole)) {
        // For testing, override this
        username = "admin";
        fullName = "Administrator";
        userRole = "admin";
        //response.sendRedirect("login.jsp");
        //return;
    }
    
    // Path to user data file
    String dataDir = "C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\data";
    String userFile = dataDir + File.separator + "userManagement.json";
    
    // Initialize user store if needed
    try {
        initializeUserStore(userFile);
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    // Process user actions
    String action = request.getParameter("action");
    String userId = request.getParameter("userid");
    String message = "";
    boolean success = false;
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        if ("add".equals(action)) {
            // Add new user
            try {
                String newUsername = request.getParameter("newUsername");
                String newPassword = request.getParameter("newPassword");
                String newEmail = request.getParameter("newEmail");
                String newFullName = request.getParameter("newFullName");
                String newRole = request.getParameter("newRole");
                String newContactNumber = request.getParameter("newContactNumber");
                String newAddress = request.getParameter("newAddress");
                boolean newEmailVerified = "on".equals(request.getParameter("newEmailVerified"));
                
                // Validate username is unique
                User existingUser = getUserByUsername(newUsername, userFile);
                if (existingUser != null) {
                    message = "Username already exists. Please choose a different username.";
                } else {
                    // Create new user
                    User newUser = new User();
                    newUser.setUsername(newUsername);
                    newUser.setPassword(newPassword);
                    newUser.setEmail(newEmail);
                    newUser.setFullName(newFullName);
                    newUser.setRole(newRole);
                    newUser.setContactNumber(newContactNumber);
                    newUser.setAddress(newAddress);
                    newUser.setEmailVerified(newEmailVerified);
                    newUser.setActive(true);  // New users are active by default
                    
                    addUser(newUser, userFile);
                    success = true;
                    message = "User added successfully!";
                }
            } catch (Exception e) {
                message = "Error adding user: " + e.getMessage();
                e.printStackTrace();
            }
        } else if ("update".equals(action)) {
            // Update user
            try {
                String editUserId = request.getParameter("editUserId");
                String editUsername = request.getParameter("editUsername");
                String editPassword = request.getParameter("editPassword");
                String editEmail = request.getParameter("editEmail");
                String editFullName = request.getParameter("editFullName");
                String editRole = request.getParameter("editRole");
                String editContactNumber = request.getParameter("editContactNumber");
                String editAddress = request.getParameter("editAddress");
                boolean editEmailVerified = "on".equals(request.getParameter("editEmailVerified"));
                boolean editActive = "on".equals(request.getParameter("editActive"));
                
                User user = getUserById(editUserId, userFile);
                if (user != null) {
                    // Check if username is changed and if it's unique
                    if (!user.getUsername().equals(editUsername)) {
                        User existingUser = getUserByUsername(editUsername, userFile);
                        if (existingUser != null && !existingUser.getId().equals(editUserId)) {
                            message = "Username already exists. Please choose a different username.";
                            success = false;
                        } else {
                            user.setUsername(editUsername);
                            success = true;
                        }
                    } else {
                        success = true;
                    }
                    
                    if (success) {
                        // Only update password if provided
                        if (editPassword != null && !editPassword.trim().isEmpty()) {
                            user.setPassword(editPassword); // Should be hashed in real app
                        }
                        
                        user.setEmail(editEmail);
                        user.setFullName(editFullName);
                        user.setRole(editRole);
                        user.setContactNumber(editContactNumber);
                        user.setAddress(editAddress);
                        user.setEmailVerified(editEmailVerified);
                        user.setActive(editActive);
                        
                        updateUser(user, userFile);
                        success = true;
                        message = "User updated successfully!";
                    }
                } else {
                    message = "User not found.";
                    success = false;
                }
            } catch (Exception e) {
                message = "Error updating user: " + e.getMessage();
                e.printStackTrace();
                success = false;
            }
        } else if ("resetpw".equals(action)) {
            // Reset user password
            try {
                String resetUserId = request.getParameter("resetUserId");
                String newPassword = request.getParameter("newPassword");
                
                if (newPassword == null || newPassword.trim().isEmpty()) {
                    message = "Password cannot be empty.";
                    success = false;
                } else {
                    User user = getUserById(resetUserId, userFile);
                    if (user != null) {
                        user.setPassword(newPassword); // Should be hashed in real app
                        updateUser(user, userFile);
                        success = true;
                        message = "Password reset successfully!";
                    } else {
                        message = "User not found.";
                        success = false;
                    }
                }
            } catch (Exception e) {
                message = "Error resetting password: " + e.getMessage();
                e.printStackTrace();
                success = false;
            }
        }
    } else if (action != null && userId != null) {
        try {
            if ("delete".equals(action)) {
                // Delete user
                deleteUser(userId, userFile);
                success = true;
                message = "User deleted successfully.";
            } else if ("activate".equals(action)) {
                // Activate user
                User user = getUserById(userId, userFile);
                if (user != null) {
                    user.setActive(true);
                    updateUser(user, userFile);
                    success = true;
                    message = "User activated successfully.";
                } else {
                    message = "User not found.";
                    success = false;
                }
            } else if ("deactivate".equals(action)) {
                // Deactivate user
                User user = getUserById(userId, userFile);
                if (user != null) {
                    user.setActive(false);
                    updateUser(user, userFile);
                    success = true;
                    message = "User deactivated successfully.";
                } else {
                    message = "User not found.";
                    success = false;
                }
            } else if ("verify".equals(action)) {
                // Verify user email
                User user = getUserById(userId, userFile);
                if (user != null) {
                    user.setEmailVerified(true);
                    updateUser(user, userFile);
                    success = true;
                    message = "Email marked as verified.";
                } else {
                    message = "User not found.";
                    success = false;
                }
            }
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
            e.printStackTrace();
            success = false;
        }
    }
    
    // Get all users for display
    List<User> users = new ArrayList<>();
    try {
        users = getAllUsers(userFile);
    } catch (Exception e) {
        message = "Error loading users: " + e.getMessage();
        e.printStackTrace();
    }
    
    // Sort users by role
    Collections.sort(users, new Comparator<User>() {
        @Override
        public int compare(User u1, User u2) {
            // Sort by role priority: admin > manager > user
            if ("admin".equals(u1.getRole()) && !"admin".equals(u2.getRole())) {
                return -1;
            } else if (!"admin".equals(u1.getRole()) && "admin".equals(u2.getRole())) {
                return 1;
            } else if ("manager".equals(u1.getRole()) && !"manager".equals(u2.getRole())) {
                return -1;
            } else if (!"manager".equals(u1.getRole()) && "manager".equals(u2.getRole())) {
                return 1;
            }
            // If roles are the same, sort by username
            return u1.getUsername().compareToIgnoreCase(u2.getUsername());
        }
    });
    
    // Count users by role and status
    int adminCount = 0;
    int managerCount = 0;
    int userCount = 0;
    int activeCount = 0;
    int inactiveCount = 0;
    int verifiedCount = 0;
    
    for (User user : users) {
        if ("admin".equalsIgnoreCase(user.getRole())) {
            adminCount++;
        } else if ("manager".equalsIgnoreCase(user.getRole())) {
            managerCount++;
        } else {
            userCount++;
        }
        
        if (user.isActive()) {
            activeCount++;
        } else {
            inactiveCount++;
        }
        
        if (user.isEmailVerified()) {
            verifiedCount++;
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management | Admin Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css">
    <style>
        :root {
            --dark-blue: #081c45;
            --medium-blue: #0e307e;
            --light-blue: #2a4494;
            --highlight-blue: #4568dc;
            --admin-color: #4e1d9e;
            --manager-color: #c34a36;
            --user-color: #3c8dbc;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
        }
        
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: 280px;
            background: linear-gradient(to bottom, #000c24, #001a4d);
            color: white;
            padding-top: 20px;
            transition: all 0.3s;
            z-index: 1000;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
        }
        
        .sidebar-header {
            padding: 20px 25px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        
        .sidebar-header .logo {
            font-size: 1.8rem;
            font-weight: bold;
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
        }
        
        .admin-badge {
            font-size: 0.7rem;
            background-color: white;
            color: var(--admin-color);
            padding: 2px 8px;
            border-radius: 10px;
            margin-left: 10px;
        }
        
        .nav-item {
            margin-bottom: 5px;
        }
        
        .nav-link {
            padding: 12px 25px;
            color: rgba(255,255,255,0.8);
            font-weight: 500;
            border-radius: 0;
            display: flex;
            align-items: center;
            transition: all 0.3s;
        }
        
        .nav-link:hover, .nav-link.active {
            background-color: rgba(255,255,255,0.1);
            color: white;
        }
        
        .nav-link i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        
        .content {
            margin-left: 280px;
            padding: 20px;
            transition: all 0.3s;
        }
        
        .toggle-sidebar {
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1001;
            display: none;
        }
        
        .sidebar-bottom {
            position: absolute;
            bottom: 0;
            width: 100%;
            padding: 20px 25px;
            border-top: 1px solid rgba(255,255,255,0.1);
        }
        
        .user-menu {
            display: flex;
            align-items: center;
            color: white;
            text-decoration: none;
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #3a86ff;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            margin-right: 10px;
        }
        
        .dropdown-toggle::after {
            display: none;
        }
        
        .card {
            border: none;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            border-radius: 10px;
            margin-bottom: 20px;
        }
        
        .card-header {
            background-color: white;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            padding: 15px 20px;
        }
        
        .role-badge {
            font-size: 0.75rem;
            padding: 0.25rem 0.5rem;
            border-radius: 10px;
        }
        
        .badge-admin {
            background-color: var(--admin-color);
            color: white;
        }
        
        .badge-manager {
            background-color: var(--manager-color);
            color: white;
        }
        
        .badge-user {
            background-color: var(--user-color);
            color: white;
        }
        
        .status-indicator {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            display: inline-block;
            margin-right: 5px;
        }
        
        .status-active {
            background-color: #38b000;
        }
        
        .status-inactive {
            background-color: #d90429;
        }
        
        .status-verified {
            background-color: #3a86ff;
        }
        
        .status-unverified {
            background-color: #ffbe0b;
        }
        
        .action-btn {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }
        
        .user-table th {
            font-weight: 600;
        }
        
        .search-container {
            position: relative;
            max-width: 300px;
        }
        
        .search-container .form-control {
            padding-left: 38px;
        }
        
        .search-icon {
            position: absolute;
            top: 50%;
            left: 13px;
            transform: translateY(-50%);
            color: #6c757d;
        }
        
        .stats-card {
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.1) 0%, rgba(255, 255, 255, 0.05) 100%);
            border-radius: 16px;
            overflow: hidden;
            padding: 15px;
            position: relative;
            transition: all 0.3s ease;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            color: white;
            height: 100%;
        }
        
        .stats-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.25);
        }
        
        .stats-card.admin-card {
            background: linear-gradient(135deg, var(--admin-color) 0%, #2b0c5d 100%);
        }
        
        .stats-card.manager-card {
            background: linear-gradient(135deg, var(--manager-color) 0%, #7d2e22 100%);
        }
        
        .stats-card.user-card {
            background: linear-gradient(135deg, var(--user-color) 0%, #2a6389 100%);
        }
        
        .stats-card.active-card {
            background: linear-gradient(135deg, #38b000 0%, #246800 100%);
        }
        
        .stats-card.inactive-card {
            background: linear-gradient(135deg, #d90429 0%, #8c031b 100%);
        }
        
        .stats-card.verified-card {
            background: linear-gradient(135deg, #3a86ff 0%, #1b4cd1 100%);
        }
        
        .stats-card .icon {
            position: absolute;
            top: 20px;
            right: 20px;
            font-size: 48px;
            opacity: 0.15;
        }
        
        .stats-card .stats-number {
            font-size: 2.5rem;
            font-weight: 700;
        }
        
        .stats-card .stats-title {
            font-size: 1.1rem;
            margin-bottom: 0;
        }
        
        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-280px);
            }
            
            .content {
                margin-left: 0;
            }
            
            .sidebar.show {
                transform: translateX(0);
            }
            
            .toggle-sidebar {
                display: block;
            }
            
            .content.pushed {
                margin-left: 280px;
            }
        }
    </style>
</head>
<body>
    <button class="btn btn-light toggle-sidebar" id="toggleSidebar">
        <i class="fas fa-bars"></i>
    </button>
    
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <a href="admin-dashboard.jsp" class="logo">
                <i class="fas fa-building me-2"></i> PropertyFinder <span class="admin-badge">ADMIN</span>
            </a>
        </div>
        
        <ul class="nav flex-column mt-4">
            <li class="nav-item">
                <a class="nav-link" href="adminDasboardChart.jsp">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="adminDashboard.jsp">
                    <i class="fas fa-users"></i> User Management
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="agentManagement.jsp">
                    <i class="fas fa-user-tie"></i> Agent Management
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="propertyManagement.jsp">
                    <i class="fas fa-home"></i> Properties
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="adminAnalytics.jsp">
                    <i class="fas fa-chart-bar"></i> Analytics
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="adminSetting.jsp">
                    <i class="fas fa-cog"></i> Settings
                </a>
            </li>
        </ul>
        
        <div class="sidebar-bottom">
            <div class="dropdown">
                <a href="#" class="user-menu dropdown-toggle" data-bs-toggle="dropdown">
                    <div class="user-avatar">
                        <i class="fas fa-user-shield"></i>
                    </div>
                    <div>
                        <div class="fw-bold"><%= fullName %></div>
                        <small class="text-white-50"><%= username %></small>
                    </div>
                </a>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="#"><i class="fas fa-user me-2"></i>My Profile</a></li>
                    <li><a class="dropdown-item" href="adminSetting.jsp"><i class="fas fa-cog me-2"></i>Account Settings</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item text-danger" href="adminLogout.jsp"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                </ul>
            </div>
        </div>
    </div>
    
    <!-- Content -->
    <div class="content">
        <div class="container-fluid">
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>User Management</h2>
                <div>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">
                        <i class="fas fa-user-plus me-2"></i> Add New User
                    </button>
                </div>
            </div>
            
            <!-- Status Messages -->
            <% if (!message.isEmpty()) { %>
                <div class="alert alert-<%= success ? "success" : "danger" %> alert-dismissible fade show" role="alert">
                    <i class="fas fa-<%= success ? "check" : "exclamation" %>-circle me-2"></i> <%= message %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>
            
            <!-- Stats Cards -->
            <div class="row mb-4">
                <div class="col-md-4 col-lg-2 mb-3">
                    <div class="stats-card admin-card">
                        <div class="icon">
                            <i class="fas fa-user-shield"></i>
                        </div>
                        <h2 class="stats-number"><%= adminCount %></h2>
                        <p class="stats-title">Admin Users</p>
                    </div>
                </div>
                <div class="col-md-4 col-lg-2 mb-3">
                    <div class="stats-card manager-card">
                        <div class="icon">
                            <i class="fas fa-user-tie"></i>
                        </div>
                        <h2 class="stats-number"><%= managerCount %></h2>
                        <p class="stats-title">Managers</p>
                    </div>
                </div>
                <div class="col-md-4 col-lg-2 mb-3">
                    <div class="stats-card user-card">
                        <div class="icon">
                            <i class="fas fa-user"></i>
                        </div>
                        <h2 class="stats-number"><%= userCount %></h2>
                        <p class="stats-title">Regular Users</p>
                    </div>
                </div>
                <div class="col-md-4 col-lg-2 mb-3">
                    <div class="stats-card active-card">
                        <div class="icon">
                            <i class="fas fa-toggle-on"></i>
                        </div>
                        <h2 class="stats-number"><%= activeCount %></h2>
                        <p class="stats-title">Active Accounts</p>
                    </div>
                </div>
                <div class="col-md-4 col-lg-2 mb-3">
                    <div class="stats-card inactive-card">
                        <div class="icon">
                            <i class="fas fa-toggle-off"></i>
                        </div>
                        <h2 class="stats-number"><%= inactiveCount %></h2>
                        <p class="stats-title">Inactive Accounts</p>
                    </div>
                </div>
                <div class="col-md-4 col-lg-2 mb-3">
                    <div class="stats-card verified-card">
                        <div class="icon">
                            <i class="fas fa-envelope-circle-check"></i>
                        </div>
                        <h2 class="stats-number"><%= verifiedCount %></h2>
                        <p class="stats-title">Verified Emails</p>
                    </div>
                </div>
            </div>
            
            <!-- User List Card -->
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">All Users</h5>
                    <div class="search-container">
                        <i class="fas fa-search search-icon"></i>
                        <input type="text" id="userSearchInput" class="form-control" placeholder="Search users...">
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table id="userTable" class="table table-striped table-hover user-table align-middle">
                            <thead>
                                <tr>
                                    <th>User</th>
                                    <th>Email</th>
                                    <th>Role</th>
                                    <th>Contact</th>
                                    <th>Status</th>
                                    <th>Last Login</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (users.isEmpty()) { %>
                                    <tr>
                                        <td colspan="7" class="text-center">No users found.</td>
                                    </tr>
                                <% } else { %>
                                    <% for (User user : users) { %>
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="user-avatar me-3" style="width: 40px; height: 40px; font-size: 18px;">
                                                    <% if ("admin".equalsIgnoreCase(user.getRole())) { %>
                                                        <i class="fas fa-user-shield"></i>
                                                    <% } else if ("manager".equalsIgnoreCase(user.getRole())) { %>
                                                        <i class="fas fa-user-tie"></i>
                                                    <% } else { %>
                                                        <i class="fas fa-user"></i>
                                                    <% } %>
                                                </div>
                                                <div>
                                                    <div class="fw-bold"><%= user.getFullName() %></div>
                                                    <div class="small text-muted"><%= user.getUsername() %></div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <%= user.getEmail() %>
                                            <% if (user.isEmailVerified()) { %>
                                                <span class="ms-1 text-success" title="Email Verified"><i class="fas fa-check-circle"></i></span>
                                            <% } else { %>
                                                <span class="ms-1 text-warning" title="Email Not Verified"><i class="fas fa-exclamation-circle"></i></span>
                                            <% } %>
                                        </td>
                                        <td>
                                            <% if ("admin".equalsIgnoreCase(user.getRole())) { %>
                                                <span class="role-badge badge-admin">Administrator</span>
                                            <% } else if ("manager".equalsIgnoreCase(user.getRole())) { %>
                                                <span class="role-badge badge-manager">Manager</span>
                                            <% } else { %>
                                                <span class="role-badge badge-user">User</span>
                                            <% } %>
                                        </td>
                                        <td>
                                            <% if (user.getContactNumber() != null && !user.getContactNumber().isEmpty()) { %>
                                                <div><i class="fas fa-phone me-1 text-muted"></i> <%= user.getContactNumber() %></div>
                                            <% } else { %>
                                                <div class="text-muted">No contact provided</div>
                                            <% } %>
                                        </td>
                                        <td>
                                            <% if (user.isActive()) { %>
                                                <span class="text-success"><i class="fas fa-check-circle me-1"></i> Active</span>
                                            <% } else { %>
                                                <span class="text-danger"><i class="fas fa-times-circle me-1"></i> Inactive</span>
                                            <% } %>
                                        </td>
                                        <td>
                                            <% if (user.getLastLogin() != null && !user.getLastLogin().isEmpty()) { %>
                                                <%= user.getLastLogin() %>
                                            <% } else { %>
                                                <span class="text-muted">Never logged in</span>
                                            <% } %>
                                        </td>
                                        <td>
                                            <div class="btn-group">
                                                <button class="btn btn-sm btn-outline-primary action-btn" 
                                                    onclick="viewUser('<%= user.getId() %>','<%= user.getUsername() %>','<%= user.getFullName() %>','<%= user.getEmail() %>','<%= user.getRole() %>','<%= user.getContactNumber() != null ? user.getContactNumber() : "" %>','<%= user.getAddress() != null ? user.getAddress().replace("'", "\\'") : "" %>','<%= user.getLastLogin() != null ? user.getLastLogin() : "" %>','<%= user.getRegistrationDate() %>',<%= user.isActive() %>,<%= user.isEmailVerified() %>)">
                                                    <i class="fas fa-eye" title="View User"></i>
                                                </button>
                                                
                                                <button class="btn btn-sm btn-outline-secondary action-btn" 
                                                    onclick="editUser('<%= user.getId() %>','<%= user.getUsername() %>','<%= user.getFullName() %>','<%= user.getEmail() %>','<%= user.getRole() %>','<%= user.getContactNumber() != null ? user.getContactNumber() : "" %>','<%= user.getAddress() != null ? user.getAddress().replace("'", "\\'") : "" %>',<%= user.isActive() %>,<%= user.isEmailVerified() %>)">
                                                    <i class="fas fa-edit" title="Edit User"></i>
                                                </button>
                                                
                                                <button class="btn btn-sm btn-outline-warning action-btn" 
                                                    onclick="resetPassword('<%= user.getId() %>', '<%= user.getUsername() %>')">
                                                    <i class="fas fa-key" title="Reset Password"></i>
                                                </button>
                                                
                                                <!-- Add activate/deactivate buttons based on current status -->
                                                <% if (user.isActive()) { %>
                                                    <a href="adminDashboard.jsp?action=deactivate&userid=<%= user.getId() %>" 
                                                    class="btn btn-sm btn-outline-danger action-btn"
                                                    onclick="return confirm('Are you sure you want to deactivate this user?')">
                                                        <i class="fas fa-user-slash" title="Deactivate User"></i>
                                                    </a>
                                                <% } else { %>
                                                    <a href="adminDashboard.jsp?action=activate&userid=<%= user.getId() %>" 
                                                    class="btn btn-sm btn-outline-success action-btn"
                                                    onclick="return confirm('Are you sure you want to activate this user?')">
                                                        <i class="fas fa-user-check" title="Activate User"></i>
                                                    </a>
                                                <% } %>
                                                
                                                <!-- Email verification button if not verified -->
                                                <% if (!user.isEmailVerified()) { %>
                                                    <a href="userManagement.jsp?action=verify&userid=<%= user.getId() %>" 
                                                    class="btn btn-sm btn-outline-primary action-btn"
                                                    onclick="return confirm('Are you sure you want to mark this email as verified?')">
                                                        <i class="fas fa-envelope-circle-check" title="Verify Email"></i>
                                                    </a>
                                                <% } %>
                                                
                                                <a href="adminDashboard.jsp?action=delete&userid=<%= user.getId() %>" 
                                                class="btn btn-sm btn-outline-danger action-btn"
                                                onclick="return confirm('Are you sure you want to delete this user? This action cannot be undone.')">
                                                    <i class="fas fa-trash" title="Delete User"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                    <% } %>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            
            <!-- Footer -->
            <footer class="mt-4">
                <div class="text-center text-muted">
                    <p>&copy; 2025 PropertyFinder Administrative Panel. All rights reserved.</p>
                    <p class="small">Current Date and Time (UTC): 2025-05-02 20:10:12 | User: IT24103866</p>
                </div>
            </footer>
        </div>
    </div>
    
    <!-- Add User Modal -->
    <div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addUserModalLabel">Add New User</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="adminDashboard.jsp" method="post">
                    <input type="hidden" name="action" value="add">
                    <div class="modal-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="newUsername" class="form-label">Username</label>
                                <input type="text" class="form-control" id="newUsername" name="newUsername" required>
                                <div class="form-text">Username must be unique and at least 4 characters.</div>
                            </div>
                            <div class="col-md-6">
                                <label for="newPassword" class="form-label">Password</label>
                                <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                                <div class="form-text">Password should be secure and at least 8 characters.</div>
                            </div>
                            <div class="col-md-6">
                                <label for="newFullName" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="newFullName" name="newFullName" required>
                            </div>
                            <div class="col-md-6">
                                <label for="newEmail" class="form-label">Email</label>
                                <input type="email" class="form-control" id="newEmail" name="newEmail" required>
                            </div>
                            <div class="col-md-6">
                                <label for="newContactNumber" class="form-label">Contact Number</label>
                                <input type="text" class="form-control" id="newContactNumber" name="newContactNumber">
                            </div>
                            <div class="col-md-6">
                                <label for="newRole" class="form-label">Role</label>
                                <select class="form-select" id="newRole" name="newRole" required>
                                    <option value="user" selected>Regular User</option>
                                    <option value="manager">Manager</option>
                                    <option value="admin">Administrator</option>
                                </select>
                            </div>
                            <div class="col-md-12">
                                <label for="newAddress" class="form-label">Address</label>
                                <textarea class="form-control" id="newAddress" name="newAddress" rows="2"></textarea>
                            </div>
                            <div class="col-md-12">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="newEmailVerified" name="newEmailVerified">
                                    <label class="form-check-label" for="newEmailVerified">
                                        Email verified
                                    </label>
                                    <div class="form-text">Email verification is normally required for account activation.</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Add User</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Edit User Modal -->
    <div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editUserModalLabel">Edit User</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="adminDashboard.jsp" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" id="editUserId" name="editUserId" value="">
                    <div class="modal-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="editUsername" class="form-label">Username</label>
                                <input type="text" class="form-control" id="editUsername" name="editUsername" required>
                            </div>
                            <div class="col-md-6">
                                <label for="editPassword" class="form-label">Password</label>
                                <input type="password" class="form-control" id="editPassword" name="editPassword" placeholder="Leave blank to keep current password">
                                <div class="form-text">Only enter a new password if you want to change it.</div>
                            </div>
                            <div class="col-md-6">
                                <label for="editFullName" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="editFullName" name="editFullName" required>
                            </div>
                            <div class="col-md-6">
                                <label for="editEmail" class="form-label">Email</label>
                                <input type="email" class="form-control" id="editEmail" name="editEmail" required>
                            </div>
                            <div class="col-md-6">
                                <label for="editContactNumber" class="form-label">Contact Number</label>
                                <input type="text" class="form-control" id="editContactNumber" name="editContactNumber">
                            </div>
                            <div class="col-md-6">
                                <label for="editRole" class="form-label">Role</label>
                                <select class="form-select" id="editRole" name="editRole" required>
                                    <option value="user">Regular User</option>
                                    <option value="manager">Manager</option>
                                    <option value="admin">Administrator</option>
                                </select>
                            </div>
                            <div class="col-md-12">
                                <label for="editAddress" class="form-label">Address</label>
                                <textarea class="form-control" id="editAddress" name="editAddress" rows="2"></textarea>
                            </div>
                            <div class="col-md-6">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="editEmailVerified" name="editEmailVerified">
                                    <label class="form-check-label" for="editEmailVerified">
                                        Email verified
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="editActive" name="editActive">
                                    <label class="form-check-label" for="editActive">
                                        Account active
                                    </label>
                                    <div class="form-text">Inactive accounts cannot log in to the system.</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- View User Modal -->
    <div class="modal fade" id="viewUserModal" tabindex="-1" aria-labelledby="viewUserModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="viewUserModalLabel">User Details</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-4 text-center border-end">
                            <div id="viewUserAvatar" class="user-avatar mx-auto mb-3" style="width: 100px; height: 100px; font-size: 40px;">
                                <i class="fas fa-user"></i>
                            </div>
                            <h4 id="viewUserFullName"></h4>
                            <p id="viewUserRole" class="mb-2"></p>
                            <div class="badge bg-success mb-3" id="viewUserStatus"></div>
                            <div id="viewUserVerified"></div>
                        </div>
                        <div class="col-md-8">
                            <h5>Account Information</h5>
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <p><strong>Username:</strong><br>
                                    <span id="viewUserUsername"></span></p>
                                </div>
                                <div class="col-md-6">
                                    <p><strong>Email:</strong><br>
                                    <span id="viewUserEmail"></span></p>
                                </div>
                                <div class="col-md-6">
                                    <p><strong>Registration Date:</strong><br>
                                    <span id="viewUserRegistration"></span></p>
                                </div>
                                <div class="col-md-6">
                                    <p><strong>Last Login:</strong><br>
                                    <span id="viewUserLastLogin"></span></p>
                                </div>
                            </div>
                            
                            <h5>Contact Information</h5>
                            <div class="row">
                                <div class="col-md-6">
                                    <p><strong>Contact Number:</strong><br>
                                    <span id="viewUserContact"></span></p>
                                </div>
                                <div class="col-md-6">
                                    <p><strong>Address:</strong><br>
                                    <span id="viewUserAddress"></span></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="viewEditButton">Edit User</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Reset Password Modal -->
    <div class="modal fade" id="resetPasswordModal" tabindex="-1" aria-labelledby="resetPasswordModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="resetPasswordModalLabel">Reset Password</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="adminDashboard.jsp" method="post">
                    <input type="hidden" name="action" value="resetpw">
                    <input type="hidden" id="resetUserId" name="resetUserId">
                    <div class="modal-body">
                        <p>Reset password for user: <strong id="resetUserUsername"></strong></p>
                        <div class="mb-3">
                            <label for="newPassword" class="form-label">New Password</label>
                            <input type="password" class="form-control" id="resetNewPassword" name="newPassword" required>
                        </div>
                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label">Confirm New Password</label>
                            <input type="password" class="form-control" id="resetConfirmPassword" required>
                            <div id="passwordMatchError" class="invalid-feedback">
                                Passwords do not match
                                                    </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary" id="resetPasswordButton">Reset Password</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- DataTables -->
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Initialize DataTable
            const userTable = $('#userTable').DataTable({
                "paging": true,
                "ordering": true,
                "info": true,
                "responsive": true,
                "lengthMenu": [10, 25, 50, 100],
                "language": {
                    "search": "Filter records:",
                    "lengthMenu": "Show _MENU_ users per page",
                    "zeroRecords": "No matching users found",
                    "info": "Showing _START_ to _END_ of _TOTAL_ users",
                    "infoEmpty": "No users available",
                    "infoFiltered": "(filtered from _MAX_ total users)"
                }
            });
            
            // Connect the custom search box to DataTable
            $('#userSearchInput').on('keyup', function() {
                userTable.search(this.value).draw();
            });
            
            // Toggle sidebar on mobile
            const toggleSidebarBtn = document.getElementById('toggleSidebar');
            const sidebar = document.querySelector('.sidebar');
            const content = document.querySelector('.content');
            
            toggleSidebarBtn?.addEventListener('click', function() {
                sidebar.classList.toggle('show');
                content.classList.toggle('pushed');
                
                // Change icon based on sidebar state
                const icon = toggleSidebarBtn.querySelector('i');
                if (sidebar.classList.contains('show')) {
                    icon.classList.remove('fa-bars');
                    icon.classList.add('fa-times');
                } else {
                    icon.classList.remove('fa-times');
                    icon.classList.add('fa-bars');
                }
            });
            
            // Password confirmation validation
            const resetNewPassword = document.getElementById('resetNewPassword');
            const resetConfirmPassword = document.getElementById('resetConfirmPassword');
            const resetPasswordButton = document.getElementById('resetPasswordButton');
            const passwordMatchError = document.getElementById('passwordMatchError');
            
            function validatePasswordMatch() {
                if (resetNewPassword.value !== resetConfirmPassword.value) {
                    resetConfirmPassword.classList.add('is-invalid');
                    passwordMatchError.style.display = 'block';
                    resetPasswordButton.disabled = true;
                    return false;
                } else {
                    resetConfirmPassword.classList.remove('is-invalid');
                    passwordMatchError.style.display = 'none';
                    resetPasswordButton.disabled = false;
                    return true;
                }
            }
            
            resetConfirmPassword?.addEventListener('keyup', validatePasswordMatch);
            resetNewPassword?.addEventListener('keyup', validatePasswordMatch);
            
            // Auto-update role badge based on role selection
            const newRoleSelect = document.getElementById('newRole');
            if (newRoleSelect) {
                newRoleSelect.addEventListener('change', function() {
                    // Additional custom logic can be added here if needed
                    console.log('Role changed to:', this.value);
                });
            }
            
            // Automatically set focus on appropriate fields when modals open
            $('#addUserModal').on('shown.bs.modal', function() {
                document.getElementById('newUsername').focus();
            });
            
            $('#editUserModal').on('shown.bs.modal', function() {
                document.getElementById('editFullName').focus();
            });
            
            $('#resetPasswordModal').on('shown.bs.modal', function() {
                document.getElementById('resetNewPassword').focus();
            });
        });
        
        // Function to populate and show edit user modal
        function editUser(id, username, fullName, email, role, contactNumber, address, isActive, isEmailVerified) {
            document.getElementById('editUserId').value = id;
            document.getElementById('editUsername').value = username;
            document.getElementById('editFullName').value = fullName;
            document.getElementById('editEmail').value = email;
            document.getElementById('editRole').value = role.toLowerCase();
            document.getElementById('editContactNumber').value = contactNumber;
            document.getElementById('editAddress').value = address;
            document.getElementById('editActive').checked = isActive;
            document.getElementById('editEmailVerified').checked = isEmailVerified;
            
            // Clear the password field (we don't want to prefill this)
            document.getElementById('editPassword').value = '';
            
            // Show the modal
            new bootstrap.Modal(document.getElementById('editUserModal')).show();
        }
        
        // Function to populate and show view user modal
        function viewUser(id, username, fullName, email, role, contactNumber, address, lastLogin, registrationDate, isActive, isEmailVerified) {
            // Set user data in the modal
            document.getElementById('viewUserFullName').textContent = fullName;
            document.getElementById('viewUserUsername').textContent = username;
            document.getElementById('viewUserEmail').textContent = email;
            document.getElementById('viewUserContact').textContent = contactNumber || 'Not provided';
            document.getElementById('viewUserAddress').textContent = address || 'Not provided';
            document.getElementById('viewUserRegistration').textContent = registrationDate;
            document.getElementById('viewUserLastLogin').textContent = lastLogin || 'Never logged in';
            
            // Set role badge
            let roleBadgeClass = '';
            let roleIcon = '';
            let roleText = '';
            
            if (role.toLowerCase() === 'admin') {
                roleBadgeClass = 'badge-admin';
                roleIcon = 'user-shield';
                roleText = 'Administrator';
            } else if (role.toLowerCase() === 'manager') {
                roleBadgeClass = 'badge-manager';
                roleIcon = 'user-tie';
                roleText = 'Manager';
            } else {
                roleBadgeClass = 'badge-user';
                roleIcon = 'user';
                roleText = 'Regular User';
            }
            
            document.getElementById('viewUserRole').innerHTML = `<span class="role-badge ${roleBadgeClass}">${roleText}</span>`;
            
            // Update avatar icon based on role
            const avatarElement = document.getElementById('viewUserAvatar');
            avatarElement.innerHTML = `<i class="fas fa-${roleIcon}"></i>`;
            
            // Set background color based on role
            if (role.toLowerCase() === 'admin') {
                avatarElement.style.backgroundColor = 'var(--admin-color)';
            } else if (role.toLowerCase() === 'manager') {
                avatarElement.style.backgroundColor = 'var(--manager-color)';
            } else {
                avatarElement.style.backgroundColor = 'var(--user-color)';
            }
            
            // Set user status
            document.getElementById('viewUserStatus').textContent = isActive ? 'Active' : 'Inactive';
            document.getElementById('viewUserStatus').className = isActive ? 'badge bg-success mb-3' : 'badge bg-danger mb-3';
            
            // Set email verification status
            document.getElementById('viewUserVerified').innerHTML = isEmailVerified ? 
                '<span class="badge bg-info"><i class="fas fa-envelope-circle-check me-1"></i>Email Verified</span>' : 
                '<span class="badge bg-warning text-dark"><i class="fas fa-exclamation-triangle me-1"></i>Email Not Verified</span>';
            
            // Set up edit button
            document.getElementById('viewEditButton').onclick = function() {
                // Close view modal
                bootstrap.Modal.getInstance(document.getElementById('viewUserModal')).hide();
                // Open edit modal
                editUser(id, username, fullName, email, role, contactNumber, address, isActive, isEmailVerified);
            };
            
            // Show the modal
            new bootstrap.Modal(document.getElementById('viewUserModal')).show();
        }
        
        // Function to initialize password reset modal
        function resetPassword(userId, username) {
            document.getElementById('resetUserId').value = userId;
            document.getElementById('resetUserUsername').textContent = username;
            document.getElementById('resetNewPassword').value = '';
            document.getElementById('resetConfirmPassword').value = '';
            document.getElementById('resetConfirmPassword').classList.remove('is-invalid');
            document.getElementById('passwordMatchError').style.display = 'none';
            document.getElementById('resetPasswordButton').disabled = false;
            
            // Show the modal
            new bootstrap.Modal(document.getElementById('resetPasswordModal')).show();
        }
        
        // Function to generate a random strong password
        function generateRandomPassword() {
            const length = 12;
            const charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+";
            let password = "";
            
            // Ensure at least one of each character type
            password += "ABCDEFGHIJKLMNOPQRSTUVWXYZ"[Math.floor(Math.random() * 26)]; // Uppercase
            password += "abcdefghijklmnopqrstuvwxyz"[Math.floor(Math.random() * 26)]; // Lowercase
            password += "0123456789"[Math.floor(Math.random() * 10)]; // Number
            password += "!@#$%^&*()_+"[Math.floor(Math.random() * 12)]; // Special char
            
            // Fill the rest randomly
            for (let i = 4; i < length; i++) {
                password += charset[Math.floor(Math.random() * charset.length)];
            }
            
            // Shuffle the password
            password = password.split('').sort(() => 0.5 - Math.random()).join('');
            
            return password;
        }
        
        // Display current system date and time on the page
        document.addEventListener('DOMContentLoaded', function() {
            // Set the current date/time and user in the footer
            const footerTimeElement = document.querySelector('footer p.small');
            if (footerTimeElement) {
                footerTimeElement.textContent = 'Current Date and Time (UTC): 2025-05-02 20:16:05 | User: IT24103866';
            }
        });
    </script>
</body>
</html>