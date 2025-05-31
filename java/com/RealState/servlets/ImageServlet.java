package com.RealState.servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/propertyImage/*")
public class ImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String IMAGE_BASE_PATH = "C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\property-images";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get the path info from the request URL
        String pathInfo = request.getPathInfo();
        System.out.println("Image path requested: " + pathInfo);
        
        if (pathInfo == null || pathInfo.equals("/")) {
            System.out.println("Missing image path");
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing image path");
            return;
        }
        
        // Remove leading slash if present
        if (pathInfo.startsWith("/")) {
            pathInfo = pathInfo.substring(1);
        }
        
        // Construct the full file path
        String filePath = IMAGE_BASE_PATH + File.separator + pathInfo;
        File file = new File(filePath);
        System.out.println("Looking for image at: " + filePath);
        
        if (!file.exists() || !file.isFile()) {
            System.out.println("Image file not found: " + filePath);
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found");
            return;
        }
        
        // Set the content type
        String contentType = getServletContext().getMimeType(file.getName());
        if (contentType == null) {
            // Default to JPEG if can't determine
            contentType = "image/jpeg";
        }
        response.setContentType(contentType);
        
        // Set content length for better performance
        response.setContentLength((int) file.length());
        
        // Stream the image to the response
        try (
            FileInputStream in = new FileInputStream(file);
            OutputStream out = response.getOutputStream()
        ) {
            // Copy the image data
            byte[] buffer = new byte[4096];
            int bytesRead;
            
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
            
            // Ensure it's fully written and flushed
            out.flush();
        } catch (IOException e) {
            System.out.println("Error serving image: " + e.getMessage());
            throw e;
        }
    }
}