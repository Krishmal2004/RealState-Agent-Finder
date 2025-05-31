<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Real Estate Agent Finder</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <style>
        :root {
            --dark-blue: #1a1f3c;
            --darker-blue: #151933;
            --accent-blue: #4A90E2;
            --light-blue: #84CEEB;
            --text-light: #E1E8ED;
            --text-bright: #FFFFFF;
            --success-color: #2ECC71;
            --card-bg: rgba(26, 31, 60, 0.7);
            --border-color: rgba(74, 144, 226, 0.3);
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: var(--dark-blue);
            color: var(--text-light);
            line-height: 1.6;
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        #particles-js {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1;
            background: linear-gradient(135deg, var(--darker-blue) 0%, var(--dark-blue) 100%);
        }

        .content-wrapper {
            position: relative;
            z-index: 2;
        }

        .header {
            background: rgba(74, 144, 226, 0.1);
            padding: 20px;
            text-align: center;
            position: relative;
            backdrop-filter: blur(10px);
            border-bottom: 1px solid var(--border-color);
        }

        .user-info {
            background: var(--card-bg);
            border-radius: 15px;
            border-left: 4px solid var(--accent-blue);
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            border: 1px solid var(--border-color);
        }

        .about-container {
            background: var(--card-bg);
            border-radius: 15px;
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            border: 1px solid var(--border-color);
        }

        .feature-card {
            background: rgba(74, 144, 226, 0.1);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            border: 1px solid var(--border-color);
            transition: transform 0.3s ease;
        }

        .feature-card:hover {
            transform: translateY(-5px);
        }

        .icon-circle {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: var(--accent-blue);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 15px;
            font-size: 24px;
            color: white;
        }

        .stats-container {
            background: rgba(74, 144, 226, 0.05);
            border-radius: 10px;
            padding: 20px;
            margin-top: 30px;
        }

        .stat-item {
            text-align: center;
            padding: 15px;
        }

        .stat-number {
            font-size: 2.5em;
            font-weight: bold;
            color: var(--accent-blue);
        }

        .stat-label {
            color: var(--text-light);
            font-size: 0.9em;
        }

        .team-member {
            text-align: center;
            margin-bottom: 30px;
        }

        .team-member img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            margin-bottom: 15px;
            border: 3px solid var(--accent-blue);
        }

        .section-title {
            color: var(--accent-blue);
            margin-bottom: 1rem;
            font-weight: 600;
        }

        .btn-home {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background: var(--accent-blue);
            color: var(--text-bright);
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(74, 144, 226, 0.3);
            border: 1px solid var(--border-color);
            z-index: 1000;
        }

        .btn-home:hover {
            background: #357abd;
            color: var(--text-bright);
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(74, 144, 226, 0.5);
        }

        .btn-home i {
            font-size: 1.5rem;
        }
    </style>
</head>
<body>
    <div id="particles-js"></div>
    
    <div class="content-wrapper">
        <div class="header animate__animated animate__fadeInDown">
            <h1 class="mb-0">About Real Estate Agent Finder</h1>
        </div>

        <div class="container mt-4">
            <div class="user-info p-4 mb-4 animate__animated animate__fadeInLeft">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <span class="user-badge">
                            <i class="fas fa-user"></i> Krishmal2004
                        </span>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <span class="clock-display">2025-03-14 21:15:40</span>
                    </div>
                </div>
            </div>

            <div class="about-container p-4 animate__animated animate__fadeInUp">
                <h2 class="section-title">Our Mission</h2>
                <p>We're revolutionizing the way people connect with real estate agents through our innovative platform. Our mission is to make finding the perfect real estate agent as simple and efficient as possible.</p>

                <div class="row mt-5">
                    <h2 class="section-title">Key Features</h2>
                    <div class="col-md-4">
                        <div class="feature-card">
                            <div class="icon-circle">
                                <i class="fas fa-search"></i>
                            </div>
                            <h3>Smart Agent Matching</h3>
                            <p>Advanced algorithms to match you with the perfect agent based on your specific needs and preferences.</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="feature-card">
                            <div class="icon-circle">
                                <i class="fas fa-calendar-alt"></i>
                            </div>
                            <h3>Easy Scheduling</h3>
                            <p>Book appointments with agents instantly through our integrated scheduling system.</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="feature-card">
                            <div class="icon-circle">
                                <i class="fas fa-star"></i>
                            </div>
                            <h3>Verified Reviews</h3>
                            <p>Read authentic reviews from real clients to make informed decisions.</p>
                        </div>
                    </div>
                </div>

                <div class="stats-container mt-5">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="stat-item">
                                <div class="stat-number animate__animated animate__fadeIn">500+</div>
                                <div class="stat-label">Active Agents</div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stat-item">
                                <div class="stat-number animate__animated animate__fadeIn">10K+</div>
                                <div class="stat-label">Happy Clients</div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stat-item">
                                <div class="stat-number animate__animated animate__fadeIn">15K+</div>
                                <div class="stat-label">Properties Listed</div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stat-item">
                                <div class="stat-number animate__animated animate__fadeIn">98%</div>
                                <div class="stat-label">Satisfaction Rate</div>
                            </div>
                        </div>
                    </div>
                </div>

                <h2 class="section-title mt-5">Our Team</h2>
                <div class="row">
                    <div class="col-md-3">
                        <div class="team-member">
                            <img src="https://via.placeholder.com/150" alt="Team Member">
                            <h4>John Doe</h4>
                            <p>Founder & CEO</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="team-member">
                            <img src="https://via.placeholder.com/150" alt="Team Member">
                            <h4>Jane Smith</h4>
                            <p>Head of Operations</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="team-member">
                            <img src="https://via.placeholder.com/150" alt="Team Member">
                            <h4>Mike Johnson</h4>
                            <p>Lead Developer</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="team-member">
                            <img src="https://via.placeholder.com/150" alt="Team Member">
                            <h4>Sarah Wilson</h4>
                            <p>Customer Success</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <a href="index.jsp" class="btn-home animate__animated animate__pulse animate__infinite animate__slower" title="Go to Homepage">
            <i class="fas fa-home"></i>
        </a>
    </div>

    <script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
    <script>
        // Particles.js configuration
        particlesJS("particles-js", {
            particles: {
                number: {
                    value: 80,
                    density: { enable: true, value_area: 800 }
                },
                color: { value: "#4A90E2" },
                shape: { type: "circle" },
                opacity: {
                    value: 0.5,
                    random: true,
                    animation: {
                        enable: true,
                        speed: 1,
                        opacity_min: 0.1,
                        sync: false
                    }
                },
                size: {
                    value: 3,
                    random: true,
                    animation: {
                        enable: true,
                        speed: 2,
                        size_min: 0.1,
                        sync: false
                    }
                },
                line_linked: {
                    enable: true,
                    distance: 150,
                    color: "#4A90E2",
                    opacity: 0.4,
                    width: 1
                },
                move: {
                    enable: true,
                    speed: 1,
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
    </script>
</body>
</html>