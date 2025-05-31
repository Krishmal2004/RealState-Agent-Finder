<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Real Estate Agent Finder</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <!-- AOS Library -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #0a1f44 0%, #1a3a6c 100%);
            min-height: 100vh;
            overflow-x: hidden;
        }

        #particles-js {
            position: fixed;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: 0;
        }

        .register-container {
            position: relative;
            z-index: 1;
            padding: 2rem 0;
        }

        .register-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
        }

        .register-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
        }

        .input-group {
            transition: all 0.3s ease;
        }

        .input-group:hover {
            transform: translateX(5px);
        }

        .input-group-text {
            background-color: #f8f9fa;
            border: none;
            color: #0a1f44;
        }

        .form-control {
            border: 1px solid #dee2e6;
            padding: 0.75rem;
        }

        .form-control:focus {
            box-shadow: 0 0 0 3px rgba(10, 31, 68, 0.1);
            border-color: #0a1f44;
        }

        .btn-register {
            background: #0a1f44;
            color: white;
            padding: 12px;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .btn-register:hover {
            background: #1a3a6c;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(10, 31, 68, 0.2);
        }

        .floating {
            animation: floating 3s ease-in-out infinite;
        }

        @keyframes floating {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
            100% { transform: translateY(0px); }
        }

        .current-time {
            position: fixed;
            top: 20px;
            right: 20px;
            color: white;
            background: rgba(0, 0, 0, 0.5);
            padding: 10px;
            border-radius: 10px;
            font-size: 0.9rem;
            z-index: 1000;
        }

        .password-strength {
            height: 5px;
            margin-top: 5px;
            border-radius: 3px;
            transition: all 0.3s ease;
        }
    </style>
</head>
<body>
    <!-- Particles.js Container -->
    <div id="particles-js"></div>

    <!-- Current Time Display -->
    <div class="current-time">
        <i class="fas fa-clock me-2"></i>
        <span id="current-time">2025-03-14 08:36:11</span>
    </div>

    <!-- Main Content -->
    <div class="container register-container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="register-card p-4" data-aos="fade-up" data-aos-duration="1000">
                    <!-- Header -->
                    <div class="text-center mb-4">
                        <i class="fas fa-user-plus fa-3x text-primary floating mb-3"></i>
                        <h2 class="animate__animated animate__fadeInDown">Create Account</h2>
                        <p class="text-muted animate__animated animate__fadeIn animate__delay-1s">
                            Join our Real Estate Community
                        </p>
                    </div>

                    <!-- Registration Form -->
                    <form id="registrationForm" action="register" method="POST" >
                    	
                        <!-- Full Name -->
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <div class="input-group mb-3">
                                    <span class="input-group-text">
                                        <i class="fas fa-user"></i>
                                    </span>
                                    <input type="text" name="firstName" class="form-control" placeholder="First Name" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-user"></i>
                                    </span>
                                    <input type="text" class="form-control" placeholder="Last Name" required>
                                </div>
                            </div>
                        </div>

                        <!-- Email -->
                        <div class="input-group mb-3">
                            <span class="input-group-text">
                                <i class="fas fa-envelope"></i>
                            </span>
                            <input name="email" type="text" class="form-control" placeholder="Email address" required>
                        </div>

                        <!-- Phone -->
                        <div class="input-group mb-3">
                            <span class="input-group-text">
                                <i class="fas fa-phone"></i>
                            </span>
                            <input name="phone" type="tel" class="form-control" placeholder="Phone Number" required>
                        </div>

                        <!-- Password -->
                        <div class="input-group mb-2">
                            <span class="input-group-text">
                                <i class="fas fa-lock"></i>
                            </span>
                            <input name = "password" type="password" id="password" class="form-control" placeholder="Password" required>
                        </div>
                        <div class="password-strength w-100 mb-3"></div>

                        <!-- Confirm Password -->
                        <div class="input-group mb-3">
                            <span class="input-group-text">
                                <i class="fas fa-lock"></i>
                            </span>
                            <input type="password" id="confirmPassword" class="form-control" placeholder="Confirm Password" required>
                        </div>

                        <!-- User Type Selection -->
                        <div class="mb-3">
                            <label class="form-label">Register as:</label>
                            <div class="d-flex gap-3">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="userType" id="buyer" value="buyer" checked>
                                    <label class="form-check-label" for="buyer">
                                        <i class="fas fa-home me-1"></i> Buyer/Renter
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="userType" id="agent" value="agent">
                                    <label class="form-check-label" for="agent">
                                        <i class="fas fa-user-tie me-1"></i> Real Estate Agent
                                    </label>
                                </div>
                            </div>
                        </div>

                        <!-- Terms and Conditions -->
                        <div class="form-check mb-3">
                            <input class="form-check-input" type="checkbox" id="terms" required>
                            <label class="form-check-label" for="terms">
                                I agree to the <a href="terms.jsp" class="text-primary">Terms and Conditions</a>
                            </label>
                        </div>

                        <!-- Submit Button -->
                        <button type="submit" class="btn btn-register w-100 mb-3 animate__animated animate__pulse animate__infinite">
                            <i class="fas fa-user-plus me-2"></i>Create Account
                        </button>

                        <!-- Login Link -->
                        <div class="text-center">
                            <p class="mb-0">
                                Already have an account? 
                                <a href="UserLogin.jsp" class="text-primary">Login here</a>
                            </p>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>

    <script>
        // Initialize AOS
        AOS.init();

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

        // Update current time
        function updateTime() {
            const timeElement = document.getElementById('current-time');
            const now = new Date();
            const formattedTime = now.toISOString().slice(0, 19).replace('T', ' ');
            timeElement.textContent = formattedTime;
        }
        setInterval(updateTime, 1000);

        // Password strength indicator
        const password = document.getElementById('password');
        const strengthBar = document.querySelector('.password-strength');

        password.addEventListener('input', function() {
            const strength = calculatePasswordStrength(this.value);
            updateStrengthBar(strength);
        });

        function calculatePasswordStrength(password) {
            let strength = 0;
            if (password.length >= 8) strength += 25;
            if (password.match(/[A-Z]/)) strength += 25;
            if (password.match(/[0-9]/)) strength += 25;
            if (password.match(/[^A-Za-z0-9]/)) strength += 25;
            return strength;
        }

        function updateStrengthBar(strength) {
            strengthBar.style.width = strength + '%';
            if (strength < 25) {
                strengthBar.style.backgroundColor = '#ff4444';
            } else if (strength < 50) {
                strengthBar.style.backgroundColor = '#ffbb33';
            } else if (strength < 75) {
                strengthBar.style.backgroundColor = '#00C851';
            } else {
                strengthBar.style.backgroundColor = '#007E33';
            }
        }

        // Form validation
        const form = document.getElementById('registrationForm');
        const confirmPassword = document.getElementById('confirmPassword');

        form.addEventListener('submit', function(e) {
            if (password.value !== confirmPassword.value) {
                e.preventDefault();
                alert('Passwords do not match!');
                return;
            }
            // Add your form submission logic here
            alert('Registration successful!');
        });

        // Add animation to input fields on focus
        document.querySelectorAll('.form-control').forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.classList.add('animate__animated', 'animate__pulse');
            });
            
            input.addEventListener('blur', function() {
                this.parentElement.classList.remove('animate__animated', 'animate__pulse');
            });
        });
    </script>
</body>
</html>