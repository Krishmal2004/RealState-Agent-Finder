package com.RealState.servlets;

import com.google.gson.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import java.io.*;
import java.util.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/PropertyManagementServlet/*")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class PropertyManagementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Gson gson = new GsonBuilder()
            .setPrettyPrinting()
            .serializeNulls()
            .create();
    private static final String DATA_FILE = "C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\data\\properties.json";
    private static final String IMAGE_UPLOAD_PATH = "C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\property-images\\";
    private static final String CURRENT_USER = "Krishmal2004"; // Updated with current user
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    
    private String getCurrentTimestamp() {
        return LocalDateTime.now().format(DATE_FORMATTER);
    }
    
    // Property model class with audit fields
    private static class Property {
        String propertyId;
        String agentId;
        String title;
        String type;
        double price;
        String location;
        int bedrooms;
        int bathrooms;
        double squareFeet;
        String description;
        List<String> amenities;
        List<String> images;
        String status;
        String createdDate;
        String createdBy;
        String updatedDate;
        String updatedBy;
        boolean featured;

        public Property() {
            String timestamp = "2025-04-07 13:20:36"; // Updated with current timestamp
            this.propertyId = "PROP" + System.currentTimeMillis();
            this.createdDate = timestamp;
            this.createdBy = CURRENT_USER;
            this.updatedDate = timestamp;
            this.updatedBy = CURRENT_USER;
            this.status = "Active";
            this.featured = false;
            this.amenities = new ArrayList<>();
            this.images = new ArrayList<>();
        }
    }
    private static class PropertyData {
        List<Property> properties;
        String lastUpdated;
        String lastUpdatedBy;
        
        public PropertyData() {
            properties = new ArrayList<>();
            lastUpdated = LocalDateTime.now().format(DATE_FORMATTER);
            lastUpdatedBy = CURRENT_USER;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Handle multipart form data
            Property newProperty = new Property();
            List<String> uploadedImages = handleImageUploads(request, newProperty.propertyId);
            
            // Get property data from form
            populatePropertyData(request, newProperty);
            newProperty.images = uploadedImages;
            
            // Validate the property data
            validatePropertyData(newProperty);
            
            // Load existing data
            PropertyData data = loadPropertyData();
            
            // Add new property
            data.properties.add(newProperty);
            data.lastUpdated = getCurrentTimestamp();
            data.lastUpdatedBy = CURRENT_USER;
            
            // Save to file
            savePropertyData(data);

            // Send success response
            sendSuccessResponse(out, newProperty);

        } catch (Exception e) {
            sendErrorResponse(out, e.getMessage());
        }
    }

    private void populatePropertyData(HttpServletRequest request, Property property) {
        property.title = request.getParameter("title");
        property.type = request.getParameter("type");
        property.price = Double.parseDouble(request.getParameter("price"));
        property.location = request.getParameter("location");
        property.bedrooms = Integer.parseInt(request.getParameter("bedrooms"));
        property.bathrooms = Integer.parseInt(request.getParameter("bathrooms"));
        property.squareFeet = Double.parseDouble(request.getParameter("squareFeet"));
        property.description = request.getParameter("description");
        property.agentId = CURRENT_USER;
        
        // Handle amenities if provided
        String[] amenities = request.getParameterValues("amenities");
        if (amenities != null) {
            property.amenities = Arrays.asList(amenities);
        }
    }

    private List<String> handleImageUploads(HttpServletRequest request, String propertyId) 
            throws IOException, ServletException {
        List<String> imagePaths = new ArrayList<>();
        
        // Create directory for property images
        File uploadDir = new File(IMAGE_UPLOAD_PATH + propertyId);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Process each uploaded file
        for (Part part : request.getParts()) {
            if (part.getContentType() != null && part.getContentType().startsWith("image/")) {
                String fileName = getSubmittedFileName(part);
                String fileExtension = fileName.substring(fileName.lastIndexOf("."));
                String newFileName = UUID.randomUUID().toString() + fileExtension;
                
                // Save the file
                String filePath = uploadDir.getPath() + File.separator + newFileName;
                part.write(filePath);
                
                // Store the relative path
                imagePaths.add("property-images/" + propertyId + "/" + newFileName);
            }
        }
        
        return imagePaths;
    }

    private String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return "unknown";
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo != null && pathInfo.startsWith("/image/")) {
            serveImage(response, pathInfo.substring(7));
        } else if (pathInfo != null && pathInfo.startsWith("/property/")) {
            String propertyId = pathInfo.substring(10);
            servePropertyDetails(response, propertyId);
        } else {
            servePropertyList(response);
        }
    }

    private void serveImage(HttpServletResponse response, String imagePath) 
            throws IOException {
        File imageFile = new File(IMAGE_UPLOAD_PATH + imagePath);
        if (!imageFile.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String contentType = getServletContext().getMimeType(imageFile.getName());
        if (contentType == null) {
            contentType = "application/octet-stream";
        }

        response.setContentType(contentType);
        response.setContentLength((int) imageFile.length());

        try (FileInputStream in = new FileInputStream(imageFile);
             OutputStream out = response.getOutputStream()) {
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
        }
    }

    private void servePropertyDetails(HttpServletResponse response, String propertyId) 
            throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            PropertyData data = loadPropertyData();
            Property property = data.properties.stream()
                    .filter(p -> p.propertyId.equals(propertyId))
                    .findFirst()
                    .orElse(null);

            if (property == null) {
                sendErrorResponse(out, "Property not found");
            } else {
                out.println(gson.toJson(property));
            }
        } catch (Exception e) {
            sendErrorResponse(out, e.getMessage());
        }
    }

    private void servePropertyList(HttpServletResponse response) 
            throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            PropertyData data = loadPropertyData();
            out.println(gson.toJson(data.properties));
        } catch (Exception e) {
            sendErrorResponse(out, e.getMessage());
        }
    }

    private void validatePropertyData(Property property) throws Exception {
        if (property.title == null || property.title.trim().isEmpty()) {
            throw new Exception("Property title is required");
        }
        if (property.price <= 0) {
            throw new Exception("Invalid property price");
        }
        if (property.location == null || property.location.trim().isEmpty()) {
            throw new Exception("Property location is required");
        }
        if (property.images.isEmpty()) {
            throw new Exception("At least one property image is required");
        }
    }

    private PropertyData loadPropertyData() throws IOException {
        File file = new File(DATA_FILE);
        
        // Ensure directory exists
        File dir = file.getParentFile();
        if (!dir.exists()) {
            dir.mkdirs();
        }
        
        // Create new file if it doesn't exist
        if (!file.exists()) {
            PropertyData emptyData = new PropertyData();
            savePropertyData(emptyData);
            return emptyData;
        }
        
        // Read existing data
        try (Reader reader = new FileReader(file)) {
            PropertyData data = gson.fromJson(reader, PropertyData.class);
            return data != null ? data : new PropertyData();
        } catch (JsonSyntaxException e) {
            throw new IOException("Invalid JSON data in file: " + e.getMessage());
        }
    }

    private void savePropertyData(PropertyData data) throws IOException {
        // Create backup before saving
        File originalFile = new File(DATA_FILE);
        if (originalFile.exists()) {
            File backupFile = new File(DATA_FILE + ".backup");
            System.out.println(backupFile);
            copyFile(originalFile, backupFile);
        }
        
        // Save new data
        try (Writer writer = new FileWriter(DATA_FILE)) {
            gson.toJson(data, writer);
        }
    }

    private void copyFile(File source, File dest) throws IOException {
        try (InputStream in = new FileInputStream(source);
             OutputStream out = new FileOutputStream(dest)) {
            byte[] buffer = new byte[1024];
            int length;
            while ((length = in.read(buffer)) > 0) {
                out.write(buffer, 0, length);
            }
        }
    }

    private void sendSuccessResponse(PrintWriter out, Property property) {
        JsonObject response = new JsonObject();
        response.addProperty("status", "success");
        response.addProperty("message", "Property added successfully");
        response.addProperty("propertyId", property.propertyId);
        response.addProperty("timestamp", getCurrentTimestamp());
        response.addProperty("user", CURRENT_USER);
        out.println(gson.toJson(response));
    }

    private void sendErrorResponse(PrintWriter out, String message) {
        JsonObject error = new JsonObject();
        error.addProperty("status", "error");
        error.addProperty("message", message);
        error.addProperty("timestamp", getCurrentTimestamp());
        error.addProperty("user", CURRENT_USER);
        out.println(gson.toJson(error));
    }
}