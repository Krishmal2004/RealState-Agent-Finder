<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="org.json.*" %>

<%!
    // Helper method to count users by role
    public Map<String, Integer> countUsersByRole(String userFilePath) {
        Map<String, Integer> counts = new HashMap<>();
        counts.put("admin", 0);
        counts.put("manager", 0);
        counts.put("user", 0);
        counts.put("total", 0);
        counts.put("active", 0);
        
        try {
            File file = new File(userFilePath);
            if (!file.exists()) {
                return counts;
            }
            
            String jsonContent = new String(Files.readAllBytes(Paths.get(userFilePath)));
            JSONObject jsonData = new JSONObject(jsonContent);
            
            if (jsonData.has("users")) {
                JSONArray usersArray = jsonData.getJSONArray("users");
                
                for (int i = 0; i < usersArray.length(); i++) {
                    JSONObject user = usersArray.getJSONObject(i);
                    String role = user.optString("role", "user").toLowerCase();
                    boolean active = user.optBoolean("active", false);
                    
                    // Count by role
                    if ("admin".equals(role)) {
                        counts.put("admin", counts.get("admin") + 1);
                    } else if ("manager".equals(role)) {
                        counts.put("manager", counts.get("manager") + 1);
                    } else {
                        counts.put("user", counts.get("user") + 1);
                    }
                    
                    // Count active users
                    if (active) {
                        counts.put("active", counts.get("active") + 1);
                    }
                    
                    // Increment total
                    counts.put("total", counts.get("total") + 1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return counts;
    }
    
    // Helper method to count agents by specialty
    public Map<String, Integer> countAgentsBySpecialty(String agentFilePath) {
        Map<String, Integer> counts = new HashMap<>();
        counts.put("residential", 0);
        counts.put("commercial", 0);
        counts.put("luxury", 0);
        counts.put("land", 0);
        counts.put("industrial", 0);
        counts.put("total", 0);
        counts.put("active", 0);
        counts.put("featured", 0);
        
        try {
            File file = new File(agentFilePath);
            if (!file.exists()) {
                return counts;
            }
            
            String jsonContent = new String(Files.readAllBytes(Paths.get(agentFilePath)));
            JSONObject jsonData = new JSONObject(jsonContent);
            
            if (jsonData.has("agents")) {
                JSONArray agentsArray = jsonData.getJSONArray("agents");
                
                for (int i = 0; i < agentsArray.length(); i++) {
                    JSONObject agent = agentsArray.getJSONObject(i);
                    String specialty = agent.optString("specialty", "").toLowerCase();
                    boolean active = agent.optBoolean("active", false);
                    boolean featured = agent.optBoolean("featured", false);
                    
                    // Count by specialty
                    if ("residential".equals(specialty)) {
                        counts.put("residential", counts.get("residential") + 1);
                    } else if ("commercial".equals(specialty)) {
                        counts.put("commercial", counts.get("commercial") + 1);
                    } else if ("luxury".equals(specialty)) {
                        counts.put("luxury", counts.get("luxury") + 1);
                    } else if ("land".equals(specialty)) {
                        counts.put("land", counts.get("land") + 1);
                    } else if ("industrial".equals(specialty)) {
                        counts.put("industrial", counts.get("industrial") + 1);
                    }
                    
                    // Count active and featured agents
                    if (active) {
                        counts.put("active", counts.get("active") + 1);
                    }
                    
                    if (featured) {
                        counts.put("featured", counts.get("featured") + 1);
                    }
                    
                    // Increment total
                    counts.put("total", counts.get("total") + 1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return counts;
    }
    
    // Helper method to count properties by type and status
    public Map<String, Integer> countProperties(String propertyFilePath) {
        Map<String, Integer> counts = new HashMap<>();
        counts.put("house", 0);
        counts.put("apartment", 0);
        counts.put("commercial", 0);
        counts.put("land", 0);
        counts.put("total", 0);
        counts.put("available", 0);
        counts.put("sold", 0);
        counts.put("pending", 0);
        counts.put("rented", 0);
        counts.put("featured", 0);
        
        // Additional statistics
        counts.put("totalValue", 0);  // Sum of all property prices
        
        try {
            File file = new File(propertyFilePath);
            if (!file.exists()) {
                return counts;
            }
            
            String jsonContent = new String(Files.readAllBytes(Paths.get(propertyFilePath)));
            JSONObject jsonData = new JSONObject(jsonContent);
            
            if (jsonData.has("properties")) {
                JSONArray propertiesArray = jsonData.getJSONArray("properties");
                
                for (int i = 0; i < propertiesArray.length(); i++) {
                    JSONObject property = propertiesArray.getJSONObject(i);
                    String propertyType = property.optString("propertyType", "").toLowerCase();
                    String status = property.optString("status", "").toLowerCase();
                    boolean featured = property.optBoolean("featured", false);
                    int price = property.optInt("price", 0);
                    
                    // Count by property type
                    if ("house".equals(propertyType)) {
                        counts.put("house", counts.get("house") + 1);
                    } else if ("apartment".equals(propertyType)) {
                        counts.put("apartment", counts.get("apartment") + 1);
                    } else if ("commercial".equals(propertyType)) {
                        counts.put("commercial", counts.get("commercial") + 1);
                    } else if ("land".equals(propertyType)) {
                        counts.put("land", counts.get("land") + 1);
                    }
                    
                    // Count by status
                    if ("available".equals(status)) {
                        counts.put("available", counts.get("available") + 1);
                    } else if ("sold".equals(status)) {
                        counts.put("sold", counts.get("sold") + 1);
                    } else if ("pending".equals(status)) {
                        counts.put("pending", counts.get("pending") + 1);
                    } else if ("rented".equals(status)) {
                        counts.put("rented", counts.get("rented") + 1);
                    }
                    
                    // Count featured properties
                    if (featured) {
                        counts.put("featured", counts.get("featured") + 1);
                    }
                    
                    // Add to total value
                    counts.put("totalValue", counts.get("totalValue") + price);
                    
                    // Increment total
                    counts.put("total", counts.get("total") + 1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return counts;
    }
    
    // Helper class to represent a recent activity
    public static class Activity {
        private String type; // "property", "user", "agent"
        private String action; // "added", "updated", "deleted", etc.
        private String itemId;
        private String itemName;
        private String timestamp;
        private String user;
        
        public Activity(String type, String action, String itemId, String itemName, String timestamp, String user) {
            this.type = type;
            this.action = action;
            this.itemId = itemId;
            this.itemName = itemName;
            this.timestamp = timestamp;
            this.user = user;
        }
        
        public String getType() { return type; }
        public String getAction() { return action; }
        public String getItemId() { return itemId; }
        public String getItemName() { return itemName; }
        public String getTimestamp() { return timestamp; }
        public String getUser() { return user; }
    }
    
    // Method to generate some sample recent activities
    public List<Activity> getSampleActivities() {
        List<Activity> activities = new ArrayList<>();
        
        // Add sample activities
        activities.add(new Activity("property", "added", "12345", "Modern 3-Bedroom House with Garden", "2025-05-02 21:30:15", "admin"));
        activities.add(new Activity("agent", "updated", "AG23456789", "Jane Smith", "2025-05-02 21:15:22", "admin"));
        activities.add(new Activity("user", "added", "USR00000006", "Robert Johnson", "2025-05-02 20:55:10", "admin"));
        activities.add(new Activity("property", "sold", "12346", "Luxury Downtown Apartment", "2025-05-02 19:42:38", "admin"));
        activities.add(new Activity("property", "featured", "12347", "Commercial Office Space", "2025-05-02 18:30:45", "admin"));
        activities.add(new Activity("agent", "featured", "AG12345678", "John Doe", "2025-05-02 17:22:18", "admin"));
        activities.add(new Activity("user", "deactivated", "USR00000004", "Jane Smith", "2025-05-02 16:15:30", "admin"));
        activities.add(new Activity("property", "updated", "12348", "Beachfront Villa with Pool", "2025-05-02 15:05:12", "admin"));
        
        return activities;
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
    
    // Data paths
    String dataDir = "C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\data";
    String userFile = dataDir + File.separator + "userManagement.json";
    String agentFile = dataDir + File.separator + "agentsManagement.json";
    String propertyFile = dataDir + File.separator + "propertiesManagement.json";
    
    // Get counts and statistics
    Map<String, Integer> userStats = countUsersByRole(userFile);
    Map<String, Integer> agentStats = countAgentsBySpecialty(agentFile);
    Map<String, Integer> propertyStats = countProperties(propertyFile);
    
    // Get recent activities
    List<Activity> recentActivities = getSampleActivities();
    
    // Set the current date and time
    String currentDateTime = "2025-05-02 21:35:25";
    String currentUserLogin = "IT24103866";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | PropertyFinder</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Chart.js -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.css">
    <style>
        :root {
            --dark-blue: #081c45;
            --medium-blue: #0e307e;
            --light-blue: #2a4494;
            --highlight-blue: #4568dc;
            --house-color: #3a86ff;
            --apartment-color: #ff006e;
            --commercial-color: #9d4edd;
            --land-color: #38b000;
            --user-color: #3c8dbc;
            --agent-color: #ff9f1c;
            --admin-color: #4e1d9e;
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
        
        .dashboard-card {
            border-radius: 10px;
            border: none;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            margin-bottom: 20px;
            transition: all 0.3s;
        }
        
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }
        
        .stats-card {
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.1) 0%, rgba(255, 255, 255, 0.05) 100%);
            border-radius: 16px;
            overflow: hidden;
            padding: 20px;
            position: relative;
            transition: all 0.3s ease;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            color: white;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        
        .stats-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.25);
        }
        
        .stats-card.property-card {
            background: linear-gradient(135deg, var(--house-color) 0%, #1b4cd1 100%);
        }
        
        .stats-card.agent-card {
            background: linear-gradient(135deg, var(--agent-color) 0%, #e07a00 100%);
        }
        
        .stats-card.user-card {
            background: linear-gradient(135deg, var(--user-color) 0%, #2a6389 100%);
        }
        
        .stats-card.revenue-card {
            background: linear-gradient(135deg, #00b4d8 0%, #0077b6 100%);
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
            margin-bottom: 0.5rem;
        }
        
        .stats-card .stats-title {
            font-size: 1.1rem;
            margin-bottom: 0;
        }
        
        .stats-card .stats-subtitle {
            font-size: 0.9rem;
            opacity: 0.7;
        }
        
        .stats-card .progress {
            height: 5px;
            background-color: rgba(255, 255, 255, 0.2);
            margin-top: 15px;
            border-radius: 5px;
        }
        
        .stats-card .progress-bar {
            border-radius: 5px;
            background-color: rgba(255, 255, 255, 0.8);
        }
        
        .chart-container {
            position: relative;
            height: 300px;
            width: 100%;
        }
        
        .activity-list {
            max-height: 400px;
            overflow-y: auto;
        }
        
        .activity-item {
            padding: 15px;
            border-left: 3px solid #ddd;
            position: relative;
            margin-left: 20px;
            margin-bottom: 15px;
            transition: all 0.3s;
        }
        
        .activity-item:hover {
            background-color: rgba(13, 38, 76, 0.05);
            transform: translateX(5px);
        }
        
        .activity-item::before {
            content: '';
            width: 15px;
            height: 15px;
            border-radius: 50%;
            background-color: white;
            border: 3px solid #ddd;
            position: absolute;
            left: -9px;
            top: 20px;
        }
        
        .activity-item.property-activity {
            border-left-color: var(--house-color);
        }
        
        .activity-item.property-activity::before {
            border-color: var(--house-color);
        }
        
        .activity-item.agent-activity {
            border-left-color: var(--agent-color);
        }
        
        .activity-item.agent-activity::before {
            border-color: var(--agent-color);
        }
        
        .activity-item.user-activity {
            border-left-color: var(--user-color);
        }
        
        .activity-item.user-activity::before {
            border-color: var(--user-color);
        }
        
        .quick-action-card {
            border-radius: 10px;
            transition: all 0.3s;
            background-color: white;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            cursor: pointer;
            text-align: center;
            padding: 20px 15px;
            height: 100%;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }
        
        .quick-action-card:hover {
            background-color: var(--light-blue);
            color: white;
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }
        
        .quick-action-card:hover .quick-action-icon {
            color: white;
            transform: scale(1.1);
        }
        
        .quick-action-icon {
            font-size: 2rem;
            margin-bottom: 15px;
            color: var(--medium-blue);
            transition: all 0.3s;
        }
        
        .badge-house {
            background-color: var(--house-color);
            color: white;
        }
        
        .badge-apartment {
            background-color: var(--apartment-color);
            color: white;
        }
        
        .badge-commercial {
            background-color: var(--commercial-color);
            color: white;
        }
        
        .badge-land {
            background-color: var(--land-color);
            color: white;
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
                <a class="nav-link active" href="adminDasboardChart.jsp">
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
            <!-- Page Header with Welcome Message -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="card dashboard-card">
                        <div class="card-body p-4">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h2 class="mb-1">Welcome back, <%= fullName %>!</h2>
                                    <p class="text-muted mb-0">Here's what's happening with your properties today.</p>
                                </div>
                                <div class="text-end">
                                    <p class="mb-0 text-muted"><i class="fas fa-calendar-alt me-2"></i><%= currentDateTime %></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Main Stats Cards -->
            <div class="row mb-4">
                <div class="col-md-6 col-lg-3 mb-4 mb-lg-0">
                    <div class="stats-card property-card">
                        <div class="icon">
                            <i class="fas fa-home"></i>
                        </div>
                        <div>
                            <h2 class="stats-number"><%= propertyStats.get("total") %></h2>
                            <p class="stats-title">Total Properties</p>
                            <p class="stats-subtitle"><%= propertyStats.get("available") %> available, <%= propertyStats.get("sold") %> sold</p>
                        </div>
                        <div class="progress">
                            <div class="progress-bar" role="progressbar" style="width: <%= propertyStats.get("available") * 100 / Math.max(1, propertyStats.get("total")) %>%" aria-valuenow="<%= propertyStats.get("available") %>" aria-valuemin="0" aria-valuemax="<%= propertyStats.get("total") %>"></div>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-6 col-lg-3 mb-4 mb-lg-0">
                    <div class="stats-card agent-card">
                        <div class="icon">
                            <i class="fas fa-user-tie"></i>
                        </div>
                        <div>
                            <h2 class="stats-number"><%= agentStats.get("total") %></h2>
                            <p class="stats-title">Total Agents</p>
                            <p class="stats-subtitle"><%= agentStats.get("active") %> active, <%= agentStats.get("featured") %> featured</p>
                        </div>
                        <div class="progress">
                            <div class="progress-bar" role="progressbar" style="width: <%= agentStats.get("active") * 100 / Math.max(1, agentStats.get("total")) %>%" aria-valuenow="<%= agentStats.get("active") %>" aria-valuemin="0" aria-valuemax="<%= agentStats.get("total") %>"></div>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-6 col-lg-3 mb-4 mb-md-0">
                    <div class="stats-card user-card">
                        <div class="icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <div>
                            <h2 class="stats-number"><%= userStats.get("total") %></h2>
                            <p class="stats-title">Total Users</p>
                            <p class="stats-subtitle"><%= userStats.get("active") %> active accounts</p>
                        </div>
                        <div class="progress">
                            <div class="progress-bar" role="progressbar" style="width: <%= userStats.get("active") * 100 / Math.max(1, userStats.get("total")) %>%" aria-valuenow="<%= userStats.get("active") %>" aria-valuemin="0" aria-valuemax="<%= userStats.get("total") %>"></div>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-6 col-lg-3">
                    <div class="stats-card revenue-card">
                        <div class="icon">
                            <i class="fas fa-dollar-sign"></i>
                        </div>
                        <div>
                            <h2 class="stats-number">$<%= String.format("%,d", propertyStats.get("totalValue")) %></h2>
                            <p class="stats-title">Total Property Value</p>
                            <p class="stats-subtitle">Across <%= propertyStats.get("total") %> properties</p>
                        </div>
                        <div class="progress">
                            <div class="progress-bar" role="progressbar" style="width: 75%" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Quick Actions Grid -->
            <div class="row mb-4">
                <div class="col-12">
                    <h4 class="mb-3">Quick Actions</h4>
                </div>
                
                <div class="col-6 col-md-3 mb-3">
                    <a href="propertyManagement.jsp" class="text-decoration-none">
                        <div class="quick-action-card">
                            <div class="quick-action-icon">
                                <i class="fas fa-plus-circle"></i>
                            </div>
                            <h5>Add Property</h5>
                        </div>
                    </a>
                </div>
                
                <div class="col-6 col-md-3 mb-3">
                    <a href="agentManagement.jsp" class="text-decoration-none">
                        <div class="quick-action-card">
                            <div class="quick-action-icon">
                                <i class="fas fa-user-plus"></i>
                            </div>
                            <h5>Add Agent</h5>
                        </div>
                    </a>
                </div>
                
                <div class="col-6 col-md-3 mb-3">
                    <a href="adminDashboard.jsp" class="text-decoration-none">
                        <div class="quick-action-card">
                            <div class="quick-action-icon">
                                <i class="fas fa-user-cog"></i>
                            </div>
                            <h5>Manage Users</h5>
                        </div>
                    </a>
                </div>
                
                <div class="col-6 col-md-3 mb-3">
                    <a href="adminAnalytics.jsp" class="text-decoration-none">
                        <div class="quick-action-card">
                            <div class="quick-action-icon">
                                <i class="fas fa-chart-line"></i>
                            </div>
                            <h5>View Analytics</h5>
                        </div>
                    </a>
                </div>
            </div>
            
            <!-- Charts and Activity Row -->
            <div class="row mb-4">
                <!-- Property Charts -->
                <div class="col-md-8">
                    <div class="card dashboard-card h-100">
                        <div class="card-header bg-white py-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">Property Analytics</h5>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-sm btn-outline-secondary active" data-chart="type">By Type</button>
                                    <button type="button" class="btn btn-sm btn-outline-secondary" data-chart="status">By Status</button>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="chart-container">
                                <canvas id="propertyChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Recent Activity -->
                <div class="col-md-4">
                    <div class="card dashboard-card h-100">
                        <div class="card-header bg-white py-3">
                            <h5 class="mb-0">Recent Activity</h5>
                        </div>
                        <div class="card-body p-0">
                            <div class="activity-list px-3 py-1">
                                <% for (Activity activity : recentActivities) { 
                                    String activityClass = activity.getType() + "-activity";
                                    String actionIcon = "";
                                    
                                    if ("added".equals(activity.getAction())) {
                                        actionIcon = "fas fa-plus-circle";
                                    } else if ("updated".equals(activity.getAction())) {
                                        actionIcon = "fas fa-edit";
                                    } else if ("deleted".equals(activity.getAction())) {
                                        actionIcon = "fas fa-trash";
                                    } else if ("sold".equals(activity.getAction())) {
                                        actionIcon = "fas fa-handshake";
                                    } else if ("featured".equals(activity.getAction())) {
                                        actionIcon = "fas fa-star";
                                    } else if ("deactivated".equals(activity.getAction())) {
                                        actionIcon = "fas fa-user-slash";
                                    } else {
                                        actionIcon = "fas fa-info-circle";
                                    }
                                %>
                                    <div class="activity-item <%= activityClass %>">
                                        <div class="d-flex justify-content-between mb-1">
                                            <div>
                                                <span class="fw-bold"><i class="<%= actionIcon %> me-2"></i><%= activity.getAction().substring(0,1).toUpperCase() + activity.getAction().substring(1) %> <%= activity.getType() %></span>
                                            </div>
                                            <small class="text-muted"><%= activity.getTimestamp() %></small>
                                        </div>
                                        <p class="mb-0">
                                            <%= activity.getItemName() %> <small class="text-muted">(<%= activity.getItemId() %>)</small>
                                        </p>
                                        <small class="text-muted">by <%= activity.getUser() %></small>
                                    </div>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Property Distribution and Agent Performance -->
            <div class="row mb-4">
                <!-- Properties by Type -->
                <div class="col-md-6 mb-4 mb-md-0">
                    <div class="card dashboard-card h-100">
                        <div class="card-header bg-white py-3">
                            <h5 class="mb-0">Property Distribution</h5>
                        </div>
                        <div class="card-body">
                            <div class="chart-container">
                                <canvas id="propertyDistributionChart"></canvas>
                            </div>
                            <div class="row mt-3">
                                <div class="col-6 col-md-3 text-center">
                                    <div class="mb-2"><span class="badge badge-house px-2 py-1">Houses</span></div>
                                    <h4><%= propertyStats.get("house") %></h4>
                                </div>
                                <div class="col-6 col-md-3 text-center">
                                    <div class="mb-2"><span class="badge badge-apartment px-2 py-1">Apartments</span></div>
                                    <h4><%= propertyStats.get("apartment") %></h4>
                                </div>
                                <div class="col-6 col-md-3 text-center">
                                    <div class="mb-2"><span class="badge badge-commercial px-2 py-1">Commercial</span></div>
                                    <h4><%= propertyStats.get("commercial") %></h4>
                                </div>
                                <div class="col-6 col-md-3 text-center">
                                    <div class="mb-2"><span class="badge badge-land px-2 py-1">Land</span></div>
                                    <h4><%= propertyStats.get("land") %></h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Agent Performance -->
                <div class="col-md-6">
                    <div class="card dashboard-card">
                        <div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
                            <h5 class="mb-0">Agent Performance</h5>
                            <a href="agentManagement.jsp" class="btn btn-sm btn-outline-primary">View All</a>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-borderless align-middle">
                                    <thead>
                                        <tr>
                                            <th>Agent</th>
                                            <th>Properties</th>
                                            <th>Performance</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="user-avatar me-3" style="width: 40px; height: 40px; font-size: 18px;">
                                                        <i class="fas fa-user-tie"></i>
                                                    </div>
                                                    <div>
                                                        <p class="fw-bold mb-0">John Doe</p>
                                                        <p class="text-muted mb-0 small">Residential</p>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <p class="mb-0">24 sold</p>
                                                <p class="text-muted mb-0 small">32 listed</p>
                                            </td>
                                            <td width="30%">
                                                <div class="d-flex align-items-center">
                                                    <div class="progress flex-grow-1" style="height: 6px;">
                                                        <div class="progress-bar bg-success" style="width: 75%"></div>
                                                    </div>
                                                    <span class="ms-2">75%</span>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="user-avatar me-3" style="width: 40px; height: 40px; font-size: 18px;">
                                                        <i class="fas fa-user-tie"></i>
                                                    </div>
                                                    <div>
                                                        <p class="fw-bold mb-0">Jane Smith</p>
                                                        <p class="text-muted mb-0 small">Commercial</p>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <p class="mb-0">18 sold</p>
                                                <p class="text-muted mb-0 small">22 listed</p>
                                            </td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="progress flex-grow-1" style="height: 6px;">
                                                        <div class="progress-bar bg-info" style="width: 82%"></div>
                                                    </div>
                                                    <span class="ms-2">82%</span>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="user-avatar me-3" style="width: 40px; height: 40px; font-size: 18px;">
                                                        <i class="fas fa-user-tie"></i>
                                                    </div>
                                                    <div>
                                                        <p class="fw-bold mb-0">Alex Johnson</p>
                                                        <p class="text-muted mb-0 small">Luxury</p>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <p class="mb-0">12 sold</p>
                                                <p class="text-muted mb-0 small">15 listed</p>
                                            </td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="progress flex-grow-1" style="height: 6px;">
                                                        <div class="progress-bar bg-warning" style="width: 80%"></div>
                                                    </div>
                                                    <span class="ms-2">80%</span>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
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
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
    
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
            
            // Initialize charts
            initCharts();
            
            // Handle chart type switching
            document.querySelectorAll('[data-chart]').forEach(button => {
                button.addEventListener('click', function() {
                    // Remove active class from all buttons
                    document.querySelectorAll('[data-chart]').forEach(btn => {
                        btn.classList.remove('active');
                    });
                    
                    // Add active class to clicked button
                    this.classList.add('active');
                    
                    // Update the chart based on selected type
                    const chartType = this.getAttribute('data-chart');
                    updatePropertyChart(chartType);
                });
            });
        });
        
        // Charts initialization
        function initCharts() {
            // Set Chart.js defaults for lighter text
            Chart.defaults.color = '#6c757d';
            Chart.defaults.font.family = "'Segoe UI', sans-serif";
            
            // Property Chart (By Type initially)
            initPropertyChart();
            
            // Property Distribution Pie Chart
            initPropertyDistributionChart();
        }
        
        // Initialize Property Chart
        function initPropertyChart() {
            const ctx = document.getElementById('propertyChart').getContext('2d');
            window.propertyChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Houses', 'Apartments', 'Commercial', 'Land'],
                    datasets: [{
                        label: 'Number of Properties',
                        data: [<%= propertyStats.get("house") %>, <%= propertyStats.get("apartment") %>, <%= propertyStats.get("commercial") %>, <%= propertyStats.get("land") %>],
                        backgroundColor: [
                            'rgba(58, 134, 255, 0.8)',
                            'rgba(255, 0, 110, 0.8)',
                            'rgba(157, 78, 221, 0.8)',
                            'rgba(56, 176, 0, 0.8)'
                        ],
                        borderColor: [
                            'rgba(58, 134, 255, 1)',
                            'rgba(255, 0, 110, 1)',
                            'rgba(157, 78, 221, 1)',
                            'rgba(56, 176, 0, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        },
                        title: {
                            display: true,
                            text: 'Properties by Type',
                            font: {
                                size: 16
                            }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: 'rgba(0, 0, 0, 0.05)'
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            }
                        }
                    }
                }
            });
        }
        
        // Update Property Chart based on selected view
        function updatePropertyChart(chartType) {
            if (chartType === 'type') {
                window.propertyChart.data.labels = ['Houses', 'Apartments', 'Commercial', 'Land'];
                window.propertyChart.data.datasets[0].data = [<%= propertyStats.get("house") %>, <%= propertyStats.get("apartment") %>, <%= propertyStats.get("commercial") %>, <%= propertyStats.get("land") %>];
                window.propertyChart.data.datasets[0].backgroundColor = [
                    'rgba(58, 134, 255, 0.8)',
                    'rgba(255, 0, 110, 0.8)',
                    'rgba(157, 78, 221, 0.8)',
                    'rgba(56, 176, 0, 0.8)'
                ];
                window.propertyChart.options.plugins.title.text = 'Properties by Type';
            } else if (chartType === 'status') {
                window.propertyChart.data.labels = ['Available', 'Pending', 'Sold', 'Rented'];
                window.propertyChart.data.datasets[0].data = [<%= propertyStats.get("available") %>, <%= propertyStats.get("pending") %>, <%= propertyStats.get("sold") %>, <%= propertyStats.get("rented") %>];
                window.propertyChart.data.datasets[0].backgroundColor = [
                    'rgba(56, 176, 0, 0.8)',
                    'rgba(255, 190, 11, 0.8)',
                    'rgba(217, 4, 41, 0.8)',
                    'rgba(58, 134, 255, 0.8)'
                ];
                window.propertyChart.options.plugins.title.text = 'Properties by Status';
            }
            
            window.propertyChart.update();
        }
        
        // Initialize Property Distribution Pie Chart
        function initPropertyDistributionChart() {
            const ctx = document.getElementById('propertyDistributionChart').getContext('2d');
            window.propertyDistributionChart = new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: ['Houses', 'Apartments', 'Commercial', 'Land'],
                    datasets: [{
                        data: [<%= propertyStats.get("house") %>, <%= propertyStats.get("apartment") %>, <%= propertyStats.get("commercial") %>, <%= propertyStats.get("land") %>],
                        backgroundColor: [
                            'rgba(58, 134, 255, 0.8)',
                            'rgba(255, 0, 110, 0.8)',
                            'rgba(157, 78, 221, 0.8)',
                            'rgba(56, 176, 0, 0.8)'
                        ],
                        borderColor: [
                            'rgba(58, 134, 255, 1)',
                            'rgba(255, 0, 110, 1)',
                            'rgba(157, 78, 221, 1)',
                            'rgba(56, 176, 0, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false,
                        }
                    },
                    cutout: '70%'
                }
            });
        }
    </script>
</body>
</html>