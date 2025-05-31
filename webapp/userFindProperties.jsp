<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*, java.nio.file.*, com.google.gson.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Property Finder</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="findPropertiesUser.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <style>
        /* Additional styles for property cards */
        .property-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border-radius: 10px;
            overflow: hidden;
            height: 100%;
            border: 1px solid #e0e0e0;
        }
        
        .property-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        
        .property-img {
            height: 200px;
            object-fit: cover;
            width: 100%;
        }
        
        .status-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .status-sale, .status-Active {
            background-color: rgba(25, 135, 84, 0.85);
            color: white;
        }
        
        .status-rent {
            background-color: rgba(13, 110, 253, 0.85);
            color: white;
        }
        
        .price-tag {
            font-size: 1.25rem;
            font-weight: 700;
            color: #0d6efd;
        }
        
        .amenity-tag {
            background: rgba(13, 110, 253, 0.1);
            color: #0d6efd;
            padding: 0.25rem 0.5rem;
            border-radius: 15px;
            font-size: 0.75rem;
            display: inline-block;
            margin: 0.25rem;
            border: 1px solid rgba(13, 110, 253, 0.2);
        }
        
        .hero-section {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('https://images.unsplash.com/photo-1560518883-ce09059eeffa?auto=format&fit=crop&w=1200&q=80');
            background-size: cover;
            background-position: center;
            padding: 100px 0;
        }
        
        .filter-card {
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        
        .dashboard-btn {
            position: fixed;
            top: 20px;
            left: 20px;
            background: #0d6efd;
            color: white;
            padding: 10px 15px;
            border-radius: 50px;
            text-decoration: none;
            z-index: 1000;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            display: flex;
            align-items: center;
            transition: all 0.3s ease;
        }
        
        .dashboard-btn:hover {
            background: #0b5ed7;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            color: white;
        }
        
        .modal-content {
            border-radius: 15px;
            overflow: hidden;
        }
        
        /* Loader animation */
        .loader {
            border: 5px solid #f3f3f3;
            border-radius: 50%;
            border-top: 5px solid #0d6efd;
            width: 50px;
            height: 50px;
            animation: spin 1s linear infinite;
            margin: 20px auto;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        .debug-info {
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            padding: 10px;
            margin-bottom: 20px;
            font-family: monospace;
            font-size: 0.8rem;
        }
        
        /* Pagination styles */
        .pagination-container {
            display: flex;
            justify-content: center;
            margin-top: 30px;
            margin-bottom: 20px;
        }
        
        .pagination-btn {
            padding: 8px 15px;
            margin: 0 5px;
            border-radius: 5px;
            border: none;
            background-color: #0d6efd;
            color: white;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .pagination-btn:hover {
            background-color: #0b5ed7;
            transform: translateY(-2px);
        }
        
        .pagination-btn:disabled {
            background-color: #6c757d;
            cursor: not-allowed;
            opacity: 0.6;
            transform: none;
        }
        
        .page-info {
            display: flex;
            align-items: center;
            margin: 0 10px;
            font-weight: 500;
        }
        
        .featured-badge {
            position: absolute;
            top: 10px;
            left: 10px;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            background-color: rgba(255, 193, 7, 0.85);
            color: #212529;
        }
        
        .file-error {
            border: 1px solid #f8d7da;
            background-color: #f8d7da;
            color: #842029;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <%!
        // Helper methods for safely handling JSON elements that might be null
        public String getStringFromJson(JsonObject obj, String key, String defaultValue) {
            if (obj == null || !obj.has(key) || obj.get(key).isJsonNull()) {
                return defaultValue;
            }
            return obj.get(key).getAsString();
        }
        
        public int getIntFromJson(JsonObject obj, String key, int defaultValue) {
            if (obj == null || !obj.has(key) || obj.get(key).isJsonNull()) {
                return defaultValue;
            }
            return obj.get(key).getAsInt();
        }
        
        public double getDoubleFromJson(JsonObject obj, String key, double defaultValue) {
            if (obj == null || !obj.has(key) || obj.get(key).isJsonNull()) {
                return defaultValue;
            }
            return obj.get(key).getAsDouble();
        }
        
        public boolean getBooleanFromJson(JsonObject obj, String key, boolean defaultValue) {
            if (obj == null || !obj.has(key) || obj.get(key).isJsonNull()) {
                return defaultValue;
            }
            return obj.get(key).getAsBoolean();
        }
        
        public JsonArray getArrayFromJson(JsonObject obj, String key) {
            if (obj == null || !obj.has(key) || obj.get(key).isJsonNull()) {
                return new JsonArray();
            }
            return obj.get(key).getAsJsonArray();
        }
    %>
    
    <%
        // Set current date/time and user information based on user's provided data
        String currentDateTime = "2025-05-04 15:47:35"; // Updated timestamp from the user
        String currentUser = "IT24103866"; // Updated login from the user
        
        // Get context path for image URL resolution
        String contextPath = request.getContextPath();
        
        // Pagination parameters
        int itemsPerPage = 6; // Number of properties per page
        int currentPage = 1; // Default to first page
        
        // Try to get page parameter from URL
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam);
                if (currentPage < 1) currentPage = 1;
            } catch (NumberFormatException e) {
                // Invalid page number, stick with default
                currentPage = 1;
            }
        }
        
        // Read the properties.json file using the specific path provided
        String jsonDataString = "";
        String fileErrorMessage = null;
        String filePath = "C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\data\\properties.json";
        
        try {
            // Try to read the properties.json file from the specified path
            File jsonFile = new File(filePath);
            
            if (jsonFile.exists()) {
                // Read the file line by line
                BufferedReader reader = new BufferedReader(new FileReader(jsonFile));
                StringBuilder jsonBuilder = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    jsonBuilder.append(line).append("\n");
                }
                reader.close();
                
                jsonDataString = jsonBuilder.toString();
            } else {
                fileErrorMessage = "Properties file not found at the specified path: " + filePath;
            }
        } catch (Exception e) {
            fileErrorMessage = "Error reading properties file: " + e.getMessage();
            e.printStackTrace();
        }
        
        // If we couldn't read the file or it doesn't exist, display an error
        if (jsonDataString.isEmpty()) {
            if (fileErrorMessage == null) {
                fileErrorMessage = "Properties file is empty or could not be read";
            }
        }
        
        // Parse the JSON data
        JsonObject jsonData = null;
        try {
            if (!jsonDataString.isEmpty()) {
                Gson gson = new Gson();
                jsonData = gson.fromJson(jsonDataString, JsonObject.class);
            }
        } catch (Exception e) {
            fileErrorMessage = "Error parsing JSON data: " + e.getMessage();
            e.printStackTrace();
        }
        
        // Get total number of properties
        int totalProperties = 0;
        if (jsonData != null && jsonData.has("properties")) {
            totalProperties = jsonData.getAsJsonArray("properties").size();
        }
        
        // Calculate total pages needed
        int totalPages = (int) Math.ceil((double) totalProperties / itemsPerPage);
        if (totalPages == 0) totalPages = 1; // Ensure at least one page even with no properties
        
        // Make sure currentPage is not higher than totalPages
        if (currentPage > totalPages) {
            currentPage = totalPages;
        }
        
        // Calculate the start and end indexes for properties to display on the current page
        int startIndex = (currentPage - 1) * itemsPerPage;
        int endIndex = Math.min(startIndex + itemsPerPage, totalProperties);
    %>

    <!-- Back to Dashboard Button -->
    <a href="userDashboard.jsp" class="dashboard-btn">
        <i class="fas fa-tachometer-alt me-2"></i>
        <span>Back to Dashboard</span>
    </a>

    <!-- Hero Section -->
    <div class="container-fluid hero-section py-5 text-white text-center">
        <h1>Find Your Dream Property</h1>
        <p class="lead">Browse our collection of properties</p>
    </div>

    <!-- Filter Section -->
    <div class="container mt-4 mb-4">
        <div class="card filter-card">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0">Filter Properties</h5>
            </div>
            <div class="card-body">
                <form id="filterForm">
                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <label for="propertyType" class="form-label">Property Type</label>
                            <select class="form-select" id="propertyType" name="propertyType">
                                <option value="">All Types</option>
                                <option value="apartment">Apartment</option>
                                <option value="house">House</option>
                                <option value="villa">Villa</option>
                                <option value="commercial">Commercial</option>
                            </select>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label for="priceRange" class="form-label">Price Range</label>
                            <select class="form-select" id="priceRange" name="priceRange">
                                <option value="">All Prices</option>
                                <option value="0-50000">$0 - $50,000</option>
                                <option value="50000-100000">$50,000 - $100,000</option>
                                <option value="100000-200000">$100,000 - $200,000</option>
                                <option value="200000-500000">$200,000 - $500,000</option>
                                <option value="500000-plus">$500,000+</option>
                            </select>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label for="bedrooms" class="form-label">Bedrooms</label>
                            <select class="form-select" id="bedrooms" name="bedrooms">
                                <option value="">Any</option>
                                <option value="1">1+</option>
                                <option value="2">2+</option>
                                <option value="3">3+</option>
                                <option value="4">4+</option>
                                <option value="5">5+</option>
                            </select>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label for="location" class="form-label">Location</label>
                            <select class="form-select" id="location" name="location">
                                <option value="">All Locations</option>
                                <option value="colombo">Colombo</option>
                                <option value="nugegoda">Nugegoda</option>
                                <option value="pannipitiya">Pannipitiya</option>
                                <option value="kottawa">Kottawa</option>
                                <option value="beverly hills">Beverly Hills</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <button type="button" id="applyFilters" class="btn btn-primary">Apply Filters</button>
                            <button type="button" id="resetFilters" class="btn btn-outline-secondary">Reset</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <% if (fileErrorMessage != null) { %>
    <div class="container">
        <div class="alert alert-danger" role="alert">
            <h4><i class="bi bi-exclamation-triangle"></i> Error Reading Properties File</h4>
            <p><%= fileErrorMessage %></p>
            <hr>
            <p>Please make sure the properties.json file exists and is accessible. The application is looking for the file at: <%= filePath %></p>
        </div>
    </div>
    <% } %>

    <!-- Debug Info -->
    <div class="container">
        <div class="debug-info">
            <h6>Debug Information:</h6>
            <p>Context Path: <%= contextPath %><br>
            Current Date: <%= currentDateTime %><br>
            Current User: <%= currentUser %></p>
            <p>File Path: <%= filePath %></p>
            <p>Total Properties: <%= totalProperties %> | Page: <%= currentPage %> of <%= totalPages %> | Items Per Page: <%= itemsPerPage %></p>
            <% if (jsonData != null) { %>
                <p>Last Updated: <%= getStringFromJson(jsonData, "lastUpdated", "Unknown") %> by <%= getStringFromJson(jsonData, "lastUpdatedBy", "Unknown") %></p>
            <% } else { %>
                <p>JSON Data: Not available</p>
            <% } %>
        </div>
    </div>

    <!-- Properties Section -->
    <div class="container mt-4">
        <h2 class="mb-4">Available Properties (<%= totalProperties %> listings)</h2>
        <div class="row" id="propertyList">
            <% 
                if (jsonData != null && jsonData.has("properties")) {
                    JsonArray properties = jsonData.getAsJsonArray("properties");
                    
                    if (properties.size() == 0) {
            %>
                        <div class="col-12 text-center py-5">
                            <h4>No properties found</h4>
                            <p>There are currently no properties available in the system.</p>
                        </div>
            <%
                    } else {
                        // Display only the properties for the current page
                        for (int i = startIndex; i < endIndex; i++) {
                            try {
                                JsonObject property = properties.get(i).getAsJsonObject();
                                
                                // Safely get properties with null checks using our helper methods
                                String propertyId = getStringFromJson(property, "propertyId", "PROP" + i);
                                String title = getStringFromJson(property, "title", "Untitled Property");
                                double priceVal = getDoubleFromJson(property, "price", 0.0);
                                int price = (int) priceVal;
                                String currency = "$"; // Default currency
                                String status = getStringFromJson(property, "status", "Active").toLowerCase();
                                String priceInterval = status.equals("rent") ? "/month" : "";
                                String location = getStringFromJson(property, "location", "Location not specified");
                                int beds = getIntFromJson(property, "bedrooms", 0);
                                int baths = getIntFromJson(property, "bathrooms", 0);
                                double areaVal = getDoubleFromJson(property, "squareFeet", 0.0);
                                int area = (int) areaVal;
                                String description = getStringFromJson(property, "description", "No description available");
                                boolean featured = getBooleanFromJson(property, "featured", false);
                                String type = getStringFromJson(property, "type", "Not specified");
                                
                                JsonArray amenities = getArrayFromJson(property, "amenities");
                                JsonArray images = getArrayFromJson(property, "images");
                                
                                // Get the first image or a default one
                                String mainImageUrl = "https://via.placeholder.com/800x600?text=No+Image+Available";
                                if (images.size() > 0) {
                                    String imgUrl = images.get(0).getAsString();
                                    
                                    // Process image URL
                                    if (imgUrl.startsWith("http")) {
                                        // External URL - keep as is
                                        mainImageUrl = imgUrl;
                                    } else if (imgUrl.contains("property-images/")) {
                                        // Local images via servlet
                                        String imagePath = imgUrl;
                                        if (imgUrl.startsWith("/")) {
                                            imagePath = imgUrl.substring(1);
                                        }
                                        if (!imagePath.startsWith("property-images/")) {
                                            imagePath = "property-images/" + imagePath;
                                        }
                                        
                                        if (imagePath.startsWith("property-images/")) {
                                            String pathPart = imagePath.substring("property-images/".length());
                                            mainImageUrl = request.getContextPath() + "/propertyImage/" + pathPart;
                                        } else {
                                            mainImageUrl = request.getContextPath() + "/propertyImage/" + imagePath;
                                        }
                                    } else if (imgUrl.startsWith("/")) {
                                        mainImageUrl = request.getContextPath() + imgUrl;
                                    } else {
                                        mainImageUrl = request.getContextPath() + "/" + imgUrl;
                                    }
                                }
            %>
            <div class="col-md-4 mb-4">
                <div class="card property-card">
                    <div class="position-relative">
                        <img src="<%= mainImageUrl %>" 
                             alt="<%= title %>" 
                             class="property-img"
                             onerror="this.src='https://via.placeholder.com/800x600?text=Image+Not+Available'">
                        <div class="status-badge status-<%= status %>">
                            <%= status.substring(0, 1).toUpperCase() + status.substring(1) %>
                        </div>
                        <% if (featured) { %>
                            <div class="featured-badge">
                                <i class="bi bi-star-fill"></i> Featured
                            </div>
                        <% } %>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title"><%= title %></h5>
                        <p class="card-text"><i class="bi bi-geo-alt-fill text-primary"></i> <%= location %></p>
                        <p class="price-tag"><%= currency %><%= String.format("%,d", price) %><%= priceInterval %></p>
                        
                        <div class="d-flex justify-content-between mb-3">
                            <span><i class="bi bi-door-open"></i> <%= beds %> Beds</span>
                            <span><i class="bi bi-droplet-fill"></i> <%= baths %> Baths</span>
                            <span><i class="bi bi-rulers"></i> <%= area %> sqft</span>
                        </div>
                        
                        <p class="text-muted small mb-2"><i class="bi bi-building"></i> <%= type %></p>
                        
                        <div class="mb-3">
                            <% for(int j = 0; j < Math.min(3, amenities.size()); j++) { %>
                                <span class="amenity-tag"><%= amenities.get(j).getAsString() %></span>
                            <% } %>
                            <% if(amenities.size() > 3) { %>
                                <span class="amenity-tag">+<%= amenities.size() - 3 %> more</span>
                            <% } %>
                        </div>
                        
                        <button type="button" class="btn btn-primary w-100 view-details" 
                                data-property-id="<%= propertyId %>">
                            View Details
                        </button>
                    </div>
                </div>
            </div>
            <%
                            } catch (Exception e) {
                                // Skip any property that causes an error and log it
                                System.out.println("Error processing property: " + e.getMessage());
                                e.printStackTrace();
                                continue;
                            }
                        }
                    }
                } else {
            %>
                <div class="col-12 text-center py-5">
                    <h4>No properties data available</h4>
                    <p>Please check that the properties.json file exists and is formatted correctly.</p>
                </div>
            <%
                }
            %>
        </div>
        
        <!-- Pagination Controls -->
        <% if (totalProperties > 0) { %>
        <div class="pagination-container">
            <form id="paginationForm" method="get" action="userFindProperties.jsp">
                <button type="button" class="pagination-btn" id="prevPageBtn" 
                        <% if(currentPage <= 1) { %>disabled<% } %>
                        onclick="navigateToPage(<%= currentPage - 1 %>)">
                    <i class="bi bi-chevron-left"></i> Previous
                </button>
                
                <span class="page-info">Page <%= currentPage %> of <%= totalPages %></span>
                
                <button type="button" class="pagination-btn" id="nextPageBtn"
                        <% if(currentPage >= totalPages) { %>disabled<% } %>
                        onclick="navigateToPage(<%= currentPage + 1 %>)">
                    Next <i class="bi bi-chevron-right"></i>
                </button>
                
                <!-- Hidden input field to store the page number -->
                <input type="hidden" name="page" id="pageInput" value="<%= currentPage %>">
            </form>
        </div>
        <% } %>
    </div>

    <!-- Property Detail Modal -->
    <div class="modal fade" id="propertyModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="modalPropertyTitle">Property Details</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="propertyDetails">
                    <!-- Property details will be loaded here dynamically -->
                    <div class="text-center py-3">
                        <div class="spinner-border text-primary" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="contactAgentBtn">Contact Agent</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Agent Contact Modal -->
    <div class="modal fade" id="agentModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">Contact Agent</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div id="agentInfo" class="mb-3">
                        <!-- Agent info will be loaded here -->
                    </div>
                    <div class="mb-3">
                        <div class="session-info mb-2">
                            <small class="text-muted">
                                <i class="bi bi-clock"></i> Session time: <span id="sessionTimestamp"><%= currentDateTime %></span> |
                                <i class="bi bi-person-badge"></i> User ID: <span id="sessionUserId"><%= currentUser %></span>
                            </small>
                        </div>
                        <div class="alert alert-info">
                            <small>
                                Your message will be sent as <%= currentUser %>. The agent will respond to your registered email.
                            </small>
                        </div>
                    </div>
                    <form id="contactForm">
                        <div class="mb-3">
                            <label for="name" class="form-label">Your Name</label>
                            <input type="text" class="form-control" id="name" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Your Email</label>
                            <input type="email" class="form-control" id="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="phone" class="form-label">Your Phone</label>
                            <input type="text" class="form-control" id="phone">
                        </div>
                        <div class="mb-3">
                            <label for="message" class="form-label">Message</label>
                            <textarea class="form-control" id="message" rows="3" required></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="sendMessageBtn">Send Message</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <h5>PropertyFinder</h5>
                    <p>Your trusted real estate partner.</p>
                </div>
                <div class="col-md-3">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-white">Home</a></li>
                        <li><a href="#" class="text-white">Properties</a></li>
                        <li><a href="#" class="text-white">Agents</a></li>
                        <li><a href="#" class="text-white">Contact</a></li>
                    </ul>
                </div>
                <div class="col-md-3">
                    <h5>Contact Us</h5>
                    <address>
                        <p>123 Main Street<br>City, State 12345<br>Phone: (123) 456-7890<br>Email: info@propertyfinder.com</p>
                    </address>
                </div>
                <div class="col-md-3">
                    <h5>Follow Us</h5>
                    <div class="d-flex gap-3">
                        <a href="#" class="text-white"><i class="bi bi-facebook"></i></a>
                        <a href="#" class="text-white"><i class="bi bi-twitter"></i></a>
                        <a href="#" class="text-white"><i class="bi bi-instagram"></i></a>
                        <a href="#" class="text-white"><i class="bi bi-linkedin"></i></a>
                    </div>
                </div>
            </div>
            <hr>
            <div class="text-center">
                <p>&copy; 2025 PropertyFinder. All rights reserved.</p>
                <p class="small text-muted">Current User: <%= currentUser %> | Date: <%= currentDateTime %></p>
            </div>
        </div>
    </footer>

    <script>
        // Store properties as a JavaScript variable for easy filtering
        var allProperties = <%= (jsonData != null) ? jsonData.toString() : "{\"properties\": []}" %>;
        var contextPath = '<%= contextPath %>';
        var currentDateTime = '<%= currentDateTime %>';
        var currentUser = '<%= currentUser %>';
        var currentPage = <%= currentPage %>;
        var totalPages = <%= totalPages %>;
        var itemsPerPage = <%= itemsPerPage %>;
        
        // Helper function to safely get a property value
        function safeGet(obj, prop, defaultVal) {
            if (!obj || obj[prop] === undefined || obj[prop] === null) {
                return defaultVal;
            }
            return obj[prop];
        }
        
        // Function to navigate to a specific page
        function navigateToPage(pageNum) {
            if (pageNum < 1 || pageNum > totalPages) {
                return;
            }
            
            document.getElementById('pageInput').value = pageNum;
            document.getElementById('paginationForm').submit();
        }
        
        $(document).ready(function() {
            console.log("Document ready, loading properties...");
            console.log("Found " + (allProperties.properties ? allProperties.properties.length : 0) + " properties");
            
            // Handle view details buttons
            $('.view-details').on('click', function() {
                var propertyId = $(this).data('property-id');
                showPropertyDetails(propertyId);
            });
            
            // Apply filters button
            $('#applyFilters').on('click', function() {
                filterProperties();
            });
            
            // Reset filters button
            $('#resetFilters').on('click', function() {
                $('#filterForm')[0].reset();
                filterProperties();
            });
            
            // Contact agent button
            $('#contactAgentBtn').on('click', function() {
                $('#propertyModal').modal('hide');
                $('#agentModal').modal('show');
            });
            
            // Send message button
            $('#sendMessageBtn').on('click', function() {
                if (validateContactForm()) {
                    sendAgentMessage();
                }
            });
            
            // Initialize date and user info in the agent contact modal
            $('#sessionTimestamp').text(currentDateTime);
            $('#sessionUserId').text(currentUser);
        });
        
        function showPropertyDetails(propertyId) {
            console.log("Showing details for property:", propertyId);
            
            // Find the property in the data
            var property = null;
            if (allProperties.properties) {
                for (var i = 0; i < allProperties.properties.length; i++) {
                    if (allProperties.properties[i].propertyId === propertyId) {
                        property = allProperties.properties[i];
                        break;
                    }
                }
            }
            
            if (!property) {
                console.error("Property not found:", propertyId);
                return;
            }
            
            // Set modal title
            $('#modalPropertyTitle').text(safeGet(property, "title", 'Property Details'));
            
            // Prepare property details HTML
            var detailsHtml = '<div class="property-modal-content">' +
                '<div id="propertyCarousel" class="carousel slide mb-4" data-bs-ride="carousel">' +
                '<div class="carousel-inner">';
            
            // Add carousel images
            if (property.images && property.images.length > 0) {
                for (var i = 0; i < property.images.length; i++) {
                    var image = property.images[i];
                    var imgUrl = '';
                    
                    // Process image URL
                    if (image.startsWith("http")) {
                        // External URL - keep as is
                        imgUrl = image;
                    } else if (image.includes("property-images/")) {
                        // Local images via servlet
                        var imagePath = image;
                        if (image.startsWith('/')) {
                            imagePath = image.substring(1);
                        }
                        if (!imagePath.startsWith('property-images/')) {
                            imagePath = 'property-images/' + imagePath;
                        }
                        if (imagePath.startsWith('property-images/')) {
                            var pathPart = imagePath.substring('property-images/'.length);
                            imgUrl = contextPath + '/propertyImage/' + pathPart;
                        } else {
                            imgUrl = contextPath + '/propertyImage/' + imagePath;
                        }
                    } else {
                        // Other paths
                        imgUrl = contextPath + (image.startsWith('/') ? '' : '/') + image;
                    }
                    
                    // Add class="active" only to the first carousel item
                    var activeClass = i === 0 ? ' active' : '';
                    detailsHtml += '<div class="carousel-item' + activeClass + '">' +
                        '<img src="' + imgUrl + '" class="d-block w-100" alt="' + (safeGet(property, "title", 'Property')) + ' image ' + (i + 1) + '"' +
                        ' style="height: 400px; object-fit: cover;"' +
                        ' onerror="this.src=\'https://via.placeholder.com/800x400?text=Image+Not+Available\'">' +
                        '</div>';
                }
            } else {
                detailsHtml += '<div class="carousel-item active">' +
                    '<img src="https://via.placeholder.com/800x400?text=No+Images+Available" class="d-block w-100" alt="No Image Available"' +
                    ' style="height: 400px; object-fit: cover;">' +
                    '</div>';
            }
            
            // Add carousel controls if there are multiple images
            if (property.images && property.images.length > 1) {
                detailsHtml += '</div>' +
                    '<button class="carousel-control-prev" type="button" data-bs-target="#propertyCarousel" data-bs-slide="prev">' +
                    '<span class="carousel-control-prev-icon" aria-hidden="true"></span>' +
                    '<span class="visually-hidden">Previous</span>' +
                    '</button>' +
                    '<button class="carousel-control-next" type="button" data-bs-target="#propertyCarousel" data-bs-slide="next">' +
                    '<span class="carousel-control-next-icon" aria-hidden="true"></span>' +
                    '<span class="visually-hidden">Next</span>' +
                    '</button>' +
                    '</div>';
            } else {
                detailsHtml += '</div>' +
                    '</div>';
            }
            
            // Add property information
            var status = safeGet(property, "status", "Active");
            var priceExtra = (status.toLowerCase() === "rent") ? "/month" : "";
            detailsHtml += '<div class="row">' +
                '<div class="col-md-8">' +
                '<h4>' + safeGet(property, "title", 'Untitled Property') + '</h4>' +
                '<p class="text-muted"><i class="bi bi-geo-alt-fill"></i> ' + safeGet(property, "location", 'Location not specified') + '</p>' +
                '<h5 class="text-primary">$' + safeGet(property, "price", 0).toLocaleString() + priceExtra + '</h5>' +
                '<hr>' +
                '<h5>Description</h5>' +
                '<p>' + safeGet(property, "description", 'No description available.') + '</p>' +
                '</div>' +
                '<div class="col-md-4">' +
                '<div class="card">' +
                '<div class="card-header bg-primary text-white">Property Details</div>' +
                '<ul class="list-group list-group-flush">' +
                '<li class="list-group-item"><b>Property ID:</b> ' + safeGet(property, "propertyId", 'Not specified') + '</li>' +
                '<li class="list-group-item"><b>Type:</b> ' + safeGet(property, "type", 'Not specified') + '</li>' +
                '<li class="list-group-item"><b>Status:</b> ' + safeGet(property, "status", 'Not specified') + '</li>' +
                '<li class="list-group-item"><b>Bedrooms:</b> ' + safeGet(property, "bedrooms", 0) + '</li>' +
                '<li class="list-group-item"><b>Bathrooms:</b> ' + safeGet(property, "bathrooms", 0) + '</li>' +
                '<li class="list-group-item"><b>Area:</b> ' + safeGet(property, "squareFeet", 0) + ' sqft</li>' +
                '<li class="list-group-item"><b>Listed:</b> ' + safeGet(property, "createdDate", 'Not specified') + '</li>';
                
                if (property.featured) {
                    detailsHtml += '<li class="list-group-item"><b>Featured:</b> <span class="badge bg-warning text-dark">Yes</span></li>';
                }
                
                detailsHtml += '</ul>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '<hr>' +
                '<div class="amenities mt-3">' +
                '<h5>Amenities</h5>' +
                '<div class="row">';
            
            // Add amenities
            if (property.amenities && property.amenities.length > 0) {
                for (var i = 0; i < property.amenities.length; i++) {
                    var amenity = property.amenities[i];
                    detailsHtml += '<div class="col-md-4 mb-2">' +
                        '<i class="bi bi-check-circle-fill text-success"></i> ' + amenity +
                        '</div>';
                }
            } else {
                detailsHtml += '<div class="col-12">No amenities specified.</div>';
            }
            
            detailsHtml += '</div>' +
                '</div>' +
                '<hr>' +
                '<div class="agent-info mt-3">' +
                '<h5>Agent Information</h5>' +
                '<div class="d-flex align-items-center">' +
                '<div class="flex-shrink-0">' +
                '<img src="https://via.placeholder.com/80x80" class="rounded-circle" alt="Agent" width="80">' +
                '</div>' +
                '<div class="flex-grow-1 ms-3">' +
                '<h6>' + safeGet(property, "agentId", 'Agent information not available') + '</h6>' +
                '<p class="mb-0"><i class="bi bi-telephone"></i> Contact via button below</p>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div>';
            
            // Update modal content and show it
            $('#propertyDetails').html(detailsHtml);
            
            // Store the current property ID for the agent contact form
            $('#contactAgentBtn').data('property-id', propertyId);
            
            // Show the modal
            $('#propertyModal').modal('show');
            
            // Initialize the carousel
            if (property.images && property.images.length > 1) {
                var propertyCarousel = new bootstrap.Carousel(document.getElementById('propertyCarousel'), {
                    interval: 5000
                });
            }
        }
        
        function filterProperties() {
            var propertyType = $('#propertyType').val().toLowerCase();
            var priceRange = $('#priceRange').val();
            var minBedrooms = parseInt($('#bedrooms').val()) || 0;
            var locationFilter = $('#location').val().toLowerCase();
            
            // Parse price range
            var minPrice = 0;
            var maxPrice = Infinity;
            
            if (priceRange) {
                var parts = priceRange.split('-');
                if (parts.length === 2) {
                    minPrice = parseInt(parts[0]);
                    if (parts[1] !== 'plus') {
                        maxPrice = parseInt(parts[1]);
                    }
                }
            }
            
            // Filter properties
            var filteredProperties = [];
            if (allProperties.properties) {
                for (var i = 0; i < allProperties.properties.length; i++) {
                    var property = allProperties.properties[i];
                    var include = true;
                    
                    // Filter by property type (safely)
                    if (propertyType && safeGet(property, "type", "").toLowerCase() !== propertyType && propertyType !== "") {
                        include = false;
                    }
                    
                    // Filter by price
                    if (safeGet(property, "price", 0) < minPrice || safeGet(property, "price", 0) > maxPrice) {
                        include = false;
                    }
                    
                    // Filter by bedrooms
                    if (minBedrooms > 0 && safeGet(property, "bedrooms", 0) < minBedrooms) {
                        include = false;
                    }
                    
                    // Filter by location (contains search)
                    if (locationFilter && !safeGet(property, "location", "").toLowerCase().includes(locationFilter) && locationFilter !== "") {
                        include = false;
                    }
                    
                    if (include) {
                        filteredProperties.push(property);
                    }
                }
            }
            
            // Reset to page 1 for filtered results
            currentPage = 1;
            
            // Recalculate total pages for filtered results
            totalPages = Math.ceil(filteredProperties.length / itemsPerPage);
            if (totalPages === 0) totalPages = 1;
            
            // Calculate pagination indexes for filtered results
            var startIndex = (currentPage - 1) * itemsPerPage;
            var endIndex = Math.min(startIndex + itemsPerPage, filteredProperties.length);
            
            // Get only the properties for the current page
            var paginatedProperties = [];
            for (var i = startIndex; i < endIndex; i++) {
                if (i < filteredProperties.length) {
                    paginatedProperties.push(filteredProperties[i]);
                }
            }
            
            // Rebuild the property list
            rebuildPropertyList(paginatedProperties, filteredProperties.length);
            
            // Update pagination controls
            updatePaginationControls(filteredProperties.length);
        }
        
        function updatePaginationControls(totalItems) {
            var totalPages = Math.ceil(totalItems / itemsPerPage);
            if (totalPages === 0) totalPages = 1;
            
            // Update the page info text
            $('.page-info').text('Page ' + currentPage + ' of ' + totalPages);
            
            // Enable/disable previous button
            $('#prevPageBtn').prop('disabled', currentPage <= 1);
            
            // Enable/disable next button
            $('#nextPageBtn').prop('disabled', currentPage >= totalPages);
        }
        
        function rebuildPropertyList(properties, totalCount) {
            var propertyList = $('#propertyList');
            propertyList.empty();
            
            if (properties.length === 0) {
                propertyList.html('<div class="col-12 text-center py-5"><h4>No properties found matching your criteria</h4></div>');
                return;
            }
            
            // Add each property to the list
            for (var i = 0; i < properties.length; i++) {
                var property = properties[i];
                
                // Get main image
                var mainImageUrl = "https://via.placeholder.com/800x600?text=No+Image+Available";
                if (property.images && property.images.length > 0) {
                    var imgUrl = property.images[0];
                    
                    // Process image URL
                    if (imgUrl.startsWith("http")) {
                        mainImageUrl = imgUrl;
                    } else if (imgUrl.includes("property-images/")) {
                        var imagePath = imgUrl;
                        if (imgUrl.startsWith('/')) {
                            imagePath = imgUrl.substring(1);
                        }
                        if (!imagePath.startsWith('property-images/')) {
                            imagePath = 'property-images/' + imagePath;
                        }
                        
                        if (imagePath.startsWith('property-images/')) {
                            var pathPart = imagePath.substring('property-images/'.length);
                            mainImageUrl = contextPath + '/propertyImage/' + pathPart;
                        } else {
                            mainImageUrl = contextPath + '/propertyImage/' + imagePath;
                        }
                    } else if (imgUrl.startsWith('/')) {
                        mainImageUrl = contextPath + imgUrl;
                    } else {
                        mainImageUrl = contextPath + '/' + imgUrl;
                    }
                }
                
                // Status with safe get
                var status = safeGet(property, "status", "Active");
                var statusCapitalized = status.charAt(0).toUpperCase() + status.slice(1);
                
                // Price formatting with safe get
                var price = safeGet(property, "price", 0);
                var priceInterval = status.toLowerCase() === 'rent' ? '/month' : '';
                
                // Check if featured
                var featured = safeGet(property, "featured", false);
                
                // Type with safe get
                var type = safeGet(property, "type", "Not specified");
                
                // Amenities with safe get
                var amenitiesHtml = '';
                if (property.amenities && property.amenities.length > 0) {
                    var amenityCount = Math.min(3, property.amenities.length);
                    for (var j = 0; j < amenityCount; j++) {
                        amenitiesHtml += '<span class="amenity-tag">' + property.amenities[j] + '</span>';
                    }
                    if (property.amenities.length > 3) {
                        amenitiesHtml += '<span class="amenity-tag">+' + (property.amenities.length - 3) + ' more</span>';
                    }
                }
                
                // Create and append the property card
                var propertyHtml = '<div class="col-md-4 mb-4">' +
                    '<div class="card property-card">' +
                    '<div class="position-relative">' +
                    '<img src="' + mainImageUrl + '" ' +
                    'alt="' + safeGet(property, "title", 'Property') + '" ' +
                    'class="property-img" ' +
                    'onerror="this.src=\'https://via.placeholder.com/800x600?text=Image+Not+Available\'">' +
                    '<div class="status-badge status-' + status.toLowerCase() + '">' +
                    statusCapitalized +
                    '</div>';
                
                // Add featured badge if property is featured
                if (featured) {
                    propertyHtml += '<div class="featured-badge">' +
                        '<i class="bi bi-star-fill"></i> Featured' +
                        '</div>';
                }
                
                propertyHtml += '</div>' +
                    '<div class="card-body">' +
                    '<h5 class="card-title">' + safeGet(property, "title", 'Untitled Property') + '</h5>' +
                    '<p class="card-text"><i class="bi bi-geo-alt-fill text-primary"></i> ' + safeGet(property, "location", 'Location not specified') + '</p>' +
                    '<p class="price-tag">$' + price.toLocaleString() + priceInterval + '</p>' +
                    '<div class="d-flex justify-content-between mb-3">' +
                    '<span><i class="bi bi-door-open"></i> ' + safeGet(property, "bedrooms", 0) + ' Beds</span>' +
                    '<span><i class="bi bi-droplet-fill"></i> ' + safeGet(property, "bathrooms", 0) + ' Baths</span>' +
                    '<span><i class="bi bi-rulers"></i> ' + safeGet(property, "squareFeet", 0) + ' sqft</span>' +
                    '</div>' +
                    '<p class="text-muted small mb-2"><i class="bi bi-building"></i> ' + type + '</p>' +
                    '<div class="mb-3">' +
                    amenitiesHtml +
                    '</div>' +
                    '<button type="button" class="btn btn-primary w-100 view-details" ' +
                    'data-property-id="' + safeGet(property, "propertyId", "") + '" ' +
                    'onclick="showPropertyDetails(\'' + safeGet(property, "propertyId", "") + '\')">' +
                    'View Details' +
                    '</button>' +
                    '</div>' +
                    '</div>' +
                    '</div>';
                
                propertyList.append(propertyHtml);
            }
            
            // Update the heading with the total count of filtered properties
            $('h2.mb-4').text('Available Properties (' + totalCount + ' listings)');
        }
        
        function validateContactForm() {
            var name = $('#name').val().trim();
            var email = $('#email').val().trim();
            var message = $('#message').val().trim();
            
            var isValid = true;
            
            if (!name) {
                alert('Please enter your name');
                isValid = false;
            } else if (!email) {
                alert('Please enter your email');
                isValid = false;
            } else if (!validateEmail(email)) {
                alert('Please enter a valid email address');
                isValid = false;
            } else if (!message) {
                alert('Please enter a message');
                isValid = false;
            }
            
            return isValid;
        }
        
        function validateEmail(email) {
            var re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            return re.test(String(email).toLowerCase());
        }
        
        function sendAgentMessage() {
            // In a real application, this would send the message to the server
            // For this example, we'll just show a success message
            
            // Get property and agent information
            var propertyId = $('#contactAgentBtn').data('property-id');
            var property = null;
            
            if (allProperties.properties) {
                for (var i = 0; i < allProperties.properties.length; i++) {
                    if (allProperties.properties[i].propertyId === propertyId) {
                        property = allProperties.properties[i];
                        break;
                    }
                }
            }
            
            if (!property) {
                alert('Property information not available');
                return;
            }
            
            // Simulate sending the message
            $('#agentModal').modal('hide');
            
            // Show success message
            alert('Message sent successfully! The agent will contact you soon.');
            
            // Reset the form
            $('#contactForm')[0].reset();
        }
    </script>
</body>
</html>