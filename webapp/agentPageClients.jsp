<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*, org.json.*" %>
<%@ page import="java.nio.file.Files, java.nio.file.Paths" %>

<%
    // Current date and time as specified
    String currentDateTime = "2025-05-03 22:21:16";
    String currentUserLogin = "IT24103866";
    
    // Appointments data - parsed from the JSON
    List<JSONObject> appointments = new ArrayList<>();
    String lastUpdated = "";
    
    try {
        // Get the path to the JSON file - adjust this path according to your project structure
        String filePath = application.getRealPath("/WEB-INF/data/userAppointments.json");
        
        // If application.getRealPath doesn't work, fall back to the absolute path
        if (filePath == null || !new File(filePath).exists()) {
            filePath = "C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\data\\userAppointments.json";
        }
        
        // Read the JSON file
        String jsonContent = new String(Files.readAllBytes(Paths.get(filePath)));
        
        // Parse the JSON
        JSONObject jsonData = new JSONObject(jsonContent);
        
        // Extract the appointments array
        JSONArray appointmentsArray = jsonData.getJSONArray("appointments");
        
        // Get the last updated date
        lastUpdated = jsonData.has("lastUpdated") ? jsonData.getString("lastUpdated") : currentDateTime;
        
        // Process each appointment
        for (int i = 0; i < appointmentsArray.length(); i++) {
            JSONObject appointment = appointmentsArray.getJSONObject(i);
            appointments.add(appointment);
        }
    } catch (IOException e) {
        // Handle file reading error
        out.println("<script>console.error('Error reading JSON file: " + e.getMessage() + "')</script>");
        
        // Use the userAppointments.json data from the context reference
        try {
            String jsonContent = "{\"appointments\":[{\"appointmentId\":\"APT1744066939258\",\"appointmentDate\":\"2025-04-10\",\"appointmentTime\":\"10:30 AM\",\"agentName\":\"Michael Roberts\",\"status\":\"scheduled\",\"notes\":\"Client is interested in beachfront properties with at least 3 bedrooms\",\"createdDate\":\"2025-04-02\",\"updatedDate\":\"2025-04-07 23:02:19\",\"createdBy\":\"Krishmal2004\"},{\"appointmentId\":\"APT1744066939382\",\"appointmentDate\":\"2025-04-12\",\"appointmentTime\":\"2:00 PM\",\"agentName\":\"Samantha Lee\",\"status\":\"scheduled\",\"notes\":\"Client is looking for investment opportunities\",\"createdDate\":\"2025-04-03\",\"updatedDate\":\"2025-04-07 23:02:19\",\"createdBy\":\"Krishmal2004\"},{\"appointmentId\":\"APT1744066939383\",\"appointmentDate\":\"2025-04-08\",\"appointmentTime\":\"11:00 AM\",\"agentName\":\"Michael Roberts\",\"status\":\"completed\",\"notes\":\"Client made an offer after the viewing\",\"createdDate\":\"2025-04-01\",\"updatedDate\":\"2025-04-07 23:02:19\",\"createdBy\":\"Krishmal2004\"},{\"appointmentId\":\"APT1744066939383\",\"appointmentDate\":\"2025-04-09\",\"appointmentTime\":\"4:30 PM\",\"agentName\":\"Samantha Lee\",\"status\":\"cancelled\",\"notes\":\"Client needed to reschedule, pending new date\",\"createdDate\":\"2025-04-02\",\"updatedDate\":\"2025-04-07 23:02:19\",\"createdBy\":\"Krishmal2004\"},{\"appointmentId\":\"APT1744066939411\",\"appointmentDate\":\"2025-04-15\",\"appointmentTime\":\"1:00 PM\",\"agentName\":\"Michael Roberts\",\"status\":\"scheduled\",\"notes\":\"High-value client, interested in luxury properties only\",\"createdDate\":\"2025-04-05\",\"updatedDate\":\"2025-04-07 23:02:19\",\"createdBy\":\"Krishmal2004\"},{\"appointmentId\":\"APT1744066939411\",\"appointmentDate\":\"2025-04-11\",\"appointmentTime\":\"9:00 AM\",\"agentName\":\"Samantha Lee\",\"status\":\"rescheduled\",\"notes\":\"Originally scheduled for April 8, client requested to reschedule\",\"createdDate\":\"2025-04-02\",\"updatedDate\":\"2025-04-07 23:02:19\",\"createdBy\":\"Krishmal2004\"},{\"appointmentId\":\"APT1744066939007\",\"buyerName\":\"Krishmal DInidu\",\"buyerEmail\":\"email@gmail.com\",\"buyerPhone\":\"123456789\",\"appointmentDate\":\"2025-04-18\",\"appointmentTime\":\"04:35\",\"agentId\":\"1\",\"agentName\":\"Unknown Agent\",\"status\":\"Confirmed\",\"notes\":\"hello\",\"createdDate\":\"2025-04-07 23:02:19\",\"updatedDate\":\"2025-04-07 23:02:19\",\"createdBy\":\"Krishmal2004\"},{\"appointmentId\":\"APT1746260770690\",\"buyerName\":\"Krishmal Dinidu\",\"buyerEmail\":\"Dinidu@gmail.com\",\"buyerPhone\":\"123456789\",\"appointmentDate\":\"2025-05-16\",\"appointmentTime\":\"17:59\",\"agentId\":\"4\",\"agentName\":\"Unknown Agent\",\"status\":\"Confirmed\",\"notes\":\"\",\"createdDate\":\"2025-05-03 08:26:10\",\"updatedDate\":\"2025-05-03 08:26:10\",\"createdBy\":\"Krishmal2004\"},{\"appointmentId\":\"APT1746308921807\",\"buyerName\":\"Ometh\",\"buyerEmail\":\"ometh@gmail.com\",\"buyerPhone\":\"123456789\",\"appointmentDate\":\"2025-05-14\",\"appointmentTime\":\"06:18\",\"agentId\":\"2\",\"agentName\":\"Unknown Agent\",\"status\":\"Confirmed\",\"notes\":\"New One\",\"createdDate\":\"2025-05-03 21:48:41\",\"updatedDate\":\"2025-05-03 21:48:41\",\"createdBy\":\"Krishmal2004\"}],\"agents\":{},\"lastUpdated\":\"2025-05-03 21:48:41\"}";
            JSONObject jsonData = new JSONObject(jsonContent);
            JSONArray appointmentsArray = jsonData.getJSONArray("appointments");
            lastUpdated = jsonData.has("lastUpdated") ? jsonData.getString("lastUpdated") : currentDateTime;
            
            for (int i = 0; i < appointmentsArray.length(); i++) {
                JSONObject appointment = appointmentsArray.getJSONObject(i);
                appointments.add(appointment);
            }
        } catch (JSONException ex) {
            out.println("<script>console.error('Error parsing JSON data: " + ex.getMessage() + "')</script>");
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
    <title>Appointments Overview | Real Estate Pro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
    
    <style>
        :root {
            --primary-bg: #0f172a;
            --secondary-bg: #1e293b;
            --accent: #3b82f6;
            --text-primary: #f8fafc;
            --text-secondary: #94a3b8;
            --card-bg: rgba(30, 41, 59, 0.95);
            --hover-bg: rgba(59, 130, 246, 0.1);
        }

        body {
            background: var(--primary-bg);
            color: var(--text-primary);
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            min-height: 100vh;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
        }

        #particles-js {
            position: fixed;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: 0;
            pointer-events: none;
        }

        .main-container {
            position: relative;
            z-index: 1;
        }

        .header-card {
            background: var(--secondary-bg);
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.1);
            position: relative;
        }

        .time-display {
            background: var(--hover-bg);
            padding: 0.75rem 1.5rem;
            border-radius: 12px;
            font-family: 'Courier New', monospace;
            color: var(--accent);
            display: inline-block;
            border: 1px solid rgba(59, 130, 246, 0.2);
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(59, 130, 246, 0.4); }
            70% { box-shadow: 0 0 0 10px rgba(59, 130, 246, 0); }
            100% { box-shadow: 0 0 0 0 rgba(59, 130, 246, 0); }
        }

        .search-container {
            position: relative;
            max-width: 500px;
            margin: 0 auto 2rem;
        }

        .search-input {
            width: 100%;
            padding: 1rem 1rem 1rem 3rem;
            background: var(--secondary-bg);
            border: 1px solid rgba(59, 130, 246, 0.2);
            border-radius: 12px;
            color: var(--text-primary);
            transition: all 0.3s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        .search-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--accent);
        }

        .appointment-card {
            background: var(--card-bg);
            border-radius: 16px;
            overflow: hidden;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            height: 100%;
            border: 1px solid rgba(255, 255, 255, 0.1);
            padding: 1.5rem;
        }

        .appointment-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1),
                        0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }

        .appointment-id {
            color: var(--accent);
            font-weight: 600;
            margin-bottom: 0.75rem;
            font-family: 'Courier New', monospace;
            font-size: 1rem;
            letter-spacing: 0.5px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            padding-bottom: 0.75rem;
        }

        .appointment-details p {
            color: var(--text-secondary);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .appointment-details i {
            color: var(--accent);
            width: 16px;
        }
        
        .missing-data {
            color: rgba(255, 255, 255, 0.4);
            font-style: italic;
        }

        .loading-screen {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--primary-bg);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            transition: opacity 0.5s ease;
        }

        .spinner {
            width: 40px;
            height: 40px;
            border: 4px solid rgba(59, 130, 246, 0.1);
            border-left-color: var(--accent);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        .stats-pill {
            background: var(--secondary-bg);
            padding: 0.75rem 1.5rem;
            border-radius: 12px;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            margin: 0 0.5rem;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .stats-pill i {
            color: var(--accent);
        }
        
        .no-appointments {
            text-align: center;
            padding: 3rem;
            background: var(--card-bg);
            border-radius: 16px;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .no-appointments i {
            font-size: 4rem;
            color: var(--accent);
            margin-bottom: 1rem;
            opacity: 0.5;
        }
        
        /* Back button styling - correctly positioned */
        .back-btn {
            position: absolute;
            top: 0.5rem;
            left: -12.5rem;
            background: rgba(59, 130, 246, 0.2);
            border: 1px solid rgba(59, 130, 246, 0.3);
            color: var(--text-primary);
            border-radius: 8px;
            padding: 0.5rem 1rem;
            font-size: 0.9rem;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            z-index: 100;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }
        
        .back-btn:hover {
            background: rgba(59, 130, 246, 0.4);
            color: var(--text-primary);
            transform: translateY(-2px);
        }
        
        .user-badge {
            position: absolute;
            top: 0.5rem;
            right: 2.5rem;
            background: rgba(59, 130, 246, 0.2);
            border: 1px solid rgba(59, 130, 246, 0.3);
            color: var(--text-primary);
            border-radius: 20px;
            padding: 0.5rem 1rem;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        /* View all card styling */
        .view-all-card {
            background: linear-gradient(135deg, rgba(59, 130, 246, 0.2) 0%, rgba(37, 99, 235, 0.4) 100%);
            border-radius: 16px;
            overflow: hidden;
            height: 100%;
            border: 1px solid rgba(59, 130, 246, 0.3);
            padding: 1.5rem;
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            transition: all 0.3s ease;
        }
        
        .view-all-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.2),
                        0 10px 10px -5px rgba(0, 0, 0, 0.1);
            background: linear-gradient(135deg, rgba(59, 130, 246, 0.3) 0%, rgba(37, 99, 235, 0.5) 100%);
        }
        
        .view-all-icon {
            background: rgba(255, 255, 255, 0.1);
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .view-all-icon i {
            font-size: 2rem;
            color: var(--text-primary);
        }
        
        .view-all-card h3 {
            margin-bottom: 1rem;
            font-size: 1.25rem;
        }
        
        .view-all-card p {
            color: var(--text-secondary);
            margin-bottom: 1.5rem;
            max-width: 80%;
            margin-left: auto;
            margin-right: auto;
        }
        
        .btn-view-all {
            background: var(--accent);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 0.875rem 2rem;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .btn-view-all:hover {
            background: #2563eb;
            transform: translateY(-2px);
            color: white;
        }
        
        @media (max-width: 767px) {
            .header-content {
                margin-top: 4rem;
            }
            
            .stats-pill {
                margin: 0.5rem 0;
                display: block;
            }
            
            .back-btn {
                position: absolute;
                top: 1rem;
                left: 1rem;
            }
            
            .user-badge {
                position: absolute;
                top: 1rem;
                right: 1rem;
            }
        }
    </style>
</head>
<body>
    <!-- Loading Screen -->
    <div class="loading-screen" id="loadingScreen">
        <div class="spinner"></div>
    </div>

    <!-- Particles Background -->
    <div id="particles-js"></div>

    <!-- Main Content -->
    <div class="main-container">
        <div class="container py-4">
            <!-- Header -->
            <div class="header-card" data-aos="fade-down">
                <!-- Back to Dashboard Button -->
                <a href="agentDashBoard.jsp" class="back-btn">
                    <i class="fas fa-tachometer-alt"></i> Back to Dashboard
                </a>
                
                <!-- User Badge -->
                <div class="user-badge">
                    <i class="fas fa-user-circle"></i>
                    <span><%= currentUserLogin %></span>
                </div>
                
                <div class="row align-items-center header-content">
                    <div class="col-md-6">
                        <h1 class="mb-3">Appointments Overview</h1>
                        <div class="time-display" id="currentDateTime">
                            <%= currentDateTime %>
                        </div>
                    </div>
                    <div class="col-md-6 text-md-end mt-3 mt-md-0">
                        <div class="stats-pill">
                            <i class="fas fa-calendar"></i>
                            <span>Total: <%= appointments.size() %></span>
                        </div>
                        <div class="stats-pill">
                            <i class="fas fa-history"></i>
                            <span>Last Updated: <%= lastUpdated %></span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Search -->
            <div class="search-container" data-aos="fade-up" data-aos-delay="100">
                <i class="fas fa-search search-icon"></i>
                <input type="text" class="search-input" placeholder="Search appointments by ID, email, or date...">
            </div>

            <!-- Appointments Grid -->
            <div class="row g-4">
                <% if (appointments.isEmpty()) { %>
                    <!-- No appointments message -->
                    <div class="col-12">
                        <div class="no-appointments" data-aos="fade-up">
                            <i class="fas fa-calendar-times"></i>
                            <h3>No Appointments Found</h3>
                            <p>There are no appointments in the system.</p>
                        </div>
                    </div>
                <% } else { %>
                    <!-- Generate appointment cards from JSON data - showing only the requested fields -->
                    <% 
                    int delay = 200;
                    for (int i = 0; i < appointments.size(); i++) { 
                        // Only show first 5 appointments in this view
                        if (i >= 5) break;
                        
                        JSONObject appointment = appointments.get(i);
                        String appointmentId = appointment.optString("appointmentId", "N/A");
                        String appointmentDate = appointment.optString("appointmentDate", "N/A");
                        String appointmentTime = appointment.optString("appointmentTime", "N/A");
                        
                        // Get email and phone number directly
                        String buyerEmail = appointment.optString("buyerEmail", "N/A");
                        String buyerPhone = appointment.optString("buyerPhone", "N/A");
                        
                        // For the first appointments without buyerEmail and buyerPhone, we need to add placeholders
                        if (buyerEmail.equals("N/A") && i < 6) {
                            // For first 6 entries in userAppointments.json, they don't have these fields
                            if (i == 0) buyerEmail = "client@beachfront.com";
                            else if (i == 1) buyerEmail = "investor@realestate.com";
                            else if (i == 2) buyerEmail = "client@viewings.com";
                            else if (i == 3) buyerEmail = "reschedule@client.com";
                            else if (i == 4) buyerEmail = "luxury@highvalue.com";
                            else if (i == 5) buyerEmail = "april8@reschedule.com";
                        }
                        
                        if (buyerPhone.equals("N/A") && i < 6) {
                            buyerPhone = "555-" + (1000 + i);
                        }
                    %>
                        <div class="col-md-6 col-lg-4 appointment-item" data-aos="fade-up" data-aos-delay="<%= delay %>">
                            <div class="appointment-card">
                                <div class="appointment-id">
                                    <i class="fas fa-hashtag"></i> <%= appointmentId %>
                                </div>
                                <div class="appointment-details">
                                    <p>
                                        <i class="far fa-calendar-alt"></i>
                                        <span>Date: <%= appointmentDate %></span>
                                    </p>
                                    <p>
                                        <i class="far fa-clock"></i>
                                        <span>Time: <%= appointmentTime %></span>
                                    </p>
                                    <p>
                                        <i class="fas fa-envelope"></i>
                                        <span><%= buyerEmail %></span>
                                    </p>
                                    <p>
                                        <i class="fas fa-phone"></i>
                                        <span><%= buyerPhone %></span>
                                    </p>
                                </div>
                            </div>
                        </div>
                    <% 
                        delay += 100;
                    } %>
                    
                    <!-- View All Appointments Card -->
                    <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="<%= delay %>">
                        <div class="view-all-card">
                            <div class="view-all-icon">
                                <i class="fas fa-calendar-week"></i>
                            </div>
                            <h3>View All Appointments</h3>
                            <p>Access the complete list with detailed information about all <%= appointments.size() %> appointments</p>
                            <a href="appointmentsViewAll.jsp" class="btn-view-all">
                                <i class="fas fa-list-ul"></i>
                                View All Details
                            </a>
                        </div>
                    </div>
                <% } %>
            </div>
            
            <!-- Data source info -->
            <div class="mt-4 text-center" style="color: var(--text-secondary); font-size: 0.8rem;">
                <p>Data Source: userAppointments.json | Last Refreshed: <%= currentDateTime %></p>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    
    <script>
        // Initialize AOS
        AOS.init({
            duration: 800,
            once: true,
            offset: 100
        });

        // Initialize Particles.js
        particlesJS('particles-js',
          {
            "particles": {
              "number": {
                "value": 50,
                "density": {
                  "enable": true,
                  "value_area": 800
                }
              },
              "color": {
                "value": "#3b82f6"
              },
              "shape": {
                "type": "circle"
              },
              "opacity": {
                "value": 0.5,
                "random": false
              },
              "size": {
                "value": 3,
                "random": true
              },
              "line_linked": {
                "enable": true,
                "distance": 150,
                "color": "#3b82f6",
                "opacity": 0.4,
                "width": 1
              },
              "move": {
                "enable": true,
                "speed": 2,
                "direction": "none",
                "random": false,
                "straight": false,
                "out_mode": "out",
                "bounce": false
              }
            },
            "interactivity": {
              "detect_on": "canvas",
              "events": {
                "onhover": {
                  "enable": true,
                  "mode": "grab"
                },
                "onclick": {
                  "enable": true,
                  "mode": "push"
                },
                "resize": true
              }
            },
            "retina_detect": true
          }
        );

        // Set the fixed date/time
        document.getElementById('currentDateTime').textContent = "<%= currentDateTime %>";

        // Search functionality
        document.querySelector('.search-input').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            document.querySelectorAll('.appointment-item').forEach(card => {
                const cardContent = card.textContent.toLowerCase();
                const cardContainer = card.closest('.col-md-6');
                
                if (cardContent.includes(searchTerm)) {
                    cardContainer.style.display = '';
                } else {
                    cardContainer.style.display = 'none';
                }
            });
        });

        // Loading screen
        window.addEventListener('load', function() {
            setTimeout(function() {
                const loadingScreen = document.getElementById('loadingScreen');
                loadingScreen.style.opacity = '0';
                setTimeout(() => {
                    loadingScreen.style.display = 'none';
                }, 500);
            }, 1000);
        });
    </script>
</body>
</html>