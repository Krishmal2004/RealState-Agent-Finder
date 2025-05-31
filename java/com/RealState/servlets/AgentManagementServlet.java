package com.RealState.servlets;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/agents")
public class AgentManagementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // BST root node
    private Node root;
    
    // Current date and user (hardcoded as requested)
    private final String CURRENT_DATE = "2025-05-03 12:15:55";
    private final String CURRENT_USER = "IT24103866";
    
    // Inner class for Agent object
    public static class Agent implements Comparable<Agent> {
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
        private boolean active;
        private String registrationDate;
        private String licenseNumber;
        private int yearsExperience;
        private boolean featured;
        
        public Agent() {
            this.id = generateId();
            // Use the hardcoded date format (UTC) as requested
            this.registrationDate = LocalDateTime.now()
                .format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) + " (UTC)";
            this.active = true;
            this.rating = 0.0;
            this.propertiesSold = 0;
            this.propertiesListed = 0;
            this.totalRevenue = 0.0;
            this.featured = false;
        }
        
        private String generateId() {
            Random rand = new Random();
            String prefix = "AG";
            String numbers = String.format("%08d", rand.nextInt(100000000));
            return prefix + numbers;
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
        
        // For BST comparison
        @Override
        public int compareTo(Agent other) {
            return this.id.compareTo(other.id);
        }
        
        // For searching by username
        public boolean usernameEquals(String username) {
            return this.username != null && this.username.equalsIgnoreCase(username);
        }
    }
    
    // Node class for BST
    private class Node {
        Agent agent;
        Node left, right;
        
        public Node(Agent agent) {
            this.agent = agent;
            left = right = null;
        }
    }
    
    @Override
    public void init() throws ServletException {
        // Initialize BST with sample data
        initializeAgents();
    }
    
    private void initializeAgents() {
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
        agent1.setRegistrationDate("2025-05-03 02:04:12 (UTC)");
        
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
        agent2.setRegistrationDate("2025-05-03 02:04:12 (UTC)");
        
        Agent agent3 = new Agent();
        agent3.setId("AG26350191");
        agent3.setUsername("hhh");
        agent3.setPassword("hh");
        agent3.setFullName("hh");
        agent3.setEmail("hh@gmail.com");
        agent3.setPhone("74747474747444");
        agent3.setSpecialty("Residential");
        agent3.setRating(0.0);
        agent3.setPropertiesSold(0);
        agent3.setPropertiesListed(0);
        agent3.setTotalRevenue(0.0);
        agent3.setLicenseNumber("4444");
        agent3.setYearsExperience(444);
        agent3.setFeatured(true);
        agent3.setRegistrationDate("2025-05-03 02:05:27 (UTC)");
        
        // Add agents to BST
        insert(agent1);
        insert(agent2);
        insert(agent3);
    }
    
    // BST Operations
    
    // Insert agent into BST
    private void insert(Agent agent) {
        root = insertRec(root, agent);
    }
    
    private Node insertRec(Node root, Agent agent) {
        if (root == null) {
            root = new Node(agent);
            return root;
        }
        
        if (agent.compareTo(root.agent) < 0) {
            root.left = insertRec(root.left, agent);
        } else if (agent.compareTo(root.agent) > 0) {
            root.right = insertRec(root.right, agent);
        }
        
        return root;
    }
    
    // Delete agent from BST
    private void delete(String id) {
        Agent searchKey = new Agent();
        searchKey.setId(id);
        root = deleteRec(root, searchKey);
    }
    
    private Node deleteRec(Node root, Agent key) {
        if (root == null) return null;
        
        int comparison = key.compareTo(root.agent);
        
        if (comparison < 0) {
            root.left = deleteRec(root.left, key);
        } else if (comparison > 0) {
            root.right = deleteRec(root.right, key);
        } else {
            // Node with only one child or no child
            if (root.left == null) {
                return root.right;
            } else if (root.right == null) {
                return root.left;
            }
            
            // Node with two children
            // Get the inorder successor (smallest in right subtree)
            root.agent = minValue(root.right);
            
            // Delete the inorder successor
            root.right = deleteRec(root.right, root.agent);
        }
        
        return root;
    }
    
    private Agent minValue(Node root) {
        Agent minv = root.agent;
        while (root.left != null) {
            minv = root.left.agent;
            root = root.left;
        }
        return minv;
    }
    
    // Search agent by ID
    private Agent search(String id) {
        Agent searchKey = new Agent();
        searchKey.setId(id);
        Node result = searchRec(root, searchKey);
        return result != null ? result.agent : null;
    }
    
    private Node searchRec(Node root, Agent key) {
        if (root == null || key.compareTo(root.agent) == 0) {
            return root;
        }
        
        if (key.compareTo(root.agent) < 0) {
            return searchRec(root.left, key);
        }
        
        return searchRec(root.right, key);
    }
    
    // Search agent by username
    private Agent searchByUsername(String username) {
        return searchByUsernameRec(root, username);
    }
    
    private Agent searchByUsernameRec(Node root, String username) {
        if (root == null) {
            return null;
        }
        
        if (root.agent.usernameEquals(username)) {
            return root.agent;
        }
        
        Agent leftResult = searchByUsernameRec(root.left, username);
        if (leftResult != null) {
            return leftResult;
        }
        
        return searchByUsernameRec(root.right, username);
    }
    
    // Get all agents in-order traversal
    private List<Agent> getAllAgents() {
        List<Agent> agents = new ArrayList<>();
        inOrderTraversal(root, agents);
        return agents;
    }
    
    private void inOrderTraversal(Node root, List<Agent> agents) {
        if (root != null) {
            inOrderTraversal(root.left, agents);
            agents.add(root.agent);
            inOrderTraversal(root.right, agents);
        }
    }
    
    // Update agent in BST
    private void update(Agent updatedAgent) {
        // Remove the old agent
        delete(updatedAgent.getId());
        // Insert the updated agent
        insert(updatedAgent);
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String agentId = request.getParameter("agentid");
        
        // Check session for admin role (you would implement real authentication in production)
        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");
        if (userRole == null) {
            // For testing purposes, set admin role
            session.setAttribute("userRole", "admin");
            session.setAttribute("username", CURRENT_USER);
            session.setAttribute("fullName", "Administrator");
        }
        
        // Process agent actions through GET (like delete, activate, deactivate)
        if (action != null && agentId != null) {
            String message = "";
            boolean success = false;
            
            try {
                if ("delete".equals(action)) {
                    delete(agentId);
                    success = true;
                    message = "Agent deleted successfully.";
                    
                } else if ("activate".equals(action) || "deactivate".equals(action) || 
                          "feature".equals(action) || "unfeature".equals(action)) {
                    
                    Agent agent = search(agentId);
                    if (agent != null) {
                        if ("activate".equals(action)) {
                            agent.setActive(true);
                            message = "Agent activated successfully.";
                        } else if ("deactivate".equals(action)) {
                            agent.setActive(false);
                            message = "Agent deactivated successfully.";
                        } else if ("feature".equals(action)) {
                            agent.setFeatured(true);
                            message = "Agent is now featured.";
                        } else {
                            agent.setFeatured(false);
                            message = "Agent is no longer featured.";
                        }
                        update(agent);
                        success = true;
                    } else {
                        message = "Agent not found.";
                    }
                }
                
                // Store message in session for display after redirect
                session.setAttribute("message", message);
                session.setAttribute("success", success);
                
            } catch (Exception e) {
                session.setAttribute("message", "Error: " + e.getMessage());
                session.setAttribute("success", false);
            }
            
            // Redirect to avoid form resubmission (without using context path)
            response.sendRedirect("agents");
            return;
        }
        
        // Display the agent management page
        displayAgentManagementPage(request, response);
    }
    
    private void displayAgentManagementPage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get all agents from BST
        List<Agent> agents = getAllAgents();
        
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
        
        // Set attributes for JSP
        request.setAttribute("agents", agents);
        request.setAttribute("residentialCount", residentialCount);
        request.setAttribute("commercialCount", commercialCount);
        request.setAttribute("luxuryCount", luxuryCount);
        request.setAttribute("landCount", landCount);
        request.setAttribute("industrialCount", industrialCount);
        request.setAttribute("activeCount", activeCount);
        request.setAttribute("inactiveCount", inactiveCount);
        request.setAttribute("featuredCount", featuredCount);
        request.setAttribute("currentDate", CURRENT_DATE);
        request.setAttribute("currentUser", CURRENT_USER);
        
        // Forward to JSP (not changing the path as requested)
        request.getRequestDispatcher("/agentManagement.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        HttpSession session = request.getSession();
        String message = "";
        boolean success = false;
        
        if ("add".equals(action)) {
            try {
                // Get form parameters
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
                
                // Check if username is unique
                if (searchByUsername(newUsername) != null) {
                    message = "Username already exists. Please choose a different username.";
                    success = false;
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
                    newAgent.setRegistrationDate(CURRENT_DATE + " (UTC)");
                    
                    // Add to BST
                    insert(newAgent);
                    
                    message = "Agent added successfully!";
                    success = true;
                }
                
            } catch (Exception e) {
                message = "Error adding agent: " + e.getMessage();
                success = false;
            }
            
        } else if ("update".equals(action)) {
            try {
                // Get form parameters
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
                
                // Get existing agent
                Agent agent = search(editAgentId);
                
                if (agent != null) {
                    // Check if username is being changed and if it's unique
                    if (!agent.getUsername().equals(editUsername)) {
                        Agent existingAgent = searchByUsername(editUsername);
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
                        // Update only if password is provided
                        if (editPassword != null && !editPassword.trim().isEmpty()) {
                            agent.setPassword(editPassword);
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
                        
                        update(agent);
                        message = "Agent updated successfully!";
                    }
                } else {
                    message = "Agent not found.";
                    success = false;
                }
                
            } catch (Exception e) {
                message = "Error updating agent: " + e.getMessage();
                success = false;
            }
        }
        
        // Store message in session for display after redirect
        session.setAttribute("message", message);
        session.setAttribute("success", success);
        
        // Redirect to avoid form resubmission (without using context path)
        response.sendRedirect("agents");
    }
}