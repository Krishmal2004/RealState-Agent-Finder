package com.RealState.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.nio.file.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.lang.reflect.Type;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;

@WebServlet("/agentdashboard")
public class UserAgentMassageServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    private static final String MESSAGES_FILE_PATH = "C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\data\\userAgentMassage.json";
    private static final Gson gson = new GsonBuilder().setPrettyPrinting().create();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in as agent
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("agentId") == null) {
            // Not logged in or not an agent, redirect to login
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Get agent ID from session
        String agentId = (String) session.getAttribute("agentId");
        
        try {
            // Load dashboard statistics
            Map<String, Integer> stats = getDashboardStats();
            request.setAttribute("totalProperties", stats.get("totalProperties"));
            request.setAttribute("activeClients", stats.get("activeClients"));
            request.setAttribute("appointmentsToday", stats.get("appointmentsToday"));
            request.setAttribute("propertyViews", stats.get("propertyViews"));
            
            // Load recent properties
            List<Map<String, Object>> recentProperties = getRecentProperties();
            request.setAttribute("recentProperties", recentProperties);
            
            // Load appointments
            List<Map<String, Object>> appointments = getTodayAppointments();
            request.setAttribute("appointments", appointments);
            
            // Load messages for the agent from messages.json
            List<Map<String, Object>> messages = loadAgentMessages(agentId);
            request.setAttribute("messages", messages);
            
            // Count unread messages
            int unreadCount = countUnreadMessages(messages);
            request.setAttribute("unreadMessageCount", unreadCount);
            
            // Set agent information
            Map<String, String> agentInfo = getAgentInfo(agentId);
            request.setAttribute("agentName", agentInfo.get("name"));
            request.setAttribute("agentPosition", agentInfo.get("position"));
            request.setAttribute("agentImage", agentInfo.get("imageUrl"));
            
            // Set current date and time
            request.setAttribute("currentDateTime", "2025-03-26 20:10:10");
            request.setAttribute("currentUser", "IT24103866");
            
            // Forward to the dashboard JSP
            request.getRequestDispatcher("agentDashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading dashboard data");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check action parameter to determine operation
        String action = request.getParameter("action");
        
        if (action != null) {
            if (action.equals("markMessageRead")) {
                markMessageAsRead(request, response);
                return;
            } else if (action.equals("markAllMessagesRead")) {
                markAllMessagesAsRead(request, response);
                return;
            } else if (action.equals("replyToMessage")) {
                replyToMessage(request, response);
                return;
            }
        }
        
        // If no specific action or unknown action, redirect to GET
        doGet(request, response);
    }
    
    /**
     * Mark a specific message as read
     */
    private void markMessageAsRead(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JsonObject responseJson = new JsonObject();
        
        try {
            // Get message ID
            String messageId = request.getParameter("messageId");
            if (messageId == null) {
                responseJson.addProperty("success", false);
                responseJson.addProperty("error", "Message ID is required");
                out.print(gson.toJson(responseJson));
                return;
            }
            
            // Read messages from file
            List<Map<String, Object>> messages = readMessagesFromFile();
            boolean updated = false;
            
            // Find and update the message
            for (Map<String, Object> message : messages) {
                if (message.get("messageId").toString().equals(messageId)) {
                    message.put("read", true);
                    updated = true;
                    break;
                }
            }
            
            // If message was found and updated, write back to file
            if (updated) {
                writeMessagesToFile(messages);
                responseJson.addProperty("success", true);
            } else {
                responseJson.addProperty("success", false);
                responseJson.addProperty("error", "Message not found");
            }
            
            out.print(gson.toJson(responseJson));
            
        } catch (Exception e) {
            e.printStackTrace();
            responseJson.addProperty("success", false);
            responseJson.addProperty("error", "Error: " + e.getMessage());
            out.print(gson.toJson(responseJson));
        }
    }
    
    /**
     * Mark all messages for an agent as read
     */
    private void markAllMessagesAsRead(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JsonObject responseJson = new JsonObject();
        
        try {
            // Get agent ID
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("agentId") == null) {
                responseJson.addProperty("success", false);
                responseJson.addProperty("error", "Agent not logged in");
                out.print(gson.toJson(responseJson));
                return;
            }
            String agentId = (String) session.getAttribute("agentId");
            
            // Read messages from file
            List<Map<String, Object>> messages = readMessagesFromFile();
            boolean updated = false;
            
            // Find and update all messages for this agent
            for (Map<String, Object> message : messages) {
                if (message.get("agentId").toString().equals(agentId) && 
                    !(Boolean) message.get("read")) {
                    message.put("read", true);
                    updated = true;
                }
            }
            
            // If any messages were updated, write back to file
            if (updated) {
                writeMessagesToFile(messages);
                responseJson.addProperty("success", true);
            } else {
                responseJson.addProperty("success", true);
                responseJson.addProperty("message", "No unread messages found");
            }
            
            out.print(gson.toJson(responseJson));
            
        } catch (Exception e) {
            e.printStackTrace();
            responseJson.addProperty("success", false);
            responseJson.addProperty("error", "Error: " + e.getMessage());
            out.print(gson.toJson(responseJson));
        }
    }
    
    /**
     * Reply to a message and update its status
     */
    private void replyToMessage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JsonObject responseJson = new JsonObject();
        
        try {
            // Get message parameters
            String messageId = request.getParameter("messageId");
            String replyText = request.getParameter("replyText");
            
            if (messageId == null || replyText == null || replyText.trim().isEmpty()) {
                responseJson.addProperty("success", false);
                responseJson.addProperty("error", "Message ID and reply text are required");
                out.print(gson.toJson(responseJson));
                return;
            }
            
            // Get agent info
            HttpSession session = request.getSession(false);
            String agentId = (String) session.getAttribute("agentId");
            
            // Read messages from file
            List<Map<String, Object>> messages = readMessagesFromFile();
            boolean updated = false;
            
            // Find and update the message
            for (Map<String, Object> message : messages) {
                if (message.get("messageId").toString().equals(messageId)) {
                    // Update message status
                    message.put("read", true);
                    message.put("status", "REPLIED");
                    
                    // Add reply information
                    Map<String, Object> reply = new HashMap<>();
                    reply.put("replyText", replyText);
                    reply.put("replyTimestamp", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
                    reply.put("replyAgentId", agentId);
                    
                    // Add reply to message
                    message.put("reply", reply);
                    
                    updated = true;
                    break;
                }
            }
            
            // If message was found and updated, write back to file
            if (updated) {
                writeMessagesToFile(messages);
                responseJson.addProperty("success", true);
                responseJson.addProperty("message", "Reply sent successfully");
            } else {
                responseJson.addProperty("success", false);
                responseJson.addProperty("error", "Message not found");
            }
            
            out.print(gson.toJson(responseJson));
            
        } catch (Exception e) {
            e.printStackTrace();
            responseJson.addProperty("success", false);
            responseJson.addProperty("error", "Error: " + e.getMessage());
            out.print(gson.toJson(responseJson));
        }
    }
    
    /**
     * Load messages for a specific agent
     */
    private List<Map<String, Object>> loadAgentMessages(String agentId) throws IOException {
        // Read all messages from file
        List<Map<String, Object>> allMessages = readMessagesFromFile();
        List<Map<String, Object>> agentMessages = new ArrayList<>();
        
        // Filter messages for this agent
        for (Map<String, Object> message : allMessages) {
            if (message.get("agentId").toString().equals(agentId)) {
                agentMessages.add(message);
            }
        }
        
        return agentMessages;
    }
    
    /**
     * Count unread messages
     */
    private int countUnreadMessages(List<Map<String, Object>> messages) {
        int count = 0;
        for (Map<String, Object> message : messages) {
            if (!(Boolean) message.get("read")) {
                count++;
            }
        }
        return count;
    }
    
    /**
     * Read messages from JSON file
     */
    private List<Map<String, Object>> readMessagesFromFile() throws IOException {
        // Get file path
        Path filePath = Paths.get(MESSAGES_FILE_PATH);
        File file = filePath.toFile();
        
        // If file doesn't exist, create an empty array
        if (!file.exists()) {
            List<Map<String, Object>> emptyList = new ArrayList<>();
            writeMessagesToFile(emptyList);
            return emptyList;
        }
        
        // Read file content
        String content = new String(Files.readAllBytes(filePath));
        
        // Parse JSON content with Gson
        Type listType = new TypeToken<List<Map<String, Object>>>(){}.getType();
        List<Map<String, Object>> messages = gson.fromJson(content, listType);
        
        return messages != null ? messages : new ArrayList<>();
    }
    
    /**
     * Write messages to JSON file
     */
    private void writeMessagesToFile(List<Map<String, Object>> messages) throws IOException {
        // Get file path
        Path filePath = Paths.get(MESSAGES_FILE_PATH);
        
        // Create parent directories if they don't exist
        Files.createDirectories(filePath.getParent());
        
        // Write to file
        try (FileWriter writer = new FileWriter(filePath.toFile())) {
            writer.write(gson.toJson(messages));
            writer.flush();
        }
    }
    
    /**
     * Mock method to get dashboard statistics
     */
    private Map<String, Integer> getDashboardStats() {
        Map<String, Integer> stats = new HashMap<>();
        stats.put("totalProperties", 142);
        stats.put("activeClients", 87);
        stats.put("appointmentsToday", 15);
        stats.put("propertyViews", 24);
        return stats;
    }
    
    /**
     * Mock method to get recent properties
     */
    private List<Map<String, Object>> getRecentProperties() {
        List<Map<String, Object>> properties = new ArrayList<>();
        
        Map<String, Object> prop1 = new HashMap<>();
        prop1.put("id", "1");
        prop1.put("title", "Modern Villa in Beverly Hills");
        prop1.put("location", "Beverly Hills, CA");
        prop1.put("price", "1,250,000");
        prop1.put("status", "For Sale");
        prop1.put("beds", 4);
        prop1.put("baths", 3);
        prop1.put("sqft", "2,800");
        prop1.put("imageUrl", "https://images.unsplash.com/photo-1564013799919-ab600027ffc6");
        properties.add(prop1);
        
        Map<String, Object> prop2 = new HashMap<>();
        prop2.put("id", "2");
        prop2.put("title", "Downtown Luxury Apartment");
        prop2.put("location", "Downtown, NY");
        prop2.put("price", "3,500/mo");
        prop2.put("status", "For Rent");
        prop2.put("beds", 2);
        prop2.put("baths", 2);
        prop2.put("sqft", "1,200");
        prop2.put("imageUrl", "https://images.unsplash.com/photo-1570129477492-45c003edd2be");
        properties.add(prop2);
        
        Map<String, Object> prop3 = new HashMap<>();
        prop3.put("id", "3");
        prop3.put("title", "Coastal View Home");
        prop3.put("location", "Malibu, CA");
        prop3.put("price", "3,750,000");
        prop3.put("status", "For Sale");
        prop3.put("beds", 5);
        prop3.put("baths", 4);
        prop3.put("sqft", "4,200");
        prop3.put("imageUrl", "https://images.unsplash.com/photo-1582063289852-62e3ba2747f8");
        properties.add(prop3);
        
        return properties;
    }
    
    /**
     * Mock method to get today's appointments
     */
    private List<Map<String, Object>> getTodayAppointments() {
        List<Map<String, Object>> appointments = new ArrayList<>();
        
        Map<String, Object> apt1 = new HashMap<>();
        apt1.put("time", "10:00 AM");
        apt1.put("duration", "1 hour");
        apt1.put("title", "Property Viewing with Emily Johnson");
        apt1.put("location", "123 Sunset Blvd");
        appointments.add(apt1);
        
        Map<String, Object> apt2 = new HashMap<>();
        apt2.put("time", "1:30 PM");
        apt2.put("duration", "45 minutes");
        apt2.put("title", "Contract Signing with Michael Brown");
        apt2.put("location", "Office");
        appointments.add(apt2);
        
        Map<String, Object> apt3 = new HashMap<>();
        apt3.put("time", "4:00 PM");
        apt3.put("duration", "1.5 hours");
        apt3.put("title", "Home Inspection with Taylor Family");
        apt3.put("location", "456 Oak Lane");
        appointments.add(apt3);
        
        Map<String, Object> apt4 = new HashMap<>();
        apt4.put("time", "5:30 PM");
        apt4.put("duration", "1 hour");
        apt4.put("title", "Virtual Tour with Robert Davis");
        apt4.put("location", "Remote (Zoom)");
        appointments.add(apt4);
        
        return appointments;
    }
    
    /**
     * Mock method to get agent information
     */
    private Map<String, String> getAgentInfo(String agentId) {
        Map<String, String> agentInfo = new HashMap<>();
        agentInfo.put("name", "John Smith");
        agentInfo.put("position", "Senior Real Estate Agent");
        agentInfo.put("imageUrl", "https://randomuser.me/api/portraits/men/41.jpg");
        return agentInfo;
    }
}