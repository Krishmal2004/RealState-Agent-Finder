<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logging Out - Real Estate Agent Finder</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">

    <style>
        :root {
            --dark-blue-1: #000c24;
            --dark-blue-2: #001a4d;
            --blue-accent: #0055ff;
            --light-blue: #e6f0ff;
            --white: #ffffff;
            --card-bg: rgba(255, 255, 255, 0.1);
        }

        body {
            min-height: 100vh;
            background: linear-gradient(135deg, var(--dark-blue-1), var(--dark-blue-2));
            font-family: 'Poppins', sans-serif;
            overflow: hidden;
        }

        .logout-card {
            background: var(--card-bg);
            backdrop-filter: blur(12px);
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 2.5rem 2rem;
            color: var(--white);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 90%;
            opacity: 0;
            transform: translateY(20px);
            animation: slideUp 0.6s ease forwards;
        }

        @keyframes slideUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .avatar-container {
            width: 100px;
            height: 100px;
            margin: 0 auto;
            transform: scale(0.9);
            animation: scaleIn 0.5s ease 0.3s forwards;
        }

        @keyframes scaleIn {
            to {
                transform: scale(1);
            }
        }

        .user-avatar {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            border: 2px solid var(--blue-accent);
            padding: 2px;
            background: var(--white);
            box-shadow: 0 0 15px rgba(0, 85, 255, 0.3);
        }

        .countdown-circle {
            width: 120px;
            height: 120px;
            margin: 1.5rem auto;
            background: rgba(0, 85, 255, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 2px solid var(--blue-accent);
            opacity: 0;
            animation: fadeIn 0.5s ease 0.6s forwards;
        }

        @keyframes fadeIn {
            to {
                opacity: 1;
            }
        }

        .countdown-text {
            font-size: 2.5rem;
            font-weight: bold;
            color: var(--white);
            text-shadow: 0 0 8px rgba(0, 85, 255, 0.5);
        }

        .btn-custom {
            background: rgba(0, 85, 255, 0.15);
            border: 1px solid var(--blue-accent);
            color: var(--white);
            padding: 0.6rem 1.2rem;
            border-radius: 12px;
            transition: all 0.3s ease;
            opacity: 0;
            transform: translateY(10px);
            animation: fadeInUp 0.5s ease 0.9s forwards;
        }

        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .btn-custom:hover {
            background: var(--blue-accent);
            transform: translateY(-2px);
        }

        .time-display {
            position: fixed;
            top: 20px;
            right: 20px;
            background: rgba(0, 85, 255, 0.1);
            backdrop-filter: blur(8px);
            padding: 0.8rem 1.2rem;
            border-radius: 15px;
            color: var(--white);
            border: 1px solid rgba(255, 255, 255, 0.2);
            font-size: 0.9rem;
            opacity: 0;
            animation: fadeIn 0.5s ease 1.2s forwards;
        }

        .social-links {
            margin-top: 1.5rem;
            opacity: 0;
            animation: fadeIn 0.5s ease 1.5s forwards;
        }

        .social-links .btn-custom {
            width: 38px;
            height: 38px;
            padding: 0;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            margin: 0 5px;
            animation: none;
            opacity: 1;
            transform: none;
        }

        .logout-message {
            color: var(--light-blue);
            margin: 1rem 0;
            opacity: 0;
            animation: fadeIn 0.5s ease 0.4s forwards;
        }

        .heading {
            opacity: 0;
            animation: fadeIn 0.5s ease 0.2s forwards;
        }
    </style>
</head>
<body>
    <div class="time-display">
        <i class="fas fa-clock me-2"></i>
        <span id="current-time">2025-03-16 07:53:03</span>
    </div>

    <div class="container min-vh-100 d-flex align-items-center justify-content-center">
        <div class="logout-card">
            <div class="text-center">
                <div class="avatar-container">
                    <img src="https://ui-avatars.com/api/?name=Krishmal2004&background=0055ff&color=fff" 
                         alt="Krishmal2004" 
                         class="user-avatar">
                </div>
                <h2 class="mt-3 heading">Goodbye, Krishmal2004!</h2>
                <p class="logout-message">Logging you out securely...</p>
            </div>

            <div class="countdown-circle">
                <div class="countdown-text" id="countdown">5</div>
            </div>

            <p class="text-center text-white-50 mb-4 logout-message">
                Redirecting in <span id="countdown-text">5</span> seconds
            </p>

            <div class="d-flex justify-content-center gap-3">
                <a href="userDashboard.jsp" class="btn btn-custom">
                    <i class="fas fa-home me-2"></i>Return
                </a>
                <a href="UserLogin.jsp" class="btn btn-custom">
                    <i class="fas fa-sign-in-alt me-2"></i>LogOut
                </a>
            </div>

            <div class="social-links text-center">
                <p class="text-white-50 mb-2">Stay connected</p>
                <a href="" class="btn btn-custom"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="btn btn-custom"><i class="fab fa-twitter"></i></a>
                <a href="#" class="btn btn-custom"><i class="fab fa-instagram"></i></a>
                <a href="#" class="btn btn-custom"><i class="fab fa-linkedin-in"></i></a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        <%
            session.invalidate();
        %>

        function updateTime() {
            const timeElement = document.getElementById('current-time');
            const now = new Date();
            const formattedTime = now.toISOString().slice(0, 19).replace('T', ' ');
            timeElement.textContent = formattedTime;
        }
        setInterval(updateTime, 1000);

        let timeLeft = 5;
        const countdownElement = document.getElementById('countdown');
        const countdownTextElement = document.getElementById('countdown-text');

        const countdown = setInterval(() => {
            timeLeft--;
            countdownElement.textContent = timeLeft;
            countdownTextElement.textContent = timeLeft;

            if (timeLeft <= 0) {
                clearInterval(countdown);
                window.location.href = 'index.jsp';
            }
        }, 1000);

        window.history.pushState(null, '', window.location.href);
        window.onpopstate = function() {
            window.history.pushState(null, '', window.location.href);
        };

        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }
    </script>
</body>
</html>