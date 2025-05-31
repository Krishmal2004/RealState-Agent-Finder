<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Analytics - Real Estate Agent Finder</title>

    <!-- CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">

    <style>
        :root {
            --primary: #000c24;
            --secondary: #001a4d;
            --accent: #0055ff;
            --light: #ffffff;
            --success: #28a745;
            --warning: #ffc107;
            --danger: #dc3545;
        }

        body {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            min-height: 100vh;
            font-family: 'Poppins', sans-serif;
            color: var(--light);
        }

        .dashboard-btn {
            position: fixed;
            top: 20px;
            left: 20px;
            background: rgba(0, 85, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 0.8rem 1.2rem;
            border-radius: 15px;
            color: white;
            text-decoration: none;
            z-index: 1000;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 0.9rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
        }

        .dashboard-btn:hover {
            background: rgba(0, 85, 255, 0.2);
            transform: translateX(-5px);
            color: white;
            text-decoration: none;
        }

        .analytics-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: transform 0.3s ease;
        }

        .analytics-card:hover {
            transform: translateY(-5px);
        }

        .time-display {
            position: fixed;
            top: 20px;
            right: 20px;
            background: rgba(0, 85, 255, 0.1);
            backdrop-filter: blur(8px);
            padding: 0.8rem 1.2rem;
            border-radius: 15px;
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.2);
            font-size: 0.9rem;
            z-index: 1000;
        }

        .welcome-text {
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            background: rgba(0, 85, 255, 0.1);
            backdrop-filter: blur(8px);
            padding: 0.8rem 1.2rem;
            border-radius: 15px;
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.2);
            font-size: 0.9rem;
            z-index: 1000;
            white-space: nowrap;
        }

        .activity-log {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
            padding: 1rem;
            margin-bottom: 1rem;
            border-left: 4px solid var(--accent);
        }

        .activity-success {
            border-left-color: var(--success);
        }

        .activity-warning {
            border-left-color: var(--warning);
        }

        .activity-danger {
            border-left-color: var(--danger);
        }

        .device-icon {
            font-size: 2rem;
            margin-bottom: 0.5rem;
            color: var(--accent);
        }

        .chart-container {
            height: 300px;
            position: relative;
            margin-bottom: 1rem;
        }

        .stat-card {
            background: rgba(0, 85, 255, 0.1);
            border-radius: 15px;
            padding: 1.5rem;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            background: rgba(0, 85, 255, 0.2);
        }

        .stat-icon {
            font-size: 2rem;
            margin-bottom: 1rem;
            color: var(--accent);
        }

        .stat-number {
            font-size: 1.5rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }

        .custom-table {
            color: white;
        }

        .custom-table th {
            background: rgba(0, 85, 255, 0.1);
            border-color: rgba(255, 255, 255, 0.1);
        }

        .custom-table td {
            border-color: rgba(255, 255, 255, 0.1);
        }
    </style>
</head>
<body>
    <!-- Back to Dashboard Button -->
    <a href="userDashboard.jsp" class="dashboard-btn animate__animated animate__fadeIn">
        <i class="fas fa-tachometer-alt me-2"></i>
        <span>Back to Dashboard</span>
    </a>

    <!-- Time Display -->
    <div class="time-display animate__animated animate__fadeIn">
        <i class="fas fa-clock me-2"></i>
        <span id="current-time">2025-03-16 12:43:07</span>
    </div>



    <div class="container py-5">
        <!-- Summary Stats -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="analytics-card">
                    <div class="stat-card">
                        <i class="fas fa-sign-in-alt stat-icon"></i>
                        <div class="stat-number">157</div>
                        <div>Total Logins</div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="analytics-card">
                    <div class="stat-card">
                        <i class="fas fa-clock stat-icon"></i>
                        <div class="stat-number">45h 23m</div>
                        <div>Time Active</div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="analytics-card">
                    <div class="stat-card">
                        <i class="fas fa-globe stat-icon"></i>
                        <div class="stat-number">3</div>
                        <div>Active Devices</div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="analytics-card">
                    <div class="stat-card">
                        <i class="fas fa-shield-alt stat-icon"></i>
                        <div class="stat-number">100%</div>
                        <div>Security Score</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Login Activity Chart -->
        <div class="analytics-card">
            <h5 class="mb-4">Your Login Activity</h5>
            <div class="chart-container">
                <canvas id="loginChart"></canvas>
            </div>
        </div>

        <!-- Recent Login Sessions -->
        <div class="analytics-card">
            <h5 class="mb-4">Recent Login Sessions</h5>
            <div class="table-responsive">
                <table class="table custom-table">
                    <thead>
                        <tr>
                            <th>Date & Time</th>
                            <th>Device</th>
                            <th>Location</th>
                            <th>IP Address</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>2025-03-16 12:43:07</td>
                            <td><i class="fas fa-laptop me-2"></i>Windows PC</td>
                            <td>Colombo, Sri Lanka</td>
                            <td>192.168.1.1</td>
                            <td><span class="badge bg-success">Current Session</span></td>
                        </tr>
                        <tr>
                            <td>2025-03-16 09:15:22</td>
                            <td><i class="fas fa-mobile-alt me-2"></i>iPhone 15</td>
                            <td>Kandy, Sri Lanka</td>
                            <td>192.168.1.2</td>
                            <td><span class="badge bg-secondary">Ended</span></td>
                        </tr>
                        <tr>
                            <td>2025-03-15 18:30:45</td>
                            <td><i class="fas fa-tablet-alt me-2"></i>iPad Pro</td>
                            <td>Galle, Sri Lanka</td>
                            <td>192.168.1.3</td>
                            <td><span class="badge bg-secondary">Ended</span></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Security Recommendations -->
        <div class="analytics-card">
            <h5 class="mb-4">Security Recommendations</h5>
            <div class="activity-log activity-success">
                <i class="fas fa-check-circle me-2"></i>
                Two-factor authentication is enabled
            </div>
            <div class="activity-log activity-warning">
                <i class="fas fa-exclamation-triangle me-2"></i>
                Password was last changed 85 days ago
            </div>
            <div class="activity-log">
                <i class="fas fa-info-circle me-2"></i>
                3 devices are currently logged into your account
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
            const formattedTime = now.getUTCFullYear() + '-' + 
                                String(now.getUTCMonth() + 1).padStart(2, '0') + '-' + 
                                String(now.getUTCDate()).padStart(2, '0') + ' ' + 
                                String(now.getUTCHours()).padStart(2, '0') + ':' + 
                                String(now.getUTCMinutes()).padStart(2, '0') + ':' + 
                                String(now.getUTCSeconds()).padStart(2, '0');
            timeElement.textContent = formattedTime;
        }
        setInterval(updateTime, 1000);

        // Login Activity Chart
        const ctx = document.getElementById('loginChart').getContext('2d');
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                datasets: [{
                    label: 'Login Sessions',
                    data: [5, 8, 6, 9, 7, 4, 6],
                    borderColor: '#0055ff',
                    backgroundColor: 'rgba(0, 85, 255, 0.1)',
                    fill: true,
                    tension: 0.4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        labels: {
                            color: 'white'
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: {
                            color: 'rgba(255, 255, 255, 0.1)'
                        },
                        ticks: {
                            color: 'white'
                        }
                    },
                    x: {
                        grid: {
                            color: 'rgba(255, 255, 255, 0.1)'
                        },
                        ticks: {
                            color: 'white'
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>