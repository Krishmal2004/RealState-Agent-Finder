<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Settings - Real Estate Agent Finder</title>

    <!-- CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">

    <style>
        :root {
            --primary: #0a1f44;
            --secondary: #1a3a6c;
            --accent: #4a90e2;
            --success: #28a745;
            --warning: #ffc107;
            --danger: #dc3545;
            --light: #ffffff;
            --dark: #000000;
        }

        body {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            min-height: 100vh;
            font-family: 'Arial', sans-serif;
            color: var(--light);
        }

        .admin-nav {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 1rem;
            margin-bottom: 2rem;
        }

        .admin-nav-link {
            color: var(--light);
            padding: 0.8rem 1.2rem;
            border-radius: 10px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .admin-nav-link:hover, .admin-nav-link.active {
            background: rgba(255, 255, 255, 0.1);
            transform: translateY(-2px);
        }

        .settings-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            border: 1px solid rgba(255, 255, 255, 0.1);
            transition: transform 0.3s ease;
        }

        .settings-card:hover {
            transform: translateY(-5px);
        }

        .form-control, .form-select {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: var(--light);
            padding: 0.8rem;
            border-radius: 10px;
        }

        .form-control:focus, .form-select:focus {
            background: rgba(255, 255, 255, 0.15);
            color: var(--light);
            border-color: var(--accent);
            box-shadow: none;
        }

        .time-display {
            position: fixed;
            top: 20px;
            right: 20px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(8px);
            padding: 0.8rem 1.2rem;
            border-radius: 15px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            font-size: 0.9rem;
            z-index: 1000;
        }

        .toggle-switch {
            position: relative;
            display: inline-block;
            width: 60px;
            height: 34px;
        }

        .toggle-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .toggle-slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(255, 255, 255, 0.1);
            transition: .4s;
            border-radius: 34px;
        }

        .toggle-slider:before {
            position: absolute;
            content: "";
            height: 26px;
            width: 26px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }

        input:checked + .toggle-slider {
            background-color: var(--accent);
        }

        input:checked + .toggle-slider:before {
            transform: translateX(26px);
        }

        .status-badge {
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            background: rgba(40, 167, 69, 0.2);
            color: var(--success);
        }

        .chart-container {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
            padding: 1rem;
            height: 300px;
        }
    </style>
</head>
<body>
    <!-- Time Display -->
    <div class="time-display animate__animated animate__fadeIn">
        <i class="fas fa-clock me-2"></i>
        <span id="current-time">2025-03-19 12:51:55</span>
    </div>

    <div class="container py-5">
        <!-- Admin Navigation -->
        <div class="admin-nav animate__animated animate__fadeInDown">
            <div class="d-flex justify-content-between align-items-center flex-wrap">
                <div class="d-flex gap-3">
                    <a href="#" class="admin-nav-link active">
                        <i class="fas fa-cog"></i> Settings
                    </a>
                    <a href="#" class="admin-nav-link">
                        <i class="fas fa-users"></i> Users
                    </a>
                    <a href="#" class="admin-nav-link">
                        <i class="fas fa-chart-bar"></i> Analytics
                    </a>
                    <a href="#" class="admin-nav-link">
                        <i class="fas fa-shield-alt"></i> Security
                    </a>
                </div>
                <div class="d-flex align-items-center">
                    <span class="me-3">Welcome, Krishmal2004</span>
                    <a href="logout.jsp" class="btn btn-outline-light btn-sm">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </div>
            </div>
        </div>

        <!-- Settings Grid -->
        <div class="row">
            <!-- General Settings -->
            <div class="col-md-6">
                <div class="settings-card animate__animated animate__fadeInLeft">
                    <h4 class="mb-4"><i class="fas fa-sliders-h me-2"></i>General Settings</h4>
                    <form>
                        <div class="mb-3">
                            <label class="form-label">Site Name</label>
                            <input type="text" class="form-control" value="Real Estate Agent Finder">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Contact Email</label>
                            <input type="email" class="form-control" value="admin@realestateagentfinder.com">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Language</label>
                            <select class="form-select">
                                <option value="en">English</option>
                                <option value="es">Spanish</option>
                                <option value="fr">French</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Timezone</label>
                            <select class="form-select">
                                <option value="UTC">UTC</option>
                                <option value="EST">EST</option>
                                <option value="PST">PST</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </form>
                </div>
            </div>

            <!-- Security Settings -->
            <div class="col-md-6">
                <div class="settings-card animate__animated animate__fadeInRight">
                    <h4 class="mb-4"><i class="fas fa-shield-alt me-2"></i>Security Settings</h4>
                    <div class="mb-4">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div>
                                <h6 class="mb-0">Two-Factor Authentication</h6>
                                <small class="text-muted">Enhance your account security</small>
                            </div>
                            <label class="toggle-switch">
                                <input type="checkbox" checked>
                                <span class="toggle-slider"></span>
                            </label>
                        </div>
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div>
                                <h6 class="mb-0">Login Notifications</h6>
                                <small class="text-muted">Get notified of new logins</small>
                            </div>
                            <label class="toggle-switch">
                                <input type="checkbox">
                                <span class="toggle-slider"></span>
                            </label>
                        </div>
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="mb-0">API Access</h6>
                                <small class="text-muted">Allow API integrations</small>
                            </div>
                            <label class="toggle-switch">
                                <input type="checkbox" checked>
                                <span class="toggle-slider"></span>
                            </label>
                        </div>
                    </div>
                    <hr>
                    <h6>Active Sessions</h6>
                    <div class="mb-3">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <div>
                                <i class="fas fa-laptop me-2"></i>
                                Windows 10 - Chrome
                                <br>
                                <small class="text-muted">Last active: 2 minutes ago</small>
                            </div>
                            <span class="status-badge">Current</span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <i class="fas fa-mobile-alt me-2"></i>
                                iPhone 13 - Safari
                                <br>
                                <small class="text-muted">Last active: 1 hour ago</small>
                            </div>
                            <button class="btn btn-sm btn-outline-danger">
                                <i class="fas fa-times"></i> End
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- System Status -->
            <div class="col-md-12">
                <div class="settings-card animate__animated animate__fadeInUp">
                    <h4 class="mb-4"><i class="fas fa-server me-2"></i>System Status</h4>
                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <div class="chart-container">
                                <canvas id="cpuChart"></canvas>
                            </div>
                            <h6 class="text-center mt-2">CPU Usage</h6>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="chart-container">
                                <canvas id="memoryChart"></canvas>
                            </div>
                            <h6 class="text-center mt-2">Memory Usage</h6>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="chart-container">
                                <canvas id="diskChart"></canvas>
                            </div>
                            <h6 class="text-center mt-2">Disk Usage</h6>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="chart-container">
                                <canvas id="networkChart"></canvas>
                            </div>
                            <h6 class="text-center mt-2">Network Traffic</h6>
                        </div>
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
            const formattedTime = now.getUTCFullYear() + '-' + 
                                String(now.getUTCMonth() + 1).padStart(2, '0') + '-' + 
                                String(now.getUTCDate()).padStart(2, '0') + ' ' + 
                                String(now.getUTCHours()).padStart(2, '0') + ':' + 
                                String(now.getUTCMinutes()).padStart(2, '0') + ':' + 
                                String(now.getUTCSeconds()).padStart(2, '0');
            timeElement.textContent = formattedTime;
        }
        setInterval(updateTime, 1000);

        // Initialize Charts
        function initializeCharts() {
            const chartConfigs = {
                cpu: {
                    id: 'cpuChart',
                    data: [45, 62, 58, 71, 63, 55, 48],
                    color: '#4a90e2'
                },
                memory: {
                    id: 'memoryChart',
                    data: [68, 72, 75, 70, 73, 77, 74],
                    color: '#28a745'
                },
                disk: {
                    id: 'diskChart',
                    data: [82, 83, 83, 84, 84, 85, 85],
                    color: '#ffc107'
                },
                network: {
                    id: 'networkChart',
                    data: [25, 45, 32, 67, 43, 38, 41],
                    color: '#dc3545'
                }
            };

            Object.values(chartConfigs).forEach(config => {
                const ctx = document.getElementById(config.id).getContext('2d');
                new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                        datasets: [{
                            data: config.data,
                            borderColor: config.color,
                            backgroundColor: config.color + '20',
                            fill