package com.RealState.servlets;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import org.json.*;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonArray;

@WebServlet("/AgentSortServlet")
public class IndexAgentSortServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set response type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            // Get the sorting order from the request parameter (asc or desc)
            String sortOrder = request.getParameter("order");
            if (sortOrder == null || sortOrder.isEmpty()) {
                sortOrder = "desc"; // Default to descending order (highest ratings first)
            }
            
            // Read agent data from JSON file
            String filePath = ("C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\data\\agentsManagement.json");
            
            // If application.getRealPath doesn't work, fall back to the absolute path
            if (filePath == null || !new File(filePath).exists()) {
                filePath = "C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\data\\agentsManagement.json";
            }
            
            // Read JSON file content
            String jsonContent;
            try {
                jsonContent = new String(Files.readAllBytes(Paths.get(filePath)));
            } catch (Exception e) {
                // Use fallback JSON if file cannot be read
                jsonContent = "{\"agents\":[{\"id\":\"AG12345678\",\"fullName\":\"John Doe\",\"email\":\"john.doe@propertyagent.com\",\"phone\":\"(123) 456-7890\",\"specialty\":\"Residential\",\"rating\":1.5,\"ratingCount\":0,\"yearsExperience\":5,\"propertiesSold\":24,\"active\":true,\"featured\":true},{\"id\":\"AG23456789\",\"fullName\":\"Jane Smith\",\"email\":\"jane.smith@propertyagent.com\",\"phone\":\"(234) 567-8901\",\"specialty\":\"Commercial\",\"rating\":4.2,\"ratingCount\":0,\"yearsExperience\":7,\"propertiesSold\":18,\"active\":true,\"featured\":true},{\"id\":\"AG26350191\",\"fullName\":\"hh\",\"email\":\"hh@gmail.com\",\"phone\":\"74747474747444\",\"specialty\":\"Residential\",\"rating\":5.0,\"ratingCount\":1,\"yearsExperience\":444,\"propertiesSold\":0,\"active\":true,\"featured\":true,\"reviews\":[{\"rating\":5,\"comment\":\"\",\"timestamp\":\"2025-05-03 10:00:28\",\"reviewerId\":\"IT24103866\"}]},{\"id\":\"AG82638441\",\"fullName\":\"Saviru\",\"email\":\"sa@gmail.com\",\"phone\":\"123456789\",\"specialty\":\"Luxury\",\"rating\":3.0,\"ratingCount\":0,\"yearsExperience\":2,\"propertiesSold\":0,\"active\":true,\"featured\":true},{\"id\":\"AG44144535\",\"fullName\":\"kala\",\"email\":\"kala@gmail.com\",\"phone\":\"123456789\",\"specialty\":\"Industrial\",\"rating\":5.0,\"ratingCount\":2,\"yearsExperience\":7,\"propertiesSold\":0,\"active\":true,\"featured\":true,\"reviews\":[{\"rating\":5,\"comment\":\"\",\"timestamp\":\"2025-05-03 10:00:28\",\"reviewerId\":\"IT24103866\"},{\"rating\":5,\"comment\":\"\",\"timestamp\":\"2025-05-03 10:00:28\",\"reviewerId\":\"IT24103866\"}]}],\"currentDate\":\"2025-05-03 10:00:28\"}";
            }
            
            // Parse JSON and extract agent array
            JSONObject jsonObject = new JSONObject(jsonContent);
            JSONArray agentsArray = jsonObject.getJSONArray("agents");
            
            // Convert JSONArray to List for easier manipulation
            List<JSONObject> agentsList = new ArrayList<>();
            for (int i = 0; i < agentsArray.length(); i++) {
                agentsList.add(agentsArray.getJSONObject(i));
            }
            
            // Apply Selection Sort Algorithm to sort by rating
            selectionSortByRating(agentsList, sortOrder.equals("asc"));
            
            // Create new JSONArray with sorted agents
            JSONArray sortedAgentsArray = new JSONArray();
            for (JSONObject agent : agentsList) {
                sortedAgentsArray.put(agent);
            }
            
            // Create response JSON with sorted agents
            JSONObject responseJson = new JSONObject();
            responseJson.put("agents", sortedAgentsArray);
            responseJson.put("sortOrder", sortOrder);
            responseJson.put("timestamp", new Date().toString());
            
            // Write response
            out.print(responseJson.toString());
            
        } catch (Exception e) {
            // Handle errors and return error response
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("error", "Error processing request: " + e.getMessage());
            out.print(new Gson().toJson(errorResponse));
        } finally {
            out.flush();
        }
    }
    
    // Selection Sort Algorithm Implementation
    private void selectionSortByRating(List<JSONObject> agents, boolean ascending) {
        int n = agents.size();
        
        // One by one move boundary of unsorted subarray
        for (int i = 0; i < n - 1; i++) {
            // Find the index with min/max element in unsorted array
            int selectedIdx = i;
            for (int j = i + 1; j < n; j++) {
                double currentRating = agents.get(j).optDouble("rating", 0.0);
                double selectedRating = agents.get(selectedIdx).optDouble("rating", 0.0);
                
                if (ascending) {
                    // For ascending order
                    if (currentRating < selectedRating) {
                        selectedIdx = j;
                    }
                } else {
                    // For descending order
                    if (currentRating > selectedRating) {
                        selectedIdx = j;
                    }
                }
            }
            
            // Swap the found minimum/maximum element with the first element
            JSONObject temp = agents.get(selectedIdx);
            agents.set(selectedIdx, agents.get(i));
            agents.set(i, temp);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Forward POST requests to doGet
        doGet(request, response);
    }
}