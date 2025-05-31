<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.RealState.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agent Dashboard - Real Estate Agent Finder</title>

    <!-- CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

    <style>
        :root {
            --dark-blue-1: #000c24;
            --dark-blue-2: #001a4d;
            --blue-accent: #0055ff;
            --light-blue: #e6f0ff;
            --white: #ffffff;
            --card-bg: rgba(255, 255, 255, 0.1);
            --success-color: #28a745;
            --danger-color: #dc3545;
            --warning-color: #ffc107;
        }

        body {
            min-height: 100vh;
            background: linear-gradient(135deg, var(--dark-blue-1), var(--dark-blue-2));
            font-family: 'Poppins', sans-serif;
            color: var(--white);
        }

        .dashboard-container {
            padding: 2rem 1rem;
        }

        .dashboard-card {
            background: var(--card-bg);
            backdrop-filter: blur(12px);
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 1.5rem;
            color: var(--white);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            margin-bottom: 1.5rem;
            transition: all 0.3s ease;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
        }

        .stats-card {
            background: rgba(0, 85, 255, 0.15);
            border-radius: 15px;
            padding: 1.5rem;
            text-align: center;
            transition: all 0.3s ease;
        }

        .stats-card:hover {
            background: rgba(0, 85, 255, 0.25);
            transform: translateY(-3px);
        }

        .stats-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: var(--blue-accent);
        }

        .stats-number {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }

        .property-card {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 15px;
            padding: 1rem;
            margin-bottom: 1rem;
            transition: all 0.3s ease;
        }

        .property-card:hover {
            background: rgba(255, 255, 255, 0.1);
            transform: translateX(5px);
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 10px;
            font-size: 0.8rem;
        }

        .status-active {
            background: rgba(40, 167, 69, 0.2);
            color: #28a745;
        }

        .status-pending {
            background: rgba(255, 193, 7, 0.2);
            color: #ffc107;
        }

        .nav-link {
            color: var(--white);
            padding: 1rem 1.5rem;
            border-radius: 10px;
            margin-bottom: 0.5rem;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            background: rgba(0, 85, 255, 0.15);
            color: var(--white);
        }

        .nav-link.active {
            background: var(--blue-accent);
            color: var(--white);
        }

        .search-bar {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            padding: 0.5rem 1rem;
            color: var(--white);
        }

        .search-bar:focus {
            background: rgba(255, 255, 255, 0.15);
            border-color: var(--blue-accent);
            box-shadow: none;
            color: var(--white);
        }

        .search-bar::placeholder {
            color: rgba(255, 255, 255, 0.6);
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
            z-index: 1000;
        }

        .chart-container {
            position: relative;
            margin-top: 1rem;
            height: 300px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 15px;
            padding: 1rem;
        }

        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: var(--danger-color);
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            font-size: 0.8rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        .pulse-animation {
            animation: pulse 2s infinite;
        }
    </style>
</head>
<body>
<% User user = (User)session.getAttribute("user");%>
    <!-- Time Display -->
    

    <div class="container-fluid dashboard-container">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-lg-2">
                <div class="dashboard-card">
                    <div class="text-center mb-4">
                        <img src="https://ui-avatars.com/api/?name=Krishmal2004&background=0055ff&color=fff" 
                             alt="Agent Profile" 
                             class="rounded-circle mb-3" 
                             style="width: 100px; height: 100px;">
                        <h5 class="mb-0"><%= user.getUsername() %></h5>
                        <p class="text-light mb-0">Real Estate Agent</p>
                    </div>
                    <nav class="nav flex-column">
                        <a class="nav-link active" href="userDashboard.jsp"><i class="fas fa-tachometer-alt me-2"></i>Dashboard</a>
                        <a class="nav-link" href="userFindProperties.jsp"><i class="fas fa-home me-2"></i>Properties</a>
                        <a class="nav-link" href="clients.jsp"><i class="fas fa-users me-2"></i>Clients</a>
                        <a class="nav-link" href="appointmnets.jsp"><i class="fas fa-calendar me-2"></i>Appointments</a>
                        <a class="nav-link" href="userAnalytics.jsp"><i class="fas fa-chart-line me-2"></i>Analytics</a>
                        <a class="nav-link" href="userSetting.jsp"><i class="fas fa-cog me-2"></i>Settings</a>
                        <a class="nav-link" href="userLogOut.jsp"><i class="fas fa-sign-out-alt me-2"></i>Logout</a>
                    </nav>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-lg-10">
                <!-- Welcome Section -->
                <div class="dashboard-card">
                    <div class="row align-items-center">
                        <div class="col">
                            <h2 class="mb-0">Welcome back!</h2>
                            <p class="text-light mb-0">Here's what's happening with your properties today.</p>
                        </div>
                        <div class="col-auto">
                            <div class="position-relative">
                                <input type="text" class="form-control search-bar" placeholder="Search properties...">
                                <i class="fas fa-search position-absolute" style="right: 15px; top: 50%; transform: translateY(-50%); color: var(--white);"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Stats Row -->
                <div class="row">
                    <div class="col-md-3">
                        <div class="dashboard-card">
                            <div class="stats-card">
                                <i class="fas fa-home stats-icon"></i>
                                <div class="stats-number">24</div>
                                <div class="stats-label">Active Listings</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="dashboard-card">
                            <div class="stats-card">
                                <i class="fas fa-user-friends stats-icon"></i>
                                <div class="stats-number">156</div>
                                <div class="stats-label">Total Clients</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="dashboard-card">
                            <div class="stats-card">
                                <i class="fas fa-calendar-check stats-icon"></i>
                                <div class="stats-number">12</div>
                                <div class="stats-label">Appointments</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="dashboard-card">
                            <div class="stats-card">
                                <i class="fas fa-dollar-sign stats-icon"></i>
                                <div class="stats-number">$2.4M</div>
                                <div class="stats-label">Total Sales</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Properties -->
                <div class="dashboard-card">
                    <h4 class="mb-4">Recent Properties</h4>
                    <div class="property-card">
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <img src="https://images.unsplash.com/photo-1570129477492-45c003edd2be?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8aG91c2V8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60" alt="Property" class="rounded" style="width: 80px; height: 60px; object-fit: cover;">
                            </div>
                            <div class="col">
                                <h6 class="mb-1">Luxury Villa in Colombo 7</h6>
                                <p class="mb-0 text-light">4 beds • 3 baths • 2,500 sq ft</p>
                            </div>
                            <div class="col-auto">
                                <span class="status-badge status-active">Active</span>
                            </div>
                            <div class="col-auto">
                                <h6 class="mb-0">$750,000</h6>
                            </div>
                        </div>
                    </div>
                    <div class="property-card">
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <img src="https://images.unsplash.com/photo-1582063289852-62e3ba2747f8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fGhvdXNlfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60" alt="Property" class="rounded" style="width: 80px; height: 60px; object-fit: cover;">
                            </div>
                            <div class="col">
                                <h6 class="mb-1">Modern Apartment in Colombo 3</h6>
                                <p class="mb-0 text-light">2 beds • 2 baths • 1,200 sq ft</p>
                            </div>
                            <div class="col-auto">
                                <span class="status-badge status-pending">Pending</span>
                            </div>
                            <div class="col-auto">
                                <h6 class="mb-0">$320,000</h6>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Upcoming Appointments -->
                <div class="dashboard-card">
                    <h4 class="mb-4">Upcoming Appointments</h4>
                    <div class="table-responsive">
                        <table class="table table-dark table-hover">
                            <thead>
                                <tr>
                                    <th>Client</th>
                                    <th>Property</th>
                                    <th>Date</th>
                                    <th>Time</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>John Doe</td>
                                    <td>Luxury Villa in Colombo 7</td>
                                    <td>2025-03-17</td>
                                    <td>10:00 AM</td>
                                    <td><span class="badge bg-success">Confirmed</span></td>
                                </tr>
                                <tr>
                                    <td>Jane Smith</td>
                                    <td>Modern Apartment in Colombo 3</td>
                                    <td>2025-03-17</td>
                                    <td>2:30 PM</td>
                                    <td><span class="badge bg-warning">Pending</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        // Update time
        function updateTime() {
            const timeElement = document.getElementById('current-time');
            const now = new Date();
            const formattedTime = now.getUTC