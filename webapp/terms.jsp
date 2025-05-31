<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Terms and Conditions</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
            --danger-color: #E74C3C;
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
            background: linear-gradient(
                135deg, 
                var(--darker-blue) 0%,
                var(--dark-blue) 100%
            );
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

        .header h1 {
            color: var(--text-bright);
            font-weight: 600;
            margin: 0;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .user-info {
            background: var(--card-bg);
            border-radius: 15px;
            border-left: 4px solid var(--accent-blue);
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            border: 1px solid var(--border-color);
        }

        .terms-container {
            background: var(--card-bg);
            border-radius: 15px;
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            border: 1px solid var(--border-color);
        }

        .terms-content {
            height: 400px;
            overflow-y: auto;
            padding: 20px;
            border-radius: 10px;
            background: rgba(26, 31, 60, 0.9);
            border: 1px solid var(--border-color);
        }

        .terms-content::-webkit-scrollbar {
            width: 6px;
        }

        .terms-content::-webkit-scrollbar-track {
            background: rgba(74, 144, 226, 0.1);
            border-radius: 3px;
        }

        .terms-content::-webkit-scrollbar-thumb {
            background: var(--accent-blue);
            border-radius: 3px;
        }

        .btn-custom {
            transition: all 0.3s ease;
            border-radius: 30px;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 600;
            padding: 12px 35px;
            position: relative;
            overflow: hidden;
            border: none;
        }

        .btn-decline {
            background: var(--danger-color);
            color: white;
            box-shadow: 0 4px 15px rgba(231, 76, 60, 0.3);
        }

        .btn-custom::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(
                120deg,
                transparent,
                rgba(255, 255, 255, 0.3),
                transparent
            );
            animation: shine 2s infinite;
        }

        @keyframes shine {
            0% { left: -100%; }
            20% { left: 100%; }
            100% { left: 100%; }
        }

        .timestamp {
            color: var(--text-light);
            font-size: 0.9em;
            background: rgba(74, 144, 226, 0.1);
            padding: 8px 15px;
            border-radius: 20px;
            display: inline-block;
            backdrop-filter: blur(5px);
            border: 1px solid var(--border-color);
        }

        .clock-display {
            font-family: 'Courier New', monospace;
            font-size: 1.1em;
            color: var(--accent-blue);
            background: rgba(74, 144, 226, 0.1);
            padding: 5px 10px;
            border-radius: 5px;
            border: 1px solid var(--border-color);
        }

        .user-badge {
            background: rgba(74, 144, 226, 0.2);
            color: var(--text-bright);
            padding: 5px 15px;
            border-radius: 20px;
            display: inline-block;
            backdrop-filter: blur(5px);
            border: 1px solid var(--border-color);
        }

        .section-title {
            color: var(--accent-blue);
            margin-bottom: 1rem;
            font-weight: 600;
        }

        .alert-custom {
            background: rgba(74, 144, 226, 0.1);
            border: 1px solid var(--border-color);
            color: var(--text-light);
        }
    </style>
</head>
<body>
    <div id="particles-js"></div>
    
    <div class="content-wrapper">
        <div class="header animate__animated animate__fadeInDown">
            <h1 class="mb-0">Terms and Conditions</h1>
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
                        <span class="clock-display">2025-03-14 14:34:13</span>
                    </div>
                </div>
            </div>

            <div class="terms-container p-4 animate__animated animate__fadeInUp">
                <div class="alert alert-custom animate__animated animate__pulse animate__infinite animate__slower">
                    <i class="fas fa-info-circle"></i> Please review our terms and conditions carefully.
                </div>

                <div class="terms-content mt-4">
                    <h2 class="section-title">Terms of Service Agreement</h2>
                    <p>By accessing and using our services, you agree to be bound by these terms and conditions.</p>

                    <h3 class="section-title mt-4">1. User Agreement</h3>
                    <p>You must agree to and abide by these terms to use our services.</p>

                    <h3 class="section-title mt-4">2. Privacy Policy</h3>
                    <p>We respect your privacy and protect your personal information.</p>

                    <h3 class="section-title mt-4">3. User Responsibilities</h3>
                    <p>Users are responsible for maintaining their account security.</p>
                </div>

                <div class="text-center mt-4">
                    <form name="reject_agreement" action="index.jsp" method="get" class="d-inline-block">
                        <button type="submit" class="btn btn-custom btn-decline animate__animated animate__pulse animate__infinite animate__slower">
                            <i class="fas fa-times-circle"></i> Decline
                        </button>
                    </form>
                </div>

                <div class="text-center mt-4">
                    <span class="timestamp">Last updated: 2025-03-14 14:34:13 UTC</span>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
    <script src="https://kit.fontawesome.com/your-kit-code.js"></script>

    <script>
        particlesJS("particles-js", {
            particles: {
                number: {
                    value: 100,
                    density: { enable: true, value_area: 800 }
                },
                color: { value: "#4A90E2" },
                shape: {
                    type: "circle",
                },
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
                    onhover: {
                        enable: true,
                        mode: "repulse"
                    },
                    onclick: {
                        enable: true,
                        mode: "push"
                    },
                    resize: true
                },
                modes: {
                    repulse: {
                        distance: 100,
                        duration: 0.4
                    },
                    push: {
                        particles_nb: 4
                    }
                }
            },
            retina_detect: true
        });
    </script>
</body>
</html>