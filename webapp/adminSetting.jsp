<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="org.json.*" %>

<%!
    // Helper class to represent a system settings
    public static class SystemSetting {
        private String id;
        private String name;
        private String description;
        private String value;
        private String type; // text, boolean, select, number
        private String[] options; // for select type
        private String category;
        
        public SystemSetting(String id, String name, String description, String value, String type, String category) {
            this.id = id;
            this.name = name;
            this.description = description;
            this.value = value;
            this.type = type;
            this.category = category;
        }
        
        public SystemSetting(String id, String name, String description, String value, String type, String[] options, String category) {
            this(id, name, description, value, type, category);
            this.options = options;
        }
        
        // Getters
        public String getId() { return id; }
        public String getName() { return name; }
        public String getDescription() { return description; }
        public String getValue() { return value; }
        public String getType() { return type; }
        public String[] getOptions() { return options; }
        public String getCategory() { return category; }
    }

    // Method to get default system settings
    public List<SystemSetting> getDefaultSettings() {
        List<SystemSetting> settings = new ArrayList<>();
        
        // General Settings
        settings.add(new SystemSetting(
            "company_name", 
            "Company Name", 
            "The name of your company that will appear throughout the system",
            "PropertyFinder Real Estate", 
            "text", 
            "general"
        ));
        
        settings.add(new SystemSetting(
            "contact_email", 
            "Contact Email", 
            "Primary email address for system notifications and user inquiries",
            "contact@propertyfinder.com", 
            "text", 
            "general"
        ));
        
        settings.add(new SystemSetting(
            "contact_phone", 
            "Contact Phone", 
            "Primary phone number for customer inquiries",
            "+1 (555) 123-4567", 
            "text", 
            "general"
        ));
        
        settings.add(new SystemSetting(
            "timezone", 
            "System Timezone", 
            "Default timezone for system operations and reporting",
            "UTC", 
            "select",
            new String[]{"UTC", "America/New_York", "America/Los_Angeles", "Europe/London", "Asia/Tokyo", "Australia/Sydney"},
            "general"
        ));
        
        // Property Listing Settings
        settings.add(new SystemSetting(
            "default_currency", 
            "Default Currency", 
            "Currency used for property prices",
            "USD", 
            "select",
            new String[]{"USD", "EUR", "GBP", "CAD", "AUD", "JPY"},
            "property"
        ));
        
        settings.add(new SystemSetting(
            "default_area_unit", 
            "Default Area Unit", 
            "Unit used for property area measurements",
            "sqft", 
            "select",
            new String[]{"sqft", "sqm", "acre"},
            "property"
        ));
        
        settings.add(new SystemSetting(
            "max_photos", 
            "Maximum Photos", 
            "Maximum number of photos allowed per property listing",
            "20", 
            "number", 
            "property"
        ));
        
        settings.add(new SystemSetting(
            "featured_duration", 
            "Featured Listing Duration", 
            "Number of days a property remains featured once marked",
            "30", 
            "number", 
            "property"
        ));
        
        // Notification Settings
        settings.add(new SystemSetting(
            "email_notifications", 
            "Email Notifications", 
            "Send system notifications via email",
            "true", 
            "boolean", 
            "notification"
        ));
        
        settings.add(new SystemSetting(
            "new_property_alert", 
            "New Property Alerts", 
            "Send notifications when new properties are listed",
            "true", 
            "boolean", 
            "notification"
        ));
        
        settings.add(new SystemSetting(
            "user_registration_alert", 
            "User Registration Alerts", 
            "Send notifications when new users register",
            "true", 
            "boolean", 
            "notification"
        ));
        
        settings.add(new SystemSetting(
            "inquiry_alert", 
            "Property Inquiry Alerts", 
            "Send notifications when users make property inquiries",
            "true", 
            "boolean", 
            "notification"
        ));
        
        // Security Settings
        settings.add(new SystemSetting(
            "password_expiry", 
            "Password Expiry (Days)", 
            "Number of days before users are required to change passwords (0 = never)",
            "90", 
            "number", 
            "security"
        ));
        
        settings.add(new SystemSetting(
            "session_timeout", 
            "Session Timeout (Minutes)", 
            "Number of minutes of inactivity before automatic logout",
            "30", 
            "number", 
            "security"
        ));
        
        settings.add(new SystemSetting(
            "two_factor_auth", 
            "Require Two-Factor Authentication", 
            "Enable two-factor authentication for admin users",
            "false", 
            "boolean", 
            "security"
        ));
        
        settings.add(new SystemSetting(
            "login_attempts", 
            "Maximum Login Attempts", 
            "Number of failed login attempts before account lockout",
            "5", 
            "number", 
            "security"
        ));
        
        // Appearance Settings
        settings.add(new SystemSetting(
            "color_scheme", 
            "Color Scheme", 
            "Primary color scheme for the admin interface",
            "blue", 
            "select",
            new String[]{"blue", "green", "purple", "orange", "red"},
            "appearance"
        ));
        
        settings.add(new SystemSetting(
            "logo_url", 
            "Company Logo URL", 
            "URL to company logo image (recommended size: 200x50px)",
            "/assets/images/logo.png", 
            "text", 
            "appearance"
        ));
        
        settings.add(new SystemSetting(
            "show_social_links", 
            "Show Social Media Links", 
            "Display social media links in the footer",
            "true", 
            "boolean", 
            "appearance"
        ));
        
        settings.add(new SystemSetting(
            "default_page_size", 
            "Default Page Size", 
            "Number of items to show per page in listings",
            "25", 
            "select",
            new String[]{"10", "25", "50", "100"},
            "appearance"
        ));
        
        return settings;
    }
    
    // Helper method to load settings from JSON file (or return defaults if file doesn't exist)
    public List<SystemSetting> loadSettings(String filePath) {
        List<SystemSetting> settings = getDefaultSettings();
        
        try {
            File file = new File(filePath);
            if (!file.exists()) {
                return settings;
            }
            
            String jsonContent = new String(Files.readAllBytes(Paths.get(filePath)));
            JSONObject jsonData = new JSONObject(jsonContent);
            
            if (jsonData.has("settings")) {
                JSONArray settingsArray = jsonData.getJSONArray("settings");
                Map<String, SystemSetting> settingsMap = new HashMap<>();
                
                // Convert settings list to map for easier lookup
                for (SystemSetting setting : settings) {
                    settingsMap.put(setting.getId(), setting);
                }
                
                // Update settings from JSON
                for (int i = 0; i < settingsArray.length(); i++) {
                    JSONObject settingJson = settingsArray.getJSONObject(i);
                    String id = settingJson.getString("id");
                    String value = settingJson.getString("value");
                    
                    if (settingsMap.containsKey(id)) {
                        SystemSetting setting = settingsMap.get(id);
                        // Create a new setting with updated value
                        if (setting.getOptions() != null) {
                            settingsMap.put(id, new SystemSetting(
                                setting.getId(),
                                setting.getName(),
                                setting.getDescription(),
                                value,
                                setting.getType(),
                                setting.getOptions(),
                                setting.getCategory()
                            ));
                        } else {
                            settingsMap.put(id, new SystemSetting(
                                setting.getId(),
                                setting.getName(),
                                setting.getDescription(),
                                value,
                                setting.getType(),
                                setting.getCategory()
                            ));
                        }
                    }
                }
                
                // Convert map back to list
                settings = new ArrayList<>(settingsMap.values());
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Return defaults if there's an error
        }
        
        return settings;
    }
    
    // Helper method to save settings to JSON file
    public boolean saveSettings(List<SystemSetting> settings, String filePath) {
        try {
            JSONObject jsonData = new JSONObject();
            JSONArray settingsArray = new JSONArray();
            
            // Add metadata
            jsonData.put("lastUpdated", "2025-05-02 22:38:22");
            jsonData.put("updatedBy", "IT24103866");
            
            // Convert settings to JSON array
            for (SystemSetting setting : settings) {
                JSONObject settingJson = new JSONObject();
                settingJson.put("id", setting.getId());
                settingJson.put("value", setting.getValue());
                settingJson.put("category", setting.getCategory());
                settingsArray.put(settingJson);
            }
            
            jsonData.put("settings", settingsArray);
            
            // Make sure directory exists
            File file = new File(filePath);
            file.getParentFile().mkdirs();
            
            // Write to file
            try (FileWriter writer = new FileWriter(file)) {
                writer.write(jsonData.toString(2)); // Pretty print with 2-space indentation
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        
        // Removed unreachable return false statement that was here
    }
    
    // Helper function to organize settings by category
    public Map<String, List<SystemSetting>> organizeSettingsByCategory(List<SystemSetting> settings) {
        Map<String, List<SystemSetting>> categorized = new HashMap<>();
        
        for (SystemSetting setting : settings) {
            String category = setting.getCategory();
            if (!categorized.containsKey(category)) {
                categorized.put(category, new ArrayList<>());
            }
            categorized.get(category).add(setting);
        }
        
        return categorized;
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
    
    // Path to settings data file
    String dataDir = "C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\data";
    String settingsFile = dataDir + File.separator + "adminSettings.json";
    
    // Load settings
    List<SystemSetting> allSettings = loadSettings(settingsFile);
    Map<String, List<SystemSetting>> categorizedSettings = organizeSettingsByCategory(allSettings);
    
    // Process form submission
    String message = "";
    boolean success = false;
    String activeCategory = "general"; // Default active tab
    
    if ("POST".equals(request.getMethod())) {
        try {
            // Get the category being submitted
            activeCategory = request.getParameter("category");
            if (activeCategory == null) {
                activeCategory = "general";
            }
            
            // Update settings
            for (SystemSetting setting : allSettings) {
                String paramValue = request.getParameter(setting.getId());
                if (paramValue != null) {
                    if (setting.getType().equals("boolean")) {
                        // For boolean type, check if parameter exists (checkbox was checked)
                        setting = new SystemSetting(
                            setting.getId(),
                            setting.getName(),
                            setting.getDescription(),
                            "on".equals(paramValue) ? "true" : "false",
                            setting.getType(),
                            setting.getCategory()
                        );
                    } else {
                        // For other types
                        if (setting.getOptions() != null) {
                            setting = new SystemSetting(
                                setting.getId(),
                                setting.getName(),
                                setting.getDescription(),
                                paramValue,
                                setting.getType(),
                                setting.getOptions(),
                                setting.getCategory()
                            );
                        } else {
                            setting = new SystemSetting(
                                setting.getId(),
                                setting.getName(),
                                setting.getDescription(),
                                paramValue,
                                setting.getType(),
                                setting.getCategory()
                            );
                        }
                    }
                }
            }
            
            // Save settings to file
            success = saveSettings(allSettings, settingsFile);
            
            if (success) {
                message = "Settings saved successfully.";
                // Re-categorize settings after update
                categorizedSettings = organizeSettingsByCategory(allSettings);
            } else {
                message = "Error saving settings. Please try again.";
            }
        } catch (Exception e) {
            message = "Error processing settings: " + e.getMessage();
            e.printStackTrace();
        }
    }
    
    // Current date and time for display
    String currentDateTime = "2025-05-02 22:38:22";
    String currentUserLogin = "IT24103866";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Settings | PropertyFinder Admin</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Toggle Switch CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap5-toggle@5.0.4/css/bootstrap5-toggle.min.css" rel="stylesheet">
    <style>
        :root {
            --dark-blue: #081c45;
            --medium-blue: #0e307e;
            --light-blue: #2a4494;
            --highlight-blue: #4568dc;
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
            color: var(--dark-blue);
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
        
        .settings-card {
            border-radius: 10px;
            border: none;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            margin-bottom: 20px;
            transition: all 0.3s;
        }
        
        .settings-card:hover {
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }
        
        .settings-card .card-header {
            background-color: white;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            padding: 15px 20px;
            font-weight: 600;
        }
        
        .settings-nav .nav-link {
            color: var(--medium-blue);
            border-radius: 5px;
            padding: 10px 15px;
            margin-bottom: 5px;
        }
        
        .settings-nav .nav-link:hover {
            background-color: rgba(13, 38, 76, 0.05);
            color: var(--medium-blue);
        }
        
        .settings-nav .nav-link.active {
            background-color: var(--medium-blue);
            color: white;
        }
        
        .settings-nav .nav-link i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-label {
            font-weight: 500;
        }
        
        .form-description {
            font-size: 0.875rem;
            color: #6c757d;
            margin-bottom: 0.5rem;
        }
        
        .boolean-toggle .form-check-input {
            height: 1.25rem;
            width: 2.5rem;
        }
        
        .boolean-toggle .form-check-input:checked {
            background-color: var(--medium-blue);
            border-color: var(--medium-blue);
        }
        
        .settings-footer {
            background-color: rgba(0, 0, 0, 0.02);
            border-top: 1px solid rgba(0, 0, 0, 0.05);
            padding: 15px 20px;
        }
        
        .change-history-list {
            max-height: 300px;
            overflow-y: auto;
        }
        
        .change-history-item {
            padding: 10px 0;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        }
        
        .change-history-item:last-child {
            border-bottom: none;
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
            <a href="dashboard.jsp" class="logo">
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
                <a class="nav-link" href="adminDashboard.jsp">
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
                <a class="nav-link active" href="adminSetting.jsp">
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
                <div>
                    <h2>System Settings</h2>
                    <p class="text-muted">Configure system preferences and options</p>
                </div>
                
                <div>
                    <button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#backupSettingsModal">
                        <i class="fas fa-download me-2"></i> Backup Settings
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
            
            <!-- Settings Card -->
            <div class="card settings-card">
                <div class="card-body p-0">
                    <div class="row g-0">
                        <!-- Settings Navigation Sidebar -->
                        <div class="col-lg-3 border-end">
                            <div class="p-4">
                                <h5 class="mb-3">Settings</h5>
                                <ul class="nav flex-column settings-nav" id="settingsTabs" role="tablist">
                                    <li class="nav-item" role="presentation">
                                        <a class="nav-link <%= "general".equals(activeCategory) ? "active" : "" %>" 
                                           id="general-tab" data-bs-toggle="tab" href="#general" role="tab" 
                                           aria-controls="general" aria-selected="<%= "general".equals(activeCategory) %>">
                                            <i class="fas fa-sliders-h"></i> General
                                        </a>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <a class="nav-link <%= "property".equals(activeCategory) ? "active" : "" %>" 
                                           id="property-tab" data-bs-toggle="tab" href="#property" role="tab" 
                                           aria-controls="property" aria-selected="<%= "property".equals(activeCategory) %>">
                                            <i class="fas fa-home"></i> Property Listings
                                        </a>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <a class="nav-link <%= "notification".equals(activeCategory) ? "active" : "" %>" 
                                           id="notification-tab" data-bs-toggle="tab" href="#notification" role="tab" 
                                           aria-controls="notification" aria-selected="<%= "notification".equals(activeCategory) %>">
                                            <i class="fas fa-bell"></i> Notifications
                                        </a>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <a class="nav-link <%= "security".equals(activeCategory) ? "active" : "" %>" 
                                           id="security-tab" data-bs-toggle="tab" href="#security" role="tab" 
                                           aria-controls="security" aria-selected="<%= "security".equals(activeCategory) %>">
                                            <i class="fas fa-shield-alt"></i> Security
                                        </a>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <a class="nav-link <%= "appearance".equals(activeCategory) ? "active" : "" %>" 
                                           id="appearance-tab" data-bs-toggle="tab" href="#appearance" role="tab" 
                                           aria-controls="appearance" aria-selected="<%= "appearance".equals(activeCategory) %>">
                                            <i class="fas fa-paint-brush"></i> Appearance
                                        </a>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <a class="nav-link" id="advanced-tab" data-bs-toggle="tab" href="#advanced" role="tab" 
                                           aria-controls="advanced" aria-selected="false">
                                            <i class="fas fa-tools"></i> Advanced
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        
                        <!-- Settings Content -->
                        <div class="col-lg-9">
                            <div class="tab-content p-4" id="settingsTabsContent">
                                <!-- General Settings Tab -->
                                <div class="tab-pane fade <%= "general".equals(activeCategory) ? "show active" : "" %>" id="general" role="tabpanel" aria-labelledby="general-tab">
                                    <h4 class="mb-4">General Settings</h4>
                                    <form action="adminSetting.jsp" method="post">
                                        <input type="hidden" name="category" value="general">
                                        
                                        <% if (categorizedSettings.containsKey("general")) {
                                            for (SystemSetting setting : categorizedSettings.get("general")) {
                                        %>
                                            <div class="form-group">
                                                <label for="<%= setting.getId() %>" class="form-label"><%= setting.getName() %></label>
                                                <p class="form-description"><%= setting.getDescription() %></p>
                                                
                                                <% if ("text".equals(setting.getType())) { %>
                                                    <input type="text" class="form-control" id="<%= setting.getId() %>" 
                                                           name="<%= setting.getId() %>" value="<%= setting.getValue() %>">
                                                           
                                                <% } else if ("boolean".equals(setting.getType())) { %>
                                                    <div class="form-check form-switch boolean-toggle">
                                                        <input type="checkbox" class="form-check-input" id="<%= setting.getId() %>" 
                                                               name="<%= setting.getId() %>" <%= "true".equals(setting.getValue()) ? "checked" : "" %>>
                                                    </div>
                                                    
                                                <% } else if ("number".equals(setting.getType())) { %>
                                                    <input type="number" class="form-control" id="<%= setting.getId() %>" 
                                                           name="<%= setting.getId() %>" value="<%= setting.getValue() %>">
                                                           
                                                <% } else if ("select".equals(setting.getType()) && setting.getOptions() != null) { %>
                                                    <select class="form-select" id="<%= setting.getId() %>" name="<%= setting.getId() %>">
                                                        <% for (String option : setting.getOptions()) { %>
                                                            <option value="<%= option %>" <%= option.equals(setting.getValue()) ? "selected" : "" %>><%= option %></option>
                                                        <% } %>
                                                    </select>
                                                <% } %>
                                            </div>
                                        <% } } %>
                                        
                                        <div class="settings-footer">
                                            <div class="d-flex justify-content-end">
                                                <button type="button" class="btn btn-outline-secondary me-2" onclick="resetTabForm(this.form)">
                                                    Reset
                                                </button>
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="fas fa-save me-2"></i>Save Changes
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                
                                <!-- Property Settings Tab -->
                                <div class="tab-pane fade <%= "property".equals(activeCategory) ? "show active" : "" %>" id="property" role="tabpanel" aria-labelledby="property-tab">
                                    <h4 class="mb-4">Property Listing Settings</h4>
                                    <form action="adminSetting.jsp" method="post">
                                        <input type="hidden" name="category" value="property">
                                        
                                        <% if (categorizedSettings.containsKey("property")) {
                                            for (SystemSetting setting : categorizedSettings.get("property")) {
                                        %>
                                            <div class="form-group">
                                                <label for="<%= setting.getId() %>" class="form-label"><%= setting.getName() %></label>
                                                <p class="form-description"><%= setting.getDescription() %></p>
                                                
                                                <% if ("text".equals(setting.getType())) { %>
                                                    <input type="text" class="form-control" id="<%= setting.getId() %>" 
                                                           name="<%= setting.getId() %>" value="<%= setting.getValue() %>">
                                                           
                                                <% } else if ("boolean".equals(setting.getType())) { %>
                                                    <div class="form-check form-switch boolean-toggle">
                                                        <input type="checkbox" class="form-check-input" id="<%= setting.getId() %>" 
                                                               name="<%= setting.getId() %>" <%= "true".equals(setting.getValue()) ? "checked" : "" %>>
                                                    </div>
                                                    
                                                <% } else if ("number".equals(setting.getType())) { %>
                                                    <input type="number" class="form-control" id="<%= setting.getId() %>" 
                                                           name="<%= setting.getId() %>" value="<%= setting.getValue() %>">
                                                           
                                                <% } else if ("select".equals(setting.getType()) && setting.getOptions() != null) { %>
                                                    <select class="form-select" id="<%= setting.getId() %>" name="<%= setting.getId() %>">
                                                        <% for (String option : setting.getOptions()) { %>
                                                            <option value="<%= option %>" <%= option.equals(setting.getValue()) ? "selected" : "" %>><%= option %></option>
                                                        <% } %>
                                                    </select>
                                                <% } %>
                                            </div>
                                        <% } } %>
                                        
                                        <div class="settings-footer">
                                            <div class="d-flex justify-content-end">
                                                <button type="button" class="btn btn-outline-secondary me-2" onclick="resetTabForm(this.form)">
                                                    Reset
                                                </button>
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="fas fa-save me-2"></i>Save Changes
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                
                                <!-- Notification Settings Tab -->
                                <div class="tab-pane fade <%= "notification".equals(activeCategory) ? "show active" : "" %>" id="notification" role="tabpanel" aria-labelledby="notification-tab">
                                    <h4 class="mb-4">Notification Settings</h4>
                                    <form action="adminSetting.jsp" method="post">
                                        <input type="hidden" name="category" value="notification">
                                        
                                        <% if (categorizedSettings.containsKey("notification")) {
                                            for (SystemSetting setting : categorizedSettings.get("notification")) {
                                        %>
                                            <div class="form-group">
                                                <label for="<%= setting.getId() %>" class="form-label"><%= setting.getName() %></label>
                                                <p class="form-description"><%= setting.getDescription() %></p>
                                                
                                                <% if ("text".equals(setting.getType())) { %>
                                                    <input type="text" class="form-control" id="<%= setting.getId() %>" 
                                                           name="<%= setting.getId() %>" value="<%= setting.getValue() %>">
                                                           
                                                <% } else if ("boolean".equals(setting.getType())) { %>
                                                    <div class="form-check form-switch boolean-toggle">
                                                        <input type="checkbox" class="form-check-input" id="<%= setting.getId() %>" 
                                                               name="<%= setting.getId() %>" <%= "true".equals(setting.getValue()) ? "checked" : "" %>>
                                                    </div>
                                                    
                                                <% } else if ("number".equals(setting.getType())) { %>
                                                    <input type="number" class="form-control" id="<%= setting.getId() %>" 
                                                           name="<%= setting.getId() %>" value="<%= setting.getValue() %>">
                                                           
                                                <% } else if ("select".equals(setting.getType()) && setting.getOptions() != null) { %>
                                                    <select class="form-select" id="<%= setting.getId() %>" name="<%= setting.getId() %>">
                                                        <% for (String option : setting.getOptions()) { %>
                                                            <option value="<%= option %>" <%= option.equals(setting.getValue()) ? "selected" : "" %>><%= option %></option>
                                                        <% } %>
                                                    </select>
                                                <% } %>
                                            </div>
                                        <% } } %>
                                        
                                        <div class="alert alert-info mt-3">
                                            <i class="fas fa-info-circle me-2"></i> Email templates can be customized in the Templates section.
                                        </div>
                                        
                                        <div class="settings-footer">
                                            <div class="d-flex justify-content-end">
                                                <button type="button" class="btn btn-outline-secondary me-2" onclick="resetTabForm(this.form)">
                                                    Reset
                                                </button>
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="fas fa-save me-2"></i>Save Changes
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                
                                <!-- Security Settings Tab -->
                                <div class="tab-pane fade <%= "security".equals(activeCategory) ? "show active" : "" %>" id="security" role="tabpanel" aria-labelledby="security-tab">
                                    <h4 class="mb-4">Security Settings</h4>
                                    <form action="adminSetting.jsp" method="post">
                                        <input type="hidden" name="category" value="security">
                                        
                                        <% if (categorizedSettings.containsKey("security")) {
                                            for (SystemSetting setting : categorizedSettings.get("security")) {
                                        %>
                                            <div class="form-group">
                                                <label for="<%= setting.getId() %>" class="form-label"><%= setting.getName() %></label>
                                                <p class="form-description"><%= setting.getDescription() %></p>
                                                
                                                <% if ("text".equals(setting.getType())) { %>
                                                    <input type="text" class="form-control" id="<%= setting.getId() %>" 
                                                           name="<%= setting.getId() %>" value="<%= setting.getValue() %>">
                                                           
                                                <% } else if ("boolean".equals(setting.getType())) { %>
                                                    <div class="form-check form-switch boolean-toggle">
                                                        <input type="checkbox" class="form-check-input" id="<%= setting.getId() %>" 
                                                               name="<%= setting.getId() %>" <%= "true".equals(setting.getValue()) ? "checked" : "" %>>
                                                    </div>
                                                    
                                                <% } else if ("number".equals(setting.getType())) { %>
                                                    <input type="number" class="form-control" id="<%= setting.getId() %>" 
                                                           name="<%= setting.getId() %>" value="<%= setting.getValue() %>">
                                                           
                                                <% } else if ("select".equals(setting.getType()) && setting.getOptions() != null) { %>
                                                    <select class="form-select" id="<%= setting.getId() %>" name="<%= setting.getId() %>">
                                                        <% for (String option : setting.getOptions()) { %>
                                                            <option value="<%= option %>" <%= option.equals(setting.getValue()) ? "selected" : "" %>><%= option %></option>
                                                        <% } %>
                                                    </select>
                                                <% } %>
                                            </div>
                                        <% } } %>
                                        
                                        <div class="alert alert-warning mt-3">
                                            <i class="fas fa-exclamation-triangle me-2"></i> Changing security settings may affect user access and require re-authentication.
                                        </div>
                                        
                                        <div class="settings-footer">
                                            <div class="d-flex justify-content-end">
                                                <button type="button" class="btn btn-outline-secondary me-2" onclick="resetTabForm(this.form)">
                                                    Reset
                                                </button>
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="fas fa-save me-2"></i>Save Changes
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                
                                <!-- Appearance Settings Tab -->
                                <div class="tab-pane fade <%= "appearance".equals(activeCategory) ? "show active" : "" %>" id="appearance" role="tabpanel" aria-labelledby="appearance-tab">
                                    <h4 class="mb-4">Appearance Settings</h4>
                                    <form action="adminSetting.jsp" method="post">
                                        <input type="hidden" name="category" value="appearance">
                                        
                                        <% if (categorizedSettings.containsKey("appearance")) {
                                            for (SystemSetting setting : categorizedSettings.get("appearance")) {
                                        %>
                                            <div class="form-group">
                                                <label for="<%= setting.getId() %>" class="form-label"><%= setting.getName() %></label>
                                                <p class="form-description"><%= setting.getDescription() %></p>
                                                
                                                <% if ("text".equals(setting.getType())) { %>
                                                    <input type="text" class="form-control" id="<%= setting.getId() %>" 
                                                           name="<%= setting.getId() %>" value="<%= setting.getValue() %>">
                                                           
                                                <% } else if ("boolean".equals(setting.getType())) { %>
                                                    <div class="form-check form-switch boolean-toggle">
                                                        <input type="checkbox" class="form-check-input" id="<%= setting.getId() %>" 
                                                               name="<%= setting.getId() %>" <%= "true".equals(setting.getValue()) ? "checked" : "" %>>
                                                    </div>
                                                    
                                                <% } else if ("number".equals(setting.getType())) { %>
                                                    <input type="number" class="form-control" id="<%= setting.getId() %>" 
                                                           name="<%= setting.getId() %>" value="<%= setting.getValue() %>">
                                                           
                                                <% } else if ("select".equals(setting.getType()) && setting.getOptions() != null) { %>
                                                    <select class="form-select" id="<%= setting.getId() %>" name="<%= setting.getId() %>">
                                                        <% for (String option : setting.getOptions()) { %>
                                                            <option value="<%= option %>" <%= option.equals(setting.getValue()) ? "selected" : "" %>><%= option %></option>
                                                        <% } %>
                                                    </select>
                                                <% } %>
                                                
                                                <% if ("color_scheme".equals(setting.getId())) { %>
                                                    <div class="d-flex mt-3 gap-2">
                                                        <div class="color-preview blue" style="width: 30px; height: 30px; border-radius: 50%; background-color: #081c45; cursor: pointer;"></div>
                                                        <div class="color-preview green" style="width: 30px; height: 30px; border-radius: 50%; background-color: #146c43; cursor: pointer;"></div>
                                                        <div class="color-preview purple" style="width: 30px; height: 30px; border-radius: 50%; background-color: #4e1d9e; cursor: pointer;"></div>
                                                        <div class="color-preview orange" style="width: 30px; height: 30px; border-radius: 50%; background-color: #e67a00; cursor: pointer;"></div>
                                                        <div class="color-preview red" style="width: 30px; height: 30px; border-radius: 50%; background-color: #dc3545; cursor: pointer;"></div>
                                                    </div>
                                                <% } %>
                                                
                                                <% if ("logo_url".equals(setting.getId())) { %>
                                                    <div class="mt-2">
                                                        <button type="button" class="btn btn-sm btn-outline-secondary">Upload Logo</button>
                                                    </div>
                                                <% } %>
                                            </div>
                                        <% } } %>
                                        
                                        <div class="settings-footer">
                                            <div class="d-flex justify-content-end">
                                                <button type="button" class="btn btn-outline-secondary me-2" onclick="resetTabForm(this.form)">
                                                    Reset
                                                </button>
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="fas fa-save me-2"></i>Save Changes
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                
                                <!-- Advanced Settings Tab -->
                                <div class="tab-pane fade" id="advanced" role="tabpanel" aria-labelledby="advanced-tab">
                                    <h4 class="mb-4">Advanced Settings</h4>
                                    
                                    <div class="alert alert-danger mb-4">
                                        <i class="fas fa-exclamation-triangle me-2"></i>
                                        <strong>Warning:</strong> These settings can significantly impact system functionality. 
                                        Make changes only if you understand the implications.
                                    </div>
                                    
                                    <div class="settings-group mb-4">
                                        <h5>System Maintenance</h5>
                                        <div class="row g-3 mt-2">
                                            <div class="col-lg-6">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <h6>Clear System Cache</h6>
                                                        <p class="text-muted small">Removes temporary files to improve performance.</p>
                                                        <button type="button" class="btn btn-outline-primary btn-sm">Clear Cache</button>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <h6>Optimize Database</h6>
                                                        <p class="text-muted small">Run database optimization routines.</p>
                                                        <button type="button" class="btn btn-outline-primary btn-sm">Optimize Now</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="settings-group mb-4">
                                        <h5>Data Management</h5>
                                        <div class="row g-3 mt-2">
                                            <div class="col-lg-6">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <h6>Import Data</h6>
                                                        <p class="text-muted small">Import properties, users, or agents from CSV/XML.</p>
                                                        <button type="button" class="btn btn-outline-primary btn-sm" data-bs-toggle="modal" data-bs-target="#importDataModal">Import Data</button>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <h6>Export Data</h6>
                                                        <p class="text-muted small">Export system data to CSV/XML format.</p>
                                                        <button type="button" class="btn btn-outline-primary btn-sm" data-bs-toggle="modal" data-bs-target="#exportDataModal">Export Data</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="settings-group">
                                        <h5>System Settings Change History</h5>
                                        <div class="card mt-2">
                                            <div class="card-body p-0">
                                                <div class="change-history-list p-3">
                                                    <div class="change-history-item">
                                                        <div class="d-flex justify-content-between">
                                                            <span class="fw-bold">Company Name Updated</span>
                                                            <span class="text-muted">2025-05-01 14:32:15</span>
                                                        </div>
                                                        <p class="mb-0 text-muted small">Changed from "Real Estate Co." to "PropertyFinder Real Estate" by admin</p>
                                                    </div>
                                                    <div class="change-history-item">
                                                        <div class="d-flex justify-content-between">
                                                            <span class="fw-bold">Security Settings Modified</span>
                                                            <span class="text-muted">2025-04-28 09:15:43</span>
                                                        </div>
                                                        <p class="mb-0 text-muted small">Session timeout changed from 60 to 30 minutes by admin</p>
                                                    </div>
                                                    <div class="change-history-item">
                                                        <div class="d-flex justify-content-between">
                                                            <span class="fw-bold">Email Notifications Enabled</span>
                                                            <span class="text-muted">2025-04-25 16:08:22</span>
                                                        </div>
                                                        <p class="mb-0 text-muted small">Email notifications for new user registrations turned on by admin</p>
                                                    </div>
                                                    <div class="change-history-item">
                                                        <div class="d-flex justify-content-between">
                                                            <span class="fw-bold">Color Scheme Changed</span>
                                                            <span class="text-muted">2025-04-20 11:47:36</span>
                                                        </div>
                                                        <p class="mb-0 text-muted small">Interface color scheme changed from "green" to "blue" by admin</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Footer -->
            <footer class="mt-4">
                <div class="text-center text-muted">
                    <p>&copy; 2025 PropertyFinder Administrative Panel. All rights reserved.</p>
                    <p class="small">Current Date and Time (UTC): <%= currentDateTime %> | User: <%= currentUserLogin %></p>
                </div>
            </footer>
        </div>
    </div>
    
    <!-- Backup Settings Modal -->
    <div class="modal fade" id="backupSettingsModal" tabindex="-1" aria-labelledby="backupSettingsModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="backupSettingsModalLabel">Backup System Settings</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Create a backup of your system settings for safekeeping or transfer to another installation.</p>
                    
                    <div class="mb-3">
                        <label for="backupName" class="form-label">Backup Name</label>
                        <input type="text" class="form-control" id="backupName" value="PropertyFinder-Settings-Backup-<%= currentDateTime.replace(" ", "-").replace(":", "-") %>">
                    </div>
                    
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="includeUserSettings" checked>
                        <label class="form-check-label" for="includeUserSettings">
                            Include user-specific settings
                        </label>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary">Download Backup</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Import Data Modal -->
    <div class="modal fade" id="importDataModal" tabindex="-1" aria-labelledby="importDataModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="importDataModalLabel">Import Data</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="importType" class="form-label">Import Type</label>
                        <select class="form-select" id="importType">
                            <option value="properties">Properties</option>
                            <option value="users">Users</option>
                            <option value="agents">Agents</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="importFile" class="form-label">Select File</label>
                        <input class="form-control" type="file" id="importFile">
                        <div class="form-text">Supported formats: CSV, XML, JSON</div>
                    </div>
                    <div class="form-check mb-3">
                        <input class="form-check-input" type="checkbox" id="overwriteExisting">
                        <label class="form-check-label" for="overwriteExisting">
                            Overwrite existing records with matching IDs
                        </label>
                    </div>
                    <div class="alert alert-warning">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        Importing data may overwrite existing records. Please ensure you have a backup.
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary">Import</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Export Data Modal -->
    <div class="modal fade" id="exportDataModal" tabindex="-1" aria-labelledby="exportDataModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exportDataModalLabel">Export Data</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="exportType" class="form-label">Export Type</label>
                        <select class="form-select" id="exportType">
                            <option value="properties">Properties</option>
                            <option value="users">Users</option>
                            <option value="agents">Agents</option>
                            <option value="all">All Data</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="exportFormat" class="form-label">Format</label>
                        <select class="form-select" id="exportFormat">
                            <option value="csv">CSV</option>
                            <option value="xml">XML</option>
                            <option value="json">JSON</option>
                        </select>
                    </div>
                    <div class="form-check mb-3">
                        <input class="form-check-input" type="checkbox" id="includeArchived">
                        <label class="form-check-label" for="includeArchived">
                            Include archived/inactive records
                        </label>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary">Export</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Bootstrap Toggle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap5-toggle@5.0.4/js/bootstrap5-toggle.ecmas.min.js"></script>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
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
            
            // Settings tab functions
            const settingsTabs = document.querySelectorAll('#settingsTabs a');
            settingsTabs.forEach(tab => {
                tab.addEventListener('click', function(e) {
                    // Store active tab in session storage for persistence
                    sessionStorage.setItem('activeSettingsTab', this.getAttribute('href').substring(1));
                });
            });
            
            // Restore tab state on page load if saved in session storage
            const activeTab = sessionStorage.getItem('activeSettingsTab');
            if (activeTab) {
                const savedTab = document.querySelector(`#settingsTabs a[href="#${activeTab}"]`);
                if (savedTab && !savedTab.classList.contains('active')) {
                    // Only trigger click if not already active (avoids loop)
                    savedTab.click();
                }
            }
            
            // Color scheme preview click handlers
            document.querySelectorAll('.color-preview').forEach(preview => {
                preview.addEventListener('click', function() {
                    // Get the color scheme name from the class
                    const colorScheme = this.className.split(' ')[1]; // e.g. "blue", "green", etc.
                    document.querySelector('#color_scheme').value = colorScheme;
                });
            });
        });
        
        // Function to reset a form to its initial values
        function resetTabForm(form) {
            if (confirm('Are you sure you want to reset these settings to their current values? Any unsaved changes will be lost.')) {
                form.reset();
            }
        }
        
        // Handle color scheme preview functionality
        document.addEventListener('DOMContentLoaded', function() {
            const colorPreviews = document.querySelectorAll('.color-preview');
            
            colorPreviews.forEach(preview => {
                preview.addEventListener('click', function() {
                    // Get color scheme from class
                    const scheme = this.classList[1]; // "blue", "green", etc.
                    
                    // Update the select box
                    const colorSchemeSelect = document.getElementById('color_scheme');
                    if (colorSchemeSelect) {
                        colorSchemeSelect.value = scheme;
                    }
                    
                    // Add visual indication of selection
                    colorPreviews.forEach(p => p.style.border = 'none');
                    this.style.border = '2px solid #333';
                });
            });
            
            // Set initial border around the currently selected color scheme
            const currentScheme = document.getElementById('color_scheme')?.value;
            if (currentScheme) {
                const activePreview = document.querySelector(`.color-preview.${currentScheme}`);
                if (activePreview) {
                    activePreview.style.border = '2px solid #333';
                }
            }
            
            // Update footer timestamp
            const footerTimeElement = document.querySelector('footer p.small');
            if (footerTimeElement) {
                footerTimeElement.textContent = 'Current Date and Time (UTC): 2025-05-02 22:44:17 | User: IT24103866';
            }
            
            // Handle backup settings button
            document.querySelector('#backupSettingsModal .btn-primary').addEventListener('click', function() {
                const backupName = document.getElementById('backupName').value;
                const includeUserSettings = document.getElementById('includeUserSettings').checked;
                
                // In a real application, this would trigger an AJAX request to generate and download the backup
                alert('Backup initiated: ' + backupName + (includeUserSettings ? ' (including user settings)' : ''));
                
                // Close modal
                bootstrap.Modal.getInstance(document.getElementById('backupSettingsModal')).hide();
            });
            
            // Handle import data button
            document.querySelector('#importDataModal .btn-primary').addEventListener('click', function() {
                const importType = document.getElementById('importType').value;
                const importFile = document.getElementById('importFile').files[0];
                const overwriteExisting = document.getElementById('overwriteExisting').checked;
                
                if (!importFile) {
                    alert('Please select a file to import.');
                    return;
                }
                
                // In a real application, this would trigger file upload and processing
                alert('Import started for: ' + importType + '\nFile: ' + importFile.name + 
                      (overwriteExisting ? '\nOverwriting existing records.' : ''));
                
                // Close modal
                bootstrap.Modal.getInstance(document.getElementById('importDataModal')).hide();
            });
            
            // Handle export data button
            document.querySelector('#exportDataModal .btn-primary').addEventListener('click', function() {
                const exportType = document.getElementById('exportType').value;
                const exportFormat = document.getElementById('exportFormat').value;
                const includeArchived = document.getElementById('includeArchived').checked;
                
                // In a real application, this would trigger data export generation
                alert('Export initiated for: ' + exportType + '\nFormat: ' + exportFormat +
                      (includeArchived ? '\nIncluding archived records.' : ''));
                
                // Close modal
                bootstrap.Modal.getInstance(document.getElementById('exportDataModal')).hide();
            });
        });
    </script>
</body>
</html>