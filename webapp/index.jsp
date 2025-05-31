<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Real Estate Agent Finder - Home</title>

    <!-- CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    

    <style>
        /* Common Styles */
        :root {
            --primary-color: #0a1f44;
            --secondary-color: #1a3a6c;
            --accent-color: #4a90e2;
            --text-light: #ffffff;
            --text-dark: #333333;
        }

        body {
            font-family: 'Arial', sans-serif;
            overflow-x: hidden;
        }

        /* Header Styles */
        .navbar {
            background: rgba(10, 31, 68, 0.95);
            backdrop-filter: blur(10px);
            padding: 1rem 0;
            transition: all 0.3s ease;
        }

        .navbar.scrolled {
            padding: 0.5rem 0;
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: bold;
            color: var(--text-light) !important;
        }

        .nav-link {
            color: var(--text-light) !important;
            margin: 0 10px;
            position: relative;
            transition: all 0.3s ease;
        }

        .nav-link::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--accent-color);
            transition: width 0.3s ease;
        }

        .nav-link:hover::after {
            width: 100%;
        }

        .user-profile {
            display: flex;
            align-items: center;
            color: var(--text-light);
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
            border: 2px solid var(--accent-color);
            padding: 2px;
        }

        /* Hero Section */
        .hero-section {
            height: 80vh;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            position: relative;
            overflow: hidden;
        }

        .hero-content {
            position: relative;
            z-index: 2;
            color: var(--text-light);
        }
        .image-container {
            position: relative;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
        }

        .floating {
            animation: floating 3s ease-in-out infinite;
        }
        .image-container::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(
                135deg,
                rgba(10, 31, 68, 0.3) 0%,
                rgba(74, 144, 226, 0.3) 100%
            );
            pointer-events: none;
        }

        @keyframes floating {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
            100% { transform: translateY(0px); }
        }

        /* Footer Styles */
        .footer {
            background: var(--primary-color);
            color: var(--text-light);
            padding: 3rem 0 2rem;
        }

        .footer-heading {
            color: var(--accent-color);
            margin-bottom: 1.5rem;
        }

        .footer-link {
            color: var(--text-light);
            text-decoration: none;
            transition: all 0.3s ease;
            display: block;
            margin-bottom: 0.5rem;
        }

        .footer-link:hover {
            color: var(--accent-color);
            transform: translateX(5px);
        }

        .social-links a {
            color: var(--text-light);
            margin-right: 15px;
            font-size: 1.5rem;
            transition: all 0.3s ease;
        }

        .social-links a:hover {
            color: var(--accent-color);
            transform: translateY(-5px);
        }

        /* Particles Effect */
        #particles-js {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
        }

        /* Current Time Display */
        .current-time {
            position: fixed;
            top: 20px;
            right: 20px;
            background: rgba(0, 0, 0, 0.5);
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            z-index: 1000;
        }

        /* Chat Widget Styles */
.chat-widget {
    position: fixed;
    bottom: 80px;
    right: 20px;
    width: 300px;
    background: white;
    border-radius: 10px;
    box-shadow: 0 5px 25px rgba(0,0,0,0.2);
    z-index: 1000;
    display: none;
    overflow: hidden;
    transition: all 0.3s ease;
}

.chat-header {
    background: var(--primary-color);
    color: white;
    padding: 15px;
    font-weight: bold;
    display: flex;
    align-items: center;
    cursor: move;
}

.minimize-btn {
    margin-left: auto;
    background: none;
    border: none;
    color: white;
    cursor: pointer;
}

.chat-body {
    height: 400px;
    display: flex;
    flex-direction: column;
}

.chat-messages {
    flex-grow: 1;
    padding: 15px;
    overflow-y: auto;
}

.message {
    margin-bottom: 10px;
    padding: 10px;
    border-radius: 10px;
    max-width: 80%;
}

.message.user {
    background: var(--accent-color);
    color: white;
    margin-left: auto;
}

.message.bot {
    background: #f0f2f5;
    color: var(--text-dark);
}

.chat-input {
    display: flex;
    padding: 10px;
    border-top: 1px solid #eee;
}

.chat-input input {
    flex-grow: 1;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 20px;
    margin-right: 10px;
}

.chat-input button {
    background: var(--accent-color);
    color: white;
    border: none;
    border-radius: 50%;
    width: 35px;
    height: 35px;
    cursor: pointer;
    transition: all 0.3s ease;
}

.chat-input button:hover {
    transform: scale(1.1);
}

.chat-toggle {
    position: fixed;
    bottom: 20px;
    right: 20px;
    background: var(--accent-color);
    color: white;
    border: none;
    border-radius: 50%;
    width: 60px;
    height: 60px;
    font-size: 1.2rem;
    cursor: pointer;
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
    transition: all 0.3s ease;
    z-index: 1000;
}

.chat-toggle:hover {
    transform: scale(1.1);
}

/* Add animation classes */
.slide-in {
    animation: slideIn 0.3s ease forwards;
}

.slide-out {
    animation: slideOut 0.3s ease forwards;
}

@keyframes slideIn {
    from {
        transform: translateX(100%);
        opacity: 0;
    }
    to {
        transform: translateX(0);
        opacity: 1;
    }
}

@keyframes slideOut {
    from {
        transform: translateX(0);
        opacity: 1;
    }
    to {
        transform: translateX(100%);
        opacity: 0;
    }
}

/* Add to your existing styles */
.typing-indicator {
    display: flex;
    gap: 4px;
    padding: 10px;
    background: #f0f2f5;
    border-radius: 10px;
    margin-bottom: 10px;
    width: fit-content;
}

.typing-indicator span {
    width: 8px;
    height: 8px;
    background: var(--text-secondary);
    border-radius: 50%;
    animation: typing 1s infinite ease-in-out;
}

.typing-indicator span:nth-child(1) { animation-delay: 0.2s; }
.typing-indicator span:nth-child(2) { animation-delay: 0.4s; }
.typing-indicator span:nth-child(3) { animation-delay: 0.6s; }

@keyframes typing {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-10px); }
}
    </style>
</head>
<body>
	
    <!-- Current Time Display -->
    <div class="current-time">
        <i class="fas fa-clock me-2"></i>
        <span id="current-time">2025-03-14 08:45:00</span>
    </div>

    <!-- Header/Navbar -->
    <!-- Header/Navbar -->
<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container">
        <a class="navbar-brand animate__animated animate__fadeInLeft" href="#">
            <i class="fas fa-home me-2"></i>
            RealEstate Finder
        </a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto animate__animated animate__fadeInDown">
                <li class="nav-item">
                    <a class="nav-link" href="findProperties1.jsp"><i class="fas fa-search me-1"></i>Find Properties</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="findProperties.jsp"><i class="fas fa-user-tie me-1"></i>Find Agents</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="login.jsp"><i class="fas fa-calendar me-1"></i>Appointments</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="about.jsp"><i class="fas fa-info-circle me-1"></i>About Us</a>
                </li>
            </ul>
            
            <% if(session.getAttribute("") == null) { %>
                <!-- Login/Register Buttons -->
                <div class="nav-auth-buttons animate__animated animate__fadeInRight">
                    <a href="login.jsp" class="btn btn-outline-light me-2">
                        <i class="fas fa-sign-in-alt me-1"></i>Admin
                    </a>
                    <a href="AgentLogin.jsp" class="btn btn-outline-light me-2">
                        <i class="fas fa-sign-in-alt me-1"></i>Agent
                    </a>
                    <a href="UserLogin.jsp" class="btn btn-outline-light me-2">
                        <i class="fas fa-sign-in-alt me-1"></i>Login
                    </a>
                    <a href="register.jsp" class="btn btn-primary">
                        <i class="fas fa-user-plus me-1"></i>Register
                    </a>
                </div>
            <% } else { %>
                <!-- User Profile Dropdown -->
                <div class="user-profile animate__animated animate__fadeInRight">
                    <div class="dropdown">
                        <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle" 
                           id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                            <img src="https://ui-avatars.com/api/?name=<%= session.getAttribute("user") %>&background=random" 
                                 alt="User Avatar" 
                                 class="user-avatar">
                            <div class="user-info">
                                <small>Welcome,</small>
                                <div class="fw-bold"><%= session.getAttribute("user") %></div>
                            </div>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                            <li>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-user me-2"></i>My Profile
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-cog me-2"></i>Settings
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-history me-2"></i>History
                                </a>
                            </li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <a class="dropdown-item text-danger" href="logout.jsp">
                                    <i class="fas fa-sign-out-alt me-2"></i>Logout
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            <% } %>
        </div>
    </div>
</nav>

    <!-- Hero Section -->
    <section class="hero-section d-flex align-items-center">
        <div id="particles-js"></div>
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 hero-content" data-aos="fade-right">
                    <h1 class="display-4 fw-bold mb-4">Find Your Perfect Home</h1>
                    <p class="lead mb-4">Connect with top real estate agents and find your dream property with ease.</p>
                    <div class="d-flex gap-3">
                        <a href="searching.jsp" class="btn btn-primary btn-lg animate__animated animate__pulse animate__infinite">
                            <i class="fas fa-search me-2"></i>Start Searching
                        </a>
                        <a href="login.jsp" class="btn btn-outline-light btn-lg">
                            <i class="fas fa-user-tie me-2"></i>Meet Agents
                        </a>
                    </div>
                </div>
                <div class="col-lg-6" data-aos="fade-left">
                <div class="image-container">
                    <img src="https://images.unsplash.com/photo-1600585154340-be6161a56a0c" alt="Modern Living Space" alt="Modern Living Space" alt="Hero Image" class="img-fluid floating">
                </div>
            </div>
        </div>
    </section>

    <!-- Chat Widget -->
<div class="chat-widget" id="chatWidget">
    <div class="chat-header" id="chatHeader">
        <i class="fas fa-robot me-2"></i>
        Property Assistant
        <button class="minimize-btn" id="minimizeChat">
            <i class="fas fa-minus"></i>
        </button>
    </div>
    <div class="chat-body" id="chatBody">
        <div class="chat-messages" id="chatMessages">
            <div class="message bot">
                Hello! I'm your real estate assistant. How can I help you today?
            </div>
            
            <!-- Add this inside your chat-messages div -->
<div class="chat-loading" style="display: none;">
    <div class="typing-indicator">
        <span></span>
        <span></span>
        <span></span>
    </div>
</div>
        </div>
        <div class="chat-input">
            <input type="text" id="userInput" placeholder="Type your message...">
            <button id="sendMessage">
                <i class="fas fa-paper-plane"></i>
            </button>
        </div>
    </div>
</div>

<!-- Chat Toggle Button -->
<button class="chat-toggle" id="chatToggle">
    <i class="fas fa-comments"></i>
</button>

    <!-- Main Content Section -->
    <!-- Add your main content here -->

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-4" data-aos="fade-up">
                    <h4 class="footer-heading">About Us</h4>
                    <p>We connect real estate agents with potential buyers and renters, making property transactions smoother and more efficient.</p>
                    <div class="social-links mt-3">
                        <a href="#"><i class="fab fa-facebook"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-linkedin"></i></a>
                    </div>
                </div>
                
                <div class="col-md-2 mb-4" data-aos="fade-up" data-aos-delay="100">
                    <h4 class="footer-heading">Quick Links</h4>
                    <a href="index.jsp" class="footer-link">Home</a>
                    <a href="#" class="footer-link">Properties</a>
                    <a href="#" class="footer-link">Agents</a>
                    <a href="conatct.jsp" class="footer-link">Contact</a>
                </div>
                
                <div class="col-md-3 mb-4" data-aos="fade-up" data-aos-delay="200">
                    <h4 class="footer-heading">Contact Info</h4>
                    <a href="#" class="footer-link"><i class="fas fa-phone me-2"></i>+94 70 219 5755</a>
                    <a href="#" class="footer-link"><i class="fas fa-envelope me-2"></i>krishmaldinidu5466@gmail.com</a>
                    <a href="#" class="footer-link"><i class="fas fa-map-marker-alt me-2"></i>123 Real Estate St.</a>
                </div>
                
                <div class="col-md-3 mb-4" data-aos="fade-up" data-aos-delay="300">
                    <h4 class="footer-heading">Newsletter</h4>
                    <p>Subscribe to our newsletter for updates and news.</p>
                    <div class="input-group">
                        <input type="email" class="form-control" placeholder="Your email">
                        <button class="btn btn-primary"><i class="fas fa-paper-plane"></i></button>
                    </div>
                </div>
            </div>
            
            <hr class="mt-4 mb-4">
            
            <div class="row">
                <div class="col-md-6 text-center text-md-start">
                    <p class="mb-0">&copy; 2025 Real Estate Agent Finder. All rights reserved.</p>
                </div>
                <div class="col-md-6 text-center text-md-end">
                    <a href="privacy.jsp" class="footer-link d-inline-block mx-2">Privacy Policy</a>
                    <a href="termsAndServices.jsp" class="footer-link d-inline-block mx-2">Terms of Service</a>
                </div>
            </div>
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
                number: { value: 80, density: { enable: true, value_area: 800 } },
                color: { value: "#ffffff" },
                shape: { type: "circle" },
                opacity: {
                    value: 0.5,
                    random: false,
                    animation: { enable: true, speed: 1, opacity_min: 0.1, sync: false }
                },
                size: {
                    value: 3,
                    random: true,
                    animation: { enable: true, speed: 40, size_min: 0.1, sync: false }
                },
                line_linked: {
                    enable: true,
                    distance: 150,
                    color: "#ffffff",
                    opacity: 0.4,
                    width: 1
                },
                move: {
                    enable: true,
                    speed: 6,
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
                    onhover: { enable: true, mode: "repulse" },
                    onclick: { enable: true, mode: "push" },
                    resize: true
                }
            },
            retina_detect: true
        });

        // Navbar Scroll Effect
        window.addEventListener('scroll', function() {
            const navbar = document.querySelector('.navbar');
            if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });

        // Update current time
        function updateTime() {
            const timeElement = document.getElementById('current-time');
            const now = new Date();
            const formattedTime = now.toISOString().slice(0, 19).replace('T', ' ');
            timeElement.textContent = formattedTime;
        }
        setInterval(updateTime, 1000);

        // Add smooth scrolling to all links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function(e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });

        // Chat Widget Functionality
document.addEventListener('DOMContentLoaded', function() {
    const chatWidget = document.getElementById('chatWidget');
    const chatToggle = document.getElementById('chatToggle');
    const chatHeader = document.getElementById('chatHeader');
    const minimizeChat = document.getElementById('minimizeChat');
    const userInput = document.getElementById('userInput');
    const sendMessage = document.getElementById('sendMessage');
    const chatMessages = document.getElementById('chatMessages');
    
    sendMessage.addEventListener('click', () => {
        handleUserMessage();
    });
    
 // Send message on Enter key
    userInput.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') {
            handleUserMessage();
        }
    });
 
 // Handle user message
    function handleUserMessage() {
        const message = userInput.value.trim();
        if (message) {
            // Add user message
            addMessage(message, 'user');
            // Clear input
            userInput.value = '';
            // Show typing indicator
            showTypingIndicator();
            // Get bot response with delay
            setTimeout(() => {
                removeTypingIndicator();
                const botResponse = getBotResponse(message);
                addMessage(botResponse, 'bot');
            }, 1000);
        }
    }

    // Add message to chat
    function addMessage(message, sender) {
        const messageDiv = document.createElement('div');
        messageDiv.classList.add('message', sender);
        messageDiv.textContent = message;
        chatMessages.appendChild(messageDiv);
        // Scroll to bottom
        chatMessages.scrollTop = chatMessages.scrollHeight;
    }

    // Show typing indicator
    function showTypingIndicator() {
        const typingDiv = document.createElement('div');
        typingDiv.className = 'typing-indicator';
        typingDiv.innerHTML = `
            <span></span>
            <span></span>
            <span></span>
        `;
        typingDiv.id = 'typing-indicator';
        chatMessages.appendChild(typingDiv);
        chatMessages.scrollTop = chatMessages.scrollHeight;
    }

    // Remove typing indicator
    function removeTypingIndicator() {
        const typingIndicator = document.getElementById('typing-indicator');
        if (typingIndicator) {
            typingIndicator.remove();
        }
    }

 
 

    let isDragging = false;
    let currentX;
    let currentY;
    let initialX;
    let initialY;
    let xOffset = 0;
    let yOffset = 0;

    // Toggle chat widget
    chatToggle.addEventListener('click', () => {
        if (chatWidget.style.display === 'none' || !chatWidget.style.display) {
            chatWidget.style.display = 'block';
            chatWidget.classList.add('slide-in');
            chatWidget.classList.remove('slide-out');
        }
    });

    // Minimize chat
    minimizeChat.addEventListener('click', () => {
        chatWidget.classList.remove('slide-in');
        chatWidget.classList.add('slide-out');
        setTimeout(() => {
            chatWidget.style.display = 'none';
        }, 300);
    });
    
 // Update the sendUserMessage function
    async function sendUserMessage() {
        const message = userInput.value.trim();
        if (message) {
            // Add user message
            addMessage(message, 'user');
            // Clear input
            userInput.value = '';
            // Show loading indicator
            const response = await getBotResponse(message);
            addMessage(response, 'bot');
        }
    }

 // AI API Integration
    async function callOpenAI(message) {
        try {
            const response = await fetch('https://api.openai.com/v1/chat/completions', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${openAiKey}` // You'll need to set this server-side
                },
                body: JSON.stringify({
                    model: "gpt-3.5-turbo",
                    messages: [{
                        role: "system",
                        content: "You are a helpful real estate assistant. Provide concise, relevant information about properties, pricing, and real estate matters."
                    }, {
                        role: "user",
                        content: message
                    }],
                    max_tokens: 150,
                    temperature: 0.7
                })
            });

            const data = await response.json();
            return data.choices[0].message.content;
        } catch (error) {
            console.error('Error calling AI API:', error);
            return getDefaultResponse(message);
        }
    }

    // Update the existing getBotResponse function to use the API
    async function getBotResponse(message) {
        const loadingMessage = addMessage("Thinking...", 'bot');
        
        try {
            const response = await callOpenAI(message);
            // Remove loading message
            loadingMessage.remove();
            return response;
        } catch (error) {
            // Remove loading message
            loadingMessage.remove();
            return getDefaultResponse(message);
        }
    }
    
 // Get bot response
    function getBotResponse(message) {
        message = message.toLowerCase();
        const currentUser = '<%= session.getAttribute("user") != null ? session.getAttribute("user") : "Guest" %>';
        
        if (message.includes('property') || message.includes('house') || message.includes('apartment')) {
            return `I'd be happy to help you find properties, ${currentUser}! What's your preferred location and budget?`;
        } else if (message.includes('agent') || message.includes('realtor')) {
            return `I can connect you with our top-rated real estate agents, ${currentUser}. Would you like to schedule a consultation?`;
        } else if (message.includes('price') || message.includes('cost') || message.includes('budget')) {
            return `Our properties range from various price points. What's your budget range, ${currentUser}?`;
        } else if (message.includes('location') || message.includes('area')) {
            return "We have properties in many locations. Which area are you interested in?";
        } else if (message.includes('hello') || message.includes('hi') || message.includes('hey')) {
            return `Hello ${currentUser}! How can I help you with your real estate needs today?`;
        } else {
            return `I'm here to help with any real estate related questions, ${currentUser}. You can ask about:\n• Properties\n• Prices\n• Locations\n• Agents\n• Viewings`;
        }
    }

    // Fallback responses if API fails
    function getDefaultResponse(message) {
        message = message.toLowerCase();
        if (message.includes('property') || message.includes('house') || message.includes('apartment')) {
            return "I can help you find properties! What's your preferred location and budget?";
        } else if (message.includes('agent') || message.includes('realtor')) {
            return "I can connect you with our top-rated real estate agents. Would you like to schedule a consultation?";
        } else if (message.includes('price') || message.includes('cost') || message.includes('budget')) {
            return "Our properties range from various price points. What's your budget range?";
        } else if (message.includes('location') || message.includes('area')) {
            return "We have properties in many locations. Which area are you interested in?";
        } else {
            return "I'm here to help with any real estate related questions. Feel free to ask about properties, agents, or scheduling a viewing!";
        }
    }
    
 // Toggle chat widget
    chatToggle.addEventListener('click', () => {
        if (chatWidget.style.display === 'none' || !chatWidget.style.display) {
            chatWidget.style.display = 'block';
            chatWidget.classList.add('slide-in');
            chatWidget.classList.remove('slide-out');
        }
    });
 
 
    // Make chat widget draggable
    chatHeader.addEventListener('mousedown', dragStart);
    document.addEventListener('mousemove', drag);
    document.addEventListener('mouseup', dragEnd);

    function dragStart(e) {
        initialX = e.clientX - xOffset;
        initialY = e.clientY - yOffset;

        if (e.target === chatHeader) {
            isDragging = true;
        }
    }

    function drag(e) {
        if (isDragging) {
            e.preventDefault();
            currentX = e.clientX - initialX;
            currentY = e.clientY - initialY;

            xOffset = currentX;
            yOffset = currentY;

            setTranslate(currentX, currentY, chatWidget);
        }
    }

    function dragEnd(e) {
        initialX = currentX;
        initialY = currentY;
        isDragging = false;
    }

    function setTranslate(xPos, yPos, el) {
        el.style.transform = `translate3d(${xPos}px, ${yPos}px, 0)`;
    }
    
    
});
    </script>
</body>
</html>