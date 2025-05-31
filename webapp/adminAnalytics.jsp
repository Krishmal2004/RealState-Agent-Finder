<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.time.format.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%!
    // Generate sample monthly data for properties
    public Map<String, List<Integer>> generateMonthlySalesData() {
        Map<String, List<Integer>> monthlySales = new HashMap<>();
        List<Integer> sold = Arrays.asList(5, 7, 8, 12, 15, 18, 22, 25, 20, 17, 14, 16);
        List<Integer> listed = Arrays.asList(12, 15, 18, 22, 25, 28, 30, 32, 27, 24, 20, 25);
        List<Integer> pending = Arrays.asList(3, 5, 4, 6, 7, 5, 8, 10, 8, 6, 5, 7);
        
        monthlySales.put("sold", sold);
        monthlySales.put("listed", listed);
        monthlySales.put("pending", pending);
        
        return monthlySales;
    }
    
    // Generate sample monthly revenue data
    public List<Integer> generateMonthlyRevenueData() {
        return Arrays.asList(150000, 220000, 250000, 320000, 380000, 420000, 
                            480000, 510000, 450000, 400000, 350000, 430000);
    }
    
    // Generate regional data for properties
    public Map<String, Map<String, Integer>> generateRegionalData() {
        Map<String, Map<String, Integer>> regionalData = new HashMap<>();
        
        Map<String, Integer> downtown = new HashMap<>();
        downtown.put("count", 45);
        downtown.put("sold", 22);
        downtown.put("averagePrice", 450000);
        regionalData.put("Downtown", downtown);
        
        Map<String, Integer> northDistrict = new HashMap<>();
        northDistrict.put("count", 38);
        northDistrict.put("sold", 18);
        northDistrict.put("averagePrice", 380000);
        regionalData.put("North District", northDistrict);
        
        Map<String, Integer> westside = new HashMap<>();
        westside.put("count", 52);
        westside.put("sold", 31);
        westside.put("averagePrice", 520000);
        regionalData.put("Westside", westside);
        
        Map<String, Integer> southEast = new HashMap<>();
        southEast.put("count", 35);
        southEast.put("sold", 16);
        southEast.put("averagePrice", 290000);
        regionalData.put("South East", southEast);
        
        Map<String, Integer> suburban = new HashMap<>();
        suburban.put("count", 64);
        suburban.put("sold", 38);
        suburban.put("averagePrice", 340000);
        regionalData.put("Suburban", suburban);
        
        return regionalData;
    }
    
    // Generate property type performance data
    public Map<String, Map<String, Object>> generatePropertyTypePerformance() {
        Map<String, Map<String, Object>> propertyTypePerformance = new HashMap<>();
        
        Map<String, Object> house = new HashMap<>();
        house.put("count", 85);
        house.put("averagePrice", 420000);
        house.put("averageDaysOnMarket", 45);
        house.put("conversionRate", 68.5);
        propertyTypePerformance.put("House", house);
        
        Map<String, Object> apartment = new HashMap<>();
        apartment.put("count", 110);
        apartment.put("averagePrice", 280000);
        apartment.put("averageDaysOnMarket", 38);
        apartment.put("conversionRate", 72.3);
        propertyTypePerformance.put("Apartment", apartment);
        
        Map<String, Object> commercial = new HashMap<>();
        commercial.put("count", 25);
        commercial.put("averagePrice", 850000);
        commercial.put("averageDaysOnMarket", 85);
        commercial.put("conversionRate", 42.0);
        propertyTypePerformance.put("Commercial", commercial);
        
        Map<String, Object> land = new HashMap<>();
        land.put("count", 18);
        land.put("averagePrice", 320000);
        land.put("averageDaysOnMarket", 120);
        land.put("conversionRate", 33.5);
        propertyTypePerformance.put("Land", land);
        
        return propertyTypePerformance;
    }
    
    // Generate top performing agents data
    public List<Map<String, Object>> generateTopAgentsData() {
        List<Map<String, Object>> topAgents = new ArrayList<>();
        
        Map<String, Object> agent1 = new HashMap<>();
        agent1.put("name", "John Doe");
        agent1.put("specialty", "Residential");
        agent1.put("propertiesSold", 24);
        agent1.put("revenue", 1250000);
        agent1.put("customerRating", 4.8);
        agent1.put("performance", 92);
        topAgents.add(agent1);
        
        Map<String, Object> agent2 = new HashMap<>();
        agent2.put("name", "Jane Smith");
        agent2.put("specialty", "Commercial");
        agent2.put("propertiesSold", 18);
        agent2.put("revenue", 2100000);
        agent2.put("customerRating", 4.7);
        agent2.put("performance", 88);
        topAgents.add(agent2);
        
        Map<String, Object> agent3 = new HashMap<>();
        agent3.put("name", "Alex Johnson");
        agent3.put("specialty", "Luxury");
        agent3.put("propertiesSold", 12);
        agent3.put("revenue", 1750000);
        agent3.put("customerRating", 4.9);
        agent3.put("performance", 85);
        topAgents.add(agent3);
        
        Map<String, Object> agent4 = new HashMap<>();
        agent4.put("name", "Sarah Williams");
        agent4.put("specialty", "Residential");
        agent4.put("propertiesSold", 21);
        agent4.put("revenue", 980000);
        agent4.put("customerRating", 4.6);
        agent4.put("performance", 83);
        topAgents.add(agent4);
        
        Map<String, Object> agent5 = new HashMap<>();
        agent5.put("name", "Michael Brown");
        agent5.put("specialty", "Land");
        agent5.put("propertiesSold", 8);
        agent5.put("revenue", 850000);
        agent5.put("customerRating", 4.5);
        agent5.put("performance", 79);
        topAgents.add(agent5);
        
        return topAgents;
    }
    
    // Generate user engagement data
    public Map<String, Integer> generateUserEngagementData() {
        Map<String, Integer> userEngagement = new HashMap<>();
        userEngagement.put("activeUsers", 387);
        userEngagement.put("propertiesViewed", 4832);
        userEngagement.put("searchesPerformed", 2156);
        userEngagement.put("favoritesAdded", 926);
        userEngagement.put("inquiriesSent", 543);
        
        return userEngagement;
    }
    
    // Generate property view/inquiry conversion data
    public List<Map<String, Object>> generateConversionData() {
        List<Map<String, Object>> conversionData = new ArrayList<>();
        
        String[] months = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
        int[] views = {1250, 1320, 1580, 1740, 1920, 2050, 2210, 2350, 2180, 1980, 1820, 1950};
        int[] inquiries = {85, 92, 110, 125, 148, 165, 182, 195, 170, 155, 132, 145};
        
        for (int i = 0; i < 12; i++) {
            Map<String, Object> monthData = new HashMap<>();
            monthData.put("month", months[i]);
            monthData.put("views", views[i]);
            monthData.put("inquiries", inquiries[i]);
            // Calculate conversion rate as percentage
            double conversionRate = (double)inquiries[i] / views[i] * 100;
            monthData.put("conversionRate", Math.round(conversionRate * 10.0) / 10.0); // Round to 1 decimal place
            conversionData.add(monthData);
        }
        
        return conversionData;
    }
%>

<%
    // Check if user is logged in as admin
    String username = (String) session.getAttribute("username");
    String fullName = (String) session.getAttribute("fullName");
    String userRole = (String) session.getAttribute("userRole");
    
    if (username == null || !"admin".equalsIgnoreCase(userRole)) {
        // For testing, override this
        username = "admin";
        fullName = "Administrator";
        userRole = "admin";
        //response.sendRedirect("login.jsp");
        //return;
    }
    
    // Get analytics data
    Map<String, List<Integer>> monthlySalesData = generateMonthlySalesData();
    List<Integer> monthlyRevenueData = generateMonthlyRevenueData();
    Map<String, Map<String, Integer>> regionalData = generateRegionalData();
    Map<String, Map<String, Object>> propertyTypePerformance = generatePropertyTypePerformance();
    List<Map<String, Object>> topAgentsData = generateTopAgentsData();
    Map<String, Integer> userEngagement = generateUserEngagementData();
    List<Map<String, Object>> conversionData = generateConversionData();
    
    // Set current date and time
    String currentDateTime = "2025-05-02 21:53:18";
    String currentUserLogin = "IT24103866";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Analytics | PropertyFinder Admin</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --dark-blue: #081c45;
            --medium-blue: #0e307e;
            --light-blue: #2a4494;
            --highlight-blue: #4568dc;
            --house-color: #3a86ff;
            --apartment-color: #ff006e;
            --commercial-color: #9d4edd;
            --land-color: #38b000;
            --user-color: #3c8dbc;
            --agent-color: #ff9f1c;
            --sold-color: #38b000;
            --pending-color: #ffbe0b;
            --admin-color: #4e1d9e;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
        }
        
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: 280px;
            background: linear-gradient(to bottom, #000c24, #001a4d);
            color: white;
            padding-top: 20px;
            transition: all 0.3s;
            z-index: 1000;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
        }
        
        .sidebar-header {
            padding: 20px 25px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        
        .sidebar-header .logo {
            font-size: 1.8rem;
            font-weight: bold;
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
        }
        
        .admin-badge {
            font-size: 0.7rem;
            background-color: white;
            color: var(--dark-blue);
            padding: 2px 8px;
            border-radius: 10px;
            margin-left: 10px;
        }
        
        .nav-item {
            margin-bottom: 5px;
        }
        
        .nav-link {
            padding: 12px 25px;
            color: rgba(255,255,255,0.8);
            font-weight: 500;
            border-radius: 0;
            display: flex;
            align-items: center;
            transition: all 0.3s;
        }
        
        .nav-link:hover, .nav-link.active {
            background-color: rgba(255,255,255,0.1);
            color: white;
        }
        
        .nav-link i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        
        .content {
            margin-left: 280px;
            padding: 20px;
            transition: all 0.3s;
        }
        
        .toggle-sidebar {
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1001;
            display: none;
        }
        
        .sidebar-bottom {
            position: absolute;
            bottom: 0;
            width: 100%;
            padding: 20px 25px;
            border-top: 1px solid rgba(255,255,255,0.1);
        }
        
        .user-menu {
            display: flex;
            align-items: center;
            color: white;
            text-decoration: none;
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #3a86ff;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            margin-right: 10px;
        }
        
        .dropdown-toggle::after {
            display: none;
        }
        
        .analytics-card {
            border-radius: 10px;
            border: none;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            margin-bottom: 20px;
            transition: all 0.3s;
        }
        
        .analytics-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }
        
        .analytics-card .card-header {
            background-color: white;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            padding: 15px 20px;
            font-weight: 600;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .chart-container {
            position: relative;
            height: 300px;
            width: 100%;
        }
        
        .kpi-card {
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.1) 0%, rgba(255, 255, 255, 0.05) 100%);
            border-radius: 16px;
            overflow: hidden;
            padding: 20px;
            position: relative;
            transition: all 0.3s ease;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            color: white;
            height: 100%;
        }
        
        .kpi-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.25);
        }
        
        .kpi-card.sales-card {
            background: linear-gradient(135deg, var(--house-color) 0%, #1b4cd1 100%);
        }
        
        .kpi-card.revenue-card {
            background: linear-gradient(135deg, #00b4d8 0%, #0077b6 100%);
        }
        
        .kpi-card.agent-card {
            background: linear-gradient(135deg, var(--agent-color) 0%, #e07a00 100%);
        }
        
        .kpi-card.user-card {
            background: linear-gradient(135deg, var(--user-color) 0%, #2a6389 100%);
        }
        
        .kpi-card .icon {
            position: absolute;
            top: 20px;
            right: 20px;
            font-size: 48px;
            opacity: 0.15;
        }
        
        .kpi-card .kpi-value {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        
        .kpi-card .kpi-label {
            font-size: 1.1rem;
            margin-bottom: 0;
        }
        
        .kpi-card .kpi-trend {
            margin-top: 10px;
            font-size: 0.9rem;
        }
        
        .kpi-trend.positive {
            color: rgba(255, 255, 255, 0.9);
        }
        
        .kpi-trend.negative {
            color: rgba(255, 200, 200, 0.9);
        }
        
        .text-trend-up {
            color: #38b000;
        }
        
        .text-trend-down {
            color: #d90429;
        }
        
        .metric-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }
        
        .metric-label {
            font-weight: 500;
        }
        
        .metric-value {
            font-weight: 600;
        }
        
        .progress {
            height: 6px;
            margin-bottom: 15px;
        }
        
        .agent-performance-table td, 
        .agent-performance-table th {
            padding: 0.75rem 1rem;
        }
        
        .agent-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--agent-color);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
        }
        
        .region-map-container {
            height: 300px;
            position: relative;
            overflow: hidden;
        }
        
        .region-map-placeholder {
            background-color: rgba(0, 0, 0, 0.03);
            width: 100%;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: #6c757d;
            font-size: 1.1rem;
        }
        
        .trend-indicator {
            font-size: 0.9rem;
            margin-left: 5px;
        }
        
        .dropdown-filters {
            display: flex;
            gap: 15px;
        }
        
        .toggle-chart-type {
            cursor: pointer;
            color: #0e307e;
        }
        
        .toggle-chart-type:hover {
            color: #4568dc;
        }
        
        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-280px);
            }
            
            .content {
                margin-left: 0;
            }
            
            .sidebar.show {
                transform: translateX(0);
            }
            
            .toggle-sidebar {
                display: block;
            }
            
            .content.pushed {
                margin-left: 280px;
            }
            
            .dropdown-filters {
                flex-direction: column;
                gap: 10px;
            }
        }
    </style>
</head>
<body>
    <button class="btn btn-light toggle-sidebar" id="toggleSidebar">
        <i class="fas fa-bars"></i>
    </button>
    
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <a href="dashboard.jsp" class="logo">
                <i class="fas fa-building me-2"></i> PropertyFinder <span class="admin-badge">ADMIN</span>
            </a>
        </div>
        
        <ul class="nav flex-column mt-4">
            <li class="nav-item">
                <a class="nav-link" href="adminDasboardChart.jsp">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="adminDashboard.jsp">
                    <i class="fas fa-users"></i> User Management
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="agentManagement.jsp">
                    <i class="fas fa-user-tie"></i> Agent Management
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="propertyManagement.jsp">
                    <i class="fas fa-home"></i> Properties
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="adminAnalytics.jsp">
                    <i class="fas fa-chart-bar"></i> Analytics
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="adminSetting.jsp">
                    <i class="fas fa-cog"></i> Settings
                </a>
            </li>
        </ul>
        
        <div class="sidebar-bottom">
            <div class="dropdown">
                <a href="#" class="user-menu dropdown-toggle" data-bs-toggle="dropdown">
                    <div class="user-avatar">
                        <i class="fas fa-user-shield"></i>
                    </div>
                    <div>
                        <div class="fw-bold"><%= fullName %></div>
                        <small class="text-white-50"><%= username %></small>
                    </div>
                </a>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="#"><i class="fas fa-user me-2"></i>My Profile</a></li>
                    <li><a class="dropdown-item" href="adminSetting.jsp"><i class="fas fa-cog me-2"></i>Account Settings</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item text-danger" href="adminLogout.jsp"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                </ul>
            </div>
        </div>
    </div>
    
    <!-- Content -->
    <div class="content">
        <div class="container-fluid">
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h2>Analytics Dashboard</h2>
                    <p class="text-muted">Comprehensive performance metrics and insights</p>
                </div>
                
                <div class="dropdown-filters">
                    <div class="dropdown">
                        <button class="btn btn-outline-secondary dropdown-toggle" type="button" id="timeRangeDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-calendar-alt me-2"></i> Last 12 Months
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="timeRangeDropdown">
                            <li><a class="dropdown-item active" href="#">Last 12 Months</a></li>
                            <li><a class="dropdown-item" href="#">Last 6 Months</a></li>
                            <li><a class="dropdown-item" href="#">Last 3 Months</a></li>
                            <li><a class="dropdown-item" href="#">Current Month</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="#">Custom Range</a></li>
                        </ul>
                    </div>
                    
                    <button class="btn btn-outline-primary" id="exportDataBtn">
                        <i class="fas fa-file-export me-2"></i> Export Report
                    </button>
                </div>
            </div>
            
            <!-- KPI Cards Row -->
            <div class="row mb-4">
                <div class="col-md-6 col-lg-3 mb-4 mb-lg-0">
                    <div class="kpi-card sales-card">
                        <div class="icon">
                            <i class="fas fa-home"></i>
                        </div>
                        <div>
                            <p class="kpi-label">Total Properties Sold</p>
                            <h2 class="kpi-value">187</h2>
                            <p class="kpi-trend positive">
                                <i class="fas fa-arrow-up me-1"></i> 24% from last period
                            </p>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-6 col-lg-3 mb-4 mb-lg-0">
                    <div class="kpi-card revenue-card">
                        <div class="icon">
                            <i class="fas fa-dollar-sign"></i>
                        </div>
                        <div>
                            <p class="kpi-label">Total Revenue</p>
                            <h2 class="kpi-value">$3.96M</h2>
                            <p class="kpi-trend positive">
                                <i class="fas fa-arrow-up me-1"></i> 18% from last period
                            </p>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-6 col-lg-3 mb-4 mb-md-0">
                    <div class="kpi-card agent-card">
                        <div class="icon">
                            <i class="fas fa-user-tie"></i>
                        </div>
                        <div>
                            <p class="kpi-label">Agent Performance</p>
                            <h2 class="kpi-value">84%</h2>
                            <p class="kpi-trend positive">
                                <i class="fas fa-arrow-up me-1"></i> 9% from last period
                            </p>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-6 col-lg-3">
                    <div class="kpi-card user-card">
                        <div class="icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <div>
                            <p class="kpi-label">User Engagement</p>
                            <h2 class="kpi-value">68%</h2>
                            <p class="kpi-trend negative">
                                <i class="fas fa-arrow-down me-1"></i> 3% from last period
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Property Sales & Revenue Charts Row -->
            <div class="row mb-4">
                <div class="col-lg-8 mb-4 mb-lg-0">
                    <div class="card analytics-card h-100">
                        <div class="card-header">
                            <h5 class="mb-0">Property Sales Trends</h5>
                            <div class="btn-group">
                                <button type="button" class="btn btn-sm btn-outline-secondary active" id="viewSalesTrendBtn" data-chart="salesTrend">Sales Trend</button>
                                <button type="button" class="btn btn-sm btn-outline-secondary" id="viewSalesComparisonBtn" data-chart="salesComparison">Sales Comparison</button>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="chart-container">
                                <canvas id="propertySalesChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4">
                    <div class="card analytics-card h-100">
                        <div class="card-header">
                            <h5 class="mb-0">Revenue Analysis</h5>
                            <div class="toggle-chart-type" id="toggleRevenueChart">
                                <i class="fas fa-chart-line me-1"></i>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="chart-container">
                                <canvas id="revenueChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Regional Performance Row -->
            <div class="row mb-4">
                <div class="col-lg-8 mb-4 mb-lg-0">
                    <div class="card analytics-card h-100">
                        <div class="card-header">
                            <h5 class="mb-0">Regional Performance</h5>
                            <div class="dropdown">
                                <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="regionFilterDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                    All Regions
                                </button>
                                <ul class="dropdown-menu" aria-labelledby="regionFilterDropdown">
                                    <li><a class="dropdown-item active" href="#">All Regions</a></li>
                                    <li><a class="dropdown-item" href="#">Downtown</a></li>
                                    <li><a class="dropdown-item" href="#">North District</a></li>
                                    <li><a class="dropdown-item" href="#">Westside</a></li>
                                    <li><a class="dropdown-item" href="#">South East</a></li>
                                    <li><a class="dropdown-item" href="#">Suburban</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-7">
                                    <div class="region-map-container">
                                        <div class="region-map-placeholder">
                                            <i class="fas fa-map-marked-alt fa-3x mb-3"></i>
                                            <p>Interactive region map would be displayed here</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-5">
                                    <h6 class="mb-3">Performance by Region</h6>
                                    <table class="table table-sm">
                                        <thead>
                                            <tr>
                                                <th>Region</th>
                                                <th>Properties</th>
                                                <th>Avg Price</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% for (Map.Entry<String, Map<String, Integer>> entry : regionalData.entrySet()) { 
                                                String region = entry.getKey();
                                                Map<String, Integer> data = entry.getValue();
                                            %>
                                                <tr>
                                                    <td><%= region %></td>
                                                    <td><%= data.get("count") %> (<%= data.get("sold") %> sold)</td>
                                                    <td>$<%= String.format("%,d", data.get("averagePrice")) %></td>
                                                </tr>
                                            <% } %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4">
                    <div class="card analytics-card h-100">
                        <div class="card-header">
                            <h5 class="mb-0">Property Type Performance</h5>
                            <div class="toggle-chart-type" id="togglePropertyTypeChart">
                                <i class="fas fa-chart-pie me-1"></i>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="chart-container">
                                <canvas id="propertyTypeChart"></canvas>
                            </div>
                            <div class="mt-4">
                                <div class="metric-row">
                                    <span class="metric-label">Average Days on Market</span>
                                    <span class="metric-value">62 days <span class="text-trend-down"><i class="fas fa-arrow-down"></i> 5%</span></span>
                                </div>
                                <div class="metric-row">
                                    <span class="metric-label">Avg. Listing Conversion Rate</span>
                                    <span class="metric-value">68% <span class="text-trend-up"><i class="fas fa-arrow-up"></i> 8%</span></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Agent Performance and User Engagement Row -->
            <div class="row mb-4">
                <div class="col-lg-6 mb-4 mb-lg-0">
                    <div class="card analytics-card h-100">
                        <div class="card-header">
                            <h5 class="mb-0">Top Agent Performance</h5>
                            <div class="dropdown">
                                <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="agentMetricDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                    By Sales
                                </button>
                                <ul class="dropdown-menu" aria-labelledby="agentMetricDropdown">
                                    <li><a class="dropdown-item active" href="#">By Sales</a></li>
                                    <li><a class="dropdown-item" href="#">By Revenue</a></li>
                                    <li><a class="dropdown-item" href="#">By Rating</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover agent-performance-table align-middle">
                                    <thead>
                                        <tr>
                                            <th>Agent</th>
                                            <th>Properties Sold</th>
                                            <th>Revenue</th>
                                            <th>Performance</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for (Map<String, Object> agent : topAgentsData) { %>
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <div class="agent-avatar me-3">
                                                            <i class="fas fa-user-tie"></i>
                                                        </div>
                                                        <div>
                                                            <div class="fw-bold"><%= agent.get("name") %></div>
                                                            <small class="text-muted"><%= agent.get("specialty") %></small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td><%= agent.get("propertiesSold") %></td>
                                                <td>$<%= String.format("%,d", agent.get("revenue")) %></td>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <div class="progress flex-grow-1" style="height: 6px;">
                                                            <div class="progress-bar bg-success" style="width: <%= agent.get("performance") %>%"></div>
                                                        </div>
                                                        <span class="ms-2"><%= agent.get("performance") %>%</span>
                                                    </div>
                                                </td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-6">
                    <div class="card analytics-card h-100">
                        <div class="card-header">
                            <h5 class="mb-0">User Engagement & Conversion</h5>
                            <div class="toggle-chart-type" id="toggleUserEngagementChart">
                                <i class="fas fa-chart-line me-1"></i>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="chart-container">
                                <canvas id="userEngagementChart"></canvas>
                            </div>
                            <div class="row mt-4">
                                <div class="col-md-6">
                                    <div class="metric-row">
                                        <span class="metric-label">Active Users</span>
                                        <span class="metric-value"><%= userEngagement.get("activeUsers") %></span>
                                    </div>
                                    <div class="metric-row">
                                        <span class="metric-label">Properties Viewed</span>
                                        <span class="metric-value"><%= userEngagement.get("propertiesViewed") %></span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="metric-row">
                                        <span class="metric-label">Inquiries Sent</span>
                                        <span class="metric-value"><%= userEngagement.get("inquiriesSent") %></span>
                                    </div>
                                    <div class="metric-row">
                                        <span class="metric-label">Conversion Rate</span>
                                        <span class="metric-value">11.2% <span class="text-trend-up"><i class="fas fa-arrow-up"></i> 2.5%</span></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Footer -->
            <footer class="mt-4">
                <div class="text-center text-muted">
                    <p>&copy; 2025 PropertyFinder Administrative Panel. All rights reserved.</p>
                    <p class="small">Current Date and Time (UTC): <%= currentDateTime %> | User: <%= currentUserLogin %></p>
                </div>
            </footer>
        </div>
    </div>
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Toggle sidebar on mobile
            const toggleSidebarBtn = document.getElementById('toggleSidebar');
            const sidebar = document.querySelector('.sidebar');
            const content = document.querySelector('.content');
            
            toggleSidebarBtn?.addEventListener('click', function() {
                sidebar.classList.toggle('show');
                content.classList.toggle('pushed');
                
                // Change icon based on sidebar state
                const icon = toggleSidebarBtn.querySelector('i');
                if (sidebar.classList.contains('show')) {
                    icon.classList.remove('fa-bars');
                    icon.classList.add('fa-times');
                } else {
                    icon.classList.remove('fa-times');
                    icon.classList.add('fa-bars');
                }
            });
            
            // Initialize charts
            initCharts();
            
            // Handle export button click
            document.getElementById('exportDataBtn').addEventListener('click', function() {
                alert('Analytics report export initiated. The file will be prepared for download shortly.');
            });
            
            // Chart toggle buttons
            document.getElementById('viewSalesTrendBtn').addEventListener('click', function() {
                this.classList.add('active');
                document.getElementById('viewSalesComparisonBtn').classList.remove('active');
                updateSalesChart('salesTrend');
            });
            
            document.getElementById('viewSalesComparisonBtn').addEventListener('click', function() {
                this.classList.add('active');
                document.getElementById('viewSalesTrendBtn').classList.remove('active');
                updateSalesChart('salesComparison');
            });
            
            let revenueChartType = 'line';
            document.getElementById('toggleRevenueChart').addEventListener('click', function() {
                revenueChartType = revenueChartType === 'line' ? 'bar' : 'line';
                this.innerHTML = revenueChartType === 'line' ? 
                    '<i class="fas fa-chart-line me-1"></i>' : 
                    '<i class="fas fa-chart-bar me-1"></i>';
                updateRevenueChart(revenueChartType);
            });
            
            let propertyTypeChartType = 'pie';
            document.getElementById('togglePropertyTypeChart').addEventListener('click', function() {
                propertyTypeChartType = propertyTypeChartType === 'pie' ? 'bar' : 'pie';
                this.innerHTML = propertyTypeChartType === 'pie' ? 
                    '<i class="fas fa-chart-pie me-1"></i>' : 
                    '<i class="fas fa-chart-bar me-1"></i>';
                updatePropertyTypeChart(propertyTypeChartType);
            });
            
            let userEngagementChartType = 'line';
            document.getElementById('toggleUserEngagementChart').addEventListener('click', function() {
                userEngagementChartType = userEngagementChartType === 'line' ? 'bar' : 'line';
                this.innerHTML = userEngagementChartType === 'line' ? 
                    '<i class="fas fa-chart-line me-1"></i>' : 
                    '<i class="fas fa-chart-bar me-1"></i>';
                updateUserEngagementChart(userEngagementChartType);
            });
        });
        
        // Chart instances
        let propertySalesChart;
        let revenueChart;
        let propertyTypeChart;
        let userEngagementChart;
        
        // Charts initialization
        function initCharts() {
            // Set Chart.js defaults
            Chart.defaults.color = '#6c757d';
            Chart.defaults.font.family = "'Segoe UI', sans-serif";
            
            // Initialize Property Sales Trend Chart
            initSalesChart();
            
            // Initialize Revenue Chart
            initRevenueChart();
            
            // Initialize Property Type Chart
            initPropertyTypeChart();
            
            // Initialize User Engagement Chart
            initUserEngagementChart();
        }
        
        // Initialize Property Sales Chart
        function initSalesChart() {
            const ctx = document.getElementById('propertySalesChart').getContext('2d');
            propertySalesChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    datasets: [{
                        label: 'Properties Sold',
                        data: <%= monthlySalesData.get("sold") %>,
                        backgroundColor: 'rgba(56, 176, 0, 0.2)',
                        borderColor: 'rgba(56, 176, 0, 1)',
                        borderWidth: 2,
                        tension: 0.3,
                        fill: true
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'top'
                        },
                        title: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: 'rgba(0, 0, 0, 0.05)'
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            }
                        }
                    }
                }
            });
        }
        
        // Update Sales Chart based on view type
        function updateSalesChart(viewType) {
            if (viewType === 'salesTrend') {
                propertySalesChart.data.datasets = [{
                    label: 'Properties Sold',
                    data: <%= monthlySalesData.get("sold") %>,
                    backgroundColor: 'rgba(56, 176, 0, 0.2)',
                    borderColor: 'rgba(56, 176, 0, 1)',
                    borderWidth: 2,
                    tension: 0.3,
                    fill: true
                }];
                propertySalesChart.config.type = 'line';
            } else {
                propertySalesChart.data.datasets = [
                    {
                        label: 'Properties Sold',
                        data: <%= monthlySalesData.get("sold") %>,
                        backgroundColor: 'rgba(56, 176, 0, 0.7)',
                        borderColor: 'rgba(56, 176, 0, 1)',
                        borderWidth: 1
                    },
                    {
                        label: 'Properties Listed',
                        data: <%= monthlySalesData.get("listed") %>,
                        backgroundColor: 'rgba(58, 134, 255, 0.7)',
                        borderColor: 'rgba(58, 134, 255, 1)',
                        borderWidth: 1
                    },
                    {
                        label: 'Pending Sales',
                        data: <%= monthlySalesData.get("pending") %>,
                        backgroundColor: 'rgba(255, 190, 11, 0.7)',
                        borderColor: 'rgba(255, 190, 11, 1)',
                        borderWidth: 1
                    }
                ];
                propertySalesChart.config.type = 'bar';
            }
            propertySalesChart.update();
        }
        
        // Initialize Revenue Chart
        function initRevenueChart() {
            const ctx = document.getElementById('revenueChart').getContext('2d');
            revenueChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    datasets: [{
                        label: 'Monthly Revenue ($K)',
                        data: <%= monthlyRevenueData %>,
                        backgroundColor: 'rgba(0, 180, 216, 0.2)',
                        borderColor: 'rgba(0, 180, 216, 1)',
                        borderWidth: 2,
                        tension: 0.3,
                        fill: true,
                        // Format y-axis label to show $K
                        datalabels: {
                            formatter: function(value) {
                                return '$' + Math.round(value / 1000) + 'K';
                            }
                        }
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: 'rgba(0, 0, 0, 0.05)'
                            },
                            ticks: {
                                callback: function(value) {
                                    return '$' + value / 1000 + 'K';
                                }
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            }
                        }
                    }
                }
            });
        }
        
        // Update Revenue Chart based on chart type
        function updateRevenueChart(chartType) {
            revenueChart.config.type = chartType;
            if (chartType === 'line') {
                revenueChart.data.datasets[0].tension = 0.3;
                revenueChart.data.datasets[0].fill = true;
            } else {
                revenueChart.data.datasets[0].tension = 0;
                revenueChart.data.datasets[0].fill = false;
            }
            revenueChart.update();
        }
        
        // Initialize Property Type Chart
        function initPropertyTypeChart() {
            const ctx = document.getElementById('propertyTypeChart').getContext('2d');
            propertyTypeChart = new Chart(ctx, {
                type: 'pie',
                data: {
                    labels: ['Houses', 'Apartments', 'Commercial', 'Land'],
                    datasets: [{
                        data: [
                            <%= propertyTypePerformance.get("House").get("count") %>, 
                            <%= propertyTypePerformance.get("Apartment").get("count") %>, 
                            <%= propertyTypePerformance.get("Commercial").get("count") %>, 
                            <%= propertyTypePerformance.get("Land").get("count") %>
                        ],
                        backgroundColor: [
                            'rgba(58, 134, 255, 0.8)',
                            'rgba(255, 0, 110, 0.8)',
                            'rgba(157, 78, 221, 0.8)',
                            'rgba(56, 176, 0, 0.8)'
                        ],
                        borderColor: [
                            'rgba(58, 134, 255, 1)',
                            'rgba(255, 0, 110, 1)',
                            'rgba(157, 78, 221, 1)',
                            'rgba(56, 176, 0, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom'
                        }
                    }
                }
            });
        }
        
        // Update Property Type Chart based on chart type
        function updatePropertyTypeChart(chartType) {
            if (chartType === 'pie') {
                propertyTypeChart.config.type = 'pie';
                propertyTypeChart.options.plugins.legend.position = 'bottom';
            } else {
                propertyTypeChart.config.type = 'bar';
                propertyTypeChart.options.plugins.legend.display = false;
                propertyTypeChart.options.scales = {
                    y: {
                        beginAtZero: true,
                        grid: {
                            color: 'rgba(0, 0, 0, 0.05)'
                        }
                    },
                    x: {
                        grid: {
                            display: false
                        }
                    }
                };
            }
            propertyTypeChart.update();
        }
        
        // Initialize User Engagement Chart
        function initUserEngagementChart() {
            const conversionData = <%= new JSONArray(conversionData).toString() %>;
            const months = conversionData.map(item => item.month);
            const views = conversionData.map(item => item.views);
            const inquiries = conversionData.map(item => item.inquiries);
            const rates = conversionData.map(item => item.conversionRate);
            
            const ctx = document.getElementById('userEngagementChart').getContext('2d');
            userEngagementChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: months,
                    datasets: [
                        {
                            label: 'Property Views',
                            data: views,
                            backgroundColor: 'rgba(58, 134, 255, 0.2)',
                            borderColor: 'rgba(58, 134, 255, 1)',
                            borderWidth: 2,
                            tension: 0.3,
                            fill: true,
                            yAxisID: 'y'
                        },
                        {
                            label: 'Conversion Rate (%)',
                            data: rates,
                            backgroundColor: 'rgba(255, 159, 28, 0.2)',
                            borderColor: 'rgba(255, 159, 28, 1)',
                            borderWidth: 2,
                            tension: 0.3,
                            fill: false,
                            yAxisID: 'y1',
                            type: 'line'
                        }
                    ]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    interaction: {
                        mode: 'index',
                        intersect: false,
                    },
                    plugins: {
                        legend: {
                            position: 'top'
                        }
                    },
                    scales: {
                        y: {
                            type: 'linear',
                            display: true,
                            position: 'left',
                            beginAtZero: true,
                            grid: {
                                color: 'rgba(0, 0, 0, 0.05)'
                            },
                            title: {
                                display: true,
                                text: 'Views'
                            }
                        },
                        y1: {
                            type: 'linear',
                            display: true,
                            position: 'right',
                            beginAtZero: true,
                            max: 20,
                            grid: {
                                drawOnChartArea: false
                            },
                            title: {
                                display: true,
                                text: 'Conversion Rate (%)'
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            }
                        }
                    }
                }
            });
        }
        
        // Update User Engagement Chart based on chart type
        function updateUserEngagementChart(chartType) {
            userEngagementChart.data.datasets[0].type = chartType;
            
            if (chartType === 'line') {
                userEngagementChart.data.datasets[0].tension = 0.3;
                userEngagementChart.data.datasets[0].fill = true;
            } else {
                userEngagementChart.data.datasets[0].tension = 0;
                userEngagementChart.data.datasets[0].fill = false;
            }
            
            userEngagementChart.update();
        }
    </script>
</body>
</html>