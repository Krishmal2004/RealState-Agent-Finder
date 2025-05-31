package com.RealState.servlets;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

@WebServlet("/chat-bot")
public class ChatServlet extends HttpServlet {
    private static final String OPENAI_API_KEY = "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";
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        String userMessage = request.getParameter("message");
        
        try {
            String apiResponse = callOpenAI(userMessage);
            response.setContentType("application/json");
            response.getWriter().write(apiResponse);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }
    
    private String callOpenAI(String message) throws IOException, InterruptedException {
        HttpClient client = HttpClient.newHttpClient();
        String requestBody = String.format("""
            {
                "model": "gpt-3.5-turbo",
                "messages": [
                    {
                        "role": "system",
                        "content": "You are a helpful real estate assistant."
                    },
                    {
                        "role": "user",
                        "content": "%s"
                    }
                ]
            }""", message);

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create("https://api.openai.com/v1/chat/completions"))
                .header("Content-Type", "application/json")
                .header("Authorization", "Bearer " + "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")
                .POST(HttpRequest.BodyPublishers.ofString(requestBody))
                .build();

        HttpResponse<String> response = client.send(request, 
                HttpResponse.BodyHandlers.ofString());
        return response.body();
    }
}