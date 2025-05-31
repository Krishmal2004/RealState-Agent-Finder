<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*, com.google.gson.*" %>
<%@ page import="com.google.gson.reflect.TypeToken, java.lang.reflect.Type" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Properties | Real Estate Portal</title>

    <!-- CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@splidejs/splide@4.1.4/dist/css/splide.min.css">

    <style>
        /* All existing styles remain unchanged */
        :root {
            --primary-dark: #0A192F;
            --primary-medium: #112240;
            --primary-light: #1E3A8A;
            --accent-blue: #3B82F6;
            --accent-cyan: #06B6D4;
            --text-white: #F8FAFC;
            --text-light: #CBD5E1;
            --text-muted: #94A3B8;
            --border-color: rgba(203, 213, 225, 0.1);
            --gradient-start: rgba(10, 25, 47, 0.95);
            --gradient-end: rgba(17, 34, 64, 0.95);
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, var(--gradient-start), var(--gradient-end));
            color: var(--text-light);
            min-height: 100vh;
        }

        /* All existing styles preserved */
        .floating-search {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            background: rgba(10, 25, 47, 0.95);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid var(--border-color);
            padding: 1rem 2rem;
            transition: all 0.3s ease;
        }

        /* Debug info styles */
        .debug-info {
            background: rgba(0, 0, 0, 0.7);
            color: #fff;
            padding: 10px;
            margin: 10px 0;
            font-family: monospace;
            border-radius: 8px;
            font-size: 0.8rem;
        }
        
        /* All other existing styles */
        .search-collapsed {
            transform: translateY(-100%);
        }

        .main-container {
            padding: 7rem 2rem 2rem 2rem;
        }

        .property-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 1.5rem;
        }

        .property-card {
            background: rgba(17, 34, 64, 0.7);
            border-radius: 12px;
            overflow: hidden;
            border: 1px solid var(--border-color);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            backdrop-filter: blur(10px);
            position: relative;
        }

        .property-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }

        .splide__slide img {
            width: 100%;
            height: 250px;
            object-fit: cover;
        }

        .property-info {
            padding: 1.5rem;
        }

        .price-badge {
            position: absolute;
            top: 1rem;
            right: 1rem;
            background: linear-gradient(135deg, var(--accent-blue), var(--accent-cyan));
            color: var(--text-white);
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            z-index: 10;
        }

        .status-badge {
            position: absolute;
            top: 1rem;
            left: 1rem;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 500;
            z-index: 10;
        }

        .status-sale {
            background-color: rgba(16, 185, 129, 0.2);
            color: #10B981;
            border: 1px solid rgba(16, 185, 129, 0.3);
        }

        .status-rent, .status-active {
            background-color: rgba(245, 158, 11, 0.2);
            color: #F59E0B;
            border: 1px solid rgba(245, 158, 11, 0.3);
        }

        .property-details {
            display: flex;
            gap: 1.5rem;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid var(--border-color);
        }

        .detail-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--text-muted);
            font-size: 0.875rem;
        }

        .property-title {
            color: var(--text-white);
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .property-location {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--text-muted);
            font-size: 0.875rem;
            margin-bottom: 1rem;
        }

        .search-section {
            background: rgba(30, 58, 138, 0.3);
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .search-input {
            background: rgba(10, 25, 47, 0.5);
            border: 1px solid var(--border-color);
            color: var(--text-white);
            border-radius: 8px;
            padding: 0.75rem 1rem;
        }

        .search-input::placeholder {
            color: var(--text-muted);
        }
        
        .search-input:focus {
            border-color: var(--accent-cyan);
            box-shadow: 0 0 0 2px rgba(6, 182, 212, 0.2);
            background: rgba(10, 25, 47, 0.7);
            color: var(--text-white) !important;
        }

        .amenity-tag {
            background: rgba(59, 130, 246, 0.1);
            color: var(--accent-blue);
            border: 1px solid rgba(59, 130, 246, 0.2);
            padding: 0.25rem 0.75rem;
            border-radius: 15px;
            font-size: 0.75rem;
            display: inline-block;
            margin: 0.25rem;
        }

        .splide__arrow {
            background: rgba(10, 25, 47, 0.8);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .property-card:hover .splide__arrow {
            opacity: 1;
        }

        .splide__pagination__page {
            background: rgba(255, 255, 255, 0.3);
        }

        .splide__pagination__page.is-active {
            background: var(--accent-cyan);
        }

        .user-info {
            color: var(--text-light);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .user-avatar {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background-color: var(--accent-blue);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-white);
            font-weight: 500;
        }
        
        .error-message {
            background-color: rgba(239, 68, 68, 0.2);
            border: 1px solid rgba(239, 68, 68, 0.3);
            color: #f87171;
            padding: 1rem;
            margin-bottom: 1rem;
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <%
        // Define fixed date and time and user information
        String currentDateTime = "2025-05-01 09:15:23"; // Updated with user-specified date
        String currentUser = "IT24103866"; // Updated with user-specified login
        
        // Get context path for image URL resolution
        String contextPath = request.getContextPath();
        
        // Load and parse JSON data using Gson
        Gson gson = new Gson();
        JsonObject jsonData = null;
        String errorMessage = null;
        
        try {
            // Try with the specific path
            String jsonFilePath = "C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\data\\properties.json";
            File jsonFile = new File(jsonFilePath);
            System.out.println("Looking for JSON file at: " + jsonFile.getAbsolutePath());
            
            // Check if file exists
            if (!jsonFile.exists()) {
                errorMessage = "Properties file not found at: " + jsonFilePath;
                
                // Create fallback data
                String fallbackJsonData = "{\"properties\":[" +
                    "{\"propertyId\":\"PROP1744062398848\",\"agentId\":null,\"title\":\"Grand Luxury Villa with Ocean View\",\"type\":null,\"price\":1250000.0,\"location\":\"78 Coastal Avenue, Colombo 03\",\"bedrooms\":5,\"bathrooms\":4,\"squareFeet\":4200.0,\"description\":null,\"amenities\":[\"Infinity Pool\",\"Ocean View\",\"Smart Home\",\"Security\"],\"images\":[\"https://images.unsplash.com/photo-1613977257363-707ba9348227\",\"https://images.unsplash.com/photo-1613977257592-4871e5fcd7c4\",\"https://images.unsplash.com/photo-1613977257401-b1a01c3491a9\"],\"status\":\"sale\",\"createdDate\":\"2025-04-07 13:20:36\",\"createdBy\":\"Krishmal2004\",\"updatedDate\":\"2025-04-07 13:20:36\",\"updatedBy\":\"Krishmal2004\",\"featured\":false}," +
                    "{\"propertyId\":\"PROP1744062398868\",\"agentId\":null,\"title\":\"Modern City Center Apartment\",\"type\":null,\"price\":350000.0,\"location\":\"45 Urban Square, Colombo 02\",\"bedrooms\":2,\"bathrooms\":2,\"squareFeet\":1100.0,\"description\":null,\"amenities\":[\"City View\",\"Gym\",\"Parking\"],\"images\":[\"https://images.unsplash.com/photo-1522708323590-d24dbb6b0267\",\"https://images.unsplash.com/photo-1502005229762-cf1b2da7c5d6\"],\"status\":\"sale\",\"createdDate\":\"2025-04-07 13:20:36\",\"createdBy\":\"Krishmal2004\",\"updatedDate\":\"2025-04-07 13:20:36\",\"updatedBy\":\"Krishmal2004\",\"featured\":false}" +
                "]}";
                
                // Parse the fallback data
                jsonData = gson.fromJson(fallbackJsonData, JsonObject.class);
                
                // Try to create the directory and file
                try {
                    // Create directories if they don't exist
                    File parentDir = jsonFile.getParentFile();
                    if (!parentDir.exists()) {
                        parentDir.mkdirs();
                    }
                    
                    // Write the JSON file
                    FileWriter writer = new FileWriter(jsonFile);
                    writer.write(fallbackJsonData);
                    writer.close();
                    
                    errorMessage += "<br>Created fallback properties file.";
                } catch (Exception e) {
                    errorMessage += "<br>Could not create properties file: " + e.getMessage();
                }
            } else {
                // File exists, read it
                FileReader reader = new FileReader(jsonFile);
                jsonData = gson.fromJson(reader, JsonObject.class);
                reader.close();
            }
        } catch (Exception e) {
            errorMessage = "Error loading property data: " + e.getMessage();
            
            // Create fallback data
            String fallbackJsonData = "{\"properties\":[" +
                "{\"propertyId\":\"PROP1744062398848\",\"agentId\":null,\"title\":\"Grand Luxury Villa with Ocean View\",\"type\":null,\"price\":1250000.0,\"location\":\"78 Coastal Avenue, Colombo 03\",\"bedrooms\":5,\"bathrooms\":4,\"squareFeet\":4200.0,\"description\":null,\"amenities\":[\"Infinity Pool\",\"Ocean View\",\"Smart Home\",\"Security\"],\"images\":[\"https://images.unsplash.com/photo-1613977257363-707ba9348227\",\"https://images.unsplash.com/photo-1613977257592-4871e5fcd7c4\",\"https://images.unsplash.com/photo-1613977257401-b1a01c3491a9\"],\"status\":\"sale\",\"createdDate\":\"2025-04-07 13:20:36\",\"createdBy\":\"Krishmal2004\",\"updatedDate\":\"2025-04-07 13:20:36\",\"updatedBy\":\"Krishmal2004\",\"featured\":false}," +
                "{\"propertyId\":\"PROP1744062398868\",\"agentId\":null,\"title\":\"Modern City Center Apartment\",\"type\":null,\"price\":350000.0,\"location\":\"45 Urban Square, Colombo 02\",\"bedrooms\":2,\"bathrooms\":2,\"squareFeet\":1100.0,\"description\":null,\"amenities\":[\"City View\",\"Gym\",\"Parking\"],\"images\":[\"https://images.unsplash.com/photo-1522708323590-d24dbb6b0267\",\"https://images.unsplash.com/photo-1502005229762-cf1b2da7c5d6\"],\"status\":\"sale\",\"createdDate\":\"2025-04-07 13:20:36\",\"createdBy\":\"Krishmal2004\",\"updatedDate\":\"2025-04-07 13:20:36\",\"updatedBy\":\"Krishmal2004\",\"featured\":false}" +
            "]}";
            
            jsonData = gson.fromJson(fallbackJsonData, JsonObject.class);
        }
    %>

    <!-- Floating Search Bar -->
    <div class="floating-search">
        <div class="container-fluid">
            <div class="row align-items-center">
                <div class="col-auto">
                    <div class="d-flex align-items-center gap-3">
                        <i class="fas fa-building text-accent-blue fs-4"></i>
                        <div>
                            <h5 class="mb-0 text-white">Property Listings</h5>
                            <small class="text-muted">
                                <i class="far fa-clock me-1"></i>
                                <%= currentDateTime %>
                            </small>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="row g-3">
                        <div class="col-md-3">
                            <input type="text" class="form-control search-input" placeholder="Search properties..." id="propertySearch">
                        </div>
                        <div class="col-md-2">
                            <select class="form-select search-input" id="propertyType">
                                <option value="">Property Type</option>
                                <option value="House">House</option>
                                <option value="Apartment">Apartment</option>
                                <option value="Villa">Villa</option>
                                <option value="Commercial">Commercial</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <select class="form-select search-input" id="priceRange">
                                <option value="">Price Range</option>
                                <option value="100000-200000">$100k - $200k</option>
                                <option value="200000-500000">$200k - $500k</option>
                                <option value="500000-1000000">$500k - $1M</option>
                                <option value="1000000-10000000">$1M+</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <select class="form-select search-input" id="bedrooms">
                                <option value="">Bedrooms</option>
                                <option value="1">1+</option>
                                <option value="2">2+</option>
                                <option value="3">3+</option>
                                <option value="4">4+</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <select class="form-select search-input" id="sortBy">
                                <option value="">Sort By</option>
                                <option value="price-asc">Price: Low to High</option>
                                <option value="price-desc">Price: High to Low</option>
                                <option value="newest">Newest First</option>
                                <option value="popular">Most Popular</option>
                            </select>
                        </div>
                        <div class="col-md-1">
                            <button class="btn btn-primary w-100" id="searchButton">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-auto ms-auto">
                    <div class="user-info">
                        <div class="user-avatar">
                            <i class="fas fa-user"></i>
                        </div>
                        <span><%= currentUser %></span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-container">
        <!-- Debug Info -->
        <div class="debug-info">
            <h5>Debug Information:</h5>
            <p>Context Path: <%= contextPath %></p>
            <p>Current Date: <%= currentDateTime %></p>
            <p>Current User: <%= currentUser %></p>
            <p>Base Image Path: C:\Users\user\Downloads\project\RealState\src\main\webapp\WEB-INF\property-images</p>
            <% if (errorMessage != null) { %>
                <p class="text-danger">Error: <%= errorMessage %></p>
            <% } %>
        </div>

        <% if (errorMessage != null) { %>
            <div class="error-message">
                <i class="fas fa-exclamation-circle me-2"></i>
                <%= errorMessage %>
            </div>
        <% } %>

        <div class="property-grid" id="propertyGrid">
            <% 
                if (jsonData != null && jsonData.has("properties")) {
                    JsonArray properties = jsonData.getAsJsonArray("properties");
                    
                    for (int i = 0; i < properties.size(); i++) {
                        try {
                            JsonObject property = properties.get(i).getAsJsonObject();
                            
                            // Safely get properties with null checks
                            String title = property.has("title") ? property.get("title").getAsString() : "Untitled Property";
                            double priceVal = property.has("price") ? property.get("price").getAsDouble() : 0;
                            int price = (int) priceVal;
                            String currency = "$"; // Default currency
                            String priceInterval = property.has("status") && property.get("status").getAsString().equals("rent") ? "/month" : "";
                            String status = property.has("status") ? property.get("status").getAsString().toLowerCase() : "sale";
                            String location = property.has("location") ? property.get("location").getAsString() : "Location not specified";
                            int beds = property.has("bedrooms") ? property.get("bedrooms").getAsInt() : 0;
                            int baths = property.has("bathrooms") ? property.get("bathrooms").getAsInt() : 0;
                            double areaVal = property.has("squareFeet") ? property.get("squareFeet").getAsDouble() : 0;
                            int area = (int) areaVal;
                            String areaUnit = "sqft";
                            
                            JsonArray amenities = new JsonArray();
                            if (property.has("amenities")) {
                                amenities = property.getAsJsonArray("amenities");
                            }
                            
                            JsonArray images = new JsonArray();
                            if (property.has("images")) {
                                images = property.getAsJsonArray("images");
                            }
                            
                            // Ensure we have at least one image
                            if (images.size() == 0) {
                                JsonPrimitive defaultImage = new JsonPrimitive("https://images.unsplash.com/photo-1560518883-ce09059eeffa?auto=format&fit=crop&w=1200&q=80");
                                images.add(defaultImage);
                            }
                            
                            // Display each property
            %>
                <div class="property-card">
                    <div class="splide">
                        <div class="splide__track">
                            <ul class="splide__list">
                                <% for (int j = 0; j < images.size(); j++) { 
                                    String imgUrl = images.get(j).getAsString();
                                    
                                    // FIXED IMAGE URL PROCESSING
                                    if (imgUrl.startsWith("http")) {
                                        // External URL - keep as is
                                        if (!imgUrl.contains("?")) {
                                            // Add parameters if not present
                                            imgUrl += "?auto=format&fit=crop&w=1200&q=80";
                                        }
                                    } else if (imgUrl.contains("property-images/")) {
                                        // THIS IS THE IMPORTANT FIX FOR LOCAL PROPERTY IMAGES
                                        // Extract the path after "property-images/"
                                        String imagePath = imgUrl;
                                        if (imgUrl.startsWith("/")) {
                                            imagePath = imgUrl.substring(1);
                                        }
                                        if (!imagePath.startsWith("property-images/")) {
                                            imagePath = "property-images/" + imagePath;
                                        }
                                        // If it starts with "property-images/", extract the part after it
                                        if (imagePath.startsWith("property-images/")) {
                                            String pathPart = imagePath.substring("property-images/".length());
                                            imgUrl = request.getContextPath() + "/propertyImage/" + pathPart;
                                        } else {
                                            imgUrl = request.getContextPath() + "/propertyImage/" + imagePath;
                                        }
                                    } else if (imgUrl.startsWith("/")) {
                                        // Regular web app resources - just add context path
                                        imgUrl = request.getContextPath() + imgUrl;
                                    } else {
                                        // Add leading slash and context path
                                        imgUrl = request.getContextPath() + "/" + imgUrl;
                                    }
                                %>
                                    <li class="splide__slide">
                                        <img src="<%= imgUrl %>" alt="<%= title %> Image <%= j+1 %>" 
                                            onerror="this.src='https://via.placeholder.com/800x600?text=Image+Not+Available'">
                                    </li>
                                <% } %>
                            </ul>
                        </div>
                    </div>
                    <div class="price-badge"><%= currency %><%= price %><%= priceInterval %></div>
                    <div class="status-badge status-<%= status %>">For <%= status.substring(0, 1).toUpperCase() + status.substring(1) %></div>
                    <div class="property-info">
                        <h3 class="property-title"><%= title %></h3>
                        <div class="property-location">
                            <i class="fas fa-map-marker-alt text-accent-cyan"></i>
                            <%= location %>
                        </div>
                        <div class="property-details">
                            <div class="detail-item">
                                <i class="fas fa-bed text-accent-blue"></i>
                                <%= beds %> <%= beds > 1 ? "Beds" : "Bed" %>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-bath text-accent-blue"></i>
                                <%= baths %> <%= baths > 1 ? "Baths" : "Bath" %>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-ruler-combined text-accent-blue"></i>
                                <%= area %> <%= areaUnit %>
                            </div>
                        </div>
                        <div class="mt-3">
                            <% for (int k = 0; k < amenities.size(); k++) { %>
                                <span class="amenity-tag"><%= amenities.get(k).getAsString() %></span>
                            <% } %>
                        </div>
                    </div>
                </div>
            <% 
                        } catch (Exception e) {
                            // Log error for debugging
                            System.out.println("Error processing property: " + e.getMessage());
                            e.printStackTrace();
                            continue;
                        }
                    }
                }
            %>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@splidejs/splide@4.1.4/dist/js/splide.min.js"></script>
    <script>
        // Store context path for image resolution in JavaScript
        const contextPath = '<%= contextPath %>';
        const currentDateTime = '<%= currentDateTime %>';
        const currentUser = '<%= currentUser %>';
        
        // Initialize all Splide sliders
        document.addEventListener('DOMContentLoaded', function() {
            console.log("Initializing sliders and loading properties...");
            console.log("Context Path: " + contextPath);
            console.log("Current Date: " + currentDateTime);
            console.log("Current User: " + currentUser);
            
            initSpliders();
            
            // Search functionality
            document.getElementById('searchButton').addEventListener('click', filterProperties);
            document.getElementById('propertySearch').addEventListener('keyup', function(event) {
                if (event.key === 'Enter') {
                    filterProperties();
                }
            });
        });
        
        function initSpliders() {
            const splides = document.getElementsByClassName('splide');
            for (const splide of splides) {
                new Splide(splide, {
                    type: 'loop',
                    perPage: 1,
                    autoplay: false,
                    pauseOnHover: true,
                    arrows: true,
                    pagination: true,
                    interval: 3000,
                }).mount();
            }
        }

        // Floating search bar behavior
        let lastScroll = 0;
        const floatingSearch = document.querySelector('.floating-search');
        
        window.addEventListener('scroll', () => {
            const currentScroll = window.pageYOffset;
            
            if (currentScroll <= 0) {
                floatingSearch.classList.remove('search-collapsed');
            }
            else if (currentScroll > lastScroll && !floatingSearch.classList.contains('search-collapsed')) {
                floatingSearch.classList.add('search-collapsed');
            }
            else if (currentScroll < lastScroll && floatingSearch.classList.contains('search-collapsed')) {
                floatingSearch.classList.remove('search-collapsed');
            }
            
            lastScroll = currentScroll;
        });
        
        // Store the property data as a JavaScript variable for client-side filtering
        var allPropertyData = <%= jsonData.toString() %>;
        
        // Filter properties based on search criteria
        function filterProperties() {
            var searchTerm = document.getElementById('propertySearch').value.toLowerCase();
            var propertyType = document.getElementById('propertyType').value.toLowerCase();
            var priceRange = document.getElementById('priceRange').value;
            var bedrooms = parseInt(document.getElementById('bedrooms').value) || 0;
            var sortBy = document.getElementById('sortBy').value;
            
            // Use in-memory data instead of fetch
            var properties = allPropertyData.properties;
            
            // Apply filters
            if (searchTerm) {
                properties = properties.filter(function(p) {
                    return (p.title && p.title.toLowerCase().includes(searchTerm)) || 
                           (p.location && p.location.toLowerCase().includes(searchTerm));
                });
            }
            
            if (propertyType) {
                properties = properties.filter(function(p) {
                    return (p.type && p.type.toLowerCase() === propertyType) || 
                           (p.title && p.title.toLowerCase().includes(propertyType));
                });
            }
            
            if (priceRange) {
                var range = priceRange.split('-');
                var min = parseInt(range[0]);
                var max = parseInt(range[1]);
                properties = properties.filter(function(p) {
                    return p.price >= min && p.price <= max;
                });
            }
            
            if (bedrooms > 0) {
                properties = properties.filter(function(p) {
                    return p.bedrooms >= bedrooms;
                });
            }
            
            // Apply sorting
            if (sortBy === 'price-asc') {
                properties.sort(function(a, b) {
                    return a.price - b.price;
                });
            } else if (sortBy === 'price-desc') {
                properties.sort(function(a, b) {
                    return b.price - a.price;
                });
            }
            
            // Re-render properties
            renderProperties(properties);
        }
        
        // Render the filtered properties
        function renderProperties(properties) {
            var propertyGrid = document.getElementById('propertyGrid');
            propertyGrid.innerHTML = '';
            
            if (properties.length === 0) {
                propertyGrid.innerHTML = '<div class="col-12 text-center p-5"><h3>No properties found matching your criteria</h3></div>';
                return;
            }
            
            for (var i = 0; i < properties.length; i++) {
                var property = properties[i];
                var propertyCard = document.createElement('div');
                propertyCard.className = 'property-card';
                
                // Handle missing properties with defaults
                var title = property.title || 'Untitled Property';
                var price = property.price || 0;
                var currency = '$'; // Default currency
                var status = property.status ? property.status.toLowerCase() : 'sale';
                var priceInterval = status === 'rent' ? '/month' : '';
                var location = property.location || 'Location not specified';
                var beds = property.bedrooms || 0;
                var baths = property.bathrooms || 0;
                var area = property.squareFeet || 0;
                var areaUnit = 'sqft';
                var amenities = property.amenities || [];
                var images = property.images || ['https://images.unsplash.com/photo-1560518883-ce09059eeffa?auto=format&fit=crop&w=1200&q=80'];
                
                // Create image slider
                var imagesHTML = '<div class="splide"><div class="splide__track"><ul class="splide__list">';
                for (var j = 0; j < images.length; j++) {
                    var imgUrl = images[j];
                    
                    // FIXED IMAGE URL PROCESSING in JavaScript rendering
                    if (typeof imgUrl === 'string') {
                        if (imgUrl.startsWith("http")) {
                            // External URL - keep as is
                            if (!imgUrl.includes("?")) {
                                // Add parameters if not present
                                imgUrl += "?auto=format&fit=crop&w=1200&q=80";
                            }
                        } else if (imgUrl.includes("property-images/")) {
                            // THIS IS THE IMPORTANT FIX FOR LOCAL PROPERTY IMAGES
                            // Extract the path after "property-images/"
                            let imagePath = imgUrl;
                            if (imgUrl.startsWith("/")) {
                                imagePath = imgUrl.substring(1);
                            }
                            if (!imagePath.startsWith("property-images/")) {
                                imagePath = "property-images/" + imagePath;
                            }
                            // If it starts with "property-images/", extract the part after it
                            if (imagePath.startsWith("property-images/")) {
                                let pathPart = imagePath.substring("property-images/".length());
                                imgUrl = contextPath + "/propertyImage/" + pathPart;
                            } else {
                                imgUrl = contextPath + "/propertyImage/" + imagePath;
                            }
                        } else if (imgUrl.startsWith("/")) {
                            // Regular web app resources - just add context path
                            imgUrl = contextPath + imgUrl;
                        } else {
                            // Add leading slash and context path
                            imgUrl = contextPath + "/" + imgUrl;
                        }
                    }
                    
                    imagesHTML += '<li class="splide__slide">' +
                               '<img src="' + imgUrl + '" alt="' + title + ' Image ' + (j+1) + '" ' +
                               'onerror="this.src=\'https://via.placeholder.com/800x600?text=Image+Not+Available\'">' +
                               '</li>';
                }
                imagesHTML += '</ul></div></div>';
                
                // Create price and status badges
                var statusCapitalized = status.charAt(0).toUpperCase() + status.slice(1);
                var amenitiesHTML = '';
                
                // Create amenities HTML
                for (var k = 0; k < amenities.length; k++) {
                    amenitiesHTML += '<span class="amenity-tag">' + amenities[k] + '</span>';
                }
                
                var propertyHtml = 
                    imagesHTML +
                    '<div class="price-badge">' + currency + price + priceInterval + '</div>' +
                    '<div class="status-badge status-' + status + '">For ' + statusCapitalized + '</div>' +
                    '<div class="property-info">' +
                        '<h3 class="property-title">' + title + '</h3>' +
                        '<div class="property-location">' +
                            '<i class="fas fa-map-marker-alt text-accent-cyan"></i> ' +
                            location +
                        '</div>' +
                        '<div class="property-details">' +
                            '<div class="detail-item">' +
                                '<i class="fas fa-bed text-accent-blue"></i> ' +
                                beds + ' ' + (beds > 1 ? "Beds" : "Bed") +
                            '</div>' +
                            '<div class="detail-item">' +
                                '<i class="fas fa-bath text-accent-blue"></i> ' +
                                baths + ' ' + (baths > 1 ? "Baths" : "Bath") +
                            '</div>' +
                            '<div class="detail-item">' +
                                '<i class="fas fa-ruler-combined text-accent-blue"></i> ' +
                                area + ' ' + areaUnit +
                            '</div>' +
                        '</div>' +
                        '<div class="mt-3">' +
                            amenitiesHTML +
                        '</div>' +
                    '</div>';
                
                propertyCard.innerHTML = propertyHtml;
                propertyGrid.appendChild(propertyCard);
            }
            
            // Reinitialize the sliders
            initSpliders();
        }
        
        // Toggle debug info visibility
        function toggleDebugInfo() {
            const debugInfo = document.querySelector('.debug-info');
            if (debugInfo) {
                debugInfo.style.display = debugInfo.style.display === 'none' ? 'block' : 'none';
            }
        }
        
        // You can toggle the debug info by pressing Ctrl+Shift+D
        document.addEventListener('keydown', function(e) {
            if (e.ctrlKey && e.shiftKey && e.key === 'D') {
                toggleDebugInfo();
            }
        });
    </script>
</body>
</html>