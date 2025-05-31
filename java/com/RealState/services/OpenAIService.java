package com.RealState.services;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.json.JSONArray;
import org.json.JSONObject;

/**
 * Service class for handling interactions with OpenAI API.
 */
public class OpenAIService {
    private static final Logger logger = Logger.getLogger(OpenAIService.class.getName());
    
    // Correct URL for OpenAI API
    private static final String OPENAI_URL = "https://api.openai.com/v1/chat/completions";
    
    private final String apiKey;
    
    /**
     * Constructor that takes an API key.
     * 
     * @param apiKey OpenAI API key
     */
    public OpenAIService(String apiKey) {
        this.apiKey = apiKey;
    }
    
    /**
     * Generates a response from OpenAI based on the user message.
     * 
     * @param userMessage The message from the user
     * @return Response from OpenAI
     * @throws IOException If there is an error in the API call
     */
    public String generateChatResponse(String userMessage) throws IOException {
        if (apiKey == null || apiKey.isEmpty()) {
            throw new IOException("OpenAI API key is not configured");
        }
        
        logger.info("Preparing OpenAI request for message: " + userMessage);
        
        // Create URL object with the correct OpenAI endpoint
        URL url = new URL(OPENAI_URL);
        
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setRequestProperty("Authorization", "Bearer " + apiKey);
        connection.setDoOutput(true);
        connection.setConnectTimeout(10000); // 10 seconds timeout
        connection.setReadTimeout(30000);   // 30 seconds read timeout
        
        // Create the requeste 
        JSONObject requestBody = new JSONObject();
        requestBody.put("model", "gpt-3.5-turbo");
        
        JSONArray messagesArray = new JSONArray();
        
        // Add system message
        JSONObject systemMessage = new JSONObject();
        systemMessage.put("role", "system");
        systemMessage.put("content", "You are a helpful real estate assistant specializing in helping buyers and renters find properties. " +
                "Provide concise, relevant information about properties, pricing, real estate trends, neighborhoods, " +
                "mortgage rates, and home buying/renting processes. Keep responses friendly and professional.");
        messagesArray.put(systemMessage);
        
        // Add user message
        JSONObject userMessageObj = new JSONObject();
        userMessageObj.put("role", "user");
        userMessageObj.put("content", userMessage);
        messagesArray.put(userMessageObj);
        
        requestBody.put("messages", messagesArray);
        requestBody.put("max_tokens", 250);
        requestBody.put("temperature", 0.7);
        
        logger.info("Sending request to OpenAI API");
        
        // Send the request
        try (OutputStream os = connection.getOutputStream()) {
            byte[] input = requestBody.toString().getBytes("UTF-8");
            os.write(input, 0, input.length);
        }
        
        // Process the response
        int responseCode = connection.getResponseCode();
        logger.info("Received response code from OpenAI: " + responseCode);
        
        if (responseCode == HttpURLConnection.HTTP_OK) {
            try (BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"))) {
                StringBuilder responseBody = new StringBuilder();
                String responseLine;
                while ((responseLine = br.readLine()) != null) {
                    responseBody.append(responseLine);
                }
                
                JSONObject jsonResponse = new JSONObject(responseBody.toString());
                String content = jsonResponse.getJSONArray("choices")
                        .getJSONObject(0)
                        .getJSONObject("message")
                        .getString("content");
                
                logger.info("Successfully processed OpenAI response");
                return content;
            }
        } else {
            try (BufferedReader br = new BufferedReader(new InputStreamReader(
                    connection.getErrorStream() != null ? connection.getErrorStream() : 
                    new java.io.ByteArrayInputStream(new byte[0]), "UTF-8"))) {
                StringBuilder errorResponse = new StringBuilder();
                String errorLine;
                while ((errorLine = br.readLine()) != null) {
                    errorResponse.append(errorLine);
                }
                logger.severe("Error from OpenAI API: " + errorResponse.toString());
                throw new IOException("HTTP error code: " + responseCode + ", Response: " + errorResponse);
            }
        }
    }
}