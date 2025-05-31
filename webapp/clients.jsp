<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*, org.json.*" %>
<%@ page import="java.nio.file.Files, java.nio.file.Paths" %>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter, java.time.ZoneOffset" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="com.RealState.servlets.SelectionSortServlet.Agent" %>

<%!
    // Get unique specialties from agent list
    public List<String> getUniqueSpecialties(List<Agent> agents) {
        Set<String> specialties = new HashSet<>();
        for (Agent agent : agents) {
            specialties.add(agent.getSpecialty());
        }
        return new ArrayList<>(specialties);
    }
%>

<%
    // Current date and time from servlet or use default
    String currentDateTime = (String) request.getAttribute("currentDateTime");
    if (currentDateTime == null) currentDateTime = "2025-05-03 10:00:28";
    
    // Current user login from servlet or use default
    String currentUserLogin = (String) request.getAttribute("currentUserLogin");
    if (currentUserLogin == null) currentUserLogin = "IT24103866";
    
    String firstName = "User"; // Default name if not set
    
    // Get agents list from request attribute (set by servlet)
    @SuppressWarnings("unchecked")
    List<Agent> agents = (List<Agent>) request.getAttribute("agentsList");
    
    // If no agents in request, redirect to servlet to get them
    if (agents == null) {
        String redirectURL = "SelectionSortServlet";
        String sortMethod = request.getParameter("sortMethod");
        String filterSpecialty = request.getParameter("specialty");
        
        if (sortMethod != null) {
            redirectURL += "?sortMethod=" + sortMethod;
            if (filterSpecialty != null && !filterSpecialty.isEmpty()) {
                redirectURL += "&specialty=" + filterSpecialty;
            }
        } else if (filterSpecialty != null && !filterSpecialty.isEmpty()) {
            redirectURL += "?specialty=" + filterSpecialty;
        }
        
        response.sendRedirect(redirectURL);
        return;
    }
    
    // Get error message and success message from request attributes
    String errorMessage = (String) request.getAttribute("errorMessage");
    String success = (String) request.getAttribute("success");
    String ratedAgentId = (String) request.getAttribute("ratedAgentId");
    
    // Sort method and filter specialty from request parameters
    String sortMethod = request.getParameter("sortMethod");
    String filterSpecialty = request.getParameter("specialty");
    
    // Get unique specialties for the filter dropdown
    List<String> specialties = getUniqueSpecialties(agents);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agent Ratings - PropertyFinder</title>
    
    <!-- CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    
    <style>
        :root {
            --primary: #071d49;
            --secondary: #0a2c61;
            --accent: #2a78ff;
            --light: #ffffff;
            --dark: #050e24;
            --gold: #ffd700;
            --silver: #c0c0c0;
            --bronze: #cd7f32;
            --text: #e6e6e6;
        }
        
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: var(--light);
            min-height: 100vh;
            padding-bottom: 2rem;
            padding-top: 1rem;
        }
        
        .header-section {
            background: linear-gradient(135deg, var(--dark), var(--primary));
            color: var(--light);
            padding: 2rem 0;
            margin-bottom: 2rem;
            border-radius: 10px;
            position: relative;
        }
        
        .dashboard-btn {
            position: absolute;
            top: 15px;
            left: 15px;
            background: rgba(7, 29, 73, 0.7);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: var(--light);
            border-radius: 8px;
            padding: 0.5rem 1rem;
            font-size: 0.9rem;
            text-decoration: none;
            display: flex;
            align-items: center;
            transition: all 0.3s ease;
        }
        
        .dashboard-btn:hover {
            background: rgba(42, 120, 255, 0.7);
            color: var(--light);
            transform: translateY(-2px);
        }
        
        .welcome-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: rgba(7, 29, 73, 0.7);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: var(--light);
            border-radius: 50px;
            padding: 0.4rem 1rem;
            font-size: 0.9rem;
        }
        
        .rating-form {
            background-color: rgba(7, 29, 73, 0.7);
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            padding: 2rem;
            margin-top: -3rem;
            position: relative;
            z-index: 10;
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: var(--light);
        }
        
        .agent-card {
            background-color: rgba(7, 29, 73, 0.7);
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease;
            margin-bottom: 1.5rem;
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: var(--light);
        }
        
        .agent-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
        }
        
        .agent-img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        
        .star-rating {
            color: var(--gold);
            margin-bottom: 0.5rem;
        }
        
        .rating-input {
            display: flex;
            flex-direction: row-reverse;
            justify-content: center;
        }
        
        .rating-input input {
            display: none;
        }
        
        .rating-input label {
            cursor: pointer;
            font-size: 2rem;
            color: rgba(255, 255, 255, 0.3);
            padding: 0 0.1em;
            transition: color 0.3s ease;
        }
        
        .rating-input label:hover,
        .rating-input label:hover ~ label,
        .rating-input input:checked ~ label {
            color: var(--gold);
        }
        
        .agent-rank {
            position: absolute;
            top: 10px;
            left: 10px;
            width: 32px;
            height: 32px;
            background-color: var(--accent);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            border: 2px solid white;
            z-index: 2;
        }
        
        .agent-rank.gold {
            background-color: var(--gold);
            color: black;
        }
        
        .agent-rank.silver {
            background-color: silver;
            color: black;
        }
        
        .agent-rank.bronze {
            background-color: #cd7f32;
            color: white;
        }
        
        .specialty-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            background-color: rgba(42, 120, 255, 0.2);
            color: var(--light);
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 500;
            border: 1px solid rgba(42, 120, 255, 0.4);
        }
        
        .progress-bar-custom {
            height: 6px;
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 3px;
            overflow: hidden;
            margin-bottom: 0.5rem;
        }
        
        .progress-fill {
            height: 100%;
            background-color: var(--accent);
            border-radius: 3px;
        }
        
        .agent-select {
            height: 100%;
            border-right: 1px solid rgba(255, 255, 255, 0.1);
            overflow-y: auto;
            background-color: rgba(7, 29, 73, 0.7);
            border-radius: 8px;
        }
        
        .agent-option {
            padding: 0.75rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            display: flex;
            align-items: center;
            cursor: pointer;
            transition: all 0.2s;
            background-color: rgba(7, 29, 73, 0.5);
        }
        
        .agent-option:hover {
            background-color: rgba(42, 120, 255, 0.2);
        }
        
        .agent-option.active {
            background-color: rgba(42, 120, 255, 0.2);
            border-left: 3px solid var(--accent);
        }
        
        .agent-option img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 1rem;
            border: 2px solid rgba(255, 255, 255, 0.2);
        }
        
        .review-count {
            font-size: 0.85rem;
            color: rgba(255, 255, 255, 0.7);
        }
        
        .session-info {
            position: fixed;
            bottom: 10px;
            right: 10px;
            background: rgba(7, 29, 73, 0.9);
            color: white;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 12px;
            z-index: 1000;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .form-control {
            background-color: rgba(7, 29, 73, 0.6);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: var(--light);
        }
        
        .form-control:focus {
            background-color: rgba(7, 29, 73, 0.7);
            border-color: var(--accent);
            color: var(--light);
            box-shadow: 0 0 0 0.25rem rgba(42, 120, 255, 0.25);
        }
        
        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }
        
        .form-select {
            background-color: rgba(7, 29, 73, 0.6);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: var(--light);
        }
        
        .form-select:focus {
            background-color: rgba(7, 29, 73, 0.7);
            border-color: var(--accent);
            color: var(--light);
        }
        
        /* Fix for white backgrounds in form select */
        .form-select option {
            background-color: var(--primary);
            color: var(--light);
        }
        
        .btn-outline-primary {
            color: var(--light);
            border-color: var(--accent);
        }
        
        .btn-outline-primary:hover {
            background-color: var(--accent);
            border-color: var(--accent);
            color: var(--light);
        }
        
        .btn-primary {
            background-color: var(--accent);
            border-color: var(--accent);
        }
        
        .btn-primary:hover {
            background-color: #1c68f3;
            border-color: #1c68f3;
        }
        
        .text-muted {
            color: rgba(255, 255, 255, 0.6) !important;
        }
        
        h1, h2, h3, h4, h5, h6, .h1, .h2, .h3, .h4, .h5, .h6 {
            color: var(--light);
        }
        
        /* Fix for bootstrap alerts */
        .alert-success, .alert-info, .alert-warning, .alert-danger {
            background-color: rgba(7, 29, 73, 0.7);
            color: var(--light);
            border: 1px solid var(--accent);
        }
        
        .alert-success {
            border-color: #28a745;
        }
        
        .alert-info {
            border-color: var(--accent);
        }
        
        .alert-danger {
            border-color: #dc3545;
        }
        
        /* Fix for buttons in forms */
        .btn-close {
            filter: invert(1) grayscale(100%) brightness(200%);
        }
        
        .filter-controls {
            background-color: rgba(7, 29, 73, 0.7);
            border-radius: 10px;
            padding: 1.25rem;
            margin-bottom: 2rem;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        /* Animation for new ratings */
        .rating-submitted {
            animation: pulse 1s ease-in-out;
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        @media (max-width: 767px) {
            .rating-form {
                margin-top: 1rem;
            }
            
            .dashboard-btn {
                position: relative;
                top: 0;
                left: 0;
                margin-bottom: 1rem;
                display: inline-block;
            }
            
            .welcome-badge {
                position: relative;
                top: 0;
                right: 0;
                margin-bottom: 1rem;
                display: inline-block;
            }
        }
    </style>
</head>
<body>
    <!-- Main Content -->
    <div class="container">
        <!-- Header Section -->
        <header class="header-section">
            <a href="userDashboard.jsp" class="dashboard-btn">
                <i class="fas fa-tachometer-alt me-2"></i>Back to Dashboard
            </a>
            <div class="welcome-badge">
                <i class="fas fa-user-circle me-1"></i> Welcome, <%= firstName %>
            </div>
            <div class="container">
                <h1 class="display-5 text-center">Agent Ratings</h1>
                <p class="lead text-center">Rate our agents and see how they rank</p>
            </div>
        </header>

        <% if (success != null) { %>
        <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
            <i class="fas fa-check-circle me-2"></i> <%= success %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <% } %>
        
        <% if (errorMessage != null) { %>
        <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
            <i class="fas fa-exclamation-circle me-2"></i> <%= errorMessage %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <% } %>

        <!-- Rating Form Section -->
        <section class="rating-form mb-5">
            <h3 class="mb-4">Rate an Agent</h3>
            <form id="agentRatingForm" action="SelectionSortServlet" method="post">
                <!-- Add hidden inputs to preserve sort and filter parameters -->
                <% if (sortMethod != null) { %>
                <input type="hidden" name="sortMethod" value="<%= sortMethod %>">
                <% } %>
                <% if (filterSpecialty != null) { %>
                <input type="hidden" name="specialty" value="<%= filterSpecialty %>">
                <% } %>
                
                <div class="row g-4">
                    <!-- Agent Selection Side -->
                    <div class="col-md-4">
                        <h5 class="mb-3">Select an Agent to Rate</h5>
                        <div class="agent-select" style="max-height: 400px;">
                            <!-- List of agents from JSON data -->
                            <% 
                            for (int i = 0; i < agents.size(); i++) { 
                                Agent agent = agents.get(i);
                            %>
                            <div class="agent-option <%= (ratedAgentId != null && agent.getId().equals(ratedAgentId)) ? "active" : "" %>" 
                                 onclick="selectAgentToRate('<%= agent.getId() %>', '<%= agent.getFullName() %>', '<%= agent.getSpecialty() %>')">
                                <img src="https://randomuser.me/api/portraits/<%=agent.getId().hashCode() % 2 == 0 ? "men" : "women" %>/<%= Math.abs(agent.getId().hashCode() % 99) + 1 %>.jpg" 
                                     alt="<%= agent.getFullName() %>">
                                <div>
                                    <div class="fw-bold"><%= agent.getFullName() %></div>
                                    <small class="text-light opacity-75"><%= agent.getSpecialty() %></small>
                                </div>
                            </div>
                            <% } %>
                            
                            <!-- If no agents found -->
                            <% if (agents.isEmpty()) { %>
                            <div class="text-center py-4">
                                <i class="fas fa-users-slash mb-2" style="font-size: 2rem; opacity: 0.5;"></i>
                                <p>No agents found in the system.</p>
                            </div>
                            <% } %>
                        </div>
                    </div>
                    
                    <!-- Rating Form Side -->
                    <div class="col-md-8">
                        <div id="ratingFormContent" style="display: none;">
                            <h5>Your Rating for <span id="selectedAgentName"></span></h5>
                            <p class="text-light opacity-75">Please rate your experience with this agent</p>
                            
                            <div class="mb-4">
                                <label class="form-label fw-bold">Overall Rating</label>
                                <div class="rating-input mb-2">
                                    <input type="radio" id="star5" name="rating" value="5" required>
                                    <label for="star5"><i class="fas fa-star"></i></label>
                                    <input type="radio" id="star4" name="rating" value="4">
                                    <label for="star4"><i class="fas fa-star"></i></label>
                                    <input type="radio" id="star3" name="rating" value="3">
                                    <label for="star3"><i class="fas fa-star"></i></label>
                                    <input type="radio" id="star2" name="rating" value="2">
                                    <label for="star2"><i class="fas fa-star"></i></label>
                                    <input type="radio" id="star1" name="rating" value="1">
                                    <label for="star1"><i class="fas fa-star"></i></label>
                                </div>
                                <div class="text-center text-light opacity-75 small">Click on a star to rate</div>
                            </div>
                            
                            <div class="mb-4">
                                <label for="review" class="form-label fw-bold">Your Review (Optional)</label>
                                <textarea class="form-control" id="review" name="review" rows="4" 
                                          placeholder="Share your experience with this agent..."></textarea>
                            </div>
                            
                            <input type="hidden" id="agentIdInput" name="agentId" value="">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-paper-plane me-2"></i>Submit Rating
                            </button>
                        </div>
                        
                        <div id="noAgentSelected" class="text-center py-5">
                            <i class="fas fa-user-circle mb-3" style="font-size: 3rem; opacity: 0.5;"></i>
                            <h5>Please Select an Agent</h5>
                            <p class="text-light opacity-75">Choose an agent from the list on the left to provide your rating</p>
                        </div>
                    </div>
                </div>
            </form>
        </section>

        <!-- Filter Controls -->
        <section class="filter-controls mb-4">
            <h4 class="mb-3"><i class="fas fa-filter me-2"></i>Filter & Sort Options</h4>
            <form action="SelectionSortServlet" method="get" id="filterForm">
                <div class="row g-3">
                    <div class="col-md-5">
                        <label class="form-label">Sort Method</label>
                        <select class="form-select" name="sortMethod" onchange="document.getElementById('filterForm').submit()">
                            <option value="rating" <%= (sortMethod == null || sortMethod.equals("rating")) ? "selected" : "" %>>
                                Selection Sort by Rating (Default)
                            </option>
                            <option value="experience" <%= (sortMethod != null && sortMethod.equals("experience")) ? "selected" : "" %>>
                                Selection Sort by Experience
                            </option>
                            <option value="sales" <%= (sortMethod != null && sortMethod.equals("sales")) ? "selected" : "" %>>
                                Selection Sort by Properties Sold
                            </option>
                            <option value="performance" <%= (sortMethod != null && sortMethod.equals("performance")) ? "selected" : "" %>>
                                Selection Sort by Performance Score
                            </option>
                        </select>
                    </div>
                    <div class="col-md-5">
                        <label class="form-label">Filter by Specialty</label>
                        <select class="form-select" name="specialty" onchange="document.getElementById('filterForm').submit()">
                            <option value="all" <%= (filterSpecialty == null || filterSpecialty.equals("all")) ? "selected" : "" %>>All Specialties</option>
                            <% for (String specialty : specialties) { %>
                                <option value="<%= specialty %>" <%= (filterSpecialty != null && filterSpecialty.equals(specialty)) ? "selected" : "" %>>
                                    <%= specialty %>
                                </option>
                            <% } %>
                        </select>
                    </div>
                    <div class="col-md-2 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="fas fa-sync-alt me-2"></i>Apply
                        </button>
                    </div>
                </div>
            </form>
        </section>

        <!-- All Agents by Rating Section -->
        <section class="mb-5">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h2 class="mb-4">All Agents by Rating</h2>
                <div class="alert alert-info py-2 mb-0">
                    <% if (sortMethod == null || sortMethod.equals("rating")) { %>
                        <i class="fas fa-sort me-1"></i> Sorted by Rating
                    <% } else if (sortMethod.equals("experience")) { %>
                        <i class="fas fa-sort me-1"></i> Sorted by Experience
                    <% } else if (sortMethod.equals("sales")) { %>
                        <i class="fas fa-sort me-1"></i> Sorted by Properties Sold
                    <% } else if (sortMethod.equals("performance")) { %>
                        <i class="fas fa-sort me-1"></i> Sorted by Performance Score
                    <% } %>
                </div>
            </div>
            
            <div class="row">
                <% 
                // Display all agents sorted by rating
                for (int i = 0; i < agents.size(); i++) { 
                    Agent agent = agents.get(i);
                    String rankClass = "";
                    if (i == 0) rankClass = "gold";
                    else if (i == 1) rankClass = "silver";
                    else if (i == 2) rankClass = "bronze";
                %>
                <div class="col-md-4 mb-4">
                    <div class="agent-card position-relative h-100 <%= (ratedAgentId != null && agent.getId().equals(ratedAgentId)) ? "rating-submitted" : "" %>">
                        <div class="agent-rank <%= rankClass %>"><%= i+1 %></div>
                        <div class="p-4 text-center">
                            <div class="mb-3">
                                <img src="https://randomuser.me/api/portraits/<%=agent.getId().hashCode() % 2 == 0 ? "men" : "women" %>/<%= Math.abs(agent.getId().hashCode() % 99) + 1 %>.jpg" 
                                     alt="<%= agent.getFullName() %>" class="agent-img">
                            </div>
                            <h5><%= agent.getFullName() %></h5>
                            <div class="specialty-badge mb-3"><%= agent.getSpecialty() %></div>
                            <div class="star-rating">
                                <%-- Generate star ratings based on average rating --%>
                                <% 
                                double rating = agent.getRating();
                                int fullStars = (int) Math.floor(rating);
                                boolean hasHalfStar = (rating - fullStars) >= 0.5;
                                
                                for (int j = 0; j < fullStars; j++) { %>
                                    <i class="fas fa-star"></i>
                                <% } 
                                
                                if (hasHalfStar) { %>
                                    <i class="fas fa-star-half-alt"></i>
                                <% } 
                                
                                for (int j = 0; j < (5 - fullStars - (hasHalfStar ? 1 : 0)); j++) { %>
                                    <i class="far fa-star"></i>
                                <% } %>
                            </div>
                            <div class="mb-3">
                                <strong><%= String.format("%.1f", agent.getRating()) %>/5</strong>
                                <div class="review-count"><%= agent.getRatingCount() %> Reviews</div>
                            </div>
                            
                            <!-- Additional agent details -->
                            <div class="text-start mb-3">
                                <div class="d-flex justify-content-between mb-1">
                                    <small class="text-light">Experience</small>
                                    <small class="text-light"><%= agent.getYearsExperience() %> years</small>
                                </div>
                                <div class="progress-bar-custom">
                                    <div class="progress-fill" style="width: <%= Math.min(agent.getYearsExperience() * 5, 100) %>%"></div>
                                </div>
                                
                                <div class="d-flex justify-content-between mb-1">
                                    <small class="text-light">Properties Sold</small>
                                    <small class="text-light"><%= agent.getPropertiesSold() %></small>
                                </div>
                                <div class="progress-bar-custom">
                                    <div class="progress-fill" style="width: <%= Math.min(agent.getPropertiesSold() / 2, 100) %>%"></div>
                                </div>
                                
                                <div class="d-flex justify-content-between mb-1">
                                    <small class="text-light">Contact</small>
                                    <small class="text-light"><%= agent.getPhone() %></small>
                                </div>
                            </div>
                            
                            <button class="btn btn-outline-primary btn-sm" 
                                    onclick="selectAgentToRate('<%= agent.getId() %>', '<%= agent.getFullName() %>', '<%= agent.getSpecialty() %>')">
                                <i class="fas fa-star me-1"></i> Rate Agent
                            </button>
                        </div>
                    </div>
                </div>
                <% } %>
                
                <!-- If no agents found -->
                <% if (agents.isEmpty()) { %>
                <div class="col-12 text-center py-5">
                    <i class="fas fa-users-slash mb-3" style="font-size: 5rem; opacity: 0.3;"></i>
                    <h4>No agents found in the system</h4>
                    <p class="text-muted">Agents will be displayed here once they are added to the system</p>
                </div>
                <% } %>
            </div>
        </section>
    </div>
    
    <!-- Session Info Display -->
    <div class="session-info">
        <i class="fas fa-clock me-1"></i> <%= currentDateTime %> | 
        <i class="fas fa-user me-1"></i> <%= currentUserLogin %>
    </div>

    <!-- JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Function to select an agent for rating
        function selectAgentToRate(agentId, agentName, agentSpecialty) {
            // Update hidden agent ID field
            document.getElementById('agentIdInput').value = agentId;
            
            // Update displayed agent name
            document.getElementById('selectedAgentName').textContent = agentName;
            
            // Show the rating form content, hide placeholder
            document.getElementById('ratingFormContent').style.display = 'block';
            document.getElementById('noAgentSelected').style.display = 'none';
            
            // Make the selected agent in the list visually active
            const agentOptions = document.querySelectorAll('.agent-option');
            agentOptions.forEach(option => {
                option.classList.remove('active');
            });
            
            // Find the clicked option and add active class
            agentOptions.forEach(option => {
                const name = option.querySelector('.fw-bold').textContent;
                if (name === agentName) {
                    option.classList.add('active');
                }
            });
            
            // Reset rating form
            document.getElementById('agentRatingForm').reset();
            
            // Make sure hidden fields are preserved
            const sortMethod = '<%= sortMethod != null ? sortMethod : "rating" %>';
            const specialty = '<%= filterSpecialty != null ? filterSpecialty : "" %>';
            
            if (sortMethod) {
                const sortField = document.createElement('input');
                sortField.type = 'hidden';
                sortField.name = 'sortMethod';
                sortField.value = sortMethod;
                document.getElementById('agentRatingForm').appendChild(sortField);
            }
            
            if (specialty) {
                const specialtyField = document.createElement('input');
                specialtyField.type = 'hidden';
                specialtyField.name = 'specialty';
                specialtyField.value = specialty;
                document.getElementById('agentRatingForm').appendChild(specialtyField);
            }
            
            // Scroll to rating form if needed
            document.querySelector('.rating-form').scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
        
        // Check if we need to show success message animation
        document.addEventListener('DOMContentLoaded', function() {
            const successAlert = document.querySelector('.alert-success');
            if (successAlert) {
                // Auto dismiss alert after 5 seconds
                setTimeout(() => {
                    successAlert.classList.remove('show');
                    setTimeout(() => {
                        successAlert.remove();
                    }, 500);
                }, 5000);
            }
            
            // If an agent was just rated, find and highlight their card
            const ratedAgentId = '<%= ratedAgentId %>';
            if (ratedAgentId) {
                const agentButtons = document.querySelectorAll('.agent-card button');
                agentButtons.forEach(button => {
                    if (button.onclick.toString().includes(ratedAgentId)) {
                        button.closest('.agent-card').classList.add('rating-submitted');
                    }
                });
            }
        });
    </script>
</body>
</html>