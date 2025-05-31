<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*, org.json.*" %>
<%@ page import="java.nio.file.Files, java.nio.file.Paths" %>

<%
    // Current date and time - Updated to latest value from user input
    String currentDateTime = "2025-05-03 23:37:47";
    String currentUserLogin = "IT24103866";
    
    // Agents data - parsed from the JSON file
    List<JSONObject> agents = new ArrayList<>();
    
    try {
        // Get the path to the JSON file
        String filePath = "C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\data\\agentsManagement.json";
        
        // Try reading the file, if it fails, use the provided JSON string
        String jsonContent;
        try {
            jsonContent = new String(Files.readAllBytes(Paths.get(filePath)));
        } catch (Exception e) {
            // Use the provided JSON as fallback
            jsonContent = "{\"agents\":[{\"id\":\"AG12345678\",\"fullName\":\"John Doe\",\"email\":\"john.doe@propertyagent.com\",\"phone\":\"(123) 456-7890\",\"specialty\":\"Residential\",\"rating\":1.5,\"ratingCount\":0,\"yearsExperience\":5,\"propertiesSold\":24,\"active\":true,\"featured\":true},{\"id\":\"AG23456789\",\"fullName\":\"Jane Smith\",\"email\":\"jane.smith@propertyagent.com\",\"phone\":\"(234) 567-8901\",\"specialty\":\"Commercial\",\"rating\":4.2,\"ratingCount\":0,\"yearsExperience\":7,\"propertiesSold\":18,\"active\":true,\"featured\":true},{\"id\":\"AG26350191\",\"fullName\":\"hh\",\"email\":\"hh@gmail.com\",\"phone\":\"74747474747444\",\"specialty\":\"Residential\",\"rating\":5.0,\"ratingCount\":1,\"yearsExperience\":444,\"propertiesSold\":0,\"active\":true,\"featured\":true,\"reviews\":[{\"rating\":5,\"comment\":\"\",\"timestamp\":\"2025-05-03 10:00:28\",\"reviewerId\":\"IT24103866\"}]},{\"id\":\"AG82638441\",\"fullName\":\"Saviru\",\"email\":\"sa@gmail.com\",\"phone\":\"123456789\",\"specialty\":\"Luxury\",\"rating\":3.0,\"ratingCount\":0,\"yearsExperience\":2,\"propertiesSold\":0,\"active\":true,\"featured\":true},{\"id\":\"AG44144535\",\"fullName\":\"kala\",\"email\":\"kala@gmail.com\",\"phone\":\"123456789\",\"specialty\":\"Industrial\",\"rating\":5.0,\"ratingCount\":2,\"yearsExperience\":7,\"propertiesSold\":0,\"active\":true,\"featured\":true,\"reviews\":[{\"rating\":5,\"comment\":\"\",\"timestamp\":\"2025-05-03 10:00:28\",\"reviewerId\":\"IT24103866\"},{\"rating\":5,\"comment\":\"\",\"timestamp\":\"2025-05-03 10:00:28\",\"reviewerId\":\"IT24103866\"}]}],\"currentDate\":\"2025-05-03 10:00:28\"}";
        }
        
        // Parse the JSON
        JSONObject jsonData = new JSONObject(jsonContent);
        JSONArray agentsArray = jsonData.getJSONArray("agents");
        
        // Process each agent
        for (int i = 0; i < agentsArray.length(); i++) {
            JSONObject agent = agentsArray.getJSONObject(i);
            agents.add(agent);
        }
    } catch (JSONException e) {
        // Handle JSON parsing error
        out.println("<script>console.error('Error parsing JSON data: " + e.getMessage() + "')</script>");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find Agents - Estate Agent Finder</title>

    <!-- CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet">

    <style>
        :root {
            --dark-blue: #0a1f44;
            --darker-blue: #091632;
            --deepest-blue: #060d1f;
            --accent-blue: #4a90e2;
            --light-blue: #84ceeb;
            --text-light: #ffffff;
            --text-muted: #a0aec0;
            --glass-bg: rgba(10, 31, 68, 0.95);
            --glass-border: rgba(255, 255, 255, 0.1);
            --card-bg: rgba(9, 22, 50, 0.9);
            --gold: #ffd700;
        }

        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, var(--deepest-blue) 0%, var(--dark-blue) 100%);
            color: var(--text-light);
            min-height: 100vh;
        }

        #particles-js {
            position: fixed;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: 0;
        }

        .content-wrapper {
            position: relative;
            z-index: 1;
            padding: 2rem 0;
        }

        .current-time {
            position: fixed;
            top: 20px;
            right: 20px;
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            padding: 8px 15px;
            border-radius: 20px;
            border: 1px solid var(--glass-border);
            color: var(--accent-blue);
            z-index: 1000;
        }

        .search-container {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 2rem;
            border: 1px solid var(--glass-border);
            margin-bottom: 2rem;
        }

        .agent-card {
            background: var(--card-bg);
            border-radius: 15px;
            border: 1px solid var(--glass-border);
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            transition: all 0.3s ease;
            height: 100%;
            position: relative;
            overflow: hidden;
        }

        .agent-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }

        .agent-image {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 3px solid var(--accent-blue);
            padding: 3px;
            object-fit: cover;
        }

        .availability-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            display: inline-block;
        }

        .available {
            background: rgba(40, 167, 69, 0.2);
            color: #51cf66;
            border: 1px solid rgba(40, 167, 69, 0.3);
        }

        .busy {
            background: rgba(220, 53, 69, 0.2);
            color: #ff6b6b;
            border: 1px solid rgba(220, 53, 69, 0.3);
        }

        .btn-custom {
            background: var(--accent-blue);
            color: var(--text-light);
            border: none;
            padding: 0.5rem 1.5rem;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .btn-custom:hover {
            background: #357abd;
            color: var(--text-light);
            transform: translateY(-2px);
        }

        .btn-home {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background: var(--accent-blue);
            color: var(--text-light);
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(74, 144, 226, 0.3);
            border: 1px solid var(--glass-border);
            z-index: 1000;
        }

        .btn-home:hover {
            background: #357abd;
            color: var(--text-light);
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(74, 144, 226, 0.5);
        }

        .rating {
            color: #ffd700;
        }
        
        .specialty-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            background: rgba(74, 144, 226, 0.2);
            color: var(--accent-blue);
            border: 1px solid rgba(74, 144, 226, 0.3);
            margin-top: 0.5rem;
        }
        
        .no-agents-found {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 3rem;
            border: 1px solid var(--glass-border);
            text-align: center;
        }
        
        .no-agents-found i {
            font-size: 4rem;
            color: var(--accent-blue);
            margin-bottom: 1.5rem;
            opacity: 0.7;
        }
        
        .select2-container--default .select2-selection--single {
            background-color: var(--card-bg);
            border: 1px solid var(--glass-border);
            border-radius: 8px;
            height: 38px;
            color: var(--text-light);
        }
        
        .select2-container--default .select2-selection--single .select2-selection__rendered {
            color: var(--text-light);
            line-height: 36px;
            padding-left: 12px;
        }
        
        .select2-container--default .select2-selection--single .select2-selection__arrow {
            height: 36px;
        }
        
        .select2-dropdown {
            background-color: var(--card-bg);
            border: 1px solid var(--glass-border);
        }
        
        .select2-container--default .select2-results__option--highlighted[aria-selected] {
            background-color: var(--accent-blue);
        }
        
        .select2-container--default .select2-results__option {
            color: var(--text-light);
        }
        
        .sort-controls {
            display: flex;
            align-items: center;
            margin-bottom: 1.5rem;
            padding: 1rem;
            background: var(--glass-bg);
            border-radius: 10px;
            border: 1px solid var(--glass-border);
        }
        
        .sort-label {
            margin-right: 1rem;
            color: var(--text-light);
            font-weight: 500;
        }
        
        .btn-sort {
            background: rgba(59, 130, 246, 0.2);
            color: var(--accent-blue);
            border: 1px solid rgba(59, 130, 246, 0.3);
            padding: 0.375rem 0.75rem;
            border-radius: 6px;
            margin-right: 0.5rem;
            transition: all 0.3s ease;
        }
        
        .btn-sort:hover, .btn-sort.active {
            background: var(--accent-blue);
            color: var(--text-light);
        }
        
        .featured-badge {
            position: absolute;
            top: 0;
            right: 0;
            background: linear-gradient(135deg, var(--gold) 0%, #c9a81f 100%);
            color: #000;
            font-weight: bold;
            padding: 0.5rem 1.5rem;
            transform: rotate(45deg) translate(30%, -50%);
            transform-origin: top right;
            font-size: 0.8rem;
            z-index: 2;
            box-shadow: 0 2px 5px rgba(0,0,0,0.3);
            text-shadow: 0 1px 2px rgba(255,255,255,0.3);
        }
        
        /* Loading overlay */
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(6, 13, 31, 0.7);
            z-index: 9999;
            display: none;
            justify-content: center;
            align-items: center;
        }

        .loading-spinner {
            width: 50px;
            height: 50px;
            border: 5px solid rgba(74, 144, 226, 0.3);
            border-radius: 50%;
            border-top-color: var(--accent-blue);
            animation: spin 1s ease-in-out infinite;
        }
        
        /* Sorting visualization */
        .sorting-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(6, 13, 31, 0.9);
            z-index: 9998;
            display: none;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        
        .sorting-title {
            font-size: 1.5rem;
            color: var(--accent-blue);
            margin-bottom: 2rem;
        }
        
        .sorting-progress {
            width: 80%;
            max-width: 600px;
            background: var(--darker-blue);
            height: 30px;
            border-radius: 15px;
            overflow: hidden;
            margin-bottom: 1rem;
        }
        
        .sorting-bar {
            height: 100%;
            background: linear-gradient(90deg, var(--accent-blue) 0%, var(--light-blue) 100%);
            width: 0%;
            transition: width 0.3s ease;
        }
        
        .sorting-stats {
            font-size: 0.9rem;
            color: var(--text-muted);
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <!-- Particle Effect Container -->
    <div id="particles-js"></div>

    <!-- Current Time Display -->
    <div class="current-time animate__animated animate__fadeIn">
        <i class="fas fa-clock me-2"></i>
        <span id="current-time"><%= currentDateTime %></span>
    </div>

    <!-- Loading Overlay -->
    <div class="loading-overlay" id="loadingOverlay">
        <div class="loading-spinner"></div>
    </div>
    
    <!-- Sorting Algorithm Visualization Overlay -->
    <div class="sorting-overlay" id="sortingOverlay">
        <div class="sorting-title">
            <i class="fas fa-sort-numeric-down me-2"></i>
            Selection Sort in Progress
        </div>
        <div class="sorting-progress">
            <div class="sorting-bar" id="sortingBar"></div>
        </div>
        <div class="sorting-stats" id="sortingStats">
            Initializing sort...
        </div>
    </div>

    <div class="content-wrapper">
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg navbar-dark mb-4">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">
                    <i class="fas fa-building me-2"></i>Estate Agent Finder
                </a>
                <div class="ms-auto d-flex align-items-center">
                    <div class="user-info me-3">
                        <span class="text-light">
                            <i class="fas fa-user me-2"></i>
                            <%= currentUserLogin %>
                        </span>
                    </div>
                </div>
            </div>
        </nav>

        <div class="container">
            <!-- Search Section -->
            <div class="search-container animate__animated animate__fadeInDown">
                <h2 class="mb-4"><i class="fas fa-search me-2"></i>Find Your Perfect Agent</h2>
                <div class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label">Location</label>
                        <select class="form-select" id="locationFilter">
                            <option value="">All Locations</option>
                            <option value="colombo">Colombo</option>
                            <option value="gampaha">Gampaha</option>
                            <option value="kandy">Kandy</option>
                            <option value="galle">Galle</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Specialization</label>
                        <select class="form-select" id="specialtyFilter">
                            <option value="">All Types</option>
                            <option value="Residential">Residential</option>
                            <option value="Commercial">Commercial</option>
                            <option value="Luxury">Luxury</option>
                            <option value="Industrial">Industrial</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Rating</label>
                        <select class="form-select" id="ratingFilter">
                            <option value="">Any Rating</option>
                            <option value="5">5 Stars</option>
                            <option value="4">4+ Stars</option>
                            <option value="3">3+ Stars</option>
                        </select>
                    </div>
                </div>
            </div>
            
            <!-- Sort Controls -->
            <div class="sort-controls animate__animated animate__fadeIn">
                <span class="sort-label"><i class="fas fa-sort me-2"></i>Sort by Rating:</span>
                <button class="btn btn-sort active" id="sortHighToLow" onclick="sortAgents('desc')">
                    <i class="fas fa-sort-amount-down me-2"></i>Highest First
                </button>
                <button class="btn btn-sort" id="sortLowToHigh" onclick="sortAgents('asc')">
                    <i class="fas fa-sort-amount-up me-2"></i>Lowest First
                </button>
                <div class="ms-auto">
                    <span class="badge bg-info">Selection Sort</span>
                </div>
            </div>

            <!-- Agents List Container -->
            <div class="row" id="agentsContainer">
                <% if (agents.isEmpty()) { %>
                    <!-- No agents message -->
                    <div class="col-12">
                        <div class="no-agents-found">
                            <i class="fas fa-user-slash"></i>
                            <h3>No Agents Found</h3>
                            <p>There are currently no agents available. Please check back later.</p>
                        </div>
                    </div>
                <% } else { %>
                    <% 
                    // Loop through all agents
                    int delay = 100;
                    for (JSONObject agent : agents) {
                        // Extract agent details
                        String id = agent.optString("id", "");
                        String fullName = agent.optString("fullName", "Unknown");
                        String email = agent.optString("email", "");
                        String phone = agent.optString("phone", "");
                        String specialty = agent.optString("specialty", "General");
                        double rating = agent.optDouble("rating", 0.0);
                        int ratingCount = agent.optInt("ratingCount", 0);
                        int yearsExperience = agent.optInt("yearsExperience", 0);
                        int propertiesSold = agent.optInt("propertiesSold", 0);
                        boolean active = agent.optBoolean("active", false);
                        boolean featured = agent.optBoolean("featured", false);
                        
                        // Generate a consistent avatar
                        String avatarUrl = "https://ui-avatars.com/api/?name=" + fullName.replace(" ", "+") + "&background=random";
                        
                        // Calculate animation delay
                        delay += 100;
                    %>
                    <!-- Agent Card for <%= fullName %> -->
                    <div class="col-md-6 col-lg-4 mb-4 agent-item" data-specialty="<%= specialty %>" data-rating="<%= rating %>" data-id="<%= id %>">
                        <div class="agent-card animate__animated animate__fadeIn" style="animation-delay: <%= delay %>ms;">
                            <% if (featured) { %>
                                <div class="featured-badge">FEATURED</div>
                            <% } %>
                            <div class="text-center mb-3">
                                <img src="<%= avatarUrl %>" class="agent-image mb-3" alt="<%= fullName %>">
                                <h4><%= fullName %></h4>
                                <div class="rating mb-2">
                                    <%-- Generate rating stars --%>
                                    <% for (int i = 1; i <= 5; i++) { %>
                                        <% if (i <= Math.floor(rating)) { %>
                                            <i class="fas fa-star"></i>
                                        <% } else if (i - 0.5 <= rating) { %>
                                            <i class="fas fa-star-half-alt"></i>
                                        <% } else { %>
                                            <i class="far fa-star"></i>
                                        <% } %>
                                    <% } %>
                                    <span class="ms-2 text-muted">(<%= rating %>)</span>
                                </div>
                                <span class="availability-badge <%= active ? "available" : "busy" %>">
                                    <i class="fas <%= active ? "fa-check-circle" : "fa-times-circle" %> me-1"></i>
                                    <%= active ? "Available" : "Unavailable" %>
                                </span>
                                <div>
                                    <span class="specialty-badge"><i class="fas fa-tag me-1"></i><%= specialty %></span>
                                </div>
                            </div>
                            <div class="agent-info">
                                <p><i class="fas fa-envelope me-2"></i><%= email %></p>
                                <p><i class="fas fa-phone me-2"></i><%= phone %></p>
                                <p><i class="fas fa-briefcase me-2"></i><%= yearsExperience %> Years Experience</p>
                                <p><i class="fas fa-home me-2"></i><%= propertiesSold %> Properties Sold</p>
                            </div>
                            <div class="text-center mt-3">
                                <button class="btn btn-custom" onclick="scheduleWithAgent('<%= id %>')">
                                    <i class="fas fa-calendar-alt me-2"></i>Schedule Meeting
                                </button>
                            </div>
                        </div>
                    </div>
                    <% } %>
                <% } %>
            </div>
        </div>

        <!-- Home Button -->
        <a href="index.jsp" class="btn-home animate__animated animate__pulse animate__infinite animate__slower" title="Go to Homepage">
            <i class="fas fa-home"></i>
        </a>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>

    <script>
        // Initialize Particles.js
        particlesJS("particles-js", {
            particles: {
                number: { value: 80, density: { enable: true, value_area: 800 } },
                color: { value: "#4a90e2" },
                shape: { type: "circle" },
                opacity: {
                    value: 0.5,
                    random: true,
                    animation: { enable: true, speed: 1, opacity_min: 0.1, sync: false }
                },
                size: {
                    value: 3,
                    random: true,
                    animation: { enable: true, speed: 2, size_min: 0.1, sync: false }
                },
                line_linked: {
                    enable: true,
                    distance: 150,
                    color: "#4a90e2",
                    opacity: 0.4,
                    width: 1
                },
                move: {
                    enable: true,
                    speed: 2,
                    direction: "none",
                    random: true,
                    straight: false,
                    out_mode: "out",
                    bounce: false,
                    attract: { enable: true, rotateX: 600, rotateY: 1200 }
                }
            },
            interactivity: {
                detect_on: "canvas",
                events: {
                    onhover: { enable: true, mode: "repulse" },
                    onclick: { enable: true, mode: "push" },
                    resize: true
                },
                modes: {
                    repulse: { distance: 100, duration: 0.4 },
                    push: { particles_nb: 4 }
                }
            },
            retina_detect: true
        });

        // Initialize Select2 and filters
        $(document).ready(function() {
            // Initialize Select2
            $('.form-select').select2({
                theme: "classic",
                dropdownAutoWidth: true,
                width: '100%'
            });

            // Filter functionality
            $('#specialtyFilter, #ratingFilter').on('change', function() {
                filterAgents();
            });

            function filterAgents() {
                const specialtyFilter = $('#specialtyFilter').val();
                const ratingFilter = parseFloat($('#ratingFilter').val()) || 0;

                $('.agent-item').each(function() {
                    const specialty = $(this).data('specialty');
                    const rating = parseFloat($(this).data('rating'));
                    
                    const matchesSpecialty = !specialtyFilter || specialty === specialtyFilter;
                    const matchesRating = rating >= ratingFilter;
                    
                    if (matchesSpecialty && matchesRating) {
                        $(this).show();
                    } else {
                        $(this).hide();
                    }
                });
            }

            // Set current time
            document.getElementById('current-time').textContent = "<%= currentDateTime %>";
        });
        
        // Schedule meeting with agent
        function scheduleWithAgent(agentId) {
            window.location.href = 'UserLogin.jsp?agentId=' + agentId;
        }
        
        // Improved Selection Sort Implementation
        function sortAgents(order) {
            // Show loading overlay
            document.getElementById('sortingOverlay').style.display = 'flex';
            
            // Update active button state
            if (order === 'desc') {
                $('#sortHighToLow').addClass('active');
                $('#sortLowToHigh').removeClass('active');
            } else {
                $('#sortHighToLow').removeClass('active');
                $('#sortLowToHigh').addClass('active');
            }
            
            // Get all agent items
            const agentContainer = document.getElementById('agentsContainer');
            let agentItems = Array.from(document.querySelectorAll('.agent-item'));
            
            // Create array with agent data for sorting
            let agentsArray = agentItems.map(item => {
                return {
                    element: item,
                    rating: parseFloat(item.getAttribute('data-rating'))
                };
            });
            
            // Start the sequential Selection Sort algorithm with visualization
            selectionSortWithAnimation(agentsArray, order);
        }
        
        // Animated Selection Sort algorithm
        function selectionSortWithAnimation(agentsArray, order) {
            const totalSteps = agentsArray.length - 1;
            let currentStep = 0;
            
            const sortingBar = document.getElementById('sortingBar');
            const sortingStats = document.getElementById('sortingStats');
            
            function performSortStep() {
                if (currentStep >= totalSteps) {
                    // Sort is complete
                    sortingStats.textContent = 'Sort complete. Reordering DOM elements...';
                    sortingBar.style.width = '100%';
                    
                    // Delay to show 100% before completing
                    setTimeout(() => {
                        // Now reorder the actual DOM
                        const agentContainer = document.getElementById('agentsContainer');
                        agentsArray.forEach(item => {
                            agentContainer.appendChild(item.element);
                        });
                        
                        // Add animation to the newly sorted elements
                        document.querySelectorAll('.agent-card').forEach((card, index) => {
                            card.classList.remove('animate__fadeIn');
                            void card.offsetWidth; // Trigger reflow
                            card.classList.add('animate__fadeIn');
                            card.style.animationDelay = (index * 100) + 'ms';
                        });
                        
                        document.getElementById('sortingOverlay').style.display = 'none';
                    }, 500);
                    return;
                }
                
                // Show progress
                const progress = Math.round((currentStep / totalSteps) * 100);
                sortingBar.style.width = progress + '%';
                sortingStats.textContent = `Selection sort: Step ${currentStep + 1} of ${totalSteps} (${progress}% complete)`;
                
                // Selection sort - find minimum/maximum element
                let extremeIndex = currentStep;
                
                for (let j = currentStep + 1; j < agentsArray.length; j++) {
                    if (order === 'asc' && agentsArray[j].rating < agentsArray[extremeIndex].rating) {
                        extremeIndex = j;
                    } else if (order === 'desc' && agentsArray[j].rating > agentsArray[extremeIndex].rating) {
                        extremeIndex = j;
                    }
                }
                
                // Swap if needed
                if (extremeIndex !== currentStep) {
                    // Actual data swap
                    const temp = agentsArray[extremeIndex];
                    agentsArray[extremeIndex] = agentsArray[currentStep];
                    agentsArray[currentStep] = temp;
                }
                
                // Move to next step
                currentStep++;
                
                // Schedule next step with delay for visualization
                setTimeout(performSortStep, 150);
            }
            
            // Start the first step
            performSortStep();
        }
    </script>
</body>
</html>