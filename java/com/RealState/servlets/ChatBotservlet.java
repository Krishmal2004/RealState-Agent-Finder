package com.RealState.servlets;

import com.RealState.services.OpenAIService;
import org.json.JSONObject;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet that handles chatbot requests.
 */
@WebServlet("/chatbot")
public class ChatBotservlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(ChatBotservlet.class.getName());
    private OpenAIService openAIService;
    
    // Your API key - in production this should be securely stored in environment variables or config
    private static final String OPENAI_API_KEY = "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";
    
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        
        try {
            // Initialize the OpenAI service with your API key
            openAIService = new OpenAIService(OPENAI_API_KEY);
            logger.info("ChatBotservlet initialized successfully");
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error initializing ChatBotservlet", e);
            throw new ServletException("Failed to initialize ChatBotservlet", e);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            // Read the request body
            StringBuilder buffer = new StringBuilder();
            try (BufferedReader reader = request.getReader()) {
                String line;
                while ((line = reader.readLine()) != null) {
                    buffer.append(line);
                }
            }
            
            // Parse the request
            JSONObject jsonRequest = new JSONObject(buffer.toString());
            String userMessage = jsonRequest.getString("message");
            
            logger.info("Received chat request: " + userMessage);
            
            // Get response from OpenAI service
            String chatbotResponse = openAIService.generateChatResponse(userMessage);
            
            // Return the response
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("response", chatbotResponse);
            
            response.getWriter().write(jsonResponse.toString());
            logger.info("Chat response sent successfully");
        } catch (Exception e) {
            // Log the error
            logger.log(Level.SEVERE, "Error processing chat request", e);
            
            // Create fallback response
            String fallbackResponse = getFallbackResponse(request);
            
            // Return fallback response
            JSONObject errorResponse = new JSONObject();
            errorResponse.put("response", fallbackResponse);
            errorResponse.put("error", e.getMessage());
            response.getWriter().write(errorResponse.toString());
        }
    }
    
    /**
     * Provides a fallback response if the API call fails.
     */
    private String getFallbackResponse(HttpServletRequest request) {
        String username = (String) request.getSession().getAttribute("user");
        if (username == null || username.isEmpty()) {
            username = "Guest";
        }
        
        return "I'm sorry, " + username + ". I'm currently experiencing technical difficulties. " +
               "Please try again later or contact our customer service at support@realestatefinder.com for immediate assistance.";
    }
}