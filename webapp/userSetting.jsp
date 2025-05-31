<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Settings | Real Estate Platform</title>
    
    <!-- CSS Libraries -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap">
    
    <style>
        :root {
            --primary: #0055ff;
            --primary-dark: #0044cc;
            --secondary: #6c757d;
            --dark-blue-1: #050a30;
            --dark-blue-2: #051552;
            --dark-blue-3: #072599;
            --card-bg: #091340;
            --card-hover: #0a1959;
            --text-primary: #ffffff;
            --text-secondary: #b0b7c3;
            --border-color: rgba(255, 255, 255, 0.1);
            --success-color: #00c689;
            --warning-color: #ffb545;
            --danger-color: #ff5e7a;
            --info-color: #4fabff;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, var(--dark-blue-1), var(--dark-blue-2));
            min-height: 100vh;
            color: var(--text-primary);
            overflow-x: hidden;
            position: relative;
        }
        
        #particles-js {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
        }
        
        .user-settings-container {
            max-width: 1240px;
            margin: 0 auto;
            padding: 30px 15px 100px;
            position: relative;
            z-index: 10;
        }
        
        .section-title {
            font-size: 1.8rem;
            font-weight: 600;
            margin-bottom: 25px;
            color: white;
            position: relative;
            display: inline-block;
        }
        
        .section-title::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: -8px;
            height: 4px;
            width: 60%;
            background: var(--primary);
            border-radius: 10px;
        }
        
        .card {
            background: var(--card-bg);
            border-radius: 15px;
            border: 1px solid var(--border-color);
            padding: 25px;
            margin-bottom: 25px;
            transition: all 0.3s ease;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
            background: var(--card-hover);
            border-color: rgba(255, 255, 255, 0.15);
        }
        
        .form-label {
            color: var(--text-secondary);
            font-weight: 500;
            margin-bottom: 8px;
        }
        
        .form-control, .form-select {
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid var(--border-color);
            color: var(--text-primary);
            padding: 12px 15px;
            border-radius: 10px;
            font-size: 0.95rem;
            transition: all 0.2s ease;
        }
        
        .form-control:focus, .form-select:focus {
            background: rgba(255, 255, 255, 0.12);
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(0, 85, 255, 0.2);
            color: var(--text-primary);
        }
        
        .form-check-input {
            background-color: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
            width: 20px;
            height: 20px;
        }
        
        .form-check-input:checked {
            background-color: var(--primary);
            border-color: var(--primary);
        }
        
        .form-switch .form-check-input {
            width: 40px;
            height: 23px;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='-4 -4 8 8'%3e%3ccircle r='3' fill='rgba(255, 255, 255, 0.8)'/%3e%3c/svg%3e");
        }
        
        .form-switch .form-check-input:checked {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='-4 -4 8 8'%3e%3ccircle r='3' fill='%23fff'/%3e%3c/svg%3e");
        }
        
        .form-check-label {
            font-size: 0.95rem;
            color: var(--text-secondary);
            padding-left: 10px;
            margin-top: 2px;
        }
        
        .btn-primary {
            background: var(--primary);
            border-color: var(--primary);
            font-weight: 500;
            padding: 10px 24px;
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            background: var(--primary-dark);
            border-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 85, 255, 0.3);
        }
        
        .btn-primary:active, .btn-primary:focus {
            background: var(--primary-dark);
            border-color: var(--primary-dark);
            box-shadow: 0 0 0 3px rgba(0, 85, 255, 0.3);
        }
        
        .btn-outline-light {
            border-color: rgba(255, 255, 255, 0.2);
            color: var(--text-primary);
        }
        
        .btn-outline-light:hover {
            background: rgba(255, 255, 255, 0.1);
            border-color: rgba(255, 255, 255, 0.3);
            color: var(--text-primary);
        }
        
        .nav-pills .nav-link {
            color: var(--text-secondary);
            padding: 15px 25px;
            margin-bottom: 8px;
            border-radius: 10px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .nav-pills .nav-link i {
            font-size: 1.1rem;
        }
        
        .nav-pills .nav-link.active {
            background: var(--primary);
            color: white;
            box-shadow: 0 5px 15px rgba(0, 85, 255, 0.3);
        }
        
        .nav-pills .nav-link:not(.active):hover {
            background: rgba(255, 255, 255, 0.1);
            color: white;
        }
        
        .profile-avatar-container {
            position: relative;
            margin-bottom: 25px;
        }
        
        .profile-avatar {
            width: 130px;
            height: 130px;
            border-radius: 50%;
            border: 4px solid var(--primary);
            padding: 4px;
            object-fit: cover;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .profile-avatar:hover {
            transform: scale(1.05);
            box-shadow: 0 0 30px rgba(0, 85, 255, 0.4);
        }
        
        .avatar-edit-btn {
            position: absolute;
            bottom: 5px;
            right: 0;
            width: 35px;
            height: 35px;
            background: var(--primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            color: white;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
        }
        
        .avatar-edit-btn:hover {
            background: var(--primary-dark);
            transform: scale(1.1);
        }
        
        .profile-stats {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }
        
        .stat-item {
            padding: 15px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
            text-align: center;
            flex: 1;
            transition: all 0.3s ease;
        }
        
        .stat-item:hover {
            background: rgba(255, 255, 255, 0.1);
            transform: translateY(-3px);
        }
        
        .stat-value {
            font-size: 1.8rem;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 5px;
        }
        
        .stat-label {
            color: var(--text-secondary);
            font-size: 0.85rem;
        }
        
        /* Top navigation */
        .top-navbar {
            display: flex;
            justify-content: space-between;
            padding: 15px 0;
            align-items: center;
            margin-bottom: 30px;
            border-bottom: 1px solid var(--border-color);
        }
        
        .back-button {
            color: var(--text-secondary);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
            padding: 8px 15px;
            border-radius: 8px;
        }
        
        .back-button:hover {
            color: var(--text-primary);
            background: rgba(255, 255, 255, 0.08);
            transform: translateX(-3px);
        }
        
        .current-time {
            background: rgba(255, 255, 255, 0.08);
            padding: 10px 20px;
            border-radius: 30px;
            font-size: 0.9rem;
            color: var(--text-secondary);
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        /* Toast notification */
        .toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
        }
        
        .toast {
            background: var(--card-bg);
            color: var(--text-primary);
            border: none;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(10px);
            border-left: 5px solid var(--primary);
        }
        
        .toast-header {
            background: transparent;
            color: var(--text-primary);
            border-bottom: 1px solid var(--border-color);
        }
        
        .toast.success { border-left-color: var(--success-color); }
        .toast.warning { border-left-color: var(--warning-color); }
        .toast.danger { border-left-color: var(--danger-color); }
        .toast.info { border-left-color: var(--info-color); }
        
        /* Loading animation */
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.7);
            z-index: 9999;
            display: flex;
            align-items: center;
            justify-content: center;
            visibility: hidden;
            opacity: 0;
            transition: all 0.3s ease;
        }
        
        .loading-overlay.show {
            visibility: visible;
            opacity: 1;
        }
        
        .loading-spinner {
            width: 60px;
            height: 60px;
            border: 5px solid rgba(255, 255, 255, 0.1);
            border-top-color: var(--primary);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
        
        /* Password strength meter */
        .password-strength-meter {
            height: 5px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 5px;
            margin-top: 10px;
            overflow: hidden;
        }
        
        .password-strength-value {
            height: 100%;
            width: 0;
            border-radius: 5px;
            transition: width 0.3s ease, background 0.3s ease;
        }
        
        .strength-weak { background: var(--danger-color); width: 20%; }
        .strength-fair { background: var(--warning-color); width: 50%; }
        .strength-good { background: var(--info-color); width: 75%; }
        .strength-strong { background: var(--success-color); width: 100%; }
        
        .strength-text {
            font-size: 0.85rem;
            margin-top: 8px;
            color: var(--text-secondary);
        }
        
        /* Animation classes */
        .fade-in-up {
            opacity: 0;
            transform: translateY(20px);
            animation: fadeInUp 0.6s forwards;
        }
        
        .delay-1 { animation-delay: 0.1s; }
        .delay-2 { animation-delay: 0.2s; }
        .delay-3 { animation-delay: 0.3s; }
        .delay-4 { animation-delay: 0.4s; }
        .delay-5 { animation-delay: 0.5s; }
        
        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        /* Responsive adjustments */
        @media (max-width: 768px) {
            .nav-sidebar {
                margin-bottom: 30px;
            }
            
            .profile-stats {
                flex-direction: column;
                gap: 10px;
            }
        }
        
        /* Toggle switch */
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
            background-color: var(--primary);
        }
        
        input:focus + .toggle-slider {
            box-shadow: 0 0 1px var(--primary);
        }
        
        input:checked + .toggle-slider:before {
            transform: translateX(26px);
        }
    </style>
</head>
<body>
	
    <!-- Particles.js Container -->
    <div id="particles-js"></div>
    
    <!-- Loading Overlay -->
    <div class="loading-overlay" id="loadingOverlay">
        <div class="loading-spinner"></div>
    </div>
    
    <!-- Toast Notifications -->
    <div class="toast-container">
        <div class="toast" name="notification" id="notification" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <i class="fas fa-bell me-2"></i>
                <strong class="me-auto" name="notification-title" id="notification-title">Notification</strong>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
            <div class="toast-body" id="notification-message">
                Settings have been updated successfully!
            </div>
        </div>
    </div>
    
    <div class="user-settings-container">
        <!-- Top Navigation -->
        <div class="top-navbar fade-in-up">
            <a href="userDashboard.jsp" class="back-button">
                <i class="fas fa-arrow-left"></i>
                <span>Back to Dashboard</span>
            </a>
            
            <div class="current-time">
                <i class="far fa-clock"></i>
                <span name="currentDateTime" id="currentDateTime">2025-03-23 13:59:53</span>
            </div>
        </div>
        
        <div class="row">
            <!-- Left Sidebar -->
            <div class="col-lg-3 col-md-4 mb-4 fade-in-up delay-1">
                <div class="card nav-sidebar">
                    <div class="profile-avatar-container text-center">
                        <img src="https://ui-avatars.com/api/?name=John+Doe&background=0055ff&color=fff&size=200" 
                             alt="Profile Avatar" 
                             class="profile-avatar" 
                             name="profileAvatar"
                             id="profileAvatar">
                        <div class="avatar-edit-btn" name="changeAvatarBtn" id="changeAvatarBtn">
                            <i class="fas fa-camera"></i>
                            <input type="file" name="avatarUpload" id="avatarUpload" hidden accept="image/*">
                        </div>
                        
                        <h4 class="mt-3 mb-1">John Doe</h4>
                        <p class="text-secondary mb-0">Real Estate Agent</p>
                    </div>
                    
                    <div class="nav flex-column nav-pills" name="v-pills-tab" id="v-pills-tab" role="tablist">
                        <button class="nav-link active"
                         		name="profile-tab"
                                id="profile-tab" 
                                data-bs-toggle="pill" 
                                data-bs-target="#profile-tab-pane" 
                                type="button" 
                                role="tab" 
                                aria-selected="true">
                            <i class="fas fa-user"></i>
                            <span>Profile</span>
                        </button>
                        <button class="nav-link" 
                                id="security-tab"
                                name="security-tab" 
                                data-bs-toggle="pill" 
                                data-bs-target="#security-tab-pane" 
                                type="button" 
                                role="tab" 
                                aria-selected="false">
                            <i class="fas fa-shield-alt"></i>
                            <span>Security</span>
                        </button>
                        <button class="nav-link" 
                                id="notifications-tab"
                                name="notifications-tab" 
                                data-bs-toggle="pill" 
                                data-bs-target="#notifications-tab-pane" 
                                type="button" 
                                role="tab" 
                                aria-selected="false">
                            <i class="fas fa-bell"></i>
                            <span>Notifications</span>
                        </button>
                        <button class="nav-link" 
                                id="appearance-tab"
                                name="appearance-tab" 
                                data-bs-toggle="pill" 
                                data-bs-target="#appearance-tab-pane" 
                                type="button" 
                                role="tab" 
                                aria-selected="false">
                            <i class="fas fa-paint-brush"></i>
                            <span>Appearance</span>
                        </button>
                        <button class="nav-link" 
                                id="listings-tab"
                                name="listings-tab" 
                                data-bs-toggle="pill" 
                                data-bs-target="#listings-tab-pane" 
                                type="button" 
                                role="tab" 
                                aria-selected="false">
                            <i class="fas fa-home"></i>
                            <span>Listings</span>
                        </button>
                    </div>
                </div>
            </div>
            
            <!-- Right Content -->
            <div class="col-lg-9 col-md-8">
                <div class="tab-content" name="v-pills-tabContent" id="v-pills-tabContent">
                    <!-- Profile Tab -->
                    <div class="tab-pane fade show active" name="profile-tab-pane" id="profile-tab-pane" role="tabpanel" aria-labelledby="profile-tab" tabindex="0">
                        <div class="card fade-in-up delay-2">
                            <h3 class="section-title">Profile Information</h3>
                            <form action="UserSettingServlet" method="post" name="profileForm" id="profileForm" class="mt-4">
                                <div class="row g-4">
                                    <div class="col-md-6">
                                        <label for="firstName" class="form-label">First Name</label>
                                        
										<input type="text" class="form-control" name="firstName" id="firstName" value="" required>

                                    </div>
                                    <div class="col-md-6">
                                        <label for="lastName" class="form-label">Last Name</label>
                                        <input type="text" class="form-control" name="lastName" id="lastName" value="Doe" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="email" class="form-label">Email Address</label>
                                        <input type="email" class="form-control" name="email" id="email" value="john.doe@example.com" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="phone" class="form-label">Phone Number</label>
                                        <input type="tel" class="form-control" name="phone" id="phone" value="+94 70 123 4567">
                                    </div>
                                    <div class="col-12">
                                        <label for="bio" class="form-label">Bio</label>
                                        <textarea class="form-control" name="bio" id="bio" rows="4">Experienced real estate agent specializing in luxury properties and international investments. Over 10 years in the industry with a proven track record of successful transactions.</textarea>
                                    </div>
                                </div>
                            </form>
                        </div>
                        
                        <div class="card fade-in-up delay-3">
                            <h3 class="section-title">Professional Information</h3>
                            <form id="professionalForm" class="mt-4">
                                <div class="row g-4">
                                    <div class="col-md-6">
                                        <label for="jobTitle" class="form-label">Job Title</label>
                                        <input type="text" class="form-control" name="jobTitle" id="jobTitle" value="Senior Real Estate Agent">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="licenseNumber" class="form-label">License Number</label>
                                        <input type="text" class="form-control" name="licenseNumber"id="licenseNumber" value="REA-2025-37891">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="experience" class="form-label">Years of Experience</label>
                                        <select class="form-select" name="experience" id="experience">
                                            <option value="0-2">0-2 years</option>
                                            <option value="3-5">3-5 years</option>
                                            <option value="6-10" selected>6-10 years</option>
                                            <option value="10+">10+ years</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="specialization" class="form-label">Specialization</label>
                                        <select class="form-select" name="specialization" id="specialization">
                                            <option value="residential">Residential</option>
                                            <option value="commercial">Commercial</option>
                                            <option value="luxury" selected>Luxury Properties</option>
                                            <option value="industrial">Industrial</option>
                                            <option value="land">Land</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="mt-4">
                                    <button type="button" class="btn btn-primary me-2" onclick="saveProfile()">
                                        <i class="fas fa-save me-2"></i> Save Changes
                                    </button>
                                    <button type="reset" class="btn btn-outline-light">
                                        <i class="fas fa-redo me-2"></i> Reset
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                    <!-- Security Tab -->
                    <div class="tab-pane fade" name="security-tab-pane" id="security-tab-pane" role="tabpanel" aria-labelledby="security-tab" tabindex="0">
                        <div class="card fade-in-up">
                            <h3 class="section-title">Password Management</h3>
                            <form id="passwordForm" class="mt-4">
                                <div class="row g-4">
                                    <div class="col-md-12">
                                        <label for="currentPassword" class="form-label">Current Password</label>
                                        <input type="password" class="form-control" name="currentPassword" id="currentPassword" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="newPassword" class="form-label">New Password</label>
                                        <input type="password" class="form-control" name="newPassword" id="newPassword" required onkeyup="checkPasswordStrength()">
                                        <div class="password-strength-meter mt-2">
                                            <div class="password-strength-value" name="passwordStrength" id="passwordStrength"></div>
                                        </div>
                                        <span class="strength-text" name="passwordStrengthText" id="passwordStrengthText">Password strength: Not entered</span>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                        <input type="password" class="form-control" name="confirmPassword" id="confirmPassword" required>
                                    </div>
                                    <div class="col-12">
                                        <button type="button" class="btn btn-primary mt-2" onclick="updatePassword()">
                                            <i class="fas fa-key me-2"></i> Update Password
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                        
                        <div class="card fade-in-up delay-2">
                            <h3 class="section-title">Two-Factor Authentication</h3>
                            <div class="d-flex justify-content-between align-items-center mt-4">
                                <div>
                                    <h5 class="mb-1">Enable 2FA</h5>
                                    <p class="text-secondary mb-0">Add an extra layer of security to your account</p>
                                </div>
                                <label class="toggle-switch">
                                    <input type="checkbox" name="twoFactorToggle" id="twoFactorToggle">
                                    <span class="toggle-slider"></span>
                                </label>
                            </div>
                            
                            <div class="mt-4 pt-3 border-top border-secondary" name="twoFactorSetup" id="twoFactorSetup" style="display: none;">
                                <div class="text-center mb-4">
                                    <img src="https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=otpauth://totp/RealEstateApp:john.doe@example.com?secret=JBSWY3DPEHPK3PXP&issuer=RealEstateApp" 
                                         alt="QR Code" 
                                         class="img-fluid mb-3" 
                                         style="max-width: 200px;">
                                    <p class="mb-0">Scan this QR code with your authenticator app</p>
                                    <div class="mt-3">
                                        <input type="text" class="form-control mb-3" placeholder="Enter 6-digit code">
                                        <button class="btn btn-primary">Verify & Enable</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="card fade-in-up delay-3">
                            <h3 class="section-title">Sessions</h3>
                            <div class="mt-4">
                                <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom border-secondary">
                                    <div>
                                        <h5 class="mb-1">Current Session</h5>
                                        <p class="text-secondary mb-0">
                                            <i class="fas fa-laptop me-1"></i> Windows 11 - Chrome Browser
                                            <span class="ms-3"><i class="fas fa-map-marker-alt me-1"></i> Colombo, Sri Lanka</span>
                                        </p>
                                    </div>
                                    <span class="badge bg-success">Active Now</span>
                                </div>
                                
                                <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom border-secondary">
                                    <div>
                                        <h5 class="mb-1">Mobile Application</h5>
                                        <p class="text-secondary mb-0">
                                            <i class="fas fa-mobile-alt me-1"></i> iPhone 15 Pro
                                            <span class="ms-3"><i class="fas fa-map-marker-alt me-1"></i> Colombo, Sri Lanka</span>
                                            <span class="ms-3"><i class="fas fa-clock me-1"></i> Last active: 3 hours ago</span>
                                        </p>
                                    </div>
                                    <button class="btn btn-sm btn-outline-danger">
                                        <i class="fas fa-sign-out-alt me-1"></i> Logout
                                    </button>
                                </div>
                                
                                <button class="btn btn-danger">
                                    <i class="fas fa-power-off me-2"></i> Logout from all devices
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Notifications Tab -->
                    <div class="tab-pane fade" name="notifications-tab-pane" id="notifications-tab-pane" role="tabpanel" aria-labelledby="notifications-tab" tabindex="0">
                        <div class="card fade-in-up">
                            <h3 class="section-title">Notification Settings</h3>
                            <form id="notificationsForm" class="mt-4">
                                <div class="row g-4">
                                    <div class="col-12">
                                        <h5 class="mb-4">Email Notifications</h5>
                                        
                                        <div class="d-flex justify-content-between align-items-center mb-3 pb-3 border-bottom border-secondary">
                                            <div>
                                                <h6 class="mb-1">New Inquiries</h6>
                                                <p class="text-secondary mb-0">Get notified when you receive new property inquiries</p>
                                            </div>
                                            <label class="toggle-switch">
                                                <input type="checkbox" name="emailInquiries" id="emailInquiries" checked>
                                                <span class="toggle-slider"></span>
                                            </label>
                                        </div>
                                        
                                        <div class="d-flex justify-content-between align-items-center mb-3 pb-3 border-bottom border-secondary">
                                            <div>
                                                <h6 class="mb-1">Property Updates</h6>
                                                <p class="text-secondary mb-0">Updates about your listed properties</p>
                                            </div>
                                            <label class="toggle-switch">
                                                <input type="checkbox" name="emailPropertyUpdates" id="emailPropertyUpdates" checked>
                                                <span class="toggle-slider"></span>
                                            </label>
                                        </div>
                                        
                                        <div class="d-flex justify-content-between align-items-center mb-3 pb-3 border-bottom border-secondary">
                                            <div>
                                                <h6 class="mb-1">Newsletter</h6>
                                                <p class="text-secondary mb-0">Weekly newsletter with market updates and tips</p>
                                            </div>
                                            <label class="toggle-switch">
                                                <input type="checkbox" name="emailNewsletter" id="emailNewsletter">
                                                <span class="toggle-slider"></span>
                                            </label>
                                        </div>
                                    </div>
                                    
                                    <div class="col-12">
                                        <h5 class="mb-4">SMS Notifications</h5>
                                        
                                        <div class="d-flex justify-content-between align-items-center mb-3 pb-3 border-bottom border-secondary">
                                            <div>
                                                <h6 class="mb-1">Urgent Inquiries</h6>
                                                <p class="text-secondary mb-0">High-priority inquiries that need immediate attention</p>
                                            </div>
                                            <label class="toggle-switch">
                                                <input type="checkbox" name="smsUrgentInquiries" id="smsUrgentInquiries" checked>
                                                <span class="toggle-slider"></span>
                                            </label>
                                        </div>
                                        
                                        <div class="d-flex justify-content-between align-items-center mb-3 pb-3 border-bottom border-secondary">
                                            <div>
                                                <h6 class="mb-1">Appointment Reminders</h6>
                                                <p class="text-secondary mb-0">Get reminders before scheduled property viewings</p>
                                            </div>
                                            <label class="toggle-switch">
                                                <input type="checkbox" name="smsAppointments" id="smsAppointments" checked>
                                                <span class="toggle-slider"></span>
                                            </label>
                                        </div>
                                    </div>
                                    
                                    <div class="col-12">
                                        <button type="button" class="btn btn-primary me-2" onclick="saveNotifications()">
                                            <i class="fas fa-save me-2"></i> Save Preferences
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                    <!-- Appearance Tab -->
                    <div class="tab-pane fade" name="appearance-tab-pane" id="appearance-tab-pane" role="tabpanel" aria-labelledby="appearance-tab" tabindex="0">
                        <div class="card fade-in-up">
                            <h3 class="section-title">Language & Region</h3>
                            <form name="appearanceForm" id="appearanceForm" class="mt-4">
                                <div class="row g-4">
                                    <div class="col-md-6">
                                        <label for="language" class="form-label">Display Language</label>
                                        <select class="form-select" name="language" id="language">
                                            <option value="en" selected>English</option>
                                            <option value="si">Sinhala</option>
                                            <option value="ta">Tamil</option>
                                            <option value="fr">French</option>
                                            <option value="ar">Arabic</option>
                                            <option value="zh">Chinese (Simplified)</option>
                                        </select>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <label for="timezone" class="form-label">Time Zone</label>
                                        <select class="form-select" name="timezone" id="timezone">
                                            <option value="UTC">UTC (Coordinated Universal Time)</option>
                                            <option value="Asia/Colombo" selected>Asia/Colombo (GMT+5:30)</option>
                                            <option value="America/New_York">America/New_York (GMT-4)</option>
                                            <option value="Europe/London">Europe/London (GMT+1)</option>
                                            <option value="Asia/Dubai">Asia/Dubai (GMT+4)</option>
                                            <option value="Australia/Sydney">Australia/Sydney (GMT+10)</option>
                                        </select>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <label for="dateFormat" class="form-label">Date Format</label>
                                        <select class="form-select" name="dateFormat" id="dateFormat">
                                            <option value="MM/DD/YYYY">MM/DD/YYYY</option>
                                            <option value="DD/MM/YYYY" selected>DD/MM/YYYY</option>
                                            <option value="YYYY-MM-DD">YYYY-MM-DD</option>
                                        </select>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <label for="currency" class="form-label">Currency Format</label>
                                        <select class="form-select" name="currency" id="currency">
                                            <option value="LKR" selected>LKR (Rs)</option>
                                            <option value="USD">USD ($)</option>
                                            <option value="EUR">EUR (€)</option>
                                            <option value="GBP">GBP (£)</option>
                                            <option value="AED">AED (د.إ)</option>
                                        </select>
                                    </div>
                                </div>
                            </form>
                        </div>
                        
                        <div class="card fade-in-up delay-2">
                            <h3 class="section-title">Interface Preferences</h3>
                            <form class="mt-4">
                                <div class="row g-4">
                                    <div class="col-md-6">
                                        <label for="theme" class="form-label">Theme Mode</label>
                                        <select class="form-select" name="theme" id="theme">
                                            <option value="dark" selected>Dark Mode</option>
                                            <option value="light">Light Mode</option>
                                            <option value="system">Use System Setting</option>
                                        </select>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <label for="accentColor" class="form-label">Accent Color</label>
                                        <select class="form-select" name="accentColor" id="accentColor">
                                            <option value="blue" selected>Blue</option>
                                            <option value="purple">Purple</option>
                                            <option value="green">Green</option>
                                            <option value="orange">Orange</option>
                                            <option value="pink">Pink</option>
                                        </select>
                                    </div>
                                    
                                    <div class="col-12">
                                        <div class="mb-3">
                                            <label class="form-label">Display Density</label>
                                            <div class="d-flex gap-4">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" name="density" id="densityCompact">
                                                    <label class="form-check-label" for="densityCompact">Compact</label>
                                                </div>
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" name="density" id="densityDefault" checked>
                                                    <label class="form-check-label" for="densityDefault">Default</label>
                                                </div>
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" name="density" id="densityComfortable">
                                                    <label class="form-check-label" for="densityComfortable">Comfortable</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-12">
                                        <button type="button" class="btn btn-primary me-2" onclick="saveAppearance()">
                                            <i class="fas fa-save me-2"></i> Save Preferences
                                        </button>
                                        <button type="reset" class="btn btn-outline-light">
                                            <i class="fas fa-redo me-2"></i> Reset
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                    <!-- Listings Tab -->
                    <div class="tab-pane fade" name="listings-tab-pane" id="listings-tab-pane" role="tabpanel" aria-labelledby="listings-tab" tabindex="0">
                        <div class="card fade-in-up">
                            <h3 class="section-title">Listing Preferences</h3>
                            <form id="listingsForm" class="mt-4">
                                <div class="row g-4">
                                    <div class="col-md-6">
                                        <label for="defaultPropertyType" class="form-label">Default Property Type</label>
                                        <select class="form-select" name="defaultPropertyType" id="defaultPropertyType">
                                            <option value="residential" selected>Residential</option>
                                            <option value="commercial">Commercial</option>
                                            <option value="industrial">Industrial</option>
                                            <option value="land">Land</option>
                                        </select>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <label for="displayCurrency" class="form-label">Display Currency</label>
                                        <select class="form-select" name="displayCurrency" id="displayCurrency">
                                            <option value="LKR" selected>LKR - Sri Lankan Rupee</option>
                                            <option value="USD">USD - US Dollar</option>
                                            <option value="EUR">EUR - Euro</option>
                                            <option value="GBP">GBP - British Pound</option>
                                        </select>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <label for="unitSystem" class="form-label">Unit System</label>
                                        <select class="form-select" name="unitSystem" id="unitSystem">
                                            <option value="metric" selected>Metric (m², km)</option>
                                            <option value="imperial">Imperial (sq ft, miles)</option>
                                        </select>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <label for="defaultRadius" class="form-label">Default Search Radius</label>
                                        <select class="form-select" name="defaultRadius" id="defaultRadius">
                                            <option value="1">1 km</option>
                                            <option value="5" selected>5 km</option>
                                            <option value="10">10 km</option>
                                            <option value="25">25 km</option>
                                            <option value="50">50 km</option>
                                        </select>
                                    </div>
                                    
                                    <div class="col-12">
                                        <button type="button" class="btn btn-primary me-2" onclick="saveListings()">
                                            <i class="fas fa-save me-2"></i> Save Preferences
                                        </button>
                                        <button type="reset" class="btn btn-outline-light">
                                            <i class="fas fa-redo me-2"></i> Reset
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                        
                        <div class="card fade-in-up delay-2">
                            <h3 class="section-title">Default Listing Fields</h3>
                            <p class="text-secondary">Choose which fields to display by default when creating new listings</p>
                            
                            <div class="row g-3 mt-3">
                                <div class="col-md-6">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="field_price" id="field_price" checked>
                                        <label class="form-check-label" for="field_price">Price</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="field_size" id="field_size" checked>
                                        <label class="form-check-label" for="field_size">Property Size</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="field_bedrooms" id="field_bedrooms" checked>
                                        <label class="form-check-label" for="field_bedrooms">Bedrooms</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="field_bathrooms" id="field_bathrooms" checked>
                                        <label class="form-check-label" for="field_bathrooms">Bathrooms</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="field_garage" id="field_garage" checked>
                                        <label class="form-check-label" for="field_garage">Garage/Parking</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="field_year" id="field_year" checked>
                                        <label class="form-check-label" for="field_year">Year Built</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="field_pool" id="field_pool">
                                        <label class="form-check-label" for="field_pool">Swimming Pool</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="field_aircon" id="field_aircon">
                                        <label class="form-check-label" for="field_aircon">Air Conditioning</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="field_garden" id="field_garden">
                                        <label class="form-check-label" for="field_garden">Garden/Yard</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="field_security" id="field_security">
                                        <label class="form-check-label" for="field_security">Security System</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- JavaScript Libraries -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/particles.js@2.0.0/particles.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
        // Initialize Particles.js
        document.addEventListener('DOMContentLoaded', function() {
            particlesJS('particles-js', {
                "particles": {
                    "number": {
                        "value": 50,
                        "density": {
                            "enable": true,
                            "value_area": 800
                        }
                    },
                    "color": {
                        "value": "#ffffff"
                    },
                    "shape": {
                        "type": "circle",
                        "stroke": {
                            "width": 0,
                            "color": "#000000"
                        },
                        "polygon": {
                            "nb_sides": 5
                        }
                    },
                    "opacity": {
                        "value": 0.2,
                        "random": true,
                        "anim": {
                            "enable": true,
                            "speed": 0.2,
                            "opacity_min": 0.1,
                            "sync": false
                        }
                    },
                    "size": {
                        "value": 3,
                        "random": true,
                        "anim": {
                            "enable": true,
                            "speed": 2,
                            "size_min": 0.3,
                            "sync": false
                        }
                    },
                    "line_linked": {
                        "enable": true,
                        "distance": 150,
                        "color": "#ffffff",
                        "opacity": 0.1,
                        "width": 1
                    },
                    "move": {
                        "enable": true,
                        "speed": 1,
                        "direction": "none",
                        "random": true,
                        "straight": false,
                        "out_mode": "out",
                        "bounce": false,
                        "attract": {
                            "enable": false,
                            "rotateX": 600,
                            "rotateY": 1200
                        }
                    }
                },
                "interactivity": {
                    "detect_on": "canvas",
                    "events": {
                        "onhover": {
                            "enable": true,
                            "mode": "grab"
                        },
                        "onclick": {
                            "enable": true,
                            "mode": "push"
                        },
                        "resize": true
                    },
                    "modes": {
                        "grab": {
                            "distance": 140,
                            "line_linked": {
                                "opacity": 0.4
                            }
                        },
                        "bubble": {
                            "distance": 400,
                            "size": 40,
                            "duration": 2,
                            "opacity": 8,
                            "speed": 3
                        },
                        "repulse": {
                            "distance": 200,
                            "duration": 0.4
                        },
                        "push": {
                            "particles_nb": 4
                        },
                        "remove": {
                            "particles_nb": 2
                        }
                    }
                },
                "retina_detect": true
            });
            
            // Update current time
            updateCurrentTime();
            setInterval(updateCurrentTime, 1000);
            
            // Setup event listeners
            document.getElementById('changeAvatarBtn').addEventListener('click', function() {
                document.getElementById('avatarUpload').click();
            });
            
            document.getElementById('avatarUpload').addEventListener('change', function(e) {
                if (e.target.files && e.target.files[0]) {
                    const reader = new FileReader();
                    
                    reader.onload = function(e) {
                        document.getElementById('profileAvatar').src = e.target.result;
                    }
                    
                    reader.readAsDataURL(e.target.files[0]);
                    showNotification('Profile picture updated successfully', 'Profile picture has been changed.');
                }
            });
            
            document.getElementById('twoFactorToggle').addEventListener('change', function(e) {
                const twoFactorSetup = document.getElementById('twoFactorSetup');
                
                if (e.target.checked) {
                    twoFactorSetup.style.display = 'block';
                } else {
                    twoFactorSetup.style.display = 'none';
                }
            });
        });
        
        // Update current time
        function updateCurrentTime() {
            const now = new Date();
            const options = {
                year: 'numeric',
                month: '2-digit',
                day: '2-digit',
                hour: '2-digit',
                minute: '2-digit',
                second: '2-digit',
                hour12: false
            };
            
            const formattedDateTime = now.toLocaleString('en-GB', options)
                .replace(',', '')
                .replace(/(\d+)\/(\d+)\/(\d+)/, '$3-$2-$1');
                
            document.getElementById('currentDateTime').textContent = formattedDateTime;
        }
        
        // Function to show loading spinner
        function showLoading(show = true) {
            const loadingOverlay = document.getElementById('loadingOverlay');
            
            if (show) {
                loadingOverlay.classList.add('show');
            } else {
                loadingOverlay.classList.remove('show');
            }
        }
        
        // Function to show notification
        function showNotification(title, message, type = 'success') {
            const notificationEl = document.getElementById('notification');
            const notificationTitle = document.getElementById('notification-title');
            const notificationMessage = document.getElementById('notification-message');
            
            // Remove existing classes
            notificationEl.classList.remove('success', 'warning', 'danger', 'info');
            
            // Add appropriate class based on type
            notificationEl.classList.add(type);
            
            // Update content
            notificationTitle.textContent = title;
            notificationMessage.textContent = message;
            
            // Show the toast
            const toast = new bootstrap.Toast(notificationEl);
            toast.show();
        }
        
        // Password strength checker
        function checkPasswordStrength() {
            const password = document.getElementById('newPassword').value;
            const strengthBar = document.getElementById('passwordStrength');
            const strengthText = document.getElementById('passwordStrengthText');
            
            if (!password) {
                strengthBar.className = 'password-strength-value';
                strengthBar.style.width = '0';
                strengthText.textContent = 'Password strength: Not entered';
                return;
            }
            
            // Check strength
            let strength = 0;
            
            // Length check
            if (password.length >= 8) strength += 1;
            if (password.length >= 12) strength += 1;
            
            // Complexity checks
            if (/[A-Z]/.test(password)) strength += 1;
            if (/[a-z]/.test(password)) strength += 1;
            if (/[0-9]/.test(password)) strength += 1;
            if (/[^A-Za-z0-9]/.test(password)) strength += 1;
            
            // Update UI based on strength
            strengthBar.className = 'password-strength-value';
            
            if (strength < 3) {
                strengthBar.classList.add('strength-weak');
                strengthText.textContent = 'Password strength: Weak';
            } else if (strength < 5) {
                strengthBar.classList.add('strength-fair');
                strengthText.textContent = 'Password strength: Fair';
            } else if (strength < 6) {
                strengthBar.classList.add('strength-good');
                strengthText.textContent = 'Password strength: Good';
            } else {
                strengthBar.classList.add('strength-strong');
                strengthText.textContent = 'Password strength: Strong';
            }
        }
        
        // Profile save function
       
        
// Replace the saveProfile function with this:
function saveProfile() {
    showLoading(true);

    // Get the form element
    const form = document.getElementById('profileForm');
    const formData = new FormData(form);
    formData.append('action', 'saveProfile');

    // Append professional info fields that are in a different form
    formData.append('jobTitle', document.getElementById('jobTitle').value);
    formData.append('licenseNumber', document.getElementById('licenseNumber').value);
    formData.append('experience', document.getElementById('experience').value);
    formData.append('specialization', document.getElementById('specialization').value);

    // Actually send the data to the servlet
    fetch('UserSettingServlet', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        showLoading(false);
        showNotification('Profile Updated', 'Your profile information has been saved successfully.');
    })
    .catch(error => {
        console.error('Error:', error);
        showLoading(false);
        showNotification('Error', 'Failed to save profile. Please try again.', 'danger');
    });
}

        
        // Password update function
        function updatePassword() {
            const currentPassword = document.getElementById('currentPassword').value;
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            // Validation
            if (!currentPassword || !newPassword || !confirmPassword) {
                showNotification('Error', 'All password fields are required.', 'danger');
                return;
            }
            
            if (newPassword !== confirmPassword) {
                showNotification('Error', 'New passwords do not match.', 'danger');
                return;
            }
            
            showLoading(true);
            
            const passwordData = {
                action: 'savePassword',
                username: 'John_Doe', // This would come from the session
                currentPassword: currentPassword,
                newPassword: newPassword
            };
            
            // Simulate AJAX request
            setTimeout(() => {
                showLoading(false);
                showNotification('Password Updated', 'Your password has been changed successfully.');
                
                // Clear the form
                document.getElementById('passwordForm').reset();
                document.getElementById('passwordStrength').className = 'password-strength-value';
                document.getElementById('passwordStrength').style.width = '0';
                document.getElementById('passwordStrengthText').textContent = 'Password strength: Not entered';
                
                // In a real app, you would send this data to your servlet
                console.log('Password data to be sent:', passwordData);
            }, 1000);
        }
        
        // Save notification preferences
        function saveNotifications() {
            showLoading(true);
            
            const notificationData = {
                action: 'saveNotifications',
                username: 'John_Doe', // This would come from the session
                emailInquiries: document.getElementById('emailInquiries').checked,
                emailPropertyUpdates: document.getElementById('emailPropertyUpdates').checked,
                emailNewsletter: document.getElementById('emailNewsletter').checked,
                smsUrgentInquiries: document.getElementById('smsUrgentInquiries').checked,
                smsAppointments: document.getElementById('smsAppointments').checked
            };
            
            // Simulate AJAX request
            setTimeout(() => {
                showLoading(false);
                showNotification('Notifications Updated', 'Your notification preferences have been saved.');
                
                // In a real app, you would send this data to your servlet
                console.log('Notification data to be sent:', notificationData);
            }, 1000);
        }
        
        // Save appearance preferences
        function saveAppearance() {
            showLoading(true);
            
            const appearanceData = {
                action: 'saveAppearance',
                username: 'John_Doe', // This would come from the session
                language: document.getElementById('language').value,
                timezone: document.getElementById('timezone').value,
                dateFormat: document.getElementById('dateFormat').value,
                currency: document.getElementById('currency').value,
                theme: document.getElementById('theme').value,
                                accentColor: document.getElementById('accentColor').value,
                density: document.querySelector('input[name="density"]:checked').id.replace('density', '').toLowerCase()
            };
            
            // Simulate AJAX request
            setTimeout(() => {
                showLoading(false);
                showNotification('Appearance Settings Updated', 'Your appearance preferences have been saved.');
                
                // In a real app, you would send this data to your servlet
                console.log('Appearance data to be sent:', appearanceData);
            }, 1000);
        }
        
        // Save listing preferences
        function saveListings() {
            showLoading(true);
            
            const listingData = {
                action: 'saveListings',
                username: 'IT24102083', // This would come from the session
                defaultPropertyType: document.getElementById('defaultPropertyType').value,
                displayCurrency: document.getElementById('displayCurrency').value,
                unitSystem: document.getElementById('unitSystem').value,
                defaultRadius: document.getElementById('defaultRadius').value,
                fields: {
                    price: document.getElementById('field_price').checked,
                    size: document.getElementById('field_size').checked,
                    bedrooms: document.getElementById('field_bedrooms').checked,
                    bathrooms: document.getElementById('field_bathrooms').checked,
                    garage: document.getElementById('field_garage').checked,
                    yearBuilt: document.getElementById('field_year').checked,
                    pool: document.getElementById('field_pool').checked,
                    aircon: document.getElementById('field_aircon').checked,
                    garden: document.getElementById('field_garden').checked,
                    security: document.getElementById('field_security').checked
                }
            };
            
            // Simulate AJAX request with data submission to servlet
            setTimeout(() => {
                // Create form data for servlet submission
                const formData = new FormData();
                formData.append('action', 'saveListings');
                formData.append('username', 'IT24102083');
                formData.append('defaultPropertyType', document.getElementById('defaultPropertyType').value);
                formData.append('displayCurrency', document.getElementById('displayCurrency').value);
                formData.append('unitSystem', document.getElementById('unitSystem').value);
                formData.append('defaultRadius', document.getElementById('defaultRadius').value);
                
                // Append fields data as JSON string
                formData.append('fields', JSON.stringify(listingData.fields));
                
                // Actual AJAX call to servlet would go here
                /*
                fetch('UserSettingsServlet', {
                    method: 'POST',
                    body: formData
                })
                .then(response => response.json())
                .then(data => {
                    showLoading(false);
                    if (data.success) {
                        showNotification('Listing Preferences Updated', data.message);
                    } else {
                        showNotification('Error', data.message || 'An error occurred while saving preferences.', 'danger');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showLoading(false);
                    showNotification('Error', 'Failed to save preferences. Please try again.', 'danger');
                });
                */
                
                // For demonstration, we'll just show success
                showLoading(false);
                showNotification('Listing Preferences Updated', 'Your listing preferences have been saved successfully.');
                
                console.log('Listing data to be sent:', listingData);
            }, 1000);
        }
        
        // Initialize UI
        document.addEventListener('DOMContentLoaded', function() {
            // Update profile information with actual user data
            document.getElementById('profileAvatar').src = "https://ui-avatars.com/api/?name=IT24102083&background=0055ff&color=fff&size=200";
            document.querySelector('.profile-avatar-container h4').textContent = "IT24102083";
            
            // Set the current date time from server
            document.getElementById('currentDateTime').textContent = "2025-03-23 14:05:15";
            
            // Setup Bootstrap components
            const toastElList = [].slice.call(document.querySelectorAll('.toast'));
            toastElList.map(function(toastEl) {
                return new bootstrap.Toast(toastEl, {
                    autohide: true,
                    delay: 3000
                });
            });
            
            // Setup any event handlers that weren't already added
            
            // Form submission prevention
            const forms = document.querySelectorAll('form');
            forms.forEach(form => {
                form.addEventListener('submit', function(e) {
                    e.preventDefault();
                    // The specific save function will be called by the button's onclick
                });
            });
        });
        
        // Function to make AJAX calls to the servlet
        function sendToServlet(formData) {
            showLoading(true);
            
            fetch('UserSettingsServlet', {
                method: 'POST',
                body: formData
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                showLoading(false);
                if (data.success) {
                    showNotification('Success', data.message || 'Settings saved successfully.');
                } else {
                    showNotification('Error', data.message || 'An error occurred while saving settings.', 'danger');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showLoading(false);
                showNotification('Error', 'Failed to save settings. Please try again.', 'danger');
            });
        }
        
        // Upload avatar to server
        function uploadAvatar(fileInput) {
            if (fileInput.files && fileInput.files[0]) {
                const formData = new FormData();
                formData.append('action', 'uploadAvatar');
                formData.append('username', 'IT24102083');
                formData.append('avatar', fileInput.files[0]);
                
                sendToServlet(formData);
            }
        }
    </script>
</body>
</html>