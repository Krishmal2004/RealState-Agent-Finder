package com.RealState.services;

import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonPrimitive;

public class PropertyService {
    
    private String jsonFilePath;
    private Gson gson;
    
    public PropertyService(String jsonFilePath) {
        this.jsonFilePath = jsonFilePath;
        this.gson = new Gson();
    }
    
    public JsonObject getProperties() {
        try {
            FileReader reader = new FileReader(jsonFilePath);
            JsonObject jsonData = gson.fromJson(reader, JsonObject.class);
            reader.close();
            return jsonData;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * Process property images to correctly format them for display
     * @param property The property object containing images
     * @param contextPath The web application context path
     */
    public void processPropertyImages(JsonObject property, String contextPath) {
        try {
            if (!property.has("propertyId")) {
                return;
            }
            
            String propertyId = property.get("propertyId").getAsString();
            
            // Check if property-images directory exists for this property
            String basePath = "C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\property-images";
            File propertyDir = new File(basePath, propertyId);
            
            // Create new array to store valid image paths
            JsonArray newImages = new JsonArray();
            
            // Try to find actual image files in the property directory
            if (propertyDir.exists() && propertyDir.isDirectory()) {
                // List all image files
                File[] files = propertyDir.listFiles((dir, name) -> 
                    name.toLowerCase().endsWith(".jpg") || 
                    name.toLowerCase().endsWith(".jpeg") || 
                    name.toLowerCase().endsWith(".png") || 
                    name.toLowerCase().endsWith(".gif"));
                
                // Add all found image files with correct URLs
                if (files != null && files.length > 0) {
                    for (File file : files) {
                        // Create direct URL to the image via the servlet
                        String imageUrl = contextPath + "/propertyImage/" + propertyId + "/" + file.getName();
                        newImages.add(imageUrl);
                        System.out.println("Found real image: " + file.getName() + ", URL: " + imageUrl);
                    }
                }
            }
            
            // If no real images found, look for external URLs in the current data
            if (newImages.size() == 0 && property.has("images")) {
                JsonArray originalImages = property.getAsJsonArray("images");
                
                for (int i = 0; i < originalImages.size(); i++) {
                    String imgUrl = originalImages.get(i).getAsString();
                    
                    // Only keep external URLs (http/https)
                    if (imgUrl.startsWith("http")) {
                        newImages.add(imgUrl);
                        System.out.println("Using external URL: " + imgUrl);
                    }
                }
            }
            
            // If still no images at all, use a default external image
            if (newImages.size() == 0) {
                newImages.add("https://images.unsplash.com/photo-1560518883-ce09059eeffa?auto=format&fit=crop&w=1200&q=80");
                System.out.println("Using default Unsplash image as fallback");
            }
            
            // Replace the original images array with our processed one
            property.add("images", newImages);
            
        } catch (Exception e) {
            System.out.println("Error processing images for property: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    // Rest of the methods remain unchanged
    public JsonArray getPropertiesByStatus(String status) {
        JsonObject jsonData = getProperties();
        if (jsonData == null) return new JsonArray();
        
        JsonArray properties = jsonData.getAsJsonArray("properties");
        JsonArray filteredProperties = new JsonArray();
        
        for (int i = 0; i < properties.size(); i++) {
            JsonObject property = properties.get(i).getAsJsonObject();
            if (property.has("status") && property.get("status").getAsString().equals(status)) {
                filteredProperties.add(property);
            }
        }
        
        return filteredProperties;
    }
    
    public JsonArray getPropertiesByPriceRange(double min, double max) {
        JsonObject jsonData = getProperties();
        if (jsonData == null) return new JsonArray();
        
        JsonArray properties = jsonData.getAsJsonArray("properties");
        JsonArray filteredProperties = new JsonArray();
        
        for (int i = 0; i < properties.size(); i++) {
            JsonObject property = properties.get(i).getAsJsonObject();
            if (property.has("price")) {
                double price = property.get("price").getAsDouble();
                if (price >= min && price <= max) {
                    filteredProperties.add(property);
                }
            }
        }
        
        return filteredProperties;
    }
    
    public JsonArray getPropertiesByBedrooms(int minBeds) {
        JsonObject jsonData = getProperties();
        if (jsonData == null) return new JsonArray();
        
        JsonArray properties = jsonData.getAsJsonArray("properties");
        JsonArray filteredProperties = new JsonArray();
        
        for (int i = 0; i < properties.size(); i++) {
            JsonObject property = properties.get(i).getAsJsonObject();
            int beds = 0;
            if (property.has("beds")) {
                beds = property.get("beds").getAsInt();
            } else if (property.has("bedrooms")) {
                beds = property.get("bedrooms").getAsInt();
            }
            
            if (beds >= minBeds) {
                filteredProperties.add(property);
            }
        }
        
        return filteredProperties;
    }
    
    public JsonObject getPropertyById(int id) {
        JsonObject jsonData = getProperties();
        if (jsonData == null) return null;
        
        JsonArray properties = jsonData.getAsJsonArray("properties");
        
        for (int i = 0; i < properties.size(); i++) {
            JsonObject property = properties.get(i).getAsJsonObject();
            if (property.has("id") && property.get("id").getAsInt() == id) {
                return property;
            } else if (property.has("propertyId")) {
                String propId = property.get("propertyId").getAsString();
                if (propId.equals("PROP" + id)) {
                    return property;
                }
            }
        }
        
        return null;
    }
    
    public JsonArray searchProperties(String query) {
        query = query.toLowerCase();
        JsonObject jsonData = getProperties();
        if (jsonData == null) return new JsonArray();
        
        JsonArray properties = jsonData.getAsJsonArray("properties");
        JsonArray filteredProperties = new JsonArray();
        
        for (int i = 0; i < properties.size(); i++) {
            JsonObject property = properties.get(i).getAsJsonObject();
            String title = property.has("title") ? property.get("title").getAsString().toLowerCase() : "";
            String location = property.has("location") ? property.get("location").getAsString().toLowerCase() : "";
            
            if (title.contains(query) || location.contains(query)) {
                filteredProperties.add(property);
            }
        }
        
        return filteredProperties;
    }
}