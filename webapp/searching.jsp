<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Start Agents - Estate Agent Finder</title>

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
            --success-green: #28a745;
            --danger-red: #dc3545;
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

        .welcome-section {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 3rem 2rem;
            border: 1px solid var(--glass-border);
            margin-bottom: 2rem;
            text-align: center;
        }

        .feature-card {
            background: var(--card-bg);
            border-radius: 15px;
            border: 1px solid var(--glass-border);
            padding: 2rem;
            margin-bottom: 1.5rem;
            transition: all 0.3s ease;
            height: 100%;
        }

        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }

        .feature-icon {
            font-size: 2.5rem;
            color: var(--accent-blue);
            margin-bottom: 1rem;
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

        .btn-custom {
            background: var(--accent-blue);
            color: var(--text-light);
            border: none;
            padding: 0.8rem 2rem;
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
            z-index: 1000;
        }

        .btn-home:hover {
            background: #357abd;
            color: var(--text-light);
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(74, 144, 226, 0.5);
        }

        .quick-stats {
            display: flex;
            justify-content: center;
            gap: 2rem;
            margin: 2rem 0;
        }

        .stat-card {
            background: var(--card-bg);
            padding: 1rem 2rem;
            border-radius: 10px;
            text-align: center;
            border: 1px solid var(--glass-border);
        }

        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: var(--accent-blue);
        }

        .getting-started {
            margin-top: 3rem;
        }

        .step-card {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            border: 1px solid var(--glass-border);
        }

        .step-number {
            background: var(--accent-blue);
            color: var(--text-light);
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
        }
    </style>
</head>
<body>
    <!-- Particle Effect Container -->
    <div id="particles-js"></div>

    <!-- Current Time Display -->
    <div class="current-time animate__animated animate__fadeIn">
        <i class="fas fa-clock me-2"></i>
        <span id="current-time">2025-03-14 22:05:56</span>
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
                            <%= session.getAttribute("user") != null ? session.getAttribute("user") : "Krishmal2004" %>
                        </span>
                    </div>
                </div>
            </div>
        </nav>

        <div class="container">
            <!-- Welcome Section -->
            <div class="welcome-section animate__animated animate__fadeIn">
                <h1 class="mb-4"><i class="fas fa-handshake me-2"></i>Welcome to Estate Agent Finder</h1>
                <p class="lead mb-4">Your journey to finding the perfect real estate agent starts here</p>
                
                <!-- Quick Stats -->
                <div class="quick-stats">
                    <div class="stat-card">
                        <div class="stat-number">150+</div>
                        <div class="stat-label">Active Agents</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">1,200+</div>
                        <div class="stat-label">Properties</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">98%</div>
                        <div class="stat-label">Client Satisfaction</div>
                    </div>
                </div>
            </div>

            <!-- Feature Cards -->
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="feature-card text-center animate__animated animate__fadeInUp">
                        <div class="feature-icon">
                            <i class="fas fa-search"></i>
                        </div>
                        <h3>Find Agents</h3>
                        <p>Search and filter through our extensive database of qualified real estate agents.</p>
                        <a href="findProperties.jsp" class="btn btn-custom mt-3">
                            <i class="fas fa-arrow-right me-2"></i>Start Search
                        </a>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="feature-card text-center animate__animated animate__fadeInUp" style="animation-delay: 0.2s">
                        <div class="feature-icon">
                            <i class="fas fa-calendar-alt"></i>
                        </div>
                        <h3>Schedule Meetings</h3>
                        <p>Book appointments with agents at your convenience.</p>
                        <a href="login.jsp" class="btn btn-custom mt-3">
                            <i class="fas fa-calendar-plus me-2"></i>Book Now
                        </a>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="feature-card text-center animate__animated animate__fadeInUp" style="animation-delay: 0.4s">
                        <div class="feature-icon">
                            <i class="fas fa-star"></i>
                        </div>
                        <h3>Reviews & Ratings</h3>
                        <p>View and submit reviews for agents you've worked with.</p>
                        <a href="findProperties.jsp" class="btn btn-custom mt-3">
                            <i class="fas fa-star me-2"></i>View Reviews
                        </a>
                    </div>
                </div>
            </div>

            <!-- Getting Started Section -->
            <div class="getting-started animate__animated animate__fadeInUp">
                <h2 class="text-center mb-4">Getting Started</h2>
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="step-card">
                            <span class="step-number">1</span>
                            <span>Create your account or sign in</span>
                        </div>
                        <div class="step-card">
                            <span class="step-number">2</span>
                            <span>Search for agents based on your criteria</span>
                        </div>
                        <div class="step-card">
                            <span class="step-number">3</span>
                            <span>Schedule meetings with your chosen agents</span>
                        </div>
                        <div class="step-card">
                            <span class="step-number">4</span>
                            <span>Rate and review your experience</span>
                        </div>
                    </div>
                </div>
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

        // Update current time
        function updateTime() {
            const timeElement = document.getElementById('current-time');
            const now = new Date();
            const formattedTime = now.toISOString().slice(0, 19).replace('T', ' ');
            timeElement.textContent = formattedTime;
        }
        
        $(document).ready(function() {
            setInterval(updateTime, 1000);
        });
    </script>
</body>
</html>