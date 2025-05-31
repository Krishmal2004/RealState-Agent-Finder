<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Privacy Policy - Real Estate Agent Finder</title>

    <!-- CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Arial', sans-serif;
            overflow-x: hidden;
            background: linear-gradient(135deg, #1a2980 0%, #26d0ce 100%);
            color: #ffffff;
            position: relative;
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
            background: rgba(255, 255, 255, 0.97);
            color: #333;
            border-radius: 15px;
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.18);
            padding: 2rem;
            margin: 2rem auto;
            max-width: 800px;
            position: relative;
            z-index: 1;
            transition: all 0.3s ease;
        }

        .content-wrapper:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
        }

        .content-wrapper h2 {
            color: #1a2980;
            border-bottom: 2px solid #26d0ce;
            padding-bottom: 10px;
        }

        .content-wrapper h3 {
            color: #2c3e50;
            margin-top: 1.5rem;
        }

        .content-wrapper p {
            line-height: 1.6;
        }

        .content-wrapper ul {
            list-style-type: disc;
            margin-left: 1.5rem;
        }

        .user-info {
            position: fixed;
            top: 20px;
            left: 20px;
            background: rgba(26, 41, 128, 0.8);
            backdrop-filter: blur(5px);
            -webkit-backdrop-filter: blur(5px);
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            z-index: 1000;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .current-time {
            position: fixed;
            top: 20px;
            right: 20px;
            background: rgba(26, 41, 128, 0.8);
            backdrop-filter: blur(5px);
            -webkit-backdrop-filter: blur(5px);
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            z-index: 1000;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .footer {
            background: rgba(26, 41, 128, 0.9);
            backdrop-filter: blur(5px);
            -webkit-backdrop-filter: blur(5px);
            color: #ffffff;
            padding: 2rem 0;
            text-align: center;
            position: relative;
            z-index: 1;
            margin-top: 2rem;
        }

        .footer a {
            color: #26d0ce;
            margin: 0 10px;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer a:hover {
            color: #ffffff;
        }
    </style>
</head>
<body>
    <!-- Particles.js Container -->
    <div id="particles-js"></div>

    <!-- User Info Display -->
    <div class="user-info">
        <i class="fas fa-user me-2"></i>
        <span id="user-login">Krishmal2004</span>
    </div>

    <!-- Current Time Display -->
    <div class="current-time">
        <i class="fas fa-clock me-2"></i>
        <span id="current-time">2025-03-14 20:16:19</span>
    </div>

    <!-- Main Content -->
    <div class="container">
        <div class="content-wrapper animate__animated animate__fadeInUp" data-aos="fade-up">
            <h2>Privacy Policy</h2>
            <p>Welcome to Real Estate Agent Finder and Appointment System. We value your privacy and strive to protect your personal information. This privacy policy outlines how we collect, use, and safeguard your information.</p>
            
            <h3>Information Collection</h3>
            <p>We collect information that you provide directly to us, such as when you create an account, fill out a form, or communicate with us. This may include:</p>
            <ul>
                <li>Name</li>
                <li>Email address</li>
                <li>Phone number</li>
                <li>Property preferences</li>
                <li>Appointment details</li>
            </ul>

            <h3>Information Use</h3>
            <p>We use the information we collect to:</p>
            <ul>
                <li>Provide and maintain our services</li>
                <li>Personalize your experience</li>
                <li>Communicate with you</li>
                <li>Process transactions and send you related information</li>
                <li>Improve our website and services</li>
            </ul>

            <h3>Information Sharing</h3>
            <p>We do not share your personal information with third parties except in the following circumstances:</p>
            <ul>
                <li>With your consent</li>
                <li>To comply with legal obligations</li>
                <li>To protect and defend our rights and property</li>
                <li>To prevent or investigate possible wrongdoing</li>
            </ul>

            <h3>Data Security</h3>
            <p>We implement reasonable security measures to protect your personal information from unauthorized access and disclosure. However, no internet or email transmission is ever fully secure or error-free.</p>

            <h3>Changes to This Policy</h3>
            <p>We may update this privacy policy from time to time. We will notify you of any changes by posting the new privacy policy on our website. You are advised to review this privacy policy periodically for any changes.</p>

            <h3>Contact Us</h3>
            <p>If you have any questions about this privacy policy, please contact us at:</p>
            <p>Email: contact@realestatefinder.com</p>
            <p>Phone: +1 234 567 890</p>
            <p>Address: 123 Real Estate St., City, Country</p>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2025 Real Estate Agent Finder. All rights reserved.</p>
        <div>
            <a href="index.jsp">Home</a>
            <a href="conatct.jsp">Contact</a>
            <a href="termsAndServices.jsp">Terms of Service</a>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        // Initialize AOS
        AOS.init({
            duration: 1000,
            once: true
        });

        // Initialize Particles.js
        particlesJS("particles-js", {
            particles: {
                number: { 
                    value: 80, 
                    density: { enable: true, value_area: 800 } 
                },
                color: { value: "#e3f2fd" },
                shape: { type: "circle" },
                opacity: {
                    value: 0.6,
                    random: false,
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
                        speed: 40, 
                        size_min: 0.1, 
                        sync: false 
                    }
                },
                line_linked: {
                    enable: true,
                    distance: 150,
                    color: "#90caf9",
                    opacity: 0.5,
                    width: 1
                },
                move: {
                    enable: true,
                    speed: 4,
                    direction: "none",
                    random: false,
                    straight: false,
                    out_mode: "out",
                    bounce: false,
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
                    }
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
        setInterval(updateTime, 1000);
    </script>
</body>
</html>