<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Get user information before invalidating session
    String username = (String) session.getAttribute("username");
    if (username == null) {
        username = "IT24103866"; // For testing/display purposes
    }
    
    // Log the logout event (in a real application, this would be saved to a database or log file)
    String logoutTime = "2025-05-02 22:56:58";
    
    // Invalidate the session
    session.invalidate();
    
    // Set a cookie to expire the session cookie
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("JSESSIONID".equals(cookie.getName()) || "rememberMe".equals(cookie.getName())) {
                cookie.setMaxAge(0);
                cookie.setPath("/");
                response.addCookie(cookie);
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logged Out | PropertyFinder Admin</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --dark-blue: #081c45;
            --medium-blue: #0e307e;
            --light-blue: #2a4494;
            --highlight-blue: #4568dc;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, var(--dark-blue) 0%, #001a4d 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            color: white;
        }
        
        .logo-container {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .logo {
            font-size: 2.5rem;
            font-weight: bold;
            color: white;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }
        
        .logout-container {
            max-width: 600px;
            width: 100%;
            padding: 2.5rem;
            background-color: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
            text-align: center;
            margin-bottom: 2rem;
            border: 1px solid rgba(255, 255, 255, 0.15);
        }
        
        .logout-icon {
            font-size: 5rem;
            color: #4de1ff;
            margin-bottom: 1.5rem;
            text-shadow: 0 0 20px rgba(77, 225, 255, 0.5);
        }
        
        .btn-primary {
            background-color: #4de1ff;
            border-color: #4de1ff;
            color: var(--dark-blue);
            font-weight: 600;
            padding: 0.6rem 2rem;
            box-shadow: 0 4px 12px rgba(77, 225, 255, 0.3);
        }
        
        .btn-primary:hover {
            background-color: #22d3ff;
            border-color: #22d3ff;
            color: var(--dark-blue);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(77, 225, 255, 0.4);
        }
        
        .logout-info {
            color: rgba(255, 255, 255, 0.8);
            margin-top: 2rem;
            font-size: 0.9rem;
            background-color: rgba(255, 255, 255, 0.05);
            padding: 1rem;
            border-radius: 10px;
        }
        
        .main-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }
        
        .footer {
            text-align: center;
            padding: 1.5rem 0;
            color: rgba(255, 255, 255, 0.6);
            font-size: 0.9rem;
            background-color: rgba(0, 0, 0, 0.2);
            width: 100%;
            border-top: 1px solid rgba(255, 255, 255, 0.05);
        }
        
        .security-tips {
            max-width: 600px;
            margin-top: 1.5rem;
            background-color: rgba(255, 255, 255, 0.08);
            padding: 1.5rem;
            border-radius: 12px;
            text-align: left;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .security-tips h5 {
            color: #4de1ff;
            font-size: 1.2rem;
            margin-bottom: 1rem;
        }
        
        .security-tips ul {
            padding-left: 1.5rem;
            margin-bottom: 0;
            color: rgba(255, 255, 255, 0.9);
        }
        
        .security-tips li {
            margin-bottom: 0.75rem;
        }
        
        .security-tips li:last-child {
            margin-bottom: 0;
        }
        
        .security-icon {
            background-color: rgba(77, 225, 255, 0.15);
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 10px;
            color: #4de1ff;
        }
        
        .return-home {
            position: absolute;
            top: 20px;
            left: 20px;
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            display: flex;
            align-items: center;
            font-size: 0.9rem;
        }
        
        .return-home:hover {
            color: white;
        }
        
        .return-home i {
            margin-right: 5px;
            font-size: 0.85rem;
        }
        
        .highlight {
            color: #4de1ff;
            font-weight: 500;
        }
        
        @media (max-width: 576px) {
            .logout-container {
                padding: 1.5rem;
            }
            
            .logo {
                font-size: 2rem;
            }
            
            .logout-icon {
                font-size: 4rem;
            }
        }
    </style>
</head>
<body>
    <a href="login.jsp" class="return-home">
        <i class="fas fa-chevron-left"></i> Return to Login
    </a>
    
    <div class="main-content">
        <div class="logo-container">
            <a href="login.jsp" class="logo">
                <i class="fas fa-building me-2"></i> PropertyFinder
            </a>
        </div>
        
        <div class="logout-container">
            <div class="logout-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            
            <h2>Successfully Logged Out</h2>
            <p class="lead">Thank you for using the PropertyFinder Administrative System</p>
            
            <div class="mt-4">
                <a href="login.jsp" class="btn btn-primary btn-lg">
                    <i class="fas fa-sign-in-alt me-2"></i> Log In Again
                </a>
            </div>
            
            <div class="logout-info">
                <p class="mb-2">User: <span class="highlight"><%= username %></span></p>
                <p class="mb-2">Logout Time: <span class="highlight"><%= logoutTime %></span></p>
                <p class="mb-0">For security reasons, please close your browser after logging out.</p>
            </div>
        </div>
        
        <div class="security-tips">
            <h5><i class="fas fa-shield-alt me-2"></i>Security Recommendations</h5>
            <ul>
                <li>Always log out when you're finished using the system, especially on shared devices.</li>
                <li>Never share your login credentials with others or write them down in unsecured locations.</li>
                <li>Ensure you're accessing the system through a secure connection (https://).</li>
                <li>Regularly change your password and use a combination of letters, numbers, and special characters.</li>
                <li>Enable two-factor authentication for an additional layer of security.</li>
            </ul>
        </div>
    </div>
    
    <footer class="footer">
        <div class="container">
            <p>&copy; 2025 PropertyFinder Administrative System. All rights reserved.</p>
            <p class="mb-0">Current Date and Time (UTC): 2025-05-02 22:56:58 | User: IT24103866</p>
        </div>
    </footer>
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Clear localStorage/sessionStorage if used in your application
            localStorage.removeItem('userSettings');
            sessionStorage.removeItem('activeSettingsTab');
            
            // Add a subtle animation to the logout icon
            const logoutIcon = document.querySelector('.logout-icon');
            if (logoutIcon) {
                logoutIcon.style.transition = 'transform 0.5s ease-in-out';
                setTimeout(() => {
                    logoutIcon.style.transform = 'scale(1.1)';
                    setTimeout(() => {
                        logoutIcon.style.transform = 'scale(1)';
                    }, 500);
                }, 300);
            }
        });
    </script>
</body>
</html>