<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*, com.google.gson.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Appointments | Real Estate Portal</title>

    <!-- CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-dark: #0F172A;
            --primary-medium: #1E293B;
            --primary-light: #334155;
            --accent-blue: #3B82F6;
            --accent-indigo: #6366F1;
            --accent-cyan: #06B6D4;
            --accent-gradient: linear-gradient(135deg, #6366F1, #06B6D4);
            --text-white: #F8FAFC;
            --text-light: #E2E8F0;
            --text-muted: #94A3B8;
            --border-color: rgba(203, 213, 225, 0.1);
            --gradient-start: rgba(15, 23, 42, 0.95);
            --gradient-end: rgba(30, 41, 59, 0.95);
            --success-light: rgba(34, 197, 94, 0.15);
            --success-border: rgba(34, 197, 94, 0.3);
            --success-text: #22C55E;
            --warning-light: rgba(245, 158, 11, 0.15);
            --warning-border: rgba(245, 158, 11, 0.3);
            --warning-text: #F59E0B;
            --danger-light: rgba(239, 68, 68, 0.15);
            --danger-border: rgba(239, 68, 68, 0.3);
            --danger-text: #EF4444;
            --info-light: rgba(59, 130, 246, 0.15);
            --info-border: rgba(59, 130, 246, 0.3);
            --info-text: #3B82F6;
            --card-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, var(--gradient-start), var(--gradient-end));
            color: var(--text-light);
            min-height: 100vh;
            line-height: 1.6;
        }

        .floating-header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            background: rgba(15, 23, 42, 0.85);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-bottom: 1px solid var(--border-color);
            padding: 1rem 2rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        }

        .header-collapsed {
            transform: translateY(-100%);
        }

        .main-container {
            padding: 7rem 2rem 2rem 2rem;
        }

        .appointment-card {
            background: rgba(30, 41, 59, 0.6);
            border-radius: 16px;
            overflow: hidden;
            border: 1px solid var(--border-color);
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            margin-bottom: 1.5rem;
            position: relative;
            box-shadow: var(--card-shadow);
        }

        .appointment-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            border-color: rgba(203, 213, 225, 0.2);
        }

        .appointment-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(360px, 1fr));
            gap: 1.5rem;
        }

        .appointment-info {
            padding: 1.5rem;
        }

        .status-badge {
            display: inline-block;
            padding: 0.35rem 1rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
            letter-spacing: 0.025em;
            text-transform: capitalize;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .card-header .status-badge {
            margin-left: 0.5rem;
        }

        .status-scheduled, .status-Confirmed {
            background-color: var(--info-light);
            color: var(--info-text);
            border: 1px solid var(--info-border);
        }

        .status-completed {
            background-color: var(--success-light);
            color: var(--success-text);
            border: 1px solid var(--success-border);
        }

        .status-cancelled {
            background-color: var(--danger-light);
            color: var(--danger-text);
            border: 1px solid var(--danger-border);
        }

        .status-rescheduled, .status-pending {
            background-color: var(--warning-light);
            color: var(--warning-text);
            border: 1px solid var(--warning-border);
        }

        .appointment-title {
            color: var(--text-white);
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 0.75rem;
            letter-spacing: 0.025em;
        }

        .appointment-detail {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 0.85rem;
            color: var(--text-light);
        }

        .appointment-detail i {
            color: var(--accent-cyan);
            width: 20px;
            text-align: center;
        }

        .appointment-meta {
            display: flex;
            justify-content: space-between;
            margin-top: 1.5rem;
            padding-top: 1rem;
            border-top: 1px solid var(--border-color);
            color: var(--text-muted);
            font-size: 0.875rem;
        }

        .appointment-notes {
            background-color: rgba(30, 41, 59, 0.4);
            padding: 1rem;
            border-radius: 12px;
            margin-top: 1rem;
            font-size: 0.9rem;
            border-left: 3px solid var(--accent-indigo);
            color: var(--text-light);
        }

        .search-input {
            background: rgba(30, 41, 59, 0.4);
            border: 1px solid var(--border-color);
            color: var(--text-white);
            border-radius: 8px;
            padding: 0.75rem 1rem;
            font-family: 'Inter', sans-serif;
            transition: all 0.2s ease;
        }

        .search-input::placeholder {
            color: var(--text-muted);
        }
        
        .search-input:focus {
            border-color: var(--accent-indigo);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.15);
            background: rgba(30, 41, 59, 0.6);
            color: var(--text-white) !important;
        }

        .user-info {
            color: var(--text-light);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .user-avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: var(--accent-gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-white);
            font-weight: 500;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }

        .error-message {
            background-color: var(--danger-light);
            border: 1px solid var(--danger-border);
            color: var(--danger-text);
            padding: 1rem;
            margin-bottom: 1rem;
            border-radius: 8px;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .filter-badges {
            display: flex;
            flex-wrap: wrap;
            gap: 0.75rem;
            margin-bottom: 1.5rem;
        }

        .filter-badge {
            background: rgba(59, 130, 246, 0.15);
            color: var(--accent-blue);
            border: 1px solid rgba(59, 130, 246, 0.2);
            padding: 0.4rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            cursor: pointer;
            transition: all 0.2s ease;
            font-weight: 500;
        }

        .filter-badge:hover, .filter-badge.active {
            background: rgba(59, 130, 246, 0.25);
            border: 1px solid rgba(59, 130, 246, 0.35);
            transform: translateY(-1px);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .filter-badge.active {
            background: var(--accent-gradient);
            color: white;
            border: none;
        }

        .table-container {
            background: rgba(30, 41, 59, 0.6);
            border-radius: 16px;
            overflow: hidden;
            border: 1px solid var(--border-color);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            box-shadow: var(--card-shadow);
        }

        .custom-table {
            color: var(--text-light);
            width: 100%;
        }

        .custom-table thead th {
            background-color: rgba(15, 23, 42, 0.5);
            border-bottom: 1px solid var(--border-color);
            padding: 1rem;
            font-weight: 500;
            letter-spacing: 0.025em;
            color: var(--text-white);
        }

        .custom-table tbody td {
            padding: 1rem;
            border-bottom: 1px solid var(--border-color);
            vertical-align: middle;
        }

        .custom-table tbody tr:last-child td {
            border-bottom: none;
        }

        .custom-table tbody tr {
            transition: background-color 0.2s ease;
        }

        .custom-table tbody tr:hover {
            background-color: rgba(51, 65, 85, 0.4);
        }

        .view-selector {
            display: flex;
            gap: 0.5rem;
            margin-bottom: 1rem;
        }

        .view-btn {
            background: rgba(30, 41, 59, 0.6);
            border: 1px solid var(--border-color);
            color: var(--text-muted);
            border-radius: 8px;
            padding: 0.5rem 1.25rem;
            cursor: pointer;
            transition: all 0.2s ease;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .view-btn:hover, .view-btn.active {
            background: rgba(59, 130, 246, 0.25);
            color: var(--accent-blue);
            border-color: var(--accent-blue);
            transform: translateY(-1px);
        }

        .view-btn.active {
            background: var(--accent-gradient);
            color: white;
            border: none;
        }

        .card-header {
            background-color: rgba(15, 23, 42, 0.5);
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-header h5 {
            color: var(--text-white);
            font-weight: 500;
            margin: 0;
            letter-spacing: 0.025em;
        }

        .btn-primary {
            background: var(--accent-gradient);
            border: none;
            box-shadow: 0 4px 6px rgba(50, 50, 93, 0.11), 0 1px 3px rgba(0, 0, 0, 0.08);
            transition: all 0.2s ease;
        }

        .btn-primary:hover {
            transform: translateY(-1px);
            box-shadow: 0 7px 14px rgba(50, 50, 93, 0.1), 0 3px 6px rgba(0, 0, 0, 0.08);
            filter: brightness(1.05);
            background: var(--accent-gradient);
        }

        .no-results-message {
            text-align: center;
            padding: 3rem;
            color: var(--text-muted);
            border: 1px dashed var(--border-color);
            border-radius: 16px;
            margin: 2rem;
        }

        .back-to-dashboard {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--text-light);
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: all 0.2s ease;
            font-size: 0.9rem;
            background: rgba(30, 41, 59, 0.4);
            border: 1px solid var(--border-color);
        }
        
        .back-to-dashboard:hover {
            background: rgba(30, 41, 59, 0.6);
            transform: translateY(-1px);
            color: var(--text-white);
            text-decoration: none;
        }
        
        .back-to-dashboard i {
            color: var(--accent-cyan);
        }

        @media (max-width: 991.98px) {
            .floating-header .col-auto {
                margin-bottom: 0.75rem;
            }
        }

        @media (max-width: 767.98px) {
            .appointment-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <%
        // Use the provided date, time, and user information
        String currentDateTime = "2025-05-03 08:50:09";
        String currentUser = "IT24103866";
        
        // Load and parse JSON data using Gson
        Gson gson = new Gson();
        JsonObject jsonData = null;
        String errorMessage = null;
        
        try {
            String jsonFilePath = "C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\data\\userAppointments.json";
            System.out.println("Reading from: " + jsonFilePath);
            File jsonFile = new File(jsonFilePath);
            
            if (!jsonFile.exists()) {
                errorMessage = "Appointments file not found at: " + jsonFilePath;
            } else {
                // File exists, read it
                FileReader reader = new FileReader(jsonFile);
                jsonData = gson.fromJson(reader, JsonObject.class);
                reader.close();
                System.out.println("Successfully loaded appointment data");
            }
        } catch (Exception e) {
            errorMessage = "Error loading appointment data: " + e.getMessage();
            e.printStackTrace();
        }
    %>

    <!-- Floating Header -->
    <div class="floating-header">
        <div class="container-fluid">
            <div class="row align-items-center">
                <div class="col-lg-auto">
                    <div class="d-flex align-items-center gap-3">
                        <a href="agentDashBoard.jsp" class="back-to-dashboard">
                            <i class="fas fa-arrow-left"></i>
                            <span>Back to Dashboard</span>
                        </a>
                        <i class="fas fa-calendar-check text-info fs-4 ms-3"></i>
                        <div>
                            <h5 class="mb-0 text-white">User Appointments</h5>
                            <small class="text-muted">
                                <i class="far fa-clock me-1"></i>
                                <%= currentDateTime %>
                            </small>
                        </div>
                    </div>
                </div>
                <div class="col-lg">
                    <div class="row g-3">
                        <div class="col-md-3">
                            <div class="input-group">
                                <span class="input-group-text bg-transparent border-end-0 text-muted">
                                    <i class="fas fa-search"></i>
                                </span>
                                <input type="text" class="form-control search-input border-start-0" placeholder="Search appointments..." id="searchAppointment">
                            </div>
                        </div>
                        <div class="col-md-2">
                            <select class="form-select search-input" id="statusFilter">
                                <option value="">All Statuses</option>
                                <option value="scheduled">Scheduled</option>
                                <option value="completed">Completed</option>
                                <option value="cancelled">Cancelled</option>
                                <option value="rescheduled">Rescheduled</option>
                                <option value="Confirmed">Confirmed</option>
                                <option value="Pending">Pending</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <select class="form-select search-input" id="dateFilter">
                                <option value="">All Dates</option>
                                <option value="upcoming">Upcoming</option>
                                <option value="past">Past</option>
                                <option value="week">Next 7 Days</option>
                                <option value="month">Next 30 Days</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <div class="view-selector">
                                <div class="view-btn active" data-view="card">
                                    <i class="fas fa-th"></i> Card View
                                </div>
                                <div class="view-btn" data-view="table">
                                    <i class="fas fa-table"></i> Table View
                                </div>
                            </div>
                        </div>
                        <div class="col-md-1">
                            <button class="btn btn-primary w-100" id="searchButton">
                                <i class="fas fa-filter"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-lg-auto ms-auto mt-3 mt-lg-0">
                    <div class="user-info">
                        <div class="user-avatar">
                            <i class="fas fa-user"></i>
                        </div>
                        <span><%= currentUser %></span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-container">
        <% if (errorMessage != null) { %>
            <div class="error-message">
                <i class="fas fa-exclamation-circle fs-4"></i>
                <div>
                    <strong>Error:</strong> <%= errorMessage %>
                </div>
            </div>
        <% } %>

        <div class="filter-badges mb-4">
            <div class="filter-badge active" data-status="all">All Appointments</div>
            <div class="filter-badge" data-status="scheduled">Scheduled</div>
            <div class="filter-badge" data-status="completed">Completed</div>
            <div class="filter-badge" data-status="cancelled">Cancelled</div>
            <div class="filter-badge" data-status="rescheduled">Rescheduled</div>
            <div class="filter-badge" data-status="Confirmed">Confirmed</div>
        </div>

        <!-- Card View -->
        <div class="appointment-grid" id="cardView">
            <% 
                if (jsonData != null && jsonData.has("appointments")) {
                    JsonArray appointments = jsonData.getAsJsonArray("appointments");
                    
                    if (appointments.size() == 0) {
                        %><div class="no-results-message">
                            <i class="fas fa-calendar-xmark fa-3x mb-3"></i>
                            <h4>No appointments found</h4>
                            <p>There are no appointments in your database.</p>
                        </div><%
                    }
                    
                    for (int i = 0; i < appointments.size(); i++) {
                        try {
                            JsonObject appointment = appointments.get(i).getAsJsonObject();
                            
                            // Get all available fields from the JSON data
                            String appointmentId = appointment.has("appointmentId") ? 
                                appointment.get("appointmentId").getAsString() : "N/A";
                            String buyerName = appointment.has("buyerName") ? 
                                appointment.get("buyerName").getAsString() : "N/A";
                            String buyerEmail = appointment.has("buyerEmail") ? 
                                appointment.get("buyerEmail").getAsString() : "N/A";
                            String buyerPhone = appointment.has("buyerPhone") ? 
                                appointment.get("buyerPhone").getAsString() : "N/A";
                            String appointmentDate = appointment.has("appointmentDate") ? 
                                appointment.get("appointmentDate").getAsString() : "N/A";
                            String appointmentTime = appointment.has("appointmentTime") ? 
                                appointment.get("appointmentTime").getAsString() : "N/A";
                            String agentId = appointment.has("agentId") ? 
                                appointment.get("agentId").getAsString() : "N/A";
                            String agentName = appointment.has("agentName") ? 
                                appointment.get("agentName").getAsString() : "N/A";
                            String status = appointment.has("status") ? 
                                appointment.get("status").getAsString() : "N/A";
                            String notes = appointment.has("notes") ? 
                                appointment.get("notes").getAsString() : "";
                            String createdDate = appointment.has("createdDate") ? 
                                appointment.get("createdDate").getAsString() : "N/A";
                            String updatedDate = appointment.has("updatedDate") ? 
                                appointment.get("updatedDate").getAsString() : "N/A";
                            String createdBy = appointment.has("createdBy") ? 
                                appointment.get("createdBy").getAsString() : "N/A";
                            
                            // Display each appointment card
            %>
                <div class="appointment-card" data-status="<%= status.toLowerCase() %>">
                    <div class="card-header">
                        <h5><i class="far fa-calendar-check me-2"></i>Appointment</h5>
                        <span class="status-badge status-<%= status.toLowerCase() %>"><%= status %></span>
                    </div>
                    <div class="appointment-info">
                        <div class="appointment-title">ID: <%= appointmentId %></div>
                        
                        <div class="appointment-detail">
                            <i class="far fa-calendar-alt"></i>
                            <span><%= appointmentDate %>, <%= appointmentTime %></span>
                        </div>
                        
                        <% if (buyerName != null && !buyerName.equals("N/A")) { %>
                        <div class="appointment-detail">
                            <i class="far fa-user"></i>
                            <span><strong>Client:</strong> <%= buyerName %></span>
                        </div>
                        <% } %>
                        
                        <% if (buyerEmail != null && !buyerEmail.equals("N/A")) { %>
                        <div class="appointment-detail">
                            <i class="far fa-envelope"></i>
                            <span><%= buyerEmail %></span>
                        </div>
                        <% } %>
                        
                        <% if (buyerPhone != null && !buyerPhone.equals("N/A")) { %>
                        <div class="appointment-detail">
                            <i class="fas fa-phone-alt"></i>
                            <span><%= buyerPhone %></span>
                        </div>
                        <% } %>
                        
                        <div class="appointment-detail">
                            <i class="fas fa-user-tie"></i>
                            <span><strong>Agent:</strong> <%= agentName %> <% if (!agentId.equals("N/A")) { %><small class="text-muted">(ID: <%= agentId %>)</small><% } %></span>
                        </div>
                        
                        <% if (notes != null && !notes.isEmpty()) { %>
                            <div class="appointment-notes">
                                <i class="far fa-sticky-note me-2"></i> <%= notes %>
                            </div>
                        <% } %>
                        
                        <div class="appointment-meta">
                            <div>
                                <i class="far fa-calendar-plus me-1"></i> Created: <%= createdDate %>
                            </div>
                            <div>
                                <i class="far fa-edit me-1"></i> Updated: <%= updatedDate %>
                            </div>
                        </div>
                        
                        <div class="mt-2 text-end">
                            <small class="text-muted">Created by: <%= createdBy %></small>
                        </div>
                    </div>
                </div>
            <% 
                        } catch (Exception e) {
                            // Skip any appointment that causes an error
                            System.out.println("Error processing appointment: " + e.getMessage());
                            continue;
                        }
                    }
                } else {
                    %><div class="no-results-message">
                        <i class="fas fa-triangle-exclamation fa-3x mb-3"></i>
                        <h4>No appointment data available</h4>
                        <p>Unable to load appointment data from the database.</p>
                    </div><%
                }
            %>
        </div>

        <!-- Table View (Hidden by Default) -->
        <div class="table-container" id="tableView" style="display: none;">
            <table class="custom-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Date & Time</th>
                        <th>Client</th>
                        <th>Agent</th>
                        <th>Status</th>
                        <th>Notes</th>
                        <th>Created/Updated</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        if (jsonData != null && jsonData.has("appointments")) {
                            JsonArray appointments = jsonData.getAsJsonArray("appointments");
                            
                            if (appointments.size() == 0) {
                                %><tr><td colspan="7" class="text-center p-5">No appointments found.</td></tr><%
                            }
                            
                            for (int i = 0; i < appointments.size(); i++) {
                                try {
                                    JsonObject appointment = appointments.get(i).getAsJsonObject();
                                    
                                    // Get all available fields from the JSON data
                                    String appointmentId = appointment.has("appointmentId") ? 
                                        appointment.get("appointmentId").getAsString() : "N/A";
                                    String buyerName = appointment.has("buyerName") ? 
                                        appointment.get("buyerName").getAsString() : "N/A";
                                    String buyerEmail = appointment.has("buyerEmail") ? 
                                        appointment.get("buyerEmail").getAsString() : "N/A";
                                    String buyerPhone = appointment.has("buyerPhone") ? 
                                        appointment.get("buyerPhone").getAsString() : "N/A";
                                    String appointmentDate = appointment.has("appointmentDate") ? 
                                        appointment.get("appointmentDate").getAsString() : "N/A";
                                    String appointmentTime = appointment.has("appointmentTime") ? 
                                        appointment.get("appointmentTime").getAsString() : "N/A";
                                    String agentId = appointment.has("agentId") ? 
                                        appointment.get("agentId").getAsString() : "N/A";
                                    String agentName = appointment.has("agentName") ? 
                                        appointment.get("agentName").getAsString() : "N/A";
                                    String status = appointment.has("status") ? 
                                        appointment.get("status").getAsString() : "N/A";
                                    String notes = appointment.has("notes") ? 
                                        appointment.get("notes").getAsString() : "";
                                    String createdDate = appointment.has("createdDate") ? 
                                        appointment.get("createdDate").getAsString() : "N/A";
                                    String updatedDate = appointment.has("updatedDate") ? 
                                        appointment.get("updatedDate").getAsString() : "N/A";
                                    
                                    // Display each appointment row
                    %>
                        <tr data-status="<%= status.toLowerCase() %>">
                            <td><strong><%= appointmentId %></strong></td>
                            <td>
                                <div><i class="far fa-calendar-alt me-2 text-info"></i><%= appointmentDate %></div>
                                <div><i class="far fa-clock me-2 text-info"></i><%= appointmentTime %></div>
                            </td>
                            <td>
                                <% if (!buyerName.equals("N/A")) { %>
                                    <div><strong><%= buyerName %></strong></div>
                                <% } %>
                                <% if (!buyerEmail.equals("N/A")) { %>
                                    <div><small><i class="far fa-envelope me-1"></i><%= buyerEmail %></small></div>
                                <% } %>
                                <% if (!buyerPhone.equals("N/A")) { %>
                                    <div><small><i class="fas fa-phone-alt me-1"></i><%= buyerPhone %></small></div>
                                <% } %>
                            </td>
                            <td><strong><%= agentName %></strong> <% if (!agentId.equals("N/A")) { %><small class="text-muted d-block">ID: <%= agentId %></small><% } %></td>
                            <td>
                                <span class="status-badge status-<%= status.toLowerCase() %>">
                                    <%= status %>
                                </span>
                            </td>
                            <td><%= notes.length() > 50 ? notes.substring(0, 50) + "..." : notes %></td>
                            <td>
                                <div><small><i class="far fa-calendar-plus me-1 text-info"></i>Created: <%= createdDate %></small></div>
                                <div><small><i class="far fa-edit me-1 text-info"></i>Updated: <%= updatedDate %></small></div>
                            </td>
                        </tr>
                    <% 
                                } catch (Exception e) {
                                    // Skip any appointment that causes an error
                                    continue;
                                }
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
        
        <!-- Fixed Back to Dashboard Button (Mobile) -->
        <div class="d-block d-lg-none text-center mt-4">
            <a href="dashboard.jsp" class="btn btn-primary">
                <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
            </a>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Filter badges click handling
            const filterBadges = document.querySelectorAll('.filter-badge');
            filterBadges.forEach(badge => {
                badge.addEventListener('click', function() {
                    // Remove active class from all badges
                    filterBadges.forEach(b => b.classList.remove('active'));
                    
                    // Add active class to clicked badge
                    this.classList.add('active');
                    
                    // Get the status to filter by
                    const statusFilter = this.getAttribute('data-status');
                    
                    // Filter appointments by status
                    filterAppointmentsByStatus(statusFilter);
                });
            });

            // View selector handling
            const viewButtons = document.querySelectorAll('.view-btn');
            const cardView = document.getElementById('cardView');
            const tableView = document.getElementById('tableView');
            
            viewButtons.forEach(btn => {
                btn.addEventListener('click', function() {
                    // Remove active class from all view buttons
                    viewButtons.forEach(b => b.classList.remove('active'));
                    
                    // Add active class to clicked button
                    this.classList.add('active');
                    
                    // Show the selected view, hide the other
                    const viewType = this.getAttribute('data-view');
                    if (viewType === 'card') {
                        cardView.style.display = 'grid';
                        tableView.style.display = 'none';
                    } else {
                        cardView.style.display = 'none';
                        tableView.style.display = 'block';
                    }
                });
            });

            // Search functionality
            document.getElementById('searchButton').addEventListener('click', filterAppointments);
            document.getElementById('searchAppointment').addEventListener('keyup', function(event) {
                if (event.key === 'Enter') {
                    filterAppointments();
                }
            });
            
            // Floating header behavior
            let lastScroll = 0;
            const floatingHeader = document.querySelector('.floating-header');
            
            window.addEventListener('scroll', () => {
                const currentScroll = window.pageYOffset;
                
                if (currentScroll <= 0) {
                    floatingHeader.classList.remove('header-collapsed');
                }
                else if (currentScroll > lastScroll && !floatingHeader.classList.contains('header-collapsed')) {
                    floatingHeader.classList.add('header-collapsed');
                }
                else if (currentScroll < lastScroll && floatingHeader.classList.contains('header-collapsed')) {
                    floatingHeader.classList.remove('header-collapsed');
                }
                
                lastScroll = currentScroll;
            });

            // Filter appointments based on search criteria
            function filterAppointments() {
                const searchTerm = document.getElementById('searchAppointment').value.toLowerCase();
                const statusFilter = document.getElementById('statusFilter').value.toLowerCase();
                const dateFilter = document.getElementById('dateFilter').value;
                
                // Get all card and table elements
                const cards = document.querySelectorAll('#cardView .appointment-card');
                const rows = document.querySelectorAll('#tableView tbody tr');
                
                let visibleCardCount = 0;
                let visibleRowCount = 0;
                
                // Process cards
                cards.forEach(card => {
                    let shouldShow = true;
                    const cardStatus = card.getAttribute('data-status').toLowerCase();
                    
                    // Apply status filter
                    if (statusFilter && cardStatus !== statusFilter) {
                        shouldShow = false;
                    }
                    
                    // Apply text search
                    if (shouldShow && searchTerm) {
                        const cardText = card.textContent.toLowerCase();
                        shouldShow = cardText.includes(searchTerm);
                    }
                    
                    // Apply date filter if needed
                    // This would require more complex logic to parse dates
                    
                    // Show or hide the card
                    card.style.display = shouldShow ? 'block' : 'none';
                    
                    if (shouldShow) visibleCardCount++;
                });
                
                // Process table rows
                rows.forEach(row => {
                    let shouldShow = true;
                    const rowStatus = row.getAttribute('data-status').toLowerCase();
                    
                    // Apply status filter
                    if (statusFilter && rowStatus !== statusFilter) {
                        shouldShow = false;
                    }
                    
                    // Apply text search
                    if (shouldShow && searchTerm) {
                        const rowText = row.textContent.toLowerCase();
                        shouldShow = rowText.includes(searchTerm);
                    }
                    
                    // Show or hide the row
                    row.style.display = shouldShow ? '' : 'none';
                    
                    if (shouldShow) visibleRowCount++;
                });
                
                // Check if we need to show "no results" message
                handleNoResults(cardView, visibleCardCount === 0, 'card');
                handleNoResults(tableView.querySelector('tbody'), visibleRowCount === 0, 'table');
            }

            function handleNoResults(container, showMessage, viewType) {
                const existingMessage = container.querySelector('.no-results-message');
                
                if (showMessage) {
                    if (!existingMessage) {
                        const messageElement = document.createElement('div');
                        messageElement.className = viewType === 'card' ? 'no-results-message col-12' : 'no-results-message';
                        messageElement.innerHTML = `
                            <i class="fas fa-filter fa-3x mb-3 text-muted"></i>
                            <h4>No matching appointments</h4>
                            <p>Try adjusting your search filters</p>
                        `;
                        
                        if (viewType === 'table') {
                            const row = document.createElement('tr');
                            const cell = document.createElement('td');
                            cell.colSpan = 7;
                            cell.appendChild(messageElement);
                            row.appendChild(cell);
                            container.appendChild(row);
                        } else {
                            container.appendChild(messageElement);
                        }
                    }
                } else if (existingMessage) {
                    if (viewType === 'table') {
                        existingMessage.closest('tr').remove();
                    } else {
                        existingMessage.remove();
                    }
                }
            }

            // Filter appointments by status only
            function filterAppointmentsByStatus(status) {
                const cards = document.querySelectorAll('#cardView .appointment-card');
                const rows = document.querySelectorAll('#tableView tbody tr');
                
                let visibleCardCount = 0;
                let visibleRowCount = 0;
                
                cards.forEach(card => {
                    const cardStatus = card.getAttribute('data-status').toLowerCase();
                    const visible = (status === 'all' || cardStatus === status.toLowerCase());
                    card.style.display = visible ? 'block' : 'none';
                    if (visible) visibleCardCount++;
                });
                
                rows.forEach(row => {
                    const rowStatus = row.getAttribute('data-status').toLowerCase();
                    const visible = (status === 'all' || rowStatus === status.toLowerCase());
                    row.style.display = visible ? '' : 'none';
                    if (visible) visibleRowCount++;
                });
                
                // Update the status filter dropdown to match
                document.getElementById('statusFilter').value = status === 'all' ? '' : status;
                
                // Check if we need to show "no results" message
                handleNoResults(cardView, visibleCardCount === 0, 'card');
                handleNoResults(tableView.querySelector('tbody'), visibleRowCount === 0, 'table');
            }
        });
    </script>
</body>
</html>