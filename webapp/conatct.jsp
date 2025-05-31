<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Real Estate Agent Finder</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <style>
        :root {
            --dark-blue: #1a1f3c;
            --darker-blue: #151933;
            --accent-blue: #4A90E2;
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
            padding: 2rem;
        }

        .contact-container {
            background: var(--card-bg);
            border-radius: 15px;
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            border: 1px solid var(--border-color);
            margin: 2rem auto;
            max-width: 1200px;
            padding: 2rem;
        }

        .section-title {
            color: var(--accent-blue);
            margin-bottom: 1.5rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .contact-form {
            background: rgba(26, 31, 60, 0.9);
            padding: 2rem;
            border-radius: 10px;
            border: 1px solid var(--border-color);
        }

        .form-control {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid var(--border-color);
            color: var(--text-bright);
        }

        .form-control:focus {
            background: rgba(255, 255, 255, 0.15);
            border-color: var(--accent-blue);
            color: var(--text-bright);
            box-shadow: 0 0 0 0.2rem rgba(74, 144, 226, 0.25);
        }

        .form-control::placeholder {
            color: rgba(225, 232, 237, 0.5);
        }

        .map-container {
            height: 400px;
            border-radius: 10px;
            overflow: hidden;
            border: 1px solid var(--border-color);
        }

        .contact-info {
            background: rgba(26, 31, 60, 0.9);
            padding: 2rem;
            border-radius: 10px;
            border: 1px solid var(--border-color);
        }

        .info-item {
            margin-bottom: 1.5rem;
        }

        .info-item i {
            color: var(--accent-blue);
            margin-right: 10px;
            width: 20px;
        }

        .btn-submit {
            background: var(--accent-blue);
            color: var(--text-bright);
            border: none;
            padding: 10px 30px;
            border-radius: 30px;
            transition: all 0.3s ease;
        }

        .btn-submit:hover {
            background: #357abd;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(74, 144, 226, 0.4);
        }

        .user-info {
            background: rgba(74, 144, 226, 0.1);
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 2rem;
            border: 1px solid var(--border-color);
        }

        .timestamp {
            color: var(--accent-blue);
        }

        .social-links {
            margin-top: 2rem;
        }

        .social-links a {
            color: var(--accent-blue);
            margin: 0 10px;
            font-size: 1.5rem;
            transition: all 0.3s ease;
        }

        .social-links a:hover {
            color: var(--text-bright);
            transform: translateY(-3px);
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
        <div class="contact-container animate__animated animate__fadeInUp">
            <div class="user-info">
                <div class="d-flex justify-content-between align-items-center">
                    <span><i class="fas fa-user"></i> User: Krishmal2004</span>
                    <span class="timestamp">2025-03-14 20:58:38 UTC</span>
                </div>
            </div>

            <h1 class="section-title text-center mb-5">Contact Us</h1>

            <div class="row">
                <div class="col-md-6 mb-4">
                    <div class="contact-form">
                        <h2 class="section-title">Send us a Message</h2>
                        <form action="process-contact.jsp" method="POST">
                            <div class="mb-3">
                                <label for="name" class="form-label">Your Name</label>
                                <input type="text" class="form-control" id="name" name="name" required placeholder="Enter your name">
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">Email Address</label>
                                <input type="email" class="form-control" id="email" name="email" required placeholder="Enter your email">
                            </div>
                            <div class="mb-3">
                                <label for="subject" class="form-label">Subject</label>
                                <input type="text" class="form-control" id="subject" name="subject" required placeholder="Enter subject">
                            </div>
                            <div class="mb-3">
                                <label for="message" class="form-label">Message</label>
                                <textarea class="form-control" id="message" name="message" rows="5" required placeholder="Enter your message"></textarea>
                            </div>
                            <button type="submit" class="btn btn-submit">
                                <i class="fas fa-paper-plane me-2"></i>Send Message
                            </button>
                        </form>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="contact-info mb-4">
                        <h2 class="section-title">Contact Information</h2>
                        <div class="info-item">
                            <i class="fas fa-map-marker-alt"></i>
                            123 Real Estate St., Colombo, Sri Lanka
                        </div>
                        <div class="info-item">
                            <i class="fas fa-phone"></i>
                            +94 70 219 5755
                        </div>
                        <div class="info-item">
                            <i class="fas fa-envelope"></i>
                            krishmaldinidu5466@gmail.com
                        </div>
                        <div class="info-item">
                            <i class="fas fa-clock"></i>
                            Mon - Fri: 9:00 AM - 6:00 PM
                        </div>
                        <div class="social-links">
                            <a href="#" title="Facebook"><i class="fab fa-facebook"></i></a>
                            <a href="#" title="Twitter"><i class="fab fa-twitter"></i></a>
                            <a href="#" title="LinkedIn"><i class="fab fa-linkedin"></i></a>
                            <a href="#" title="Instagram"><i class="fab fa-instagram"></i></a>
                        </div>
                    </div>

                    <div class="map-container">
                        <iframe 
                            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d126743.58585989223!2d79.7861641471069!3d6.921837369440842!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3ae253d10f7a7003%3A0x320b2e4d32d3838d!2sColombo%2C%20Sri%20Lanka!5e0!3m2!1sen!2sus!4v1625764841261!5m2!1sen!2sus"
                            width="100%" 
                            height="100%" 
                            style="border:0;" 
                            allowfullscreen="" 
                            loading="lazy">
                        </iframe>
                    </div>
                </div>
            </div>
        </div>

        <a href="index.jsp" class="btn-home animate__animated animate__pulse animate__infinite animate__slower" title="Go to Homepage">
            <i class="fas fa-home"></i>
        </a>
    </div>

    <script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
    <script>
        particlesJS("particles-js", {
            particles: {
                number: { value: 80, density: { enable: true, value_area: 800 } },
                color: { value: "#4A90E2" },
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
                    bounce: false
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