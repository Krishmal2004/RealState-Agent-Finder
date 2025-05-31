package com.RealState.servlets;

import java.io.*;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;

/**
 * Selection Sort Servlet that sorts agents by different criteria using Gson for JSON processing
 */
@WebServlet("/SelectionSortServlet")
public class SelectionSortServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Current date and time - hardcoded for consistency
    private static final String CURRENT_DATE_TIME = "2025-05-03 10:00:28";
    private static final String CURRENT_USER_LOGIN = "IT24103866";
    
    /**
     * Constructor for the servlet
     */
    public SelectionSortServlet() {
        super();
    }
    
    /**
     * Process GET requests - sort agents by specified criteria
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get sort method and specialty filter from request
        String sortMethod = request.getParameter("sortMethod");
        String filterSpecialty = request.getParameter("specialty");
        
        try {
            // Get JSON data path
            String jsonFilePath = ("C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\data\\agentsManagement.json");
            
            // Load agents from JSON file using Gson
            List<Agent> agents = loadAgentsFromJson(jsonFilePath);
            
            // Apply selection sort based on requested method
            if (sortMethod == null || sortMethod.equals("rating")) {
                sortByRating(agents);
                request.setAttribute("sortedBy", "rating");
            } else if (sortMethod.equals("experience")) {
                sortByExperience(agents);
                request.setAttribute("sortedBy", "experience");
            } else if (sortMethod.equals("sales")) {
                sortByPropertiesSold(agents);
                request.setAttribute("sortedBy", "sales");
            } else if (sortMethod.equals("performance")) {
                sortByPerformance(agents);
                request.setAttribute("sortedBy", "performance");
            }
            
            // Apply specialty filter if provided
            if (filterSpecialty != null && !filterSpecialty.isEmpty() && !filterSpecialty.equalsIgnoreCase("all")) {
                agents = filterBySpecialty(agents, filterSpecialty);
            }
            
            // Store sorted list in request
            request.setAttribute("agentsList", agents);
            request.setAttribute("currentDateTime", CURRENT_DATE_TIME);
            request.setAttribute("currentUserLogin", CURRENT_USER_LOGIN);
            
            // Forward to JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("clients.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            // Handle errors
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<html><body>");
            out.println("<h2>Error processing agent data</h2>");
            out.println("<p>" + e.getMessage() + "</p>");
            out.println("<a href='clients.jsp'>Return to agents page</a>");
            out.println("</body></html>");
        }
    }
    
    /**
     * Process POST requests - handle rating submissions
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String agentId = request.getParameter("agentId");
        String ratingStr = request.getParameter("rating");
        String review = request.getParameter("review");
        
        try {
            if (agentId != null && ratingStr != null && !ratingStr.isEmpty()) {
                int rating = Integer.parseInt(ratingStr);
                
                if (rating >= 1 && rating <= 5) {
                    // Get JSON data path
                    String jsonFilePath = ("C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\data\\agentsManagement.json");
                    
                    // Update rating in JSON file
                    updateAgentRating(jsonFilePath, agentId, rating, review, CURRENT_USER_LOGIN);
                    
                    // Add success message to request
                    request.setAttribute("success", "Thank you for your feedback! Your rating has been submitted successfully.");
                    request.setAttribute("ratedAgentId", agentId);
                }
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error submitting rating: " + e.getMessage());
        }
        
        // After processing the rating, redirect to GET with sorting parameters
        String sortMethod = request.getParameter("sortMethod");
        String filterSpecialty = request.getParameter("specialty");
        
        StringBuilder redirectURL = new StringBuilder("SelectionSortServlet?");
        if (sortMethod != null && !sortMethod.isEmpty()) {
            redirectURL.append("sortMethod=").append(sortMethod).append("&");
        }
        if (filterSpecialty != null && !filterSpecialty.isEmpty()) {
            redirectURL.append("specialty=").append(filterSpecialty);
        }
        
        response.sendRedirect(redirectURL.toString());
    }
    
    /**
     * Load agents from JSON file using Gson
     */
    private List<Agent> loadAgentsFromJson(String filePath) throws Exception {
        List<Agent> agents = new ArrayList<>();
        
        try (Reader reader = new FileReader(filePath)) {
            // Parse JSON using Gson
            Gson gson = new Gson();
            JsonDataWrapper dataWrapper = gson.fromJson(reader, JsonDataWrapper.class);
            
            if (dataWrapper != null && dataWrapper.agents != null) {
                // Filter for active agents only
                for (Agent agent : dataWrapper.agents) {
                    if (agent.isActive()) {
                        agents.add(agent);
                    }
                }
            }
            
        } catch (IOException e) {
            throw new Exception("Error reading agent data file: " + e.getMessage());
        }
        
        return agents;
    }
    
    /**
     * Update agent rating in JSON file using Gson
     */
    private void updateAgentRating(String filePath, String agentId, int newRating, 
                                  String reviewText, String userId) throws Exception {
        // Validate inputs
        if (agentId == null || agentId.trim().isEmpty()) {
            throw new IllegalArgumentException("Agent ID cannot be empty");
        }
        
        if (newRating < 1 || newRating > 5) {
            throw new IllegalArgumentException("Rating must be between 1 and 5");
        }
        
        try {
            // Read the existing JSON file
            Gson gson = new Gson();
            JsonDataWrapper dataWrapper;
            
            try (Reader reader = new FileReader(filePath)) {
                dataWrapper = gson.fromJson(reader, JsonDataWrapper.class);
            }
            
            if (dataWrapper == null || dataWrapper.agents == null) {
                throw new Exception("Invalid JSON data format");
            }
            
            boolean agentFound = false;
            
            // Find the agent and update rating
            for (Agent agent : dataWrapper.agents) {
                if (agent.getId().equals(agentId)) {
                    agentFound = true;
                    
                    // Get current rating and count
                    double currentRating = agent.getRating();
                    int ratingCount = agent.getRatingCount() + 1;
                    
                    // Calculate new average rating
                    double newAvgRating;
                    if (ratingCount > 1) {
                        double previousTotal = currentRating * (ratingCount - 1);
                        newAvgRating = (previousTotal + newRating) / ratingCount;
                    } else {
                        newAvgRating = newRating;
                    }
                    
                    // Round to 1 decimal place
                    newAvgRating = Math.round(newAvgRating * 10.0) / 10.0;
                    
                    // Update the agent's rating and count
                    agent.setRating(newAvgRating);
                    agent.setRatingCount(ratingCount);
                    
                    // Create reviews list if it doesn't exist
                    if (agent.getReviews() == null) {
                        agent.setReviews(new ArrayList<>());
                    }
                    
                    // Add the new review
                    Review review = new Review();
                    review.rating = newRating;
                    review.comment = reviewText != null ? reviewText : "";
                    review.timestamp = CURRENT_DATE_TIME;
                    review.reviewerId = userId;
                    
                    agent.getReviews().add(review);
                    break;
                }
            }
            
            if (!agentFound) {
                throw new Exception("Agent with ID " + agentId + " not found");
            }
            
            // Update the currentDate field in the JSON
            dataWrapper.currentDate = CURRENT_DATE_TIME;
            
            // Write the updated JSON back to the file
            try (Writer writer = new FileWriter(filePath)) {
                gson.toJson(dataWrapper, writer);
            }
            
        } catch (IOException e) {
            throw new Exception("Error accessing agent data file: " + e.getMessage());
        }
    }
    
    /**
     * Filter agents by specialty
     */
    private List<Agent> filterBySpecialty(List<Agent> agents, String specialty) {
        List<Agent> filtered = new ArrayList<>();
        
        for (Agent agent : agents) {
            if (agent.getSpecialty().equalsIgnoreCase(specialty)) {
                filtered.add(agent);
            }
        }
        
        return filtered;
    }
    
    /**
     * Selection Sort implementation to sort agents by rating (highest to lowest)
     */
    private void sortByRating(List<Agent> agents) {
        int n = agents.size();
        
        for (int i = 0; i < n - 1; i++) {
            // Find the index of agent with highest rating
            int maxIndex = i;
            for (int j = i + 1; j < n; j++) {
                if (agents.get(j).getRating() > agents.get(maxIndex).getRating()) {
                    maxIndex = j;
                }
            }
            
            // Swap the found agent with the current position
            if (maxIndex != i) {
                Agent temp = agents.get(i);
                agents.set(i, agents.get(maxIndex));
                agents.set(maxIndex, temp);
            }
        }
    }
    
    /**
     * Selection Sort implementation to sort agents by experience (highest to lowest)
     */
    private void sortByExperience(List<Agent> agents) {
        int n = agents.size();
        
        for (int i = 0; i < n - 1; i++) {
            // Find the index of agent with most experience
            int maxIndex = i;
            for (int j = i + 1; j < n; j++) {
                if (agents.get(j).getYearsExperience() > agents.get(maxIndex).getYearsExperience()) {
                    maxIndex = j;
                }
            }
            
            // Swap the found agent with the current position
            if (maxIndex != i) {
                Agent temp = agents.get(i);
                agents.set(i, agents.get(maxIndex));
                agents.set(maxIndex, temp);
            }
        }
    }
    
    /**
     * Selection Sort implementation to sort agents by properties sold (highest to lowest)
     */
    private void sortByPropertiesSold(List<Agent> agents) {
        int n = agents.size();
        
        for (int i = 0; i < n - 1; i++) {
            // Find the index of agent with most properties sold
            int maxIndex = i;
            for (int j = i + 1; j < n; j++) {
                if (agents.get(j).getPropertiesSold() > agents.get(maxIndex).getPropertiesSold()) {
                    maxIndex = j;
                }
            }
            
            // Swap the found agent with the current position
            if (maxIndex != i) {
                Agent temp = agents.get(i);
                agents.set(i, agents.get(maxIndex));
                agents.set(maxIndex, temp);
            }
        }
    }
    
    /**
     * Selection Sort implementation to sort agents by performance score (highest to lowest)
     */
    private void sortByPerformance(List<Agent> agents) {
        int n = agents.size();
        
        for (int i = 0; i < n - 1; i++) {
            // Find the index of agent with highest performance score
            int maxIndex = i;
            for (int j = i + 1; j < n; j++) {
                if (agents.get(j).getPerformanceScore() > agents.get(maxIndex).getPerformanceScore()) {
                    maxIndex = j;
                }
            }
            
            // Swap the found agent with the current position
            if (maxIndex != i) {
                Agent temp = agents.get(i);
                agents.set(i, agents.get(maxIndex));
                agents.set(maxIndex, temp);
            }
        }
    }
    
    /**
     * Wrapper class for JSON data structure
     */
    private static class JsonDataWrapper {
        private List<Agent> agents;
        private String currentDate;
    }
    
    /**
     * Agent class that matches the JSON structure
     */
    public static class Agent {
        private String id;
        private String fullName;
        private String email;
        private String phone;
        private String specialty;
        private double rating;
        private int ratingCount;
        private int yearsExperience;
        private int propertiesSold;
        private boolean active;
        private boolean featured;
        private List<Review> reviews;
        
        // Getters and setters
        public String getId() { return id; }
        public void setId(String id) { this.id = id; }
        
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
        
        public int getRatingCount() { return ratingCount; }
        public void setRatingCount(int ratingCount) { this.ratingCount = ratingCount; }
        
        public int getYearsExperience() { return yearsExperience; }
        public void setYearsExperience(int yearsExperience) { this.yearsExperience = yearsExperience; }
        
        public int getPropertiesSold() { return propertiesSold; }
        public void setPropertiesSold(int propertiesSold) { this.propertiesSold = propertiesSold; }
        
        public boolean isActive() { return active; }
        public void setActive(boolean active) { this.active = active; }
        
        public boolean isFeatured() { return featured; }
        public void setFeatured(boolean featured) { this.featured = featured; }
        
        public List<Review> getReviews() { return reviews; }
        public void setReviews(List<Review> reviews) { this.reviews = reviews; }
        
        // Calculate performance score (combination of rating and experience)
        public double getPerformanceScore() {
            return (rating * 0.6) + (Math.min(yearsExperience, 10) / 10.0 * 0.3) + 
                   (Math.min(propertiesSold, 50) / 50.0 * 0.1);
        }
    }
    
    /**
     * Review class to match JSON structure
     */
    private static class Review {
        private int rating;
        private String comment;
        private String timestamp;
        private String reviewerId;
    }
}