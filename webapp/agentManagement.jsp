<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="org.json.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%!
    // Inner class to represent an Agent
    public static class Agent {
        private String id;
        private String username;
        private String password;
        private String fullName;
        private String email;
        private String phone;
        private String specialty;
        private double rating;
        private int propertiesSold;
        private int propertiesListed;
        private double totalRevenue;
        private boolean active = true;
        private String registrationDate;
        private String licenseNumber;
        private int yearsExperience;
        private boolean featured;
        
        public Agent() {
            this.id = generateId();
            this.registrationDate = LocalDateTime.now().format(
                DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) + " (UTC)";
            this.active = true;
            this.rating = 0.0;
            this.propertiesSold = 0;
            this.propertiesListed = 0;
            this.totalRevenue = 0.0;
            this.featured = false;
        }
        
        private String generateId() {
            // Generate a random ID
            Random rand = new Random();
            String prefix = "AG";
            String numbers = String.format("%08d", rand.nextInt(100000000));
            return prefix + numbers;
        }
        
        // Convert Agent object to JSONObject
        public JSONObject toJson() {
            JSONObject json = new JSONObject();
            json.put("id", id);
            json.put("username", username);
            json.put("password", password);
            json.put("fullName", fullName);
            json.put("email", email);
            json.put("phone", phone != null ? phone : "");
            json.put("specialty", specialty != null ? specialty : "General");
            json.put("rating", rating);
            json.put("propertiesSold", propertiesSold);
            json.put("propertiesListed", propertiesListed);
            json.put("totalRevenue", totalRevenue);
            json.put("active", active);
            json.put("registrationDate", registrationDate);
            json.put("licenseNumber", licenseNumber != null ? licenseNumber : "N/A");
            json.put("yearsExperience", yearsExperience);
            json.put("featured", featured);
            return json;
        }
        
        // Create Agent from JSONObject
        public static Agent fromJson(JSONObject json) {
            Agent agent = new Agent();
            agent.setId(json.optString("id", agent.getId()));
            agent.setUsername(json.optString("username", ""));
            agent.setPassword(json.optString("password", ""));
            agent.setFullName(json.optString("fullName", ""));
            agent.setEmail(json.optString("email", ""));
            agent.setPhone(json.optString("phone", ""));
            agent.setSpecialty(json.optString("specialty", "General"));
            agent.setRating(json.optDouble("rating", 0.0));
            agent.setPropertiesSold(json.optInt("propertiesSold", 0));
            agent.setPropertiesListed(json.optInt("propertiesListed", 0));
            agent.setTotalRevenue(json.optDouble("totalRevenue", 0.0));
            agent.setActive(json.optBoolean("active", true));
            agent.setRegistrationDate(json.optString("registrationDate", agent.getRegistrationDate()));
            agent.setLicenseNumber(json.optString("licenseNumber", "N/A"));
            agent.setYearsExperience(json.optInt("yearsExperience", 0));
            agent.setFeatured(json.optBoolean("featured", false));
            return agent;
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
        
        public String getPhone() { return phone; }
        public void setPhone(String phone) { this.phone = phone; }
        
        public String getSpecialty() { return specialty; }
        public void setSpecialty(String specialty) { this.specialty = specialty; }
        
        public double getRating() { return rating; }
        public void setRating(double rating) { this.rating = rating; }
        
        public int getPropertiesSold() { return propertiesSold; }
        public void setPropertiesSold(int propertiesSold) { this.propertiesSold = propertiesSold; }
        
        public int getPropertiesListed() { return propertiesListed; }
        public void setPropertiesListed(int propertiesListed) { this.propertiesListed = propertiesListed; }
        
        public double getTotalRevenue() { return totalRevenue; }
        public void setTotalRevenue(double totalRevenue) { this.totalRevenue = totalRevenue; }
        
        public boolean isActive() { return active; }
        public void setActive(boolean active) { this.active = active; }
        
        public String getRegistrationDate() { return registrationDate; }
        public void setRegistrationDate(String registrationDate) { this.registrationDate = registrationDate; }
        
        public String getLicenseNumber() { return licenseNumber; }
        public void setLicenseNumber(String licenseNumber) { this.licenseNumber = licenseNumber; }
        
        public int getYearsExperience() { return yearsExperience; }
        public void setYearsExperience(int yearsExperience) { this.yearsExperience = yearsExperience; }
        
        public boolean isFeatured() { return featured; }
        public void setFeatured(boolean featured) { this.featured = featured; }
    }
    
    // Methods for agent file operations using JSON
    public List<Agent> getAllAgents(String filePath) {
        List<Agent> agents = new ArrayList<>();
        File file = new File(filePath);
        
        if (!file.exists() || file.length() == 0) {
            // Return empty list if file doesn't exist or is empty
            return agents;
        }
        
        try {
            String jsonContent = new String(Files.readAllBytes(Paths.get(filePath)));
            
            // Trim the content to handle any potential whitespace
            jsonContent = jsonContent.trim();
            
            // Check if the content is a valid JSON structure
            if (!jsonContent.startsWith("{")) {
                System.out.println("Warning: Invalid JSON format in file. Creating a new JSON structure.");
                return agents; // Return empty list, will be initialized later
            }
            
            JSONObject jsonData = new JSONObject(jsonContent);
            
            // Get metadata (optional fields)
            String currentDate = jsonData.optString("currentDate", "");
            String currentUser = jsonData.optString("currentUser", "System");
            
            // Get agents array
            if (jsonData.has("agents")) {
                JSONArray agentsArray = jsonData.getJSONArray("agents");
                
                for (int i = 0; i < agentsArray.length(); i++) {
                    JSONObject agentJson = agentsArray.getJSONObject(i);
                    Agent agent = Agent.fromJson(agentJson);
                    agents.add(agent);
                }
            }
        } catch (Exception e) {
            System.out.println("Error reading agents from JSON: " + e.getMessage());
            e.printStackTrace();
            // Return empty list on error
        }
        
        return agents;
    }
    
    public Agent getAgentById(String agentId, String filePath) {
        for (Agent agent : getAllAgents(filePath)) {
            if (agent.getId().equals(agentId)) {
                return agent;
            }
        }
        return null;
    }
    
    public Agent getAgentByUsername(String username, String filePath) {
        for (Agent agent : getAllAgents(filePath)) {
            if (agent.getUsername().equalsIgnoreCase(username)) {
                return agent;
            }
        }
        return null;
    }
    
    public void addAgent(Agent agent, String filePath) {
        List<Agent> agents = getAllAgents(filePath);
        agents.add(agent);
        saveAllAgents(agents, filePath);
    }
    
    public void updateAgent(Agent updatedAgent, String filePath) {
        List<Agent> agents = getAllAgents(filePath);
        boolean found = false;
        
        for (int i = 0; i < agents.size(); i++) {
            if (agents.get(i).getId().equals(updatedAgent.getId()) || 
                agents.get(i).getUsername().equals(updatedAgent.getUsername())) {
                agents.set(i, updatedAgent);
                found = true;
                break;
            }
        }
        
        if (!found) {
            throw new IllegalArgumentException("Agent not found");
        }
        
        saveAllAgents(agents, filePath);
    }
    
    public void deleteAgent(String agentId, String filePath) {
        List<Agent> agents = getAllAgents(filePath);
        boolean found = false;
        
        for (Iterator<Agent> iterator = agents.iterator(); iterator.hasNext();) {
            Agent agent = iterator.next();
            if (agent.getId().equals(agentId)) {
                iterator.remove();
                found = true;
                break;
            }
        }
        
        if (!found) {
            throw new IllegalArgumentException("Agent not found");
        }
        
        saveAllAgents(agents, filePath);
    }
    
    private void saveAllAgents(List<Agent> agents, String filePath) {
        try {
            // Create JSON structure
            JSONObject jsonData = new JSONObject();
            JSONArray agentsArray = new JSONArray();
            
            // Add current date and user metadata
            String currentDate = "2025-05-02 20:16:05";
            jsonData.put("currentDate", currentDate);
            jsonData.put("currentUser", "IT24103866");
            
            // Add all agents to the array
            for (Agent agent : agents) {
                agentsArray.put(agent.toJson());
            }
            
            // Add agents array to main JSON object
            jsonData.put("agents", agentsArray);
            
            // Make sure directory exists
            File file = new File(filePath);
            file.getParentFile().mkdirs();
            
            // Write directly to file (safer approach without temp file)
            try (FileWriter writer = new FileWriter(file)) {
                writer.write(jsonData.toString(2)); // Pretty print with 2-space indentation
            }
        } catch (Exception e) {
            System.out.println("Error saving agents to JSON: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    public void initializeAgentStore(String filePath) {
        File file = new File(filePath);
        if (!file.exists() || file.length() == 0) {
            try {
                // Create sample agents
                Agent agent1 = new Agent();
                agent1.setId("AG12345678");
                agent1.setUsername("johndoe");
                agent1.setPassword("password123");
                agent1.setFullName("John Doe");
                agent1.setEmail("john.doe@propertyagent.com");
                agent1.setPhone("(123) 456-7890");
                agent1.setSpecialty("Residential");
                agent1.setRating(4.5);
                agent1.setPropertiesSold(24);
                agent1.setPropertiesListed(32);
                agent1.setTotalRevenue(1250000.00);
                agent1.setLicenseNumber("REA-123456");
                agent1.setYearsExperience(5);
                agent1.setFeatured(true);
                
                Agent agent2 = new Agent();
                agent2.setId("AG23456789");
                agent2.setUsername("janesmith");
                agent2.setPassword("password456");
                agent2.setFullName("Jane Smith");
                agent2.setEmail("jane.smith@propertyagent.com");
                agent2.setPhone("(234) 567-8901");
                agent2.setSpecialty("Commercial");
                agent2.setRating(4.8);
                agent2.setPropertiesSold(18);
                agent2.setPropertiesListed(22);
                agent2.setTotalRevenue(2100000.00);
                agent2.setLicenseNumber("REA-234567");
                agent2.setYearsExperience(7);
                agent2.setFeatured(true);
                
                // Create a list of agents
                List<Agent> agents = new ArrayList<>();
                agents.add(agent1);
                agents.add(agent2);
                
                // Save to file
                saveAllAgents(agents, filePath);
                System.out.println("Agent store initialized successfully with sample data");
            } catch (Exception e) {
                System.out.println("Error initializing agent store: " + e.getMessage());
                e.printStackTrace();
            }
        } else {
            try {
                // Verify if the file contains valid JSON
                List<Agent> agents = getAllAgents(filePath);
                if (agents.isEmpty()) {
                    // If the file exists but contains invalid JSON, recreate it
                    file.delete();
                    initializeAgentStore(filePath);
                }
            } catch (Exception e) {
                System.out.println("Error validating agent store: " + e.getMessage());
                e.printStackTrace();
                // Recreate the file if validation fails
                try {
                    file.delete();
                    initializeAgentStore(filePath);
                } catch (Exception ex) {
                    System.out.println("Failed to recreate agent store: " + ex.getMessage());
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
    
    // Path to agent data file
    String dataDir = "C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\data";
    String agentFile = dataDir + File.separator + "agentsManagement.json";
    
    // Initialize agent store if needed
    try {
        initializeAgentStore(agentFile);
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    // Process agent actions
    String action = request.getParameter("action");
    String agentId = request.getParameter("agentid");
    String message = "";
    boolean success = false;
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        if ("add".equals(action)) {
            // Add new agent
            try {
                String newUsername = request.getParameter("newUsername");
                String newPassword = request.getParameter("newPassword");
                String newEmail = request.getParameter("newEmail");
                String newFullName = request.getParameter("newFullName");
                String newSpecialty = request.getParameter("newSpecialty");
                String newPhone = request.getParameter("newPhone");
                String newLicenseNumber = request.getParameter("newLicenseNumber");
                int newYearsExperience = 0;
                try {
                    newYearsExperience = Integer.parseInt(request.getParameter("newYearsExperience"));
                } catch (Exception e) {
                    // Default to 0 if parsing fails
                }
                boolean newFeatured = "on".equals(request.getParameter("newFeatured"));
                
                // Validate username is unique
                Agent existingAgent = getAgentByUsername(newUsername, agentFile);
                if (existingAgent != null) {
                    message = "Username already exists. Please choose a different username.";
                } else {
                    // Create new agent
                    Agent newAgent = new Agent();
                    newAgent.setUsername(newUsername);
                    newAgent.setPassword(newPassword);
                    newAgent.setEmail(newEmail);
                    newAgent.setFullName(newFullName);
                    newAgent.setSpecialty(newSpecialty);
                    newAgent.setPhone(newPhone);
                    newAgent.setLicenseNumber(newLicenseNumber);
                    newAgent.setYearsExperience(newYearsExperience);
                    newAgent.setFeatured(newFeatured);
                    newAgent.setActive(true);  // New agents are active by default
                    
                    addAgent(newAgent, agentFile);
                    success = true;
                    message = "Agent added successfully!";
                }
            } catch (Exception e) {
                message = "Error adding agent: " + e.getMessage();
                e.printStackTrace();
            }
        } else if ("update".equals(action)) {
            // Update agent
            try {
                String editAgentId = request.getParameter("editAgentId");
                String editUsername = request.getParameter("editUsername");
                String editPassword = request.getParameter("editPassword");
                String editEmail = request.getParameter("editEmail");
                String editFullName = request.getParameter("editFullName");
                String editSpecialty = request.getParameter("editSpecialty");
                String editPhone = request.getParameter("editPhone");
                String editLicenseNumber = request.getParameter("editLicenseNumber");
                
                int editYearsExperience = 0;
                try {
                    editYearsExperience = Integer.parseInt(request.getParameter("editYearsExperience"));
                } catch (Exception e) {
                    // Default to 0 if parsing fails
                }
                
                double editRating = 0.0;
                try {
                    editRating = Double.parseDouble(request.getParameter("editRating"));
                } catch (Exception e) {
                    // Default to 0.0 if parsing fails
                }
                
                int editPropertiesSold = 0;
                try {
                    editPropertiesSold = Integer.parseInt(request.getParameter("editPropertiesSold"));
                } catch (Exception e) {
                    // Default to 0 if parsing fails
                }
                
                int editPropertiesListed = 0;
                try {
                    editPropertiesListed = Integer.parseInt(request.getParameter("editPropertiesListed"));
                } catch (Exception e) {
                    // Default to 0 if parsing fails
                }
                
                double editTotalRevenue = 0.0;
                try {
                    editTotalRevenue = Double.parseDouble(request.getParameter("editTotalRevenue"));
                } catch (Exception e) {
                    // Default to 0.0 if parsing fails
                }
                
                boolean editFeatured = "on".equals(request.getParameter("editFeatured"));
                boolean editActive = "on".equals(request.getParameter("editActive"));
                
                Agent agent = getAgentById(editAgentId, agentFile);
                if (agent != null) {
                    // Check if username is changed and if it's unique
                    if (!agent.getUsername().equals(editUsername)) {
                        Agent existingAgent = getAgentByUsername(editUsername, agentFile);
                        if (existingAgent != null && !existingAgent.getId().equals(editAgentId)) {
                            message = "Username already exists. Please choose a different username.";
                            success = false;
                        } else {
                            agent.setUsername(editUsername);
                            success = true;
                        }
                    } else {
                        success = true;
                    }
                    
                    if (success) {
                        // Only update password if provided
                        if (editPassword != null && !editPassword.trim().isEmpty()) {
                            agent.setPassword(editPassword); // Should be hashed in real app
                        }
                        
                        agent.setEmail(editEmail);
                        agent.setFullName(editFullName);
                        agent.setSpecialty(editSpecialty);
                        agent.setPhone(editPhone);
                        agent.setLicenseNumber(editLicenseNumber);
                        agent.setYearsExperience(editYearsExperience);
                        agent.setRating(editRating);
                        agent.setPropertiesSold(editPropertiesSold);
                        agent.setPropertiesListed(editPropertiesListed);
                        agent.setTotalRevenue(editTotalRevenue);
                        agent.setFeatured(editFeatured);
                        agent.setActive(editActive);
                        
                        updateAgent(agent, agentFile);
                        success = true;
                        message = "Agent updated successfully!";
                    }
                } else {
                    message = "Agent not found.";
                    success = false;
                }
            } catch (Exception e) {
                message = "Error updating agent: " + e.getMessage();
                e.printStackTrace();
                success = false;
            }
        }
    } else if (action != null && agentId != null) {
        try {
            if ("delete".equals(action)) {
                // Delete agent
                deleteAgent(agentId, agentFile);
                success = true;
                message = "Agent deleted successfully.";
            } else if ("activate".equals(action)) {
                // Activate agent
                Agent agent = getAgentById(agentId, agentFile);
                if (agent != null) {
                    agent.setActive(true);
                    updateAgent(agent, agentFile);
                    success = true;
                    message = "Agent activated successfully.";
                } else {
                    message = "Agent not found.";
                    success = false;
                }
            } else if ("deactivate".equals(action)) {
                // Deactivate agent
                Agent agent = getAgentById(agentId, agentFile);
                if (agent != null) {
                    agent.setActive(false);
                    updateAgent(agent, agentFile);
                    success = true;
                    message = "Agent deactivated successfully.";
                } else {
                    message = "Agent not found.";
                    success = false;
                }
            } else if ("feature".equals(action)) {
                // Feature agent
                Agent agent = getAgentById(agentId, agentFile);
                if (agent != null) {
                    agent.setFeatured(true);
                    updateAgent(agent, agentFile);
                    success = true;
                    message = "Agent is now featured.";
                } else {
                    message = "Agent not found.";
                    success = false;
                }
            } else if ("unfeature".equals(action)) {
                // Unfeature agent
                Agent agent = getAgentById(agentId, agentFile);
                if (agent != null) {
                    agent.setFeatured(false);
                    updateAgent(agent, agentFile);
                    success = true;
                    message = "Agent is no longer featured.";
                } else {
                    message = "Agent not found.";
                    success = false;
                }
            }
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
            e.printStackTrace();
            success = false;
        }
    }
    
    // Get all agents for display
    List<Agent> agents = new ArrayList<>();
    try {
        agents = getAllAgents(agentFile);
    } catch (Exception e) {
        message = "Error loading agents: " + e.getMessage();
        e.printStackTrace();
    }
    
    // Sort agents by rating (highest first)
    Collections.sort(agents, new Comparator<Agent>() {
        @Override
        public int compare(Agent a1, Agent a2) {
            // First sort by featured status
            if (a1.isFeatured() && !a2.isFeatured()) {
                return -1;
            } else if (!a1.isFeatured() && a2.isFeatured()) {
                return 1;
            }
            
            // Then by rating (highest first)
            return Double.compare(a2.getRating(), a1.getRating());
        }
    });
    
    // Count agents by specialty and status
    int residentialCount = 0;
    int commercialCount = 0;
    int luxuryCount = 0;
    int landCount = 0;
    int industrialCount = 0;
    int activeCount = 0;
    int inactiveCount = 0;
    int featuredCount = 0;
    
    for (Agent agent : agents) {
        if ("Residential".equalsIgnoreCase(agent.getSpecialty())) {
            residentialCount++;
        } else if ("Commercial".equalsIgnoreCase(agent.getSpecialty())) {
            commercialCount++;
        } else if ("Luxury".equalsIgnoreCase(agent.getSpecialty())) {
            luxuryCount++;
        } else if ("Land".equalsIgnoreCase(agent.getSpecialty())) {
            landCount++;
        } else if ("Industrial".equalsIgnoreCase(agent.getSpecialty())) {
            industrialCount++;
        }
        
        if (agent.isActive()) {
            activeCount++;
        } else {
            inactiveCount++;
        }
        
        if (agent.isFeatured()) {
            featuredCount++;
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agent Management | Admin Dashboard</title>
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
            --residential-color: #3a86ff;
            --commercial-color: #ff006e;
            --luxury-color: #ffbe0b;
            --land-color: #38b000;
            --industrial-color: #9d4edd;
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
        
        .specialty-badge {
            font-size: 0.75rem;
            padding: 0.25rem 0.5rem;
            border-radius: 10px;
        }
        
        .badge-residential {
            background-color: var(--residential-color);
            color: white;
        }
        
        .badge-commercial {
            background-color: var(--commercial-color);
            color: white;
        }
        
        .badge-luxury {
            background-color: var(--luxury-color);
            color: #212529;
        }
        
        .badge-land {
            background-color: var(--land-color);
            color: white;
        }
        
        .badge-industrial {
            background-color: var(--industrial-color);
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
        
        .action-btn {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }
        
        .agent-table th {
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
        
        .star-rating {
            color: #ffbe0b;
        }
        
        .featured-badge {
            background-color: #ffbe0b;
            color: #212529;
            font-size: 0.7rem;
            padding: 0.15rem 0.5rem;
            border-radius: 10px;
            margin-left: 5px;
            vertical-align: middle;
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
        
        .stats-card.residential-card {
            background: linear-gradient(135deg, var(--residential-color) 0%, #1b4cd1 100%);
        }
        
        .stats-card.commercial-card {
            background: linear-gradient(135deg, var(--commercial-color) 0%, #c30052 100%);
        }
        
        .stats-card.luxury-card {
            background: linear-gradient(135deg, var(--luxury-color) 0%, #e89b00 100%);
            color: #212529;
        }
        
        .stats-card.land-card {
            background: linear-gradient(135deg, var(--land-color) 0%, #246800 100%);
        }
        
        .stats-card.industrial-card {
            background: linear-gradient(135deg, var(--industrial-color) 0%, #6b21a8 100%);
        }
        
        .stats-card.active-card {
            background: linear-gradient(135deg, #38b000 0%, #246800 100%);
        }
        
        .stats-card.inactive-card {
            background: linear-gradient(135deg, #d90429 0%, #8c031b 100%);
        }
        
        .stats-card.featured-card {
            background: linear-gradient(135deg, #ffbe0b 0%, #e89b00 100%);
            color: #212529;
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
        
        .top-agent-card {
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            border-radius: 10px;
            overflow: hidden;
            height: 100%;
        }
        
        .top-agent-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
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
                <a class="nav-link" href="adminDashboard.jsp">
                    <i class="fas fa-users"></i> User Management
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="agentManagement.jsp">
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
                <h2>Agent Management</h2>
                <div>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addAgentModal">
                        <i class="fas fa-user-plus me-2"></i> Add New Agent
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
                <div class="col-md-4 col-lg mb-3">
                    <div class="stats-card residential-card">
                        <div class="icon">
                            <i class="fas fa-home"></i>
                        </div>
                        <h2 class="stats-number"><%= residentialCount %></h2>
                        <p class="stats-title">Residential Agents</p>
                    </div>
                </div>
                <div class="col-md-4 col-lg mb-3">
                    <div class="stats-card commercial-card">
                        <div class="icon">
                            <i class="fas fa-building"></i>
                        </div>
                        <h2 class="stats-number"><%= commercialCount %></h2>
                        <p class="stats-title">Commercial Agents</p>
                    </div>
                </div>
                <div class="col-md-4 col-lg mb-3">
                    <div class="stats-card luxury-card">
                        <div class="icon">
                            <i class="fas fa-crown"></i>
                        </div>
                        <h2 class="stats-number"><%= luxuryCount %></h2>
                        <p class="stats-title">Luxury Agents</p>
                    </div>
                </div>
                <div class="col-md-4 col-lg mb-3">
                    <div class="stats-card land-card">
                        <div class="icon">
                            <i class="fas fa-tree"></i>
                        </div>
                        <h2 class="stats-number"><%= landCount %></h2>
                        <p class="stats-title">Land Agents</p>
                    </div>
                </div>
                <div class="col-md-4 col-lg mb-3">
                    <div class="stats-card industrial-card">
                        <div class="icon">
                            <i class="fas fa-industry"></i>
                        </div>
                        <h2 class="stats-number"><%= industrialCount %></h2>
                        <p class="stats-title">Industrial Agents</p>
                    </div>
                </div>
            </div>
            
            <div class="row mb-4">
                <div class="col-md-4 mb-3">
                    <div class="stats-card active-card">
                        <div class="icon">
                            <i class="fas fa-toggle-on"></i>
                        </div>
                        <h2 class="stats-number"><%= activeCount %></h2>
                        <p class="stats-title">Active Agents</p>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="stats-card inactive-card">
                        <div class="icon">
                            <i class="fas fa-toggle-off"></i>
                        </div>
                        <h2 class="stats-number"><%= inactiveCount %></h2>
                        <p class="stats-title">Inactive Agents</p>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="stats-card featured-card">
                        <div class="icon">
                            <i class="fas fa-star"></i>
                        </div>
                        <h2 class="stats-number"><%= featuredCount %></h2>
                        <p class="stats-title">Featured Agents</p>
                    </div>
                </div>
            </div>
            
            <!-- Top Performing Agents Card -->
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Top Performing Agents</h5>
                    <div class="dropdown">
                        <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="topAgentsMenu" data-bs-toggle="dropdown" aria-expanded="false">
                            Sort By
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="topAgentsMenu">
                            <li><a class="dropdown-item active" href="#" data-sort="rating">Rating</a></li>
                            <li><a class="dropdown-item" href="#" data-sort="sales">Properties Sold</a></li>
                            <li><a class="dropdown-item" href="#" data-sort="revenue">Revenue</a></li>
                        </ul>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <%
                            // Get top 3 agents (if available)
                            int topAgentCount = Math.min(3, agents.size());
                            for (int i = 0; i < topAgentCount; i++) {
                                Agent agent = agents.get(i);
                                String badgeClass = "";
                                
                                if ("Residential".equalsIgnoreCase(agent.getSpecialty())) {
                                    badgeClass = "badge-residential";
                                } else if ("Commercial".equalsIgnoreCase(agent.getSpecialty())) {
                                    badgeClass = "badge-commercial";
                                } else if ("Luxury".equalsIgnoreCase(agent.getSpecialty())) {
                                    badgeClass = "badge-luxury";
                                } else if ("Land".equalsIgnoreCase(agent.getSpecialty())) {
                                    badgeClass = "badge-land";
                                } else if ("Industrial".equalsIgnoreCase(agent.getSpecialty())) {
                                    badgeClass = "badge-industrial";
                                }
                        %>
                        <div class="col-md-4 mb-3">
                            <div class="top-agent-card">
                                <div class="card-body text-center">
                                    <div class="mb-3 position-relative">
                                        <div class="position-absolute top-0 start-0">
                                            <span class="badge bg-dark">#<%= i+1 %></span>
                                        </div>
                                        <div class="user-avatar mx-auto" style="width: 80px; height: 80px; font-size: 32px;">
                                            <i class="fas fa-user-tie"></i>
                                        </div>
                                    </div>
                                    <h5>
                                        <%= agent.getFullName() %>
                                        <% if (agent.isFeatured()) { %>
                                            <span class="featured-badge"><i class="fas fa-star me-1"></i>Featured</span>
                                        <% } %>
                                    </h5>
                                    <p class="mb-1">
                                        <span class="specialty-badge <%= badgeClass %>">
                                            <%= agent.getSpecialty() != null ? agent.getSpecialty() : "General" %>
                                        </span>
                                    </p>
                                    <div class="star-rating mb-2">
                                        <% for (int j = 0; j < Math.floor(agent.getRating()); j++) { %>
                                            <i class="fas fa-star"></i>
                                        <% } %>
                                        <% if (agent.getRating() % 1 >= 0.5) { %>
                                            <i class="fas fa-star-half-alt"></i>
                                        <% } %>
                                        <% for (int j = 0; j < 5 - Math.ceil(agent.getRating()); j++) { %>
                                            <i class="far fa-star"></i>
                                        <% } %>
                                        <span class="text-muted ms-1"><%= String.format("%.1f", agent.getRating()) %></span>
                                    </div>
                                    <div class="row mt-3">
                                        <div class="col">
                                            <div class="fw-bold"><%= agent.getPropertiesSold() %></div>
                                            <div class="small text-muted">Properties Sold</div>
                                        </div>
                                        <div class="col border-start">
                                            <div class="fw-bold"><%= agent.getPropertiesListed() %></div>
                                            <div class="small text-muted">Properties Listed</div>
                                        </div>
                                        <div class="col border-start">
                                            <div class="fw-bold">$<%= String.format("%,.0f", agent.getTotalRevenue()) %></div>
                                            <div class="small text-muted">Total Revenue</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-footer bg-white d-flex justify-content-center">
                                    <button class="btn btn-sm btn-outline-primary me-2" onclick="viewAgent('<%= agent.getId() %>','<%= agent.getUsername() %>','<%= agent.getFullName() %>','<%= agent.getEmail() %>','<%= agent.getSpecialty() %>','<%= agent.getPhone() %>','<%= agent.getLicenseNumber() %>',<%= agent.getYearsExperience() %>,<%= agent.getRating() %>,<%= agent.getPropertiesSold() %>,<%= agent.getPropertiesListed() %>,<%= agent.getTotalRevenue() %>,<%= agent.isActive() %>,<%= agent.isFeatured() %>)">
                                        <i class="fas fa-eye me-1"></i> View
                                    </button>
                                    <button class="btn btn-sm btn-outline-secondary me-2" onclick="editAgent('<%= agent.getId() %>','<%= agent.getUsername() %>','<%= agent.getFullName() %>','<%= agent.getEmail() %>','<%= agent.getSpecialty() %>','<%= agent.getPhone() %>','<%= agent.getLicenseNumber() %>',<%= agent.getYearsExperience() %>,<%= agent.getRating() %>,<%= agent.getPropertiesSold()%>,<%= agent.getPropertiesListed() %>,<%= agent.getTotalRevenue() %>,<%= agent.isActive() %>,<%= agent.isFeatured() %>)">
                                        <i class="fas fa-edit me-1"></i> Edit
                                    </button>
                                    <% if (!agent.isFeatured()) { %>
                                        <a href="agentManagement.jsp?action=feature&agentid=<%= agent.getId() %>" class="btn btn-sm btn-outline-warning">
                                            <i class="fas fa-star me-1"></i> Feature
                                        </a>
                                    <% } else { %>
                                        <a href="agentManagement.jsp?action=unfeature&agentid=<%= agent.getId() %>" class="btn btn-sm btn-outline-secondary">
                                            <i class="far fa-star me-1"></i> Unfeature
                                        </a>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
            
            <!-- Agent List Card -->
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">All Agents</h5>
                    <div class="search-container">
                        <i class="fas fa-search search-icon"></i>
                        <input type="text" id="agentSearchInput" class="form-control" placeholder="Search agents...">
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table id="agentTable" class="table table-striped table-hover agent-table align-middle">
                            <thead>
                                <tr>
                                    <th>Agent</th>
                                    <th>Specialty</th>
                                    <th>Contact</th>
                                    <th>Rating</th>
                                    <th>Properties</th>
                                    <th>Experience</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (agents.isEmpty()) { %>
                                    <tr>
                                        <td colspan="8" class="text-center">No agents found.</td>
                                    </tr>
                                <% } else { %>
                                    <% for (Agent agent : agents) { %>
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="user-avatar me-3" style="width: 40px; height: 40px; font-size: 18px; background-color: #3a86ff;">
                                                    <i class="fas fa-user-tie"></i>
                                                </div>
                                                <div>
                                                    <div class="fw-bold">
                                                        <%= agent.getFullName() %>
                                                        <% if (agent.isFeatured()) { %>
                                                            <span class="featured-badge"><i class="fas fa-star"></i></span>
                                                        <% } %>
                                                    </div>
                                                    <div class="small text-muted"><%= agent.getUsername() %></div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <% if ("Residential".equalsIgnoreCase(agent.getSpecialty())) { %>
                                                <span class="specialty-badge badge-residential">Residential</span>
                                            <% } else if ("Commercial".equalsIgnoreCase(agent.getSpecialty())) { %>
                                                <span class="specialty-badge badge-commercial">Commercial</span>
                                            <% } else if ("Luxury".equalsIgnoreCase(agent.getSpecialty())) { %>
                                                <span class="specialty-badge badge-luxury">Luxury</span>
                                            <% } else if ("Land".equalsIgnoreCase(agent.getSpecialty())) { %>
                                                <span class="specialty-badge badge-land">Land</span>
                                            <% } else if ("Industrial".equalsIgnoreCase(agent.getSpecialty())) { %>
                                                <span class="specialty-badge badge-industrial">Industrial</span>
                                            <% } else { %>
                                                <span class="specialty-badge bg-secondary">General</span>
                                            <% } %>
                                        </td>
                                        <td>
                                            <div><i class="fas fa-envelope me-1 text-muted"></i> <%= agent.getEmail() %></div>
                                            <div><i class="fas fa-phone me-1 text-muted"></i> <%= agent.getPhone() != null && !agent.getPhone().isEmpty() ? agent.getPhone() : "Not provided" %></div>
                                        </td>
                                        <td>
                                            <div class="star-rating">
                                                <% for (int j = 0; j < Math.floor(agent.getRating()); j++) { %>
                                                    <i class="fas fa-star"></i>
                                                <% } %>
                                                <% if (agent.getRating() % 1 >= 0.5) { %>
                                                    <i class="fas fa-star-half-alt"></i>
                                                <% } %>
                                                <span class="text-muted ms-1"><%= String.format("%.1f", agent.getRating()) %></span>
                                            </div>
                                        </td>
                                        <td>
                                            <div><span class="text-success"><%= agent.getPropertiesSold() %></span> sold</div>
                                            <div><span class="text-primary"><%= agent.getPropertiesListed() %></span> listed</div>
                                        </td>
                                        <td>
                                            <div><%= agent.getYearsExperience() %> years</div>
                                            <div class="small text-muted">LIC# <%= agent.getLicenseNumber() != null && !agent.getLicenseNumber().isEmpty() ? agent.getLicenseNumber() : "N/A" %></div>
                                        </td>
                                        <td>
                                            <% if (agent.isActive()) { %>
                                                <span class="text-success"><i class="fas fa-check-circle me-1"></i> Active</span>
                                            <% } else { %>
                                                <span class="text-danger"><i class="fas fa-times-circle me-1"></i> Inactive</span>
                                            <% } %>
                                        </td>
                                        <td>
                                            <div class="btn-group">
                                                <button class="btn btn-sm btn-outline-primary action-btn" 
                                                        onclick="viewAgent('<%= agent.getId() %>','<%= agent.getUsername() %>','<%= agent.getFullName() %>','<%= agent.getEmail() %>','<%= agent.getSpecialty() %>','<%= agent.getPhone() %>','<%= agent.getLicenseNumber() %>',<%= agent.getYearsExperience() %>,<%= agent.getRating() %>,<%= agent.getPropertiesSold() %>,<%= agent.getPropertiesListed() %>,<%= agent.getTotalRevenue() %>,<%= agent.isActive() %>,<%= agent.isFeatured() %>)">
                                                    <i class="fas fa-eye" title="View Agent"></i>
                                                </button>
                                                
                                                <button class="btn btn-sm btn-outline-secondary action-btn" 
                                                        onclick="editAgent('<%= agent.getId() %>','<%= agent.getUsername() %>','<%= agent.getFullName() %>','<%= agent.getEmail() %>','<%= agent.getSpecialty() %>','<%= agent.getPhone() %>','<%= agent.getLicenseNumber() %>',<%= agent.getYearsExperience() %>,<%= agent.getRating() %>,<%= agent.getPropertiesSold() %>,<%= agent.getPropertiesListed() %>,<%= agent.getTotalRevenue() %>,<%= agent.isActive() %>,<%= agent.isFeatured() %>)">
                                                    <i class="fas fa-edit" title="Edit Agent"></i>
                                                </button>
                                                
                                                <!-- Add activate/deactivate buttons based on current status -->
                                                <% if (agent.isActive()) { %>
                                                    <a href="agentManagement.jsp?action=deactivate&agentid=<%= agent.getId() %>" 
                                                       class="btn btn-sm btn-outline-warning action-btn"
                                                       onclick="return confirm('Are you sure you want to deactivate this agent?')">
                                                        <i class="fas fa-user-slash" title="Deactivate Agent"></i>
                                                    </a>
                                                <% } else { %>
                                                    <a href="agentManagement.jsp?action=activate&agentid=<%= agent.getId() %>" 
                                                       class="btn btn-sm btn-outline-success action-btn"
                                                       onclick="return confirm('Are you sure you want to activate this agent?')">
                                                        <i class="fas fa-user-check" title="Activate Agent"></i>
                                                    </a>
                                                <% } %>
                                                
                                                <!-- Add feature/unfeature buttons based on current status -->
                                                <% if (agent.isFeatured()) { %>
                                                    <a href="agentManagement.jsp?action=unfeature&agentid=<%= agent.getId() %>" 
                                                       class="btn btn-sm btn-outline-secondary action-btn">
                                                        <i class="far fa-star" title="Unfeature Agent"></i>
                                                    </a>
                                                <% } else { %>
                                                    <a href="agentManagement.jsp?action=feature&agentid=<%= agent.getId() %>" 
                                                       class="btn btn-sm btn-outline-warning action-btn">
                                                        <i class="fas fa-star" title="Feature Agent"></i>
                                                    </a>
                                                <% } %>
                                                
                                                <a href="agentManagement.jsp?action=delete&agentid=<%= agent.getId() %>" 
                                                   class="btn btn-sm btn-outline-danger action-btn"
                                                   onclick="return confirm('Are you sure you want to delete this agent? This action cannot be undone.')">
                                                    <i class="fas fa-trash" title="Delete Agent"></i>
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
                    <p class="small">Current Date and Time (UTC): 2025-05-02 20:29:01 | User: IT24103866</p>
                </div>
            </footer>
        </div>
    </div>
    
    <!-- Add Agent Modal -->
    <div class="modal fade" id="addAgentModal" tabindex="-1" aria-labelledby="addAgentModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addAgentModalLabel">Add New Agent</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="agentManagement.jsp" method="post">
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
                                <label for="newPhone" class="form-label">Phone</label>
                                <input type="text" class="form-control" id="newPhone" name="newPhone" placeholder="(123) 456-7890">
                            </div>
                            <div class="col-md-6">
                                <label for="newSpecialty" class="form-label">Specialty</label>
                                <select class="form-select" id="newSpecialty" name="newSpecialty" required>
                                    <option value="" selected disabled>Select a specialty</option>
                                    <option value="Residential">Residential</option>
                                    <option value="Commercial">Commercial</option>
                                    <option value="Luxury">Luxury</option>
                                    <option value="Land">Land</option>
                                    <option value="Industrial">Industrial</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="newLicenseNumber" class="form-label">License Number</label>
                                <input type="text" class="form-control" id="newLicenseNumber" name="newLicenseNumber" placeholder="REA-123456">
                            </div>
                            <div class="col-md-6">
                                <label for="newYearsExperience" class="form-label">Years of Experience</label>
                                <input type="number" class="form-control" id="newYearsExperience" name="newYearsExperience" min="0" value="0">
                            </div>
                            <div class="col-md-6">
                                <div class="form-check mt-4">
                                    <input class="form-check-input" type="checkbox" id="newFeatured" name="newFeatured">
                                    <label class="form-check-label" for="newFeatured">
                                        Feature this agent on homepage
                                    </label>
                                    <div class="form-text">Featured agents appear at the top of listings.</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Add Agent</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Edit Agent Modal -->
    <div class="modal fade" id="editAgentModal" tabindex="-1" aria-labelledby="editAgentModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editAgentModalLabel">Edit Agent</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="agentManagement.jsp" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" id="editAgentId" name="editAgentId" value="">
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
                                <label for="editPhone" class="form-label">Phone</label>
                                <input type="text" class="form-control" id="editPhone" name="editPhone">
                            </div>
                            <div class="col-md-6">
                                <label for="editSpecialty" class="form-label">Specialty</label>
                                <select class="form-select" id="editSpecialty" name="editSpecialty" required>
                                    <option value="Residential">Residential</option>
                                    <option value="Commercial">Commercial</option>
                                    <option value="Luxury">Luxury</option>
                                    <option value="Land">Land</option>
                                    <option value="Industrial">Industrial</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="editLicenseNumber" class="form-label">License Number</label>
                                <input type="text" class="form-control" id="editLicenseNumber" name="editLicenseNumber">
                            </div>
                            <div class="col-md-6">
                                <label for="editYearsExperience" class="form-label">Years of Experience</label>
                                <input type="number" class="form-control" id="editYearsExperience" name="editYearsExperience" min="0">
                            </div>
                            
                            <div class="col-12">
                                <hr>
                                <h6>Performance Metrics</h6>
                            </div>
                            
                            <div class="col-md-4">
                                <label for="editRating" class="form-label">Agent Rating</label>
                                <input type="number" class="form-control" id="editRating" name="editRating" min="0" max="5" step="0.1">
                                <div class="form-text">Rating from 0 to 5 stars</div>
                            </div>
                            <div class="col-md-4">
                                <label for="editPropertiesSold" class="form-label">Properties Sold</label>
                                <input type="number" class="form-control" id="editPropertiesSold" name="editPropertiesSold" min="0">
                            </div>
                            <div class="col-md-4">
                                <label for="editPropertiesListed" class="form-label">Properties Listed</label>
                                <input type="number" class="form-control" id="editPropertiesListed" name="editPropertiesListed" min="0">
                            </div>
                            
                            <div class="col-md-6">
                                <label for="editTotalRevenue" class="form-label">Total Revenue</label>
                                <div class="input-group">
                                    <span class="input-group-text">$</span>
                                    <input type="number" class="form-control" id="editTotalRevenue" name="editTotalRevenue" min="0" step="0.01">
                                </div>
                            </div>
                            
                            <div class="col-12">
                                <hr>
                                <h6>Status</h6>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="editFeatured" name="editFeatured">
                                    <label class="form-check-label" for="editFeatured">
                                        Feature this agent on homepage
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="editActive" name="editActive">
                                    <label class="form-check-label" for="editActive">
                                        Active Account
                                    </label>
                                    <div class="form-text">Inactive agents cannot log in to the system.</div>
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
    
    <!-- View Agent Modal -->
    <div class="modal fade" id="viewAgentModal" tabindex="-1" aria-labelledby="viewAgentModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="viewAgentModalLabel">Agent Details</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-4 text-center border-end">
                            <div class="user-avatar mx-auto mb-3" style="width: 100px; height: 100px; font-size: 40px; background-color: #3a86ff;">
                                <i class="fas fa-user-tie"></i>
                            </div>
                            <h4 id="viewAgentFullName"></h4>
                            <p id="viewAgentSpecialty" class="mb-2"></p>
                            <div class="star-rating mb-3">
                                <div id="viewAgentStars"></div>
                            </div>
                            <div class="badge bg-success mb-3" id="viewAgentStatus"></div>
                            <div id="viewAgentFeaturedBadge"></div>
                        </div>
                        <div class="col-md-8">
                            <h5>Contact Information</h5>
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <p><strong><i class="fas fa-envelope me-2 text-muted"></i> Email:</strong><br>
                                    <span id="viewAgentEmail"></span></p>
                                </div>
                                <div class="col-md-6">
                                    <p><strong><i class="fas fa-phone me-2 text-muted"></i> Phone:</strong><br>
                                    <span id="viewAgentPhone"></span></p>
                                </div>
                            </div>
                            
                            <h5>Agent Information</h5>
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <p><strong>Username:</strong><br>
                                    <span id="viewAgentUsername"></span></p>
                                </div>
                                <div class="col-md-6">
                                    <p><strong>License Number:</strong><br>
                                    <span id="viewAgentLicenseNumber"></span></p>
                                </div>
                                <div class="col-md-6">
                                    <p><strong>Experience:</strong><br>
                                    <span id="viewAgentYearsExperience"></span> years</p>
                                </div>
                                <div class="col-md-6">
                                    <p><strong>Registration Date:</strong><br>
                                    <span>2025-05-02 20:29:01</span></p>
                                </div>
                            </div>
                            
                            <h5>Performance Metrics</h5>
                            <div class="row mb-2">
                                <div class="col-md-4 text-center">
                                    <div class="bg-light rounded p-3">
                                        <h2 id="viewAgentPropertiesSold" class="text-success"></h2>
                                        <p class="mb-0">Properties Sold</p>
                                    </div>
                                </div>
                                <div class="col-md-4 text-center">
                                    <div class="bg-light rounded p-3">
                                        <h2 id="viewAgentPropertiesListed" class="text-primary"></h2>
                                        <p class="mb-0">Properties Listed</p>
                                    </div>
                                </div>
                                <div class="col-md-4 text-center">
                                    <div class="bg-light rounded p-3">
                                        <h2 id="viewAgentTotalRevenue" class="text-dark"></h2>
                                        <p class="mb-0">Total Revenue</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="viewEditButton">Edit Agent</button>
                </div>
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
            const agentTable = $('#agentTable').DataTable({
                "paging": true,
                "ordering": true,
                "info": true,
                "responsive": true,
                "lengthMenu": [10, 25, 50, 100],
                "language": {
                    "search": "Filter records:",
                    "lengthMenu": "Show _MENU_ agents per page",
                    "zeroRecords": "No matching agents found",
                    "info": "Showing _START_ to _END_ of _TOTAL_ agents",
                    "infoEmpty": "No agents available",
                    "infoFiltered": "(filtered from _MAX_ total agents)"
                }
            });
            
            // Connect the custom search box to DataTable
            $('#agentSearchInput').on('keyup', function() {
                agentTable.search(this.value).draw();
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
            
            // Sort top agents by different criteria
            document.querySelectorAll('[data-sort]').forEach(item => {
                item.addEventListener('click', function(e) {
                    e.preventDefault();
                    const sortBy = this.getAttribute('data-sort');
                    // In a real app, this would trigger a server request with sorting params
                    alert(`Sorting by ${sortBy}... (This would reload the page with sorted results)`);
                    
                    // Update active state
                    document.querySelectorAll('[data-sort]').forEach(el => {
                        el.parentElement.classList.remove('active');
                    });
                    this.parentElement.classList.add('active');
                });
            });
            
            // Auto-update specialty badge based on specialty selection
            const newSpecialtySelect = document.getElementById('newSpecialty');
            if (newSpecialtySelect) {
                newSpecialtySelect.addEventListener('change', function() {
                    // Additional custom logic can be added here if needed
                    console.log('Specialty changed to:', this.value);
                });
            }
            
            // Automatically set focus on appropriate fields when modals open
            $('#addAgentModal').on('shown.bs.modal', function() {
                document.getElementById('newUsername').focus();
            });
            
            $('#editAgentModal').on('shown.bs.modal', function() {
                document.getElementById('editFullName').focus();
            });

            // Display current system date and time on the page
            const footerTimeElement = document.querySelector('footer p.small');
            if (footerTimeElement) {
                footerTimeElement.textContent = 'Current Date and Time (UTC): 2025-05-02 20:29:01 | User: IT24103866';
            }
        });
        
        // Function to populate and show edit agent modal
        function editAgent(id, username, fullName, email, specialty, phone, licenseNumber, yearsExp, rating, sold, listed, revenue, isActive, isFeatured) {
            document.getElementById('editAgentId').value = id;
            document.getElementById('editUsername').value = username;
            document.getElementById('editFullName').value = fullName;
            document.getElementById('editEmail').value = email;
            document.getElementById('editSpecialty').value = specialty;
            document.getElementById('editPhone').value = phone;
            document.getElementById('editLicenseNumber').value = licenseNumber;
            document.getElementById('editYearsExperience').value = yearsExp;
            document.getElementById('editRating').value = rating;
            document.getElementById('editPropertiesSold').value = sold;
            document.getElementById('editPropertiesListed').value = listed;
            document.getElementById('editTotalRevenue').value = revenue;
            document.getElementById('editFeatured').checked = isFeatured;
            document.getElementById('editActive').checked = isActive;
            
            // Clear the password field (we don't want to prefill this)
            document.getElementById('editPassword').value = '';
            
            // Show the modal
            new bootstrap.Modal(document.getElementById('editAgentModal')).show();
        }
        
        // Function to populate and show view agent modal
        function viewAgent(id, username, fullName, email, specialty, phone, licenseNumber, yearsExp, rating, sold, listed, revenue, isActive, isFeatured) {
            // Set agent data in the modal
            document.getElementById('viewAgentFullName').textContent = fullName;
            document.getElementById('viewAgentUsername').textContent = username;
            document.getElementById('viewAgentEmail').textContent = email;
            document.getElementById('viewAgentPhone').textContent = phone || 'Not provided';
            document.getElementById('viewAgentLicenseNumber').textContent = licenseNumber || 'Not provided';
            document.getElementById('viewAgentYearsExperience').textContent = yearsExp;
            document.getElementById('viewAgentPropertiesSold').textContent = sold;
            document.getElementById('viewAgentPropertiesListed').textContent = listed;
            document.getElementById('viewAgentTotalRevenue').textContent = '$' + new Intl.NumberFormat().format(revenue);
            
            // Set specialty badge
            let specialtyClass = '';
            if (specialty === 'Residential') {
                specialtyClass = 'badge-residential';
            } else if (specialty === 'Commercial') {
                specialtyClass = 'badge-commercial';
            } else if (specialty === 'Luxury') {
                specialtyClass = 'badge-luxury';
            } else if (specialty === 'Land') {
                specialtyClass = 'badge-land';
            } else if (specialty === 'Industrial') {
                specialtyClass = 'badge-industrial';
            }
            
            document.getElementById('viewAgentSpecialty').innerHTML = `<span class="specialty-badge ${specialtyClass}">${specialty || 'General'}</span>`;
            
            // Set agent status
            document.getElementById('viewAgentStatus').textContent = isActive ? 'Active' : 'Inactive';
            document.getElementById('viewAgentStatus').className = isActive ? 'badge bg-success mb-3' : 'badge bg-danger mb-3';
            
            // Set featured badge if featured
            document.getElementById('viewAgentFeaturedBadge').innerHTML = isFeatured ? 
                '<span class="featured-badge"><i class="fas fa-star me-1"></i>Featured Agent</span>' : '';
            
            // Set star rating
            let starsHTML = '';
            for (let i = 0; i < Math.floor(rating); i++) {
                starsHTML += '<i class="fas fa-star"></i>';
            }
            if (rating % 1 >= 0.5) {
                starsHTML += '<i class="fas fa-star-half-alt"></i>';
            }
            for (let i = 0; i < 5 - Math.ceil(rating); i++) {
                starsHTML += '<i class="far fa-star"></i>';
            }
            starsHTML += `<span class="ms-1">${rating.toFixed(1)}</span>`;
            document.getElementById('viewAgentStars').innerHTML = starsHTML;
            
            // Set up edit button
            document.getElementById('viewEditButton').onclick = function() {
                // Close view modal
                bootstrap.Modal.getInstance(document.getElementById('viewAgentModal')).hide();
                // Open edit modal
                editAgent(id, username, fullName, email, specialty, phone, licenseNumber, yearsExp, rating, sold, listed, revenue, isActive, isFeatured);
            };
            
            // Show the modal
            new bootstrap.Modal(document.getElementById('viewAgentModal')).show();
        }
    </script>
</body>
</html>