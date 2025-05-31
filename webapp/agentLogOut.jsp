<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agent Logout | Real Estate Solutions</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #0f172a;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            padding: 20px;
            color: #e2e8f0;
        }

        .logout-container {
            background: rgba(30, 41, 59, 0.5);
            backdrop-filter: blur(10px);
            border-radius: 16px;
            padding: 40px;
            max-width: 480px;
            width: 100%;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .timer {
            font-size: 48px;
            font-weight: bold;
            color: #f8fafc;
            text-align: center;
            margin: 20px 0;
            text-shadow: 0 0 10px rgba(59, 130, 246, 0.5);
        }

        .status-bar {
            height: 4px;
            background: rgba(59, 130, 246, 0.2);
            border-radius: 2px;
            margin: 20px 0;
            overflow: hidden;
        }

        .status-progress {
            height: 100%;
            background: #3b82f6;
            width: 100%;
            animation: countdown 5s linear forwards;
        }

        @keyframes countdown {
            from { width: 100%; }
            to { width: 0%; }
        }

        .user-info {
            text-align: center;
            margin-bottom: 30px;
        }

        .user-avatar {
            width: 80px;
            height: 80px;
            background: #3b82f6;
            border-radius: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            font-size: 32px;
        }

        .btn-custom {
            background: rgba(59, 130, 246, 0.1);
            border: 1px solid rgba(59, 130, 246, 0.2);
            color: #e2e8f0;
            padding: 12px 24px;
            border-radius: 8px;
            transition: all 0.3s ease;
            width: 100%;
            margin-bottom: 10px;
        }

        .btn-custom:hover {
            background: rgba(59, 130, 246, 0.2);
            border-color: rgba(59, 130, 246, 0.3);
            color: #f8fafc;
            transform: translateY(-2px);
        }

        .info-box {
            background: rgba(30, 41, 59, 0.3);
            border-radius: 12px;
            padding: 20px;
            margin: 20px 0;
            border: 1px solid rgba(255, 255, 255, 0.05);
        }

        .info-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
            padding: 10px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
        }

        .info-item:last-child {
            border-bottom: none;
            margin-bottom: 0;
        }

        .time-display {
            position: absolute;
            top: 20px;
            right: 20px;
            background: rgba(30, 41, 59, 0.7);
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 14px;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
    </style>
</head>
<body>
    <div class="time-display">
        <i class="far fa-clock me-2"></i>2025-03-21 20:39:31
    </div>

    <div class="logout-container">
        <div class="user-info">
            <div class="user-avatar">
                <i class="fas fa-user"></i>
            </div>
            <h3 class="mb-2">Krishmal2004</h3>
            <p class="text-muted mb-0">Agent Session Ending</p>
        </div>

        <div class="info-box">
            <div class="info-item">
                <span><i class="fas fa-shield-alt me-2"></i>Session Status</span>
                <span class="text-warning">Ending</span>
            </div>
            <div class="info-item">
                <span><i class="fas fa-history me-2"></i>Last Activity</span>
                <span>Just Now</span>
            </div>
            <div class="info-item">
                <span><i class="fas fa-location-arrow me-2"></i>Location</span>
                <span>Web Portal</span>
            </div>
        </div>

        <div class="timer" id="countdown">5</div>
        <div class="status-bar">
            <div class="status-progress"></div>
        </div>

        <div class="d-grid gap-2">
    		<a href="AgentLogin.jsp" class="btn btn-custom">
        		<i class="fas fa-sign-in-alt me-2"></i>Manual Logout
    		</a>
    		<a href="agentDashBoard.jsp" class="btn btn-custom">
        		<i class="fas fa-arrow-left me-2"></i>Return to Dashboard
    		</a>
		</div>

        <div class="text-center mt-4">
            <small class="text-muted">
                <i class="fas fa-info-circle me-1"></i>
                Your session will end automatically in a few seconds
            </small>
        </div>
    </div>

    <script>
        <%
            session.invalidate();
        %>

        let timeLeft = 5;
        const countdownElement = document.getElementById('countdown');

        const countdown = setInterval(() => {
            timeLeft--;
            countdownElement.textContent = timeLeft;

            if (timeLeft <= 0) {
                clearInterval(countdown);
                window.location.href = 'AgentLogin.jsp';
            }
        }, 1000);

        // Prevent back button
        window.history.pushState(null, '', window.location.href);
        window.onpopstate = function() {
            window.history.pushState(null, '', window.location.href);
        };
    </script>
</body>
</html>