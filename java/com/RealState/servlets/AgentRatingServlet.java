package com.RealState.servlets;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;
import com.RealState.model.Agent;
import com.RealState.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.lang.reflect.Type;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/agentRating")
public class AgentRatingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Data directory path
        String dataDir = getServletContext().getRealPath("/WEB-INF/data");
        
        // Read user data from estate.json
        User currentUser = readCurrentUser(dataDir);
        
        // Read agent data from agentShowingAdmin.json
        List<Agent> agents = readAgents(dataDir);
        
        // Sort agents by rating using selection sort
        selectionSortAgentsByRating(agents);
        
        // Set attributes for JSP
        request.setAttribute("agents", agents);
        request.setAttribute("currentUser", currentUser);
        request.setAttribute("currentDateTime", "2025-05-02 18:18:29");
        
        // Forward to JSP
        request.getRequestDispatcher("/agentRatings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get parameters from the form
        String agentId = request.getParameter("agentId");
        String ratingValue = request.getParameter("rating");
        String review = request.getParameter("review");
        String userId = request.getParameter("userId");
        
        if (agentId != null && ratingValue != null && userId != null) {
            int rating = Integer.parseInt(ratingValue);
            
            // Data directory path
            String dataDir = getServletContext().getRealPath("/WEB-INF/data");
            
            // Read agents from JSON
            List<Agent> agents = readAgents(dataDir);
            
            // Find the agent to update
            for (Agent agent : agents) {
                if (agent.getId().equals(agentId)) {
                    // Create new rating
                    Agent.Rating newRating = new Agent.Rating();
                    newRating.setUserId(userId);
                    newRating.setRating(rating);
                    newRating.setReview(review);
                    newRating.setDate(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
                    
                    // Add rating to agent
                    agent.addRating(newRating);
                    break;
                }
            }
            
            // Write updated data back to JSON
            writeAgents(dataDir, agents);
            
            // Sort agents by rating
            selectionSortAgentsByRating(agents);
            
            // Set attributes for JSP
            request.setAttribute("agents", agents);
            request.setAttribute("currentUser", readCurrentUser(dataDir));
            request.setAttribute("currentDateTime", "2025-05-02 18:18:29");
            request.setAttribute("message", "Rating submitted successfully!");
            request.setAttribute("success", true);
        }
        
        // Forward to JSP
        request.getRequestDispatcher("/agentRatings.jsp").forward(request, response);
    }
    
    // Read current user data from estate.json
    private User readCurrentUser(String dataDir) {
        try {
            String jsonContent = new String(Files.readAllBytes(Paths.get(dataDir, "estate.json")), StandardCharsets.UTF_8);
            JsonObject jsonObject = new Gson().fromJson(jsonContent, JsonObject.class);
            
            // Extract user data from the JSON
            User user = new User();
            if (jsonObject.has("currentUser")) {
                JsonObject userObject = jsonObject.getAsJsonObject("currentUser");
                //user.setUserId("IT24103866"); // Setting the specified user ID
                
                if (userObject.has("firstName")) {
                    user.setFirstName(userObject.get("firstName").getAsString());
                }
                
                if (userObject.has("lastName")) {
                    user.setLastName(userObject.get("lastName").getAsString());
                }
                
                if (userObject.has("username")) {
                    user.setUsername(userObject.get("username").getAsString());
                }
                
                if (userObject.has("email")) {
                    user.setEmail(userObject.get("email").getAsString());
                }
            }
            
            return user;
        } catch (IOException e) {
            e.printStackTrace();
            // Return default user if there's an error
            User defaultUser = new User();
            //defaultUser.setUserId("IT24103866");
            defaultUser.setFirstName("Default");
            defaultUser.setUsername("default_user");
            return defaultUser;
        }
    }
    
    // Read agent data from agentShowingAdmin.json
    private List<Agent> readAgents(String dataDir) {
        try {
            String jsonContent = new String(Files.readAllBytes(Paths.get(dataDir, "agentShowingAdmin.json")), StandardCharsets.UTF_8);
            Type listType = new TypeToken<List<Agent>>() {}.getType();
            return new Gson().fromJson(jsonContent, listType);
        } catch (IOException e) {
            e.printStackTrace();
            return new ArrayList<>(); // Return empty list if there's an error
        }
    }
    
    // Write agent data back to agentShowingAdmin.json
    private void writeAgents(String dataDir, List<Agent> agents) {
        try (Writer writer = new FileWriter(new File(dataDir, "agentShowingAdmin.json"))) {
            new Gson().toJson(agents, writer);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    // Selection sort for agents by rating (descending order)
    private void selectionSortAgentsByRating(List<Agent> agents) {
        int n = agents.size();
        
        // One by one move boundary of unsorted subarray
        for (int i = 0; i < n - 1; i++) {
            // Find the maximum element in unsorted array
            int maxIdx = i;
            for (int j = i + 1; j < n; j++) {
                if (agents.get(j).getRating() > agents.get(maxIdx).getRating()) {
                    maxIdx = j;
                }
            }
            
            // Swap the found maximum element with the first element
            if (maxIdx != i) {
                Agent temp = agents.get(i);
                agents.set(i, agents.get(maxIdx));
                agents.set(maxIdx, temp);
            }
        }
    }
}