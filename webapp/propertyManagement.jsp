<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="org.json.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.RealState.model.Property" %>

<%!
    // Inner class representing property data (mirrors the Property model)
    public static class PropertyData {
        private int id;
        private String title;
        private int price;
        private String currency = "USD";
        private String priceInterval = ""; // monthly, yearly, one-time
        private String status = "Available"; // Available, Sold, Pending, Rented
        private String location;
        private int beds;
        private int baths;
        private int area;
        private String areaUnit = "sqft";
        private List<String> amenities = new ArrayList<>();
        private List<String> images = new ArrayList<>();
        private String propertyType = ""; // House, Apartment, Land, Commercial
        private String description = "";
        private String listedDate;
        private String agentId = "";
        private String agentName = "";
        private boolean featured = false;
        
        public PropertyData() {
            this.id = generateId();
            this.listedDate = LocalDateTime.now().format(
                DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) + " (UTC)";
        }
        
        private int generateId() {
            // Generate a random ID between 10000 and 99999
            Random rand = new Random();
            return rand.nextInt(90000) + 10000;
        }
        
        // Convert PropertyData object to JSONObject
        public JSONObject toJson() {
            JSONObject json = new JSONObject();
            json.put("id", id);
            json.put("title", title);
            json.put("price", price);
            json.put("currency", currency);
            json.put("priceInterval", priceInterval);
            json.put("status", status);
            json.put("location", location);
            json.put("beds", beds);
            json.put("baths", baths);
            json.put("area", area);
            json.put("areaUnit", areaUnit);
            
            // Convert amenities list to JSONArray
            JSONArray amenitiesArray = new JSONArray();
            for (String amenity : amenities) {
                amenitiesArray.put(amenity);
            }
            json.put("amenities", amenitiesArray);
            
            // Convert images list to JSONArray
            JSONArray imagesArray = new JSONArray();
            for (String image : images) {
                imagesArray.put(image);
            }
            json.put("images", imagesArray);
            
            json.put("propertyType", propertyType);
            json.put("description", description);
            json.put("listedDate", listedDate);
            json.put("agentId", agentId);
            json.put("agentName", agentName);
            json.put("featured", featured);
            
            return json;
        }
        
        // Create PropertyData from JSONObject
        public static PropertyData fromJson(JSONObject json) {
            PropertyData property = new PropertyData();
            property.setId(json.optInt("id", property.getId()));
            property.setTitle(json.optString("title", ""));
            property.setPrice(json.optInt("price", 0));
            property.setCurrency(json.optString("currency", "USD"));
            property.setPriceInterval(json.optString("priceInterval", ""));
            property.setStatus(json.optString("status", "Available"));
            property.setLocation(json.optString("location", ""));
            property.setBeds(json.optInt("beds", 0));
            property.setBaths(json.optInt("baths", 0));
            property.setArea(json.optInt("area", 0));
            property.setAreaUnit(json.optString("areaUnit", "sqft"));
            
            // Get amenities JSONArray and convert to List
            JSONArray amenitiesArray = json.optJSONArray("amenities");
            if (amenitiesArray != null) {
                List<String> amenities = new ArrayList<>();
                for (int i = 0; i < amenitiesArray.length(); i++) {
                    amenities.add(amenitiesArray.optString(i, ""));
                }
                property.setAmenities(amenities);
            }
            
            // Get images JSONArray and convert to List
            JSONArray imagesArray = json.optJSONArray("images");
            if (imagesArray != null) {
                List<String> images = new ArrayList<>();
                for (int i = 0; i < imagesArray.length(); i++) {
                    images.add(imagesArray.optString(i, ""));
                }
                property.setImages(images);
            }
            
            property.setPropertyType(json.optString("propertyType", ""));
            property.setDescription(json.optString("description", ""));
            property.setListedDate(json.optString("listedDate", property.getListedDate()));
            property.setAgentId(json.optString("agentId", ""));
            property.setAgentName(json.optString("agentName", ""));
            property.setFeatured(json.optBoolean("featured", false));
            
            return property;
        }
        
        // Getters and setters
        public int getId() { return id; }
        public void setId(int id) { this.id = id; }
        
        public String getTitle() { return title; }
        public void setTitle(String title) { this.title = title; }
        
        public int getPrice() { return price; }
        public void setPrice(int price) { this.price = price; }
        
        public String getCurrency() { return currency; }
        public void setCurrency(String currency) { this.currency = currency; }
        
        public String getPriceInterval() { return priceInterval; }
        public void setPriceInterval(String priceInterval) { this.priceInterval = priceInterval; }
        
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
        
        public String getLocation() { return location; }
        public void setLocation(String location) { this.location = location; }
        
        public int getBeds() { return beds; }
        public void setBeds(int beds) { this.beds = beds; }
        
        public int getBaths() { return baths; }
        public void setBaths(int baths) { this.baths = baths; }
        
        public int getArea() { return area; }
        public void setArea(int area) { this.area = area; }
        
        public String getAreaUnit() { return areaUnit; }
        public void setAreaUnit(String areaUnit) { this.areaUnit = areaUnit; }
        
        public List<String> getAmenities() { return amenities; }
        public void setAmenities(List<String> amenities) { this.amenities = amenities; }
        
        public List<String> getImages() { return images; }
        public void setImages(List<String> images) { this.images = images; }
        
        public String getPropertyType() { return propertyType; }
        public void setPropertyType(String propertyType) { this.propertyType = propertyType; }
        
        public String getDescription() { return description; }
        public void setDescription(String description) { this.description = description; }
        
        public String getListedDate() { return listedDate; }
        public void setListedDate(String listedDate) { this.listedDate = listedDate; }
        
        public String getAgentId() { return agentId; }
        public void setAgentId(String agentId) { this.agentId = agentId; }
        
        public String getAgentName() { return agentName; }
        public void setAgentName(String agentName) { this.agentName = agentName; }
        
        public boolean isFeatured() { return featured; }
        public void setFeatured(boolean featured) { this.featured = featured; }
    }
    
    // Methods for property file operations using JSON
    public List<PropertyData> getAllProperties(String filePath) {
        List<PropertyData> properties = new ArrayList<>();
        File file = new File(filePath);
        
        if (!file.exists() || file.length() == 0) {
            // Return empty list if file doesn't exist or is empty
            return properties;
        }
        
        try {
            String jsonContent = new String(Files.readAllBytes(Paths.get(filePath)));
            
            // Trim the content to handle any potential whitespace
            jsonContent = jsonContent.trim();
            
            // Check if the content is a valid JSON structure
            if (!jsonContent.startsWith("{")) {
                System.out.println("Warning: Invalid JSON format in file. Creating a new JSON structure.");
                return properties; // Return empty list, will be initialized later
            }
            
            JSONObject jsonData = new JSONObject(jsonContent);
            
            // Get metadata (optional fields)
            String currentDate = jsonData.optString("currentDate", "");
            String currentUser = jsonData.optString("currentUser", "System");
            
            // Get properties array
            if (jsonData.has("properties")) {
                JSONArray propertiesArray = jsonData.getJSONArray("properties");
                
                for (int i = 0; i < propertiesArray.length(); i++) {
                    JSONObject propertyJson = propertiesArray.getJSONObject(i);
                    PropertyData property = PropertyData.fromJson(propertyJson);
                    properties.add(property);
                }
            }
        } catch (Exception e) {
            System.out.println("Error reading properties from JSON: " + e.getMessage());
            e.printStackTrace();
            // Return empty list on error
        }
        
        return properties;
    }
    
    public PropertyData getPropertyById(int propertyId, String filePath) {
        for (PropertyData property : getAllProperties(filePath)) {
            if (property.getId() == propertyId) {
                return property;
            }
        }
        return null;
    }
    
    public void addProperty(PropertyData property, String filePath) {
        List<PropertyData> properties = getAllProperties(filePath);
        properties.add(property);
        saveAllProperties(properties, filePath);
    }
    
    public void updateProperty(PropertyData updatedProperty, String filePath) {
        List<PropertyData> properties = getAllProperties(filePath);
        boolean found = false;
        
        for (int i = 0; i < properties.size(); i++) {
            if (properties.get(i).getId() == updatedProperty.getId()) {
                properties.set(i, updatedProperty);
                found = true;
                break;
            }
        }
        
        if (!found) {
            throw new IllegalArgumentException("Property not found");
        }
        
        saveAllProperties(properties, filePath);
    }
    
    public void deleteProperty(int propertyId, String filePath) {
        List<PropertyData> properties = getAllProperties(filePath);
        boolean found = false;
        
        for (Iterator<PropertyData> iterator = properties.iterator(); iterator.hasNext();) {
            PropertyData property = iterator.next();
            if (property.getId() == propertyId) {
                iterator.remove();
                found = true;
                break;
            }
        }
        
        if (!found) {
            throw new IllegalArgumentException("Property not found");
        }
        
        saveAllProperties(properties, filePath);
    }
    
    private void saveAllProperties(List<PropertyData> properties, String filePath) {
        try {
            // Create JSON structure
            JSONObject jsonData = new JSONObject();
            JSONArray propertiesArray = new JSONArray();
            
            // Add current date and user metadata
            String currentDate = "2025-05-02 20:43:43";
            jsonData.put("currentDate", currentDate);
            jsonData.put("currentUser", "IT24103866");
            
            // Add all properties to the array
            for (PropertyData property : properties) {
                propertiesArray.put(property.toJson());
            }
            
            // Add properties array to main JSON object
            jsonData.put("properties", propertiesArray);
            
            // Make sure directory exists
            File file = new File(filePath);
            file.getParentFile().mkdirs();
            
            // Write directly to file
            try (FileWriter writer = new FileWriter(file)) {
                writer.write(jsonData.toString(2)); // Pretty print with 2-space indentation
            }
        } catch (Exception e) {
            System.out.println("Error saving properties to JSON: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    public void initializePropertyStore(String filePath) {
        File file = new File(filePath);
        if (!file.exists() || file.length() == 0) {
            try {
                // Create sample properties
                PropertyData property1 = new PropertyData();
                property1.setId(12345);
                property1.setTitle("Modern 3-Bedroom House with Garden");
                property1.setPrice(450000);
                property1.setCurrency("USD");
                property1.setStatus("Available");
                property1.setLocation("123 Main Street, Cityville, State");
                property1.setBeds(3);
                property1.setBaths(2);
                property1.setArea(2100);
                property1.setAreaUnit("sqft");
                property1.setPropertyType("House");
                property1.setDescription("A beautiful modern house with open floor plan, renovated kitchen, and spacious backyard.");
                property1.setAgentId("AG12345678");
                property1.setAgentName("John Doe");
                property1.setFeatured(true);
                
                List<String> amenities1 = new ArrayList<>();
                amenities1.add("Air Conditioning");
                amenities1.add("Garage");
                amenities1.add("Swimming Pool");
                amenities1.add("Garden");
                property1.setAmenities(amenities1);
                
                List<String> images1 = new ArrayList<>();
                images1.add("house1_main.jpg");
                images1.add("house1_living.jpg");
                images1.add("house1_kitchen.jpg");
                property1.setImages(images1);
                
                PropertyData property2 = new PropertyData();
                property2.setId(12346);
                property2.setTitle("Luxury Downtown Apartment");
                property2.setPrice(2500);
                property2.setCurrency("USD");
                property2.setPriceInterval("monthly");
                property2.setStatus("Available");
                property2.setLocation("456 Park Avenue, Downtown, State");
                property2.setBeds(2);
                property2.setBaths(2);
                property2.setArea(1200);
                property2.setAreaUnit("sqft");
                property2.setPropertyType("Apartment");
                property2.setDescription("High-end apartment with panoramic city views, modern appliances, and 24-hour security.");
                property2.setAgentId("AG23456789");
                property2.setAgentName("Jane Smith");
                property2.setFeatured(true);
                
                List<String> amenities2 = new ArrayList<>();
                amenities2.add("Elevator");
                amenities2.add("Gym");
                amenities2.add("Doorman");
                amenities2.add("Balcony");
                property2.setAmenities(amenities2);
                
                List<String> images2 = new ArrayList<>();
                images2.add("apartment1_main.jpg");
                images2.add("apartment1_living.jpg");
                images2.add("apartment1_view.jpg");
                property2.setImages(images2);
                
                PropertyData property3 = new PropertyData();
                property3.setId(12347);
                property3.setTitle("Commercial Office Space");
                property3.setPrice(850000);
                property3.setCurrency("USD");
                property3.setStatus("Available");
                property3.setLocation("789 Business Center, Commerce District, State");
                property3.setArea(3500);
                property3.setAreaUnit("sqft");
                property3.setPropertyType("Commercial");
                property3.setDescription("Prime commercial space in the heart of the business district, with modern facilities and parking.");
                property3.setAgentId("AG23456789");
                property3.setAgentName("Jane Smith");
                
                List<String> amenities3 = new ArrayList<>();
                amenities3.add("Parking");
                amenities3.add("Security System");
                amenities3.add("Conference Room");
                amenities3.add("Kitchenette");
                property3.setAmenities(amenities3);
                
                List<String> images3 = new ArrayList<>();
                images3.add("commercial1_main.jpg");
                images3.add("commercial1_interior.jpg");
                images3.add("commercial1_office.jpg");
                property3.setImages(images3);
                
                // Create a list of properties
                List<PropertyData> properties = new ArrayList<>();
                properties.add(property1);
                properties.add(property2);
                properties.add(property3);
                
                // Save to file
                saveAllProperties(properties, filePath);
                System.out.println("Property store initialized successfully with sample data");
            } catch (Exception e) {
                System.out.println("Error initializing property store: " + e.getMessage());
                e.printStackTrace();
            }
        } else {
            try {
                // Verify if the file contains valid JSON
                List<PropertyData> properties = getAllProperties(filePath);
                if (properties.isEmpty()) {
                    // If the file exists but contains invalid JSON, recreate it
                    file.delete();
                    initializePropertyStore(filePath);
                }
            } catch (Exception e) {
                System.out.println("Error validating property store: " + e.getMessage());
                e.printStackTrace();
                // Recreate the file if validation fails
                try {
                    file.delete();
                    initializePropertyStore(filePath);
                } catch (Exception ex) {
                    System.out.println("Failed to recreate property store: " + ex.getMessage());
                }
            }
        }
    }
%>

<%
    // Check if user is logged in as admin
    String username = (String) session.getAttribute("username");
    String fullName = (String) session.getAttribute("fullName");
    String userRole = (String) session.getAttribute("userRole");
    
    if (username == null || !"admin".equalsIgnoreCase(userRole)) {
        // For testing, override this
        username = "admin";
        fullName = "Administrator";
        userRole = "admin";
        //response.sendRedirect("login.jsp");
        //return;
    }
    
    // Path to property data file
    String dataDir = "C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\data";
    String propertyFile = dataDir + File.separator + "propertiesManagement.json";
    
    // Initialize property store if needed
    try {
        initializePropertyStore(propertyFile);
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    // Process property actions
    String action = request.getParameter("action");
    String propertyIdStr = request.getParameter("propertyid");
    String message = "";
    boolean success = false;
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        if ("add".equals(action)) {
            // Add new property
            try {
                String newTitle = request.getParameter("newTitle");
                int newPrice = Integer.parseInt(request.getParameter("newPrice"));
                String newCurrency = request.getParameter("newCurrency");
                String newPriceInterval = request.getParameter("newPriceInterval");
                String newStatus = request.getParameter("newStatus");
                String newLocation = request.getParameter("newLocation");
                String newPropertyType = request.getParameter("newPropertyType");
                String newDescription = request.getParameter("newDescription");
                
                int newBeds = 0;
                try { newBeds = Integer.parseInt(request.getParameter("newBeds")); } catch (Exception e) {}
                
                int newBaths = 0;
                try { newBaths = Integer.parseInt(request.getParameter("newBaths")); } catch (Exception e) {}
                
                int newArea = 0;
                try { newArea = Integer.parseInt(request.getParameter("newArea")); } catch (Exception e) {}
                
                String newAreaUnit = request.getParameter("newAreaUnit");
                String newAgentId = request.getParameter("newAgentId");
                String newAgentName = request.getParameter("newAgentName");
                boolean newFeatured = "on".equals(request.getParameter("newFeatured"));
                
                // Handle amenities (comma-separated string)
                List<String> newAmenities = new ArrayList<>();
                String newAmenitiesStr = request.getParameter("newAmenities");
                if (newAmenitiesStr != null && !newAmenitiesStr.trim().isEmpty()) {
                    String[] amenityArray = newAmenitiesStr.split(",");
                    for (String amenity : amenityArray) {
                        newAmenities.add(amenity.trim());
                    }
                }
                
                // Handle images (comma-separated string)
                List<String> newImages = new ArrayList<>();
                String newImagesStr = request.getParameter("newImages");
                if (newImagesStr != null && !newImagesStr.trim().isEmpty()) {
                    String[] imageArray = newImagesStr.split(",");
                    for (String image : imageArray) {
                        newImages.add(image.trim());
                    }
                }
                
                // Create new property
                PropertyData newProperty = new PropertyData();
                newProperty.setTitle(newTitle);
                newProperty.setPrice(newPrice);
                newProperty.setCurrency(newCurrency);
                newProperty.setPriceInterval(newPriceInterval);
                newProperty.setStatus(newStatus);
                newProperty.setLocation(newLocation);
                newProperty.setBeds(newBeds);
                newProperty.setBaths(newBaths);
                newProperty.setArea(newArea);
                newProperty.setAreaUnit(newAreaUnit);
                newProperty.setPropertyType(newPropertyType);
                newProperty.setDescription(newDescription);
                newProperty.setAgentId(newAgentId);
                newProperty.setAgentName(newAgentName);
                newProperty.setAmenities(newAmenities);
                newProperty.setImages(newImages);
                newProperty.setFeatured(newFeatured);
                
                addProperty(newProperty, propertyFile);
                success = true;
                message = "Property added successfully!";
            } catch (Exception e) {
                message = "Error adding property: " + e.getMessage();
                e.printStackTrace();
            }
        } else if ("update".equals(action)) {
            // Update property
            try {
                int editPropertyId = Integer.parseInt(request.getParameter("editPropertyId"));
                String editTitle = request.getParameter("editTitle");
                int editPrice = Integer.parseInt(request.getParameter("editPrice"));
                String editCurrency = request.getParameter("editCurrency");
                String editPriceInterval = request.getParameter("editPriceInterval");
                String editStatus = request.getParameter("editStatus");
                String editLocation = request.getParameter("editLocation");
                String editPropertyType = request.getParameter("editPropertyType");
                String editDescription = request.getParameter("editDescription");
                
                int editBeds = 0;
                try { editBeds = Integer.parseInt(request.getParameter("editBeds")); } catch (Exception e) {}
                
                int editBaths = 0;
                try { editBaths = Integer.parseInt(request.getParameter("editBaths")); } catch (Exception e) {}
                
                int editArea = 0;
                try { editArea = Integer.parseInt(request.getParameter("editArea")); } catch (Exception e) {}
                
                String editAreaUnit = request.getParameter("editAreaUnit");
                String editAgentId = request.getParameter("editAgentId");
                String editAgentName = request.getParameter("editAgentName");
                boolean editFeatured = "on".equals(request.getParameter("editFeatured"));
                
                // Handle amenities (comma-separated string)
                List<String> editAmenities = new ArrayList<>();
                String editAmenitiesStr = request.getParameter("editAmenities");
                if (editAmenitiesStr != null && !editAmenitiesStr.trim().isEmpty()) {
                    String[] amenityArray = editAmenitiesStr.split(",");
                    for (String amenity : amenityArray) {
                        editAmenities.add(amenity.trim());
                    }
                }
                
                // Handle images (comma-separated string)
                List<String> editImages = new ArrayList<>();
                String editImagesStr = request.getParameter("editImages");
                if (editImagesStr != null && !editImagesStr.trim().isEmpty()) {
                    String[] imageArray = editImagesStr.split(",");
                    for (String image : imageArray) {
                        editImages.add(image.trim());
                    }
                }
                
                PropertyData property = getPropertyById(editPropertyId, propertyFile);
                if (property != null) {
                    property.setTitle(editTitle);
                    property.setPrice(editPrice);
                    property.setCurrency(editCurrency);
                    property.setPriceInterval(editPriceInterval);
                    property.setStatus(editStatus);
                    property.setLocation(editLocation);
                    property.setBeds(editBeds);
                    property.setBaths(editBaths);
                    property.setArea(editArea);
                    property.setAreaUnit(editAreaUnit);
                    property.setPropertyType(editPropertyType);
                    property.setDescription(editDescription);
                    property.setAgentId(editAgentId);
                    property.setAgentName(editAgentName);
                    property.setAmenities(editAmenities);
                    property.setImages(editImages);
                    property.setFeatured(editFeatured);
                    
                    updateProperty(property, propertyFile);
                    success = true;
                    message = "Property updated successfully!";
                } else {
                    message = "Property not found.";
                    success = false;
                }
            } catch (Exception e) {
                message = "Error updating property: " + e.getMessage();
                e.printStackTrace();
                success = false;
            }
        }
    } else if (action != null && propertyIdStr != null) {
        try {
            int propertyId = Integer.parseInt(propertyIdStr);
            
            if ("delete".equals(action)) {
                // Delete property
                deleteProperty(propertyId, propertyFile);
                success = true;
                message = "Property deleted successfully.";
            } else if ("feature".equals(action)) {
                // Feature property
                PropertyData property = getPropertyById(propertyId, propertyFile);
                if (property != null) {
                    property.setFeatured(true);
                    updateProperty(property, propertyFile);
                    success = true;
                    message = "Property is now featured.";
                } else {
                    message = "Property not found.";
                    success = false;
                }
            } else if ("unfeature".equals(action)) {
                // Unfeature property
                PropertyData property = getPropertyById(propertyId, propertyFile);
                if (property != null) {
                    property.setFeatured(false);
                    updateProperty(property, propertyFile);
                    success = true;
                    message = "Property is no longer featured.";
                } else {
                    message = "Property not found.";
                    success = false;
                }
            } else if ("sold".equals(action) || "available".equals(action) || "pending".equals(action) || "rented".equals(action)) {
                // Update property status
                PropertyData property = getPropertyById(propertyId, propertyFile);
                if (property != null) {
                    if ("sold".equals(action)) {
                        property.setStatus("Sold");
                    } else if ("available".equals(action)) {
                        property.setStatus("Available");
                    } else if ("pending".equals(action)) {
                        property.setStatus("Pending");
                    } else if ("rented".equals(action)) {
                        property.setStatus("Rented");
                    }
                    
                    updateProperty(property, propertyFile);
                    success = true;
                    message = "Property status updated to " + property.getStatus() + ".";
                } else {
                    message = "Property not found.";
                    success = false;
                }
            }
        } catch (NumberFormatException e) {
            message = "Invalid property ID.";
            success = false;
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
            e.printStackTrace();
            success = false;
        }
    }
    
    // Get all properties for display
    List<PropertyData> properties = new ArrayList<>();
    try {
        properties = getAllProperties(propertyFile);
    } catch (Exception e) {
        message = "Error loading properties: " + e.getMessage();
        e.printStackTrace();
    }
    
    // Sort properties by status and featured flag
    Collections.sort(properties, new Comparator<PropertyData>() {
        @Override
        public int compare(PropertyData p1, PropertyData p2) {
            // First sort by featured status
            if (p1.isFeatured() && !p2.isFeatured()) {
                return -1;
            } else if (!p1.isFeatured() && p2.isFeatured()) {
                return 1;
            }
            
            // Then by status priority: Available > Pending > Rented > Sold
            int statusPriority1 = getStatusPriority(p1.getStatus());
            int statusPriority2 = getStatusPriority(p2.getStatus());
            
            if (statusPriority1 != statusPriority2) {
                return statusPriority1 - statusPriority2;
            }
            
            // Finally by price (highest first)
            return Integer.compare(p2.getPrice(), p1.getPrice());
        }
        
        private int getStatusPriority(String status) {
            switch (status.toLowerCase()) {
                case "available": return 1;
                case "pending": return 2;
                case "rented": return 3;
                case "sold": return 4;
                default: return 5;
            }
        }
    });
    
    // Count properties by type and status
    int houseCount = 0;
    int apartmentCount = 0;
    int commercialCount = 0;
    int landCount = 0;
    
    int availableCount = 0;
    int soldCount = 0;
    int pendingCount = 0;
    int rentedCount = 0;
    
    int featuredCount = 0;
    
    for (PropertyData property : properties) {
        String type = property.getPropertyType().toLowerCase();
        if ("house".equals(type)) {
            houseCount++;
        } else if ("apartment".equals(type)) {
            apartmentCount++;
        } else if ("commercial".equals(type)) {
            commercialCount++;
        } else if ("land".equals(type)) {
            landCount++;
        }
        
        String status = property.getStatus().toLowerCase();
        if ("available".equals(status)) {
            availableCount++;
        } else if ("sold".equals(status)) {
            soldCount++;
        } else if ("pending".equals(status)) {
            pendingCount++;
        } else if ("rented".equals(status)) {
            rentedCount++;
        }
        
        if (property.isFeatured()) {
            featuredCount++;
        }
    }
    
    // Current date and time for display
    String currentDateTime = "2025-05-02 20:43:43";
    String currentUserLogin = "IT24103866";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Property Management | Admin Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css">
    <style>
        :root {
            --dark-blue: #081c45;
            --medium-blue: #0e307e;
            --light-blue: #2a4494;
            --highlight-blue: #4568dc;
            --house-color: #3a86ff;
            --apartment-color: #ff006e;
            --commercial-color: #9d4edd;
            --land-color: #38b000;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
        }
        
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: 280px;
            background: linear-gradient(to bottom, #000c24, #001a4d);
            color: white;
            padding-top: 20px;
            transition: all 0.3s;
            z-index: 1000;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
        }
        
        .sidebar-header {
            padding: 20px 25px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        
        .sidebar-header .logo {
            font-size: 1.8rem;
            font-weight: bold;
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
        }
        
        .admin-badge {
            font-size: 0.7rem;
            background-color: white;
            color: var(--dark-blue);
            padding: 2px 8px;
            border-radius: 10px;
            margin-left: 10px;
        }
        
        .nav-item {
            margin-bottom: 5px;
        }
        
        .nav-link {
            padding: 12px 25px;
            color: rgba(255,255,255,0.8);
            font-weight: 500;
            border-radius: 0;
            display: flex;
            align-items: center;
            transition: all 0.3s;
        }
        
        .nav-link:hover, .nav-link.active {
            background-color: rgba(255,255,255,0.1);
            color: white;
        }
        
        .nav-link i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        
        .content {
            margin-left: 280px;
            padding: 20px;
            transition: all 0.3s;
        }
        
        .toggle-sidebar {
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1001;
            display: none;
        }
        
        .sidebar-bottom {
            position: absolute;
            bottom: 0;
            width: 100%;
            padding: 20px 25px;
            border-top: 1px solid rgba(255,255,255,0.1);
        }
        
        .user-menu {
            display: flex;
            align-items: center;
            color: white;
            text-decoration: none;
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #3a86ff;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            margin-right: 10px;
        }
        
        .dropdown-toggle::after {
            display: none;
        }
        
        .card {
            border: none;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            border-radius: 10px;
            margin-bottom: 20px;
        }
        
        .card-header {
            background-color: white;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            padding: 15px 20px;
        }
        
        .property-type-badge {
            font-size: 0.75rem;
            padding: 0.25rem 0.5rem;
            border-radius: 10px;
        }
        
        .badge-house {
            background-color: var(--house-color);
            color: white;
        }
        
        .badge-apartment {
            background-color: var(--apartment-color);
            color: white;
        }
        
        .badge-commercial {
            background-color: var(--commercial-color);
            color: white;
        }
        
        .badge-land {
            background-color: var(--land-color);
            color: white;
        }
        
        .status-badge {
            font-size: 0.75rem;
            padding: 0.25rem 0.5rem;
            border-radius: 10px;
        }
        
        .status-available {
            background-color: #38b000;
            color: white;
        }
        
        .status-sold {
            background-color: #d90429;
            color: white;
        }
        
        .status-pending {
            background-color: #ffbe0b;
            color: black;
        }
        
        .status-rented {
            background-color: #3a86ff;
            color: white;
        }
        
        .action-btn {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }
        
        .property-table th {
            font-weight: 600;
        }
        
        .search-container {
            position: relative;
            max-width: 300px;
        }
        
        .search-container .form-control {
            padding-left: 38px;
        }
        
        .search-icon {
            position: absolute;
            top: 50%;
            left: 13px;
            transform: translateY(-50%);
            color: #6c757d;
        }
        
        .featured-badge {
            background-color: #ffbe0b;
            color: #212529;
            font-size: 0.7rem;
            padding: 0.15rem 0.5rem;
            border-radius: 10px;
            margin-left: 5px;
            vertical-align: middle;
        }
        
        .stats-card {
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.1) 0%, rgba(255, 255, 255, 0.05) 100%);
            border-radius: 16px;
            overflow: hidden;
            padding: 15px;
            position: relative;
            transition: all 0.3s ease;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            color: white;
            height: 100%;
        }
        
        .stats-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.25);
        }
        
        .stats-card.house-card {
            background: linear-gradient(135deg, var(--house-color) 0%, #1b4cd1 100%);
        }
        
        .stats-card.apartment-card {
            background: linear-gradient(135deg, var(--apartment-color) 0%, #c30052 100%);
        }
        
        .stats-card.commercial-card {
            background: linear-gradient(135deg, var(--commercial-color) 0%, #6b21a8 100%);
        }
        
        .stats-card.land-card {
            background: linear-gradient(135deg, var(--land-color) 0%, #246800 100%);
        }
        
        .stats-card.available-card {
            background: linear-gradient(135deg, #38b000 0%, #246800 100%);
        }
        
        .stats-card.sold-card {
            background: linear-gradient(135deg, #d90429 0%, #8c031b 100%);
        }
        
        .stats-card.pending-card {
            background: linear-gradient(135deg, #ffbe0b 0%, #e89b00 100%);
            color: #212529;
        }
        
        .stats-card.rented-card {
            background: linear-gradient(135deg, #3a86ff 0%, #1b4cd1 100%);
        }
        
        .stats-card .icon {
            position: absolute;
            top: 20px;
            right: 20px;
            font-size: 48px;
            opacity: 0.15;
        }
        
        .stats-card .stats-number {
            font-size: 2.5rem;
            font-weight: 700;
        }
        
        .stats-card .stats-title {
            font-size: 1.1rem;
            margin-bottom: 0;
        }
        
        .property-card {
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            border-radius: 10px;
            overflow: hidden;
            height: 100%;
        }
        
        .property-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }
        
        .property-image-container {
            height: 180px;
            overflow: hidden;
            position: relative;
        }
        
        .property-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .property-price {
            position: absolute;
            bottom: 0;
            right: 0;
            background-color: rgba(8, 28, 69, 0.9);
            color: white;
            padding: 5px 15px;
            border-top-left-radius: 10px;
        }
        
        .property-amenities {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 15px;
        }
        
        .amenity-tag {
            background-color: rgba(13, 38, 76, 0.08);
            padding: 3px 8px;
            border-radius: 5px;
            font-size: 0.75rem;
            color: var(--medium-blue);
        }
        
        .truncate-text {
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-280px);
            }
            
            .content {
                margin-left: 0;
            }
            
            .sidebar.show {
                transform: translateX(0);
            }
            
            .toggle-sidebar {
                display: block;
            }
            
            .content.pushed {
                margin-left: 280px;
            }
        }
    </style>
</head>
<body>
    <button class="btn btn-light toggle-sidebar" id="toggleSidebar">
        <i class="fas fa-bars"></i>
    </button>
    
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <a href="admin-dashboard.jsp" class="logo">
                <i class="fas fa-building me-2"></i> PropertyFinder <span class="admin-badge">ADMIN</span>
            </a>
        </div>
        
        <ul class="nav flex-column mt-4">
            <li class="nav-item">
                <a class="nav-link" href="adminDasboardChart.jsp">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="adminDashboard.jsp">
                    <i class="fas fa-users"></i> User Management
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="agentManagement.jsp">
                    <i class="fas fa-user-tie"></i> Agent Management
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="propertyManagement.jsp">
                    <i class="fas fa-home"></i> Properties
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="adminAnalytics.jsp">
                    <i class="fas fa-chart-bar"></i> Analytics
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="adminSetting.jsp">
                    <i class="fas fa-cog"></i> Settings
                </a>
            </li>
        </ul>
        
        <div class="sidebar-bottom">
            <div class="dropdown">
                <a href="#" class="user-menu dropdown-toggle" data-bs-toggle="dropdown">
                    <div class="user-avatar">
                        <i class="fas fa-user-shield"></i>
                    </div>
                    <div>
                        <div class="fw-bold"><%= fullName %></div>
                        <small class="text-white-50"><%= username %></small>
                    </div>
                </a>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="#"><i class="fas fa-user me-2"></i>My Profile</a></li>
                    <li><a class="dropdown-item" href="adminSetting.jsp"><i class="fas fa-cog me-2"></i>Account Settings</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item text-danger" href="adminLogout.jsp"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                </ul>
            </div>
        </div>
    </div>
    
    <!-- Content -->
    <div class="content">
        <div class="container-fluid">
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>Property Management</h2>
                <div>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addPropertyModal">
                        <i class="fas fa-plus me-2"></i> Add New Property
                    </button>
                </div>
            </div>
            
            <!-- Status Messages -->
            <% if (!message.isEmpty()) { %>
                <div class="alert alert-<%= success ? "success" : "danger" %> alert-dismissible fade show" role="alert">
                    <i class="fas fa-<%= success ? "check" : "exclamation" %>-circle me-2"></i> <%= message %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>
            
            <!-- Stats Cards - Property Types -->
            <div class="row mb-4">
                <div class="col-md-3 mb-3">
                    <div class="stats-card house-card">
                        <div class="icon">
                            <i class="fas fa-home"></i>
                        </div>
                        <h2 class="stats-number"><%= houseCount %></h2>
                        <p class="stats-title">Houses</p>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="stats-card apartment-card">
                        <div class="icon">
                            <i class="fas fa-building"></i>
                        </div>
                        <h2 class="stats-number"><%= apartmentCount %></h2>
                        <p class="stats-title">Apartments</p>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="stats-card commercial-card">
                        <div class="icon">
                            <i class="fas fa-store"></i>
                        </div>
                        <h2 class="stats-number"><%= commercialCount %></h2>
                        <p class="stats-title">Commercial</p>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="stats-card land-card">
                        <div class="icon">
                            <i class="fas fa-mountain"></i>
                        </div>
                        <h2 class="stats-number"><%= landCount %></h2>
                        <p class="stats-title">Land</p>
                    </div>
                </div>
            </div>
            
            <!-- Stats Cards - Property Status -->
            <div class="row mb-4">
                <div class="col-md-3 mb-3">
                    <div class="stats-card available-card">
                        <div class="icon">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <h2 class="stats-number"><%= availableCount %></h2>
                        <p class="stats-title">Available</p>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="stats-card pending-card">
                        <div class="icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <h2 class="stats-number"><%= pendingCount %></h2>
                        <p class="stats-title">Pending</p>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="stats-card sold-card">
                        <div class="icon">
                            <i class="fas fa-handshake"></i>
                        </div>
                        <h2 class="stats-number"><%= soldCount %></h2>
                        <p class="stats-title">Sold</p>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="stats-card rented-card">
                        <div class="icon">
                            <i class="fas fa-key"></i>
                        </div>
                        <h2 class="stats-number"><%= rentedCount %></h2>
                        <p class="stats-title">Rented</p>
                    </div>
                </div>
            </div>
            
            <!-- Featured Properties -->
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Featured Properties (<%= featuredCount %>)</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <% 
                            int featuredShown = 0;
                            for (PropertyData property : properties) {
                                if (property.isFeatured() && featuredShown < 3) {
                                    featuredShown++;
                                    String typeBadgeClass = "";
                                    
                                    if ("House".equalsIgnoreCase(property.getPropertyType())) {
                                        typeBadgeClass = "badge-house";
                                    } else if ("Apartment".equalsIgnoreCase(property.getPropertyType())) {
                                        typeBadgeClass = "badge-apartment";
                                    } else if ("Commercial".equalsIgnoreCase(property.getPropertyType())) {
                                        typeBadgeClass = "badge-commercial";
                                    } else if ("Land".equalsIgnoreCase(property.getPropertyType())) {
                                        typeBadgeClass = "badge-land";
                                    }
                                    
                                    String statusClass = "";
                                    if ("Available".equalsIgnoreCase(property.getStatus())) {
                                        statusClass = "status-available";
                                    } else if ("Sold".equalsIgnoreCase(property.getStatus())) {
                                        statusClass = "status-sold";
                                    } else if ("Pending".equalsIgnoreCase(property.getStatus())) {
                                        statusClass = "status-pending";
                                    } else if ("Rented".equalsIgnoreCase(property.getStatus())) {
                                        statusClass = "status-rented";
                                    }
                        %>
                        <div class="col-md-4 mb-3">
                            <div class="property-card">
                                <div class="property-image-container">
                                    <% if (property.getImages().isEmpty()) { %>
                                        <img src="https://via.placeholder.com/400x300?text=No+Image" class="property-image" alt="Property Image">
                                    <% } else { %>
                                        <img src="images/<%= property.getImages().get(0) %>" class="property-image" alt="Property Image" onerror="this.onerror=null; this.src='https://via.placeholder.com/400x300?text=Image+Error'">
                                    <% } %>
                                    <div class="property-price">
                                        <%= property.getCurrency() %> <%= String.format("%,d", property.getPrice()) %>
                                        <% if (property.getPriceInterval() != null && !property.getPriceInterval().isEmpty()) { %>
                                            /<%= property.getPriceInterval() %>
                                        <% } %>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <span class="property-type-badge <%= typeBadgeClass %>"><%= property.getPropertyType() %></span>
                                        <span class="status-badge <%= statusClass %>"><%= property.getStatus() %></span>
                                    </div>
                                    <h5 class="card-title truncate-text"><%= property.getTitle() %></h5>
                                    <p class="card-text text-muted small mb-2"><i class="fas fa-map-marker-alt me-1"></i><%= property.getLocation() %></p>
                                    
                                    <div class="d-flex justify-content-between mb-3">
                                        <% if (property.getBeds() > 0) { %>
                                            <div><small><i class="fas fa-bed me-1"></i><%= property.getBeds() %> Beds</small></div>
                                        <% } %>
                                        <% if (property.getBaths() > 0) { %>
                                            <div><small><i class="fas fa-bath me-1"></i><%= property.getBaths() %> Baths</small></div>
                                        <% } %>
                                        <% if (property.getArea() > 0) { %>
                                            <div><small><i class="fas fa-vector-square me-1"></i><%= property.getArea() %> <%= property.getAreaUnit() %></small></div>
                                        <% } %>
                                    </div>
                                    
                                    <% if (!property.getAmenities().isEmpty() && property.getAmenities().size() <= 3) { %>
                                        <div class="property-amenities">
                                            <% for (String amenity : property.getAmenities()) { %>
                                                <span class="amenity-tag"><%= amenity %></span>
                                            <% } %>
                                        </div>
                                    <% } %>
                                    
                                    <div class="d-flex mt-3">
                                        <button class="btn btn-sm btn-outline-primary me-2" onclick="viewProperty(<%= property.getId() %>,'<%= property.getTitle().replace("'", "\\'") %>','<%= property.getLocation().replace("'", "\\'") %>',<%= property.getPrice() %>,'<%= property.getCurrency() %>','<%= property.getPriceInterval() %>','<%= property.getStatus() %>',<%= property.getBeds() %>,<%= property.getBaths() %>,<%= property.getArea() %>,'<%= property.getAreaUnit() %>','<%= property.getPropertyType() %>','<%= property.getDescription().replace("'", "\\'") %>','<%= property.getAgentName().replace("'", "\\'") %>','<%= property.getListedDate() %>',<%= property.isFeatured() %>,'<%= String.join(",", property.getAmenities()).replace("'", "\\'") %>','<%= String.join(",", property.getImages()).replace("'", "\\'") %>')">
                                            <i class="fas fa-eye"></i> View
                                        </button>
                                        <button class="btn btn-sm btn-outline-secondary me-2" onclick="editProperty(<%= property.getId() %>,'<%= property.getTitle().replace("'", "\\'") %>','<%= property.getLocation().replace("'", "\\'") %>',<%= property.getPrice() %>,'<%= property.getCurrency() %>','<%= property.getPriceInterval() %>','<%= property.getStatus() %>',<%= property.getBeds() %>,<%= property.getBaths() %>,<%= property.getArea() %>,'<%= property.getAreaUnit() %>','<%= property.getPropertyType() %>','<%= property.getDescription().replace("'", "\\'") %>','<%= property.getAgentId() %>','<%= property.getAgentName().replace("'", "\\'") %>',<%= property.isFeatured() %>,'<%= String.join(",", property.getAmenities()).replace("'", "\\'") %>','<%= String.join(",", property.getImages()).replace("'", "\\'") %>')">
                                            <i class="fas fa-edit"></i> Edit
                                        </button>
                                        <div class="dropdown">
                                            <button class="btn btn-sm btn-outline-dark dropdown-toggle" type="button" id="propertyActionsDropdown<%= property.getId() %>" data-bs-toggle="dropdown" aria-expanded="false">
                                                <i class="fas fa-ellipsis-v"></i>
                                            </button>
                                            <ul class="dropdown-menu" aria-labelledby="propertyActionsDropdown<%= property.getId() %>">
                                                <% if (property.isFeatured()) { %>
                                                    <li><a class="dropdown-item" href="propertyManagement.jsp?action=unfeature&propertyid=<%= property.getId() %>"><i class="far fa-star me-2"></i>Unfeature</a></li>
                                                <% } else { %>
                                                    <li><a class="dropdown-item" href="propertyManagement.jsp?action=feature&propertyid=<%= property.getId() %>"><i class="fas fa-star me-2"></i>Feature</a></li>
                                                <% } %>
                                                <li><hr class="dropdown-divider"></li>
                                                <li><a class="dropdown-item text-danger" href="propertyManagement.jsp?action=delete&propertyid=<%= property.getId() %>" onclick="return confirm('Are you sure you want to delete this property?')"><i class="fas fa-trash me-2"></i>Delete</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% 
                                }
                            }
                            
                            // If no featured properties, show message
                            if (featuredShown == 0) {
                        %>
                            <div class="col-12">
                                <div class="alert alert-info">
                                    No featured properties yet. Mark properties as featured to showcase them here.
                                </div>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
            
            <!-- All Properties Table -->
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">All Properties</h5>
                    <div class="search-container">
                        <i class="fas fa-search search-icon"></i>
                        <input type="text" id="propertySearchInput" class="form-control" placeholder="Search properties...">
                    </div>
                </div>
                                <div class="card-body">
                    <div class="table-responsive">
                        <table id="propertyTable" class="table table-striped table-hover property-table align-middle">
                            <thead>
                                <tr>
                                    <th>Property</th>
                                    <th>Type</th>
                                    <th>Price</th>
                                    <th>Location</th>
                                    <th>Details</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (properties.isEmpty()) { %>
                                    <tr>
                                        <td colspan="7" class="text-center">No properties found.</td>
                                    </tr>
                                <% } else { %>
                                    <% for (PropertyData property : properties) { 
                                        String typeBadgeClass = "";
                                        if ("House".equalsIgnoreCase(property.getPropertyType())) {
                                            typeBadgeClass = "badge-house";
                                        } else if ("Apartment".equalsIgnoreCase(property.getPropertyType())) {
                                            typeBadgeClass = "badge-apartment";
                                        } else if ("Commercial".equalsIgnoreCase(property.getPropertyType())) {
                                            typeBadgeClass = "badge-commercial";
                                        } else if ("Land".equalsIgnoreCase(property.getPropertyType())) {
                                            typeBadgeClass = "badge-land";
                                        }
                                        
                                        String statusClass = "";
                                        if ("Available".equalsIgnoreCase(property.getStatus())) {
                                            statusClass = "status-available";
                                        } else if ("Sold".equalsIgnoreCase(property.getStatus())) {
                                            statusClass = "status-sold";
                                        } else if ("Pending".equalsIgnoreCase(property.getStatus())) {
                                            statusClass = "status-pending";
                                        } else if ("Rented".equalsIgnoreCase(property.getStatus())) {
                                            statusClass = "status-rented";
                                        }
                                    %>
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="flex-shrink-0 me-3" style="width: 60px; height: 60px; overflow: hidden; border-radius: 4px;">
                                                    <% if (property.getImages().isEmpty()) { %>
                                                        <img src="https://via.placeholder.com/60x60?text=No+Image" width="60" height="60" alt="Property Image">
                                                    <% } else { %>
                                                        <img src="images/<%= property.getImages().get(0) %>" width="60" height="60" alt="Property Image" style="object-fit: cover;" onerror="this.onerror=null; this.src='https://via.placeholder.com/60x60?text=Error'">
                                                    <% } %>
                                                </div>
                                                <div>
                                                    <div class="fw-bold">
                                                        <%= property.getTitle() %>
                                                        <% if (property.isFeatured()) { %>
                                                            <span class="featured-badge"><i class="fas fa-star"></i></span>
                                                        <% } %>
                                                    </div>
                                                    <div class="small text-muted">ID: <%= property.getId() %></div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="property-type-badge <%= typeBadgeClass %>"><%= property.getPropertyType() %></span>
                                        </td>
                                        <td>
                                            <%= property.getCurrency() %> <%= String.format("%,d", property.getPrice()) %>
                                            <% if (property.getPriceInterval() != null && !property.getPriceInterval().isEmpty()) { %>
                                                <div class="small text-muted">per <%= property.getPriceInterval() %></div>
                                            <% } %>
                                        </td>
                                        <td>
                                            <div class="small"><i class="fas fa-map-marker-alt me-1 text-muted"></i> <%= property.getLocation() %></div>
                                        </td>
                                        <td>
                                            <div class="d-flex gap-3">
                                                <% if (property.getBeds() > 0) { %>
                                                    <div><small><i class="fas fa-bed me-1 text-muted"></i><%= property.getBeds() %></small></div>
                                                <% } %>
                                                <% if (property.getBaths() > 0) { %>
                                                    <div><small><i class="fas fa-bath me-1 text-muted"></i><%= property.getBaths() %></small></div>
                                                <% } %>
                                                <% if (property.getArea() > 0) { %>
                                                    <div><small><i class="fas fa-vector-square me-1 text-muted"></i><%= property.getArea() %> <%= property.getAreaUnit() %></small></div>
                                                <% } %>
                                            </div>
                                            <% if (!property.getAmenities().isEmpty() && property.getAmenities().size() <= 2) { %>
                                                <div class="small text-muted mt-1">
                                                    <i class="fas fa-check-circle me-1"></i><%= String.join(", ", property.getAmenities().subList(0, Math.min(2, property.getAmenities().size()))) %>
                                                    <% if (property.getAmenities().size() > 2) { %>
                                                        ...
                                                    <% } %>
                                                </div>
                                            <% } %>
                                        </td>
                                        <td>
                                            <span class="status-badge <%= statusClass %>"><%= property.getStatus() %></span>
                                            <% if (property.getAgentName() != null && !property.getAgentName().isEmpty()) { %>
                                                <div class="small text-muted mt-1"><i class="fas fa-user-tie me-1"></i><%= property.getAgentName() %></div>
                                            <% } %>
                                        </td>
                                        <td>
                                            <div class="btn-group">
                                                <button class="btn btn-sm btn-outline-primary action-btn" 
                                                        onclick="viewProperty(<%= property.getId() %>,'<%= property.getTitle().replace("'", "\\'") %>','<%= property.getLocation().replace("'", "\\'") %>',<%= property.getPrice() %>,'<%= property.getCurrency() %>','<%= property.getPriceInterval() %>','<%= property.getStatus() %>',<%= property.getBeds() %>,<%= property.getBaths() %>,<%= property.getArea() %>,'<%= property.getAreaUnit() %>','<%= property.getPropertyType() %>','<%= property.getDescription().replace("'", "\\'") %>','<%= property.getAgentName().replace("'", "\\'") %>','<%= property.getListedDate() %>',<%= property.isFeatured() %>,'<%= String.join(",", property.getAmenities()).replace("'", "\\'") %>','<%= String.join(",", property.getImages()).replace("'", "\\'") %>')">
                                                    <i class="fas fa-eye" title="View Property"></i>
                                                </button>
                                                
                                                <button class="btn btn-sm btn-outline-secondary action-btn" 
                                                        onclick="editProperty(<%= property.getId() %>,'<%= property.getTitle().replace("'", "\\'") %>','<%= property.getLocation().replace("'", "\\'") %>',<%= property.getPrice() %>,'<%= property.getCurrency() %>','<%= property.getPriceInterval() %>','<%= property.getStatus() %>',<%= property.getBeds() %>,<%= property.getBaths() %>,<%= property.getArea() %>,'<%= property.getAreaUnit() %>','<%= property.getPropertyType() %>','<%= property.getDescription().replace("'", "\\'") %>','<%= property.getAgentId() %>','<%= property.getAgentName().replace("'", "\\'") %>',<%= property.isFeatured() %>,'<%= String.join(",", property.getAmenities()).replace("'", "\\'") %>','<%= String.join(",", property.getImages()).replace("'", "\\'") %>')">
                                                    <i class="fas fa-edit" title="Edit Property"></i>
                                                </button>
                                                
                                                <div class="btn-group">
                                                    <button type="button" class="btn btn-sm btn-outline-info action-btn dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                                                        <i class="fas fa-ellipsis-v"></i>
                                                    </button>
                                                    <ul class="dropdown-menu dropdown-menu-end">
                                                        <% if (!"Available".equalsIgnoreCase(property.getStatus())) { %>
                                                            <li><a class="dropdown-item" href="propertyManagement.jsp?action=available&propertyid=<%= property.getId() %>"><i class="fas fa-check-circle me-2"></i>Mark as Available</a></li>
                                                        <% } %>
                                                        <% if (!"Pending".equalsIgnoreCase(property.getStatus())) { %>
                                                            <li><a class="dropdown-item" href="propertyManagement.jsp?action=pending&propertyid=<%= property.getId() %>"><i class="fas fa-clock me-2"></i>Mark as Pending</a></li>
                                                        <% } %>
                                                        <% if (!"Sold".equalsIgnoreCase(property.getStatus())) { %>
                                                            <li><a class="dropdown-item" href="propertyManagement.jsp?action=sold&propertyid=<%= property.getId() %>"><i class="fas fa-handshake me-2"></i>Mark as Sold</a></li>
                                                        <% } %>
                                                        <% if (!"Rented".equalsIgnoreCase(property.getStatus())) { %>
                                                            <li><a class="dropdown-item" href="propertyManagement.jsp?action=rented&propertyid=<%= property.getId() %>"><i class="fas fa-key me-2"></i>Mark as Rented</a></li>
                                                        <% } %>
                                                        <li><hr class="dropdown-divider"></li>
                                                        <% if (property.isFeatured()) { %>
                                                            <li><a class="dropdown-item" href="propertyManagement.jsp?action=unfeature&propertyid=<%= property.getId() %>"><i class="far fa-star me-2"></i>Unfeature</a></li>
                                                        <% } else { %>
                                                            <li><a class="dropdown-item" href="propertyManagement.jsp?action=feature&propertyid=<%= property.getId() %>"><i class="fas fa-star me-2"></i>Feature</a></li>
                                                        <% } %>
                                                        <li><hr class="dropdown-divider"></li>
                                                        <li><a class="dropdown-item text-danger" href="propertyManagement.jsp?action=delete&propertyid=<%= property.getId() %>" onclick="return confirm('Are you sure you want to delete this property? This action cannot be undone.')"><i class="fas fa-trash me-2"></i>Delete</a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <% } %>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            
            <!-- Footer -->
            <footer class="mt-4">
                <div class="text-center text-muted">
                    <p>&copy; 2025 PropertyFinder Administrative Panel. All rights reserved.</p>
                    <p class="small">Current Date and Time (UTC): 2025-05-02 20:49:48 | User: IT24103866</p>
                </div>
            </footer>
        </div>
    </div>
    
    <!-- Add Property Modal -->
    <div class="modal fade" id="addPropertyModal" tabindex="-1" aria-labelledby="addPropertyModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addPropertyModalLabel">Add New Property</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="propertyManagement.jsp" method="post">
                    <input type="hidden" name="action" value="add">
                    <div class="modal-body">
                        <div class="row g-3">
                            <div class="col-md-12">
                                <label for="newTitle" class="form-label">Property Title</label>
                                <input type="text" class="form-control" id="newTitle" name="newTitle" required>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="newPropertyType" class="form-label">Property Type</label>
                                <select class="form-select" id="newPropertyType" name="newPropertyType" required>
                                    <option value="" selected disabled>Select type</option>
                                    <option value="House">House</option>
                                    <option value="Apartment">Apartment</option>
                                    <option value="Commercial">Commercial</option>
                                    <option value="Land">Land</option>
                                </select>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="newStatus" class="form-label">Status</label>
                                <select class="form-select" id="newStatus" name="newStatus" required>
                                    <option value="Available" selected>Available</option>
                                    <option value="Pending">Pending</option>
                                    <option value="Sold">Sold</option>
                                    <option value="Rented">Rented</option>
                                </select>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="newPrice" class="form-label">Price</label>
                                <input type="number" class="form-control" id="newPrice" name="newPrice" min="0" required>
                            </div>
                            
                            <div class="col-md-3">
                                <label for="newCurrency" class="form-label">Currency</label>
                                <select class="form-select" id="newCurrency" name="newCurrency">
                                    <option value="USD" selected>USD</option>
                                    <option value="EUR">EUR</option>
                                    <option value="GBP">GBP</option>
                                </select>
                            </div>
                            
                            <div class="col-md-3">
                                <label for="newPriceInterval" class="form-label">Interval</label>
                                <select class="form-select" id="newPriceInterval" name="newPriceInterval">
                                    <option value="" selected>One-time</option>
                                    <option value="monthly">Monthly</option>
                                    <option value="yearly">Yearly</option>
                                </select>
                            </div>
                            
                            <div class="col-md-12">
                                <label for="newLocation" class="form-label">Location</label>
                                <input type="text" class="form-control" id="newLocation" name="newLocation" required>
                            </div>
                            
                            <div class="col-md-4">
                                <label for="newBeds" class="form-label">Bedrooms</label>
                                <input type="number" class="form-control" id="newBeds" name="newBeds" min="0" value="0">
                                <div class="form-text">Enter 0 if not applicable</div>
                            </div>
                            
                            <div class="col-md-4">
                                <label for="newBaths" class="form-label">Bathrooms</label>
                                <input type="number" class="form-control" id="newBaths" name="newBaths" min="0" value="0">
                                <div class="form-text">Enter 0 if not applicable</div>
                            </div>
                            
                            <div class="col-md-4">
                                <label for="newArea" class="form-label">Area</label>
                                <div class="input-group">
                                    <input type="number" class="form-control" id="newArea" name="newArea" min="0" value="0">
                                    <select class="form-select" id="newAreaUnit" name="newAreaUnit" style="max-width: 100px;">
                                        <option value="sqft" selected>sqft</option>
                                        <option value="sqm">sqm</option>
                                        <option value="acre">acre</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="newAmenities" class="form-label">Amenities</label>
                                <input type="text" class="form-control" id="newAmenities" name="newAmenities" placeholder="e.g. Air Conditioning, Swimming Pool, Garage">
                                <div class="form-text">Enter amenities separated by commas</div>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="newImages" class="form-label">Images</label>
                                <input type="text" class="form-control" id="newImages" name="newImages" placeholder="e.g. house1.jpg, house2.jpg">
                                <div class="form-text">Enter image filenames separated by commas</div>
                            </div>
                            
                            <div class="col-md-12">
                                <label for="newDescription" class="form-label">Description</label>
                                <textarea class="form-control" id="newDescription" name="newDescription" rows="3"></textarea>
                            </div>
                            
                            <hr>
                            <h6>Agent Information</h6>
                            
                            <div class="col-md-6">
                                <label for="newAgentId" class="form-label">Agent ID</label>
                                <input type="text" class="form-control" id="newAgentId" name="newAgentId">
                            </div>
                            
                            <div class="col-md-6">
                                <label for="newAgentName" class="form-label">Agent Name</label>
                                <input type="text" class="form-control" id="newAgentName" name="newAgentName">
                            </div>
                            
                            <div class="col-md-12">
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="newFeatured" name="newFeatured">
                                    <label class="form-check-label" for="newFeatured">
                                        Feature this property (will appear in featured section)
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Add Property</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Edit Property Modal -->
    <div class="modal fade" id="editPropertyModal" tabindex="-1" aria-labelledby="editPropertyModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editPropertyModalLabel">Edit Property</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="propertyManagement.jsp" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" id="editPropertyId" name="editPropertyId" value="">
                    <div class="modal-body">
                        <div class="row g-3">
                            <div class="col-md-12">
                                <label for="editTitle" class="form-label">Property Title</label>
                                <input type="text" class="form-control" id="editTitle" name="editTitle" required>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="editPropertyType" class="form-label">Property Type</label>
                                <select class="form-select" id="editPropertyType" name="editPropertyType" required>
                                    <option value="House">House</option>
                                    <option value="Apartment">Apartment</option>
                                    <option value="Commercial">Commercial</option>
                                    <option value="Land">Land</option>
                                </select>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="editStatus" class="form-label">Status</label>
                                <select class="form-select" id="editStatus" name="editStatus" required>
                                    <option value="Available">Available</option>
                                    <option value="Pending">Pending</option>
                                    <option value="Sold">Sold</option>
                                    <option value="Rented">Rented</option>
                                </select>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="editPrice" class="form-label">Price</label>
                                <input type="number" class="form-control" id="editPrice" name="editPrice" min="0" required>
                            </div>
                            
                            <div class="col-md-3">
                                <label for="editCurrency" class="form-label">Currency</label>
                                <select class="form-select" id="editCurrency" name="editCurrency">
                                    <option value="USD">USD</option>
                                    <option value="EUR">EUR</option>
                                    <option value="GBP">GBP</option>
                                </select>
                            </div>
                            
                            <div class="col-md-3">
                                <label for="editPriceInterval" class="form-label">Interval</label>
                                <select class="form-select" id="editPriceInterval" name="editPriceInterval">
                                    <option value="">One-time</option>
                                    <option value="monthly">Monthly</option>
                                    <option value="yearly">Yearly</option>
                                </select>
                            </div>
                            
                            <div class="col-md-12">
                                <label for="editLocation" class="form-label">Location</label>
                                <input type="text" class="form-control" id="editLocation" name="editLocation" required>
                            </div>
                            
                            <div class="col-md-4">
                                <label for="editBeds" class="form-label">Bedrooms</label>
                                <input type="number" class="form-control" id="editBeds" name="editBeds" min="0">
                                <div class="form-text">Enter 0 if not applicable</div>
                            </div>
                            
                            <div class="col-md-4">
                                <label for="editBaths" class="form-label">Bathrooms</label>
                                <input type="number" class="form-control" id="editBaths" name="editBaths" min="0">
                                <div class="form-text">Enter 0 if not applicable</div>
                            </div>
                            
                            <div class="col-md-4">
                                <label for="editArea" class="form-label">Area</label>
                                <div class="input-group">
                                    <input type="number" class="form-control" id="editArea" name="editArea" min="0">
                                    <select class="form-select" id="editAreaUnit" name="editAreaUnit" style="max-width: 100px;">
                                        <option value="sqft">sqft</option>
                                        <option value="sqm">sqm</option>
                                        <option value="acre">acre</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="editAmenities" class="form-label">Amenities</label>
                                <input type="text" class="form-control" id="editAmenities" name="editAmenities">
                                <div class="form-text">Enter amenities separated by commas</div>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="editImages" class="form-label">Images</label>
                                <input type="text" class="form-control" id="editImages" name="editImages">
                                <div class="form-text">Enter image filenames separated by commas</div>
                            </div>
                            
                            <div class="col-md-12">
                                <label for="editDescription" class="form-label">Description</label>
                                <textarea class="form-control" id="editDescription" name="editDescription" rows="3"></textarea>
                            </div>
                            
                            <hr>
                            <h6>Agent Information</h6>
                            
                            <div class="col-md-6">
                                <label for="editAgentId" class="form-label">Agent ID</label>
                                <input type="text" class="form-control" id="editAgentId" name="editAgentId">
                            </div>
                            
                            <div class="col-md-6">
                                <label for="editAgentName" class="form-label">Agent Name</label>
                                <input type="text" class="form-control" id="editAgentName" name="editAgentName">
                            </div>
                            
                            <div class="col-md-12">
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="editFeatured" name="editFeatured">
                                    <label class="form-check-label" for="editFeatured">
                                        Feature this property (will appear in featured section)
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- View Property Modal -->
    <div class="modal fade" id="viewPropertyModal" tabindex="-1" aria-labelledby="viewPropertyModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="viewPropertyModalLabel">Property Details</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div id="viewPropertyImageContainer" class="mb-3" style="height: 250px; overflow: hidden; border-radius: 8px;">
                                <img id="viewPropertyImage" src="" class="w-100 h-100" alt="Property Image" style="object-fit: cover;">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <h4 id="viewPropertyTitle"></h4>
                            <div class="d-flex gap-2 mb-3">
                                <span id="viewPropertyTypeBadge" class="property-type-badge"></span>
                                <span id="viewPropertyStatusBadge" class="status-badge"></span>
                                <span id="viewPropertyFeaturedBadge"></span>
                            </div>
                            <h3 id="viewPropertyPrice" class="mb-3"></h3>
                            <p><i class="fas fa-map-marker-alt me-2 text-muted"></i> <span id="viewPropertyLocation"></span></p>
                            <div class="d-flex gap-4 mt-3">
                                <div id="viewPropertyBedsContainer">
                                    <div class="fw-bold"><i class="fas fa-bed me-2 text-muted"></i> <span id="viewPropertyBeds"></span></div>
                                    <div class="small text-muted">Bedrooms</div>
                                </div>
                                <div id="viewPropertyBathsContainer">
                                    <div class="fw-bold"><i class="fas fa-bath me-2 text-muted"></i> <span id="viewPropertyBaths"></span></div>
                                    <div class="small text-muted">Bathrooms</div>
                                </div>
                                <div id="viewPropertyAreaContainer">
                                    <div class="fw-bold"><i class="fas fa-vector-square me-2 text-muted"></i> <span id="viewPropertyArea"></span></div>
                                    <div class="small text-muted">Area</div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-12 mt-4">
                            <h5>Description</h5>
                            <p id="viewPropertyDescription"></p>
                        </div>
                        
                        <div class="col-12 mt-3" id="viewPropertyAmenitiesContainer">
                            <h5>Amenities</h5>
                            <div id="viewPropertyAmenities" class="d-flex flex-wrap gap-2"></div>
                        </div>
                        
                        <div class="col-12 mt-3">
                            <h5>Additional Information</h5>
                            <div class="row">
                                <div class="col-md-6">
                                    <p><strong>Listed Date:</strong> <span id="viewPropertyListedDate"></span></p>
                                </div>
                                <div class="col-md-6" id="viewPropertyAgentContainer">
                                    <p><strong>Agent:</strong> <span id="viewPropertyAgent"></span></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="viewEditButton">Edit Property</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- DataTables -->
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Initialize DataTable
            const propertyTable = $('#propertyTable').DataTable({
                "paging": true,
                "ordering": true,
                "info": true,
                "responsive": true,
                "lengthMenu": [10, 25, 50, 100],
                "language": {
                    "search": "Filter records:",
                    "lengthMenu": "Show _MENU_ properties per page",
                    "zeroRecords": "No matching properties found",
                    "info": "Showing _START_ to _END_ of _TOTAL_ properties",
                    "infoEmpty": "No properties available",
                    "infoFiltered": "(filtered from _MAX_ total properties)"
                }
            });
            
            // Connect the custom search box to DataTable
            $('#propertySearchInput').on('keyup', function() {
                propertyTable.search(this.value).draw();
            });
            
            // Toggle sidebar on mobile
            const toggleSidebarBtn = document.getElementById('toggleSidebar');
            const sidebar = document.querySelector('.sidebar');
            const content = document.querySelector('.content');
            
            toggleSidebarBtn?.addEventListener('click', function() {
                sidebar.classList.toggle('show');
                content.classList.toggle('pushed');
                
                // Change icon based on sidebar state
                const icon = toggleSidebarBtn.querySelector('i');
                if (sidebar.classList.contains('show')) {
                    icon.classList.remove('fa-bars');
                    icon.classList.add('fa-times');
                } else {
                    icon.classList.remove('fa-times');
                    icon.classList.add('fa-bars');
                }
            });
            
            // Display current system date and time on the page
            const footerTimeElement = document.querySelector('footer p.small');
            if (footerTimeElement) {
                footerTimeElement.textContent = 'Current Date and Time (UTC): 2025-05-02 20:49:48 | User: IT24103866';
            }
            
            // Update property type selection based on property type
            document.getElementById('newPropertyType')?.addEventListener('change', function() {
                const propertyType = this.value;
                
                // Show/hide bedroom and bathroom fields based on property type
                const bedsField = document.getElementById('newBeds').parentElement;
                const bathsField = document.getElementById('newBaths').parentElement;
                
                if (propertyType === 'Land' || propertyType === 'Commercial') {
                    bedsField.style.display = 'none';
                    bathsField.style.display = 'none';
                    document.getElementById('newBeds').value = '0';
                    document.getElementById('newBaths').value = '0';
                } else {
                    bedsField.style.display = '';
                    bathsField.style.display = '';
                }
                
                // Update price interval options based on property type
                const priceIntervalField = document.getElementById('newPriceInterval');
                if (propertyType === 'Apartment') {
                    // For apartments, default to monthly
                    if (priceIntervalField.value === '') {
                        priceIntervalField.value = 'monthly';
                    }
                }
            });
            
            // Display a warning before deleting a property
            document.querySelectorAll('[href*="action=delete"]').forEach(link => {
                link.addEventListener('click', function(e) {
                    if (!confirm('Are you sure you want to delete this property? This action cannot be undone.')) {
                        e.preventDefault();
                    }
                });
            });
        });
        
        // Function to populate and show edit property modal
        function editProperty(id, title, location, price, currency, priceInterval, status, beds, baths, area, areaUnit, propertyType, description, agentId, agentName, featured, amenities, images) {
            document.getElementById('editPropertyId').value = id;
            document.getElementById('editTitle').value = title;
            document.getElementById('editLocation').value = location;
            document.getElementById('editPrice').value = price;
            document.getElementById('editCurrency').value = currency;
            document.getElementById('editPriceInterval').value = priceInterval;
            document.getElementById('editStatus').value = status;
            document.getElementById('editBeds').value = beds;
            document.getElementById('editBaths').value = baths;
            document.getElementById('editArea').value = area;
            document.getElementById('editAreaUnit').value = areaUnit;
            document.getElementById('editPropertyType').value = propertyType;
            document.getElementById('editDescription').value = description;
            document.getElementById('editAgentId').value = agentId;
            document.getElementById('editAgentName').value = agentName;
            document.getElementById('editFeatured').checked = featured;
            document.getElementById('editAmenities').value = amenities;
            document.getElementById('editImages').value = images;
            
            // Show/hide bedroom and bathroom fields based on property type
            const bedsField = document.getElementById('editBeds').parentElement;
            const bathsField = document.getElementById('editBaths').parentElement;
            
            if (propertyType === 'Land' || propertyType === 'Commercial') {
                bedsField.style.display = 'none';
                bathsField.style.display = 'none';
            } else {
                bedsField.style.display = '';
                bathsField.style.display = '';
            }
            
            // Show the modal
            new bootstrap.Modal(document.getElementById('editPropertyModal')).show();
        }
        
        // Function to populate and show view property modal
        function viewProperty(id, title, location, price, currency, priceInterval, status, beds, baths, area, areaUnit, propertyType, description, agentName, listedDate, featured, amenities, images) {
            // Set property data in the modal
            document.getElementById('viewPropertyTitle').textContent = title;
            document.getElementById('viewPropertyLocation').textContent = location;
            document.getElementById('viewPropertyDescription').textContent = description || 'No description provided.';
            document.getElementById('viewPropertyListedDate').textContent = listedDate;
            document.getElementById('viewPropertyAgent').textContent = agentName || 'Not assigned';
            
            // Set price with currency and interval
            let priceText = `${currency} ${price.toLocaleString()}`;
            if (priceInterval) {
                priceText += ` per ${priceInterval}`;
            }
            document.getElementById('viewPropertyPrice').textContent = priceText;
            
            // Set property type badge
            let typeBadgeClass = '';
            if (propertyType === 'House') {
                typeBadgeClass = 'badge-house';
            } else if (propertyType === 'Apartment') {
                typeBadgeClass = 'badge-apartment';
            } else if (propertyType === 'Commercial') {
                typeBadgeClass = 'badge-commercial';
            } else if (propertyType === 'Land') {
                typeBadgeClass = 'badge-land';
            }
            
            document.getElementById('viewPropertyTypeBadge').className = `property-type-badge ${typeBadgeClass}`;
            document.getElementById('viewPropertyTypeBadge').textContent = propertyType;
            
            // Set status badge
            let statusClass = '';
            if (status === 'Available') {
                statusClass = 'status-available';
            } else if (status === 'Sold') {
                statusClass = 'status-sold';
            } else if (status === 'Pending') {
                statusClass = 'status-pending';
            } else if (status === 'Rented') {
                statusClass = 'status-rented';
            }
            
            document.getElementById('viewPropertyStatusBadge').className = `status-badge ${statusClass}`;
            document.getElementById('viewPropertyStatusBadge').textContent = status;
            
            // Set featured badge if featured
            document.getElementById('viewPropertyFeaturedBadge').innerHTML = featured ? 
                '<span class="featured-badge"><i class="fas fa-star me-1"></i>Featured</span>' : '';
            
            // Set beds, baths, area
            const bedsContainer = document.getElementById('viewPropertyBedsContainer');
            const bathsContainer = document.getElementById('viewPropertyBathsContainer');
            const areaContainer = document.getElementById('viewPropertyAreaContainer');
            
            if (beds > 0) {
                document.getElementById('viewPropertyBeds').textContent = beds;
                bedsContainer.style.display = '';
            } else {
                bedsContainer.style.display = 'none';
            }
            
            if (baths > 0) {
                document.getElementById('viewPropertyBaths').textContent = baths;
                bathsContainer.style.display = '';
            } else {
                bathsContainer.style.display = 'none';
            }
            
            if (area > 0) {
                document.getElementById('viewPropertyArea').textContent = `${area} ${areaUnit}`;
                areaContainer.style.display = '';
            } else {
                areaContainer.style.display = 'none';
            }
            
            // Set agent info
            const agentContainer = document.getElementById('viewPropertyAgentContainer');
            if (agentName) {
                agentContainer.style.display = '';
            } else {
                agentContainer.style.display = 'none';
            }
            
            // Set amenities
            const amenitiesContainer = document.getElementById('viewPropertyAmenitiesContainer');
            const amenitiesElement = document.getElementById('viewPropertyAmenities');
            amenitiesElement.innerHTML = '';
            
            if (amenities) {
                const amenityList = amenities.split(',');
                if (amenityList.length > 0 && amenityList[0] !== '') {
                    amenityList.forEach(amenity => {
                        if (amenity.trim()) {
                            const span = document.createElement('span');
                            span.className = 'amenity-tag';
                            span.textContent = amenity.trim();
                            amenitiesElement.appendChild(span);
                        }
                    });
                    amenitiesContainer.style.display = '';
                } else {
                    amenitiesContainer.style.display = 'none';
                }
            } else {
                amenitiesContainer.style.display = 'none';
            }
            
            // Set main image
            const imageElement = document.getElementById('viewPropertyImage');
            if (images) {
                const imageList = images.split(',');
                if (imageList.length > 0 && imageList[0] !== '') {
                    imageElement.src = `images/${imageList[0].trim()}`;
                    imageElement.onerror = function() {
                        this.onerror = null;
                        this.src = 'https://via.placeholder.com/800x600?text=Image+Not+Found';
                    };
                } else {
                    imageElement.src = 'https://via.placeholder.com/800x600?text=No+Image';
                }
            } else {
                imageElement.src = 'https://via.placeholder.com/800x600?text=No+Image';
            }
            
            // Set up edit button
            document.getElementById('viewEditButton').onclick = function() {
                // Close view modal
                bootstrap.Modal.getInstance(document.getElementById('viewPropertyModal')).hide();
                // Open edit modal with the agent ID - we can't pass it from the view function
                // so we'll need to get it from the edit button's data attribute
                const agentId = document.querySelector(`[data-property-id="${id}"]`)?.dataset.agentId || '';
                editProperty(id, title, location, price, currency, priceInterval, status, beds, baths, area, areaUnit, propertyType, description, agentId, agentName, featured, amenities, images);
            };
            
            // Show the modal
            new bootstrap.Modal(document.getElementById('viewPropertyModal')).show();
        }
    </script>
</body>
</html>