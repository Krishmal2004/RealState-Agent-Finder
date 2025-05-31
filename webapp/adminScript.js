/**
 * Enterprise Admin Management Portal - Main JavaScript
 * Version: 3.2.1
 * Last Updated: 2025-03-28
 */

// Immediately-invoked Function Expression to avoid global scope pollution
(function() {
    'use strict';

    // Configuration settings
    const config = {
        debug: false,
        dataRefreshInterval: 300000, // 5 minutes
        toastDuration: 5000,
        defaultAnimationDuration: 300,
        apiEndpoint: 'https://api.example.com/v1/',
        dateFormat: 'YYYY-MM-DD',
        timeFormat: 'HH:mm:ss',
        defaultPageSize: 10,
        maxSearchResults: 50,
        currentUser: {
            username: 'IT24103866',
            role: 'Administrator',
            permissions: ['users.manage', 'agents.manage', 'settings.view', 'settings.edit']
        },
        currentDateTime: '2025-03-28 17:01:39'
    };

    // DOM Elements Cache
    const DOM = {};

    // Application state
    let state = {
        currentUser: null,
        lastUpdated: null,
        darkMode: true,
        sidebarCollapsed: false,
        currentPage: 'dashboard',
        notifications: [],
        userFilters: {},
        agentFilters: {},
        searchQuery: '',
        editingItem: null
    };

    /**
     * Initialize the application when DOM is fully loaded
     */
    document.addEventListener('DOMContentLoaded', function() {
        console.log('Initializing Admin Portal...');
        
        // Cache DOM elements
        cacheDOM();
        
        // Set current user and datetime
        updateUserInfo();
        updateDateTime();
        
        // Initialize components
        initializeComponents();
        
        // Set up event listeners
        setupEventListeners();
        
        // Load initial data
        loadInitialData();
        
        console.log('Admin Portal initialization complete');
    });

    /**
     * Cache commonly accessed DOM elements
     */
    function cacheDOM() {
        DOM.sidebar = document.getElementById('sidebar');
        DOM.sidebarToggle = document.getElementById('sidebarToggle');
        DOM.mobileSidebarToggle = document.getElementById('mobileSidebarToggle');
        DOM.mobileOverlay = document.getElementById('mobileOverlay');
        DOM.mainContent = document.getElementById('mainContent');
        DOM.contentSections = document.querySelectorAll('.content-section');
        DOM.navLinks = document.querySelectorAll('.nav-link[data-page]');
        DOM.currentPageTitle = document.getElementById('currentPageTitle');
        DOM.currentDateTime = document.getElementById('currentDateTime');
        DOM.currentUsername = document.querySelectorAll('#currentUsername');
        DOM.currentUserRole = document.querySelectorAll('#currentUserRole');
        DOM.userTable = document.getElementById('usersTable');
        DOM.agentTable = document.getElementById('agentsTable');
        DOM.themeToggle = document.getElementById('themeToggle');
        DOM.dashboardRefreshBtn = document.getElementById('dashboardRefreshBtn');
        DOM.searchInput = document.getElementById('globalSearchInput');
        DOM.loadingIndicator = document.getElementById('loadingIndicator');
        DOM.toastContainer = document.getElementById('toastContainer');
        DOM.addUserForm = document.getElementById('addUserForm');
        DOM.editUserForm = document.getElementById('editUserForm');
        DOM.addAgentForm = document.getElementById('addAgentForm');
    }

    /**
     * Initialize UI components and plugins
     */
    function initializeComponents() {
        // Initialize tooltips
        const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
        if (tooltipTriggerList.length > 0) {
            Array.from(tooltipTriggerList).map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));
        }
        
        // Initialize DataTables
        if (DOM.userTable) {
            try {
                const userTable = new DataTable('#usersTable', {
                    responsive: true,
                    language: {
                        search: "_INPUT_",
                        searchPlaceholder: "Search users..."
                    },
                    pageLength: config.defaultPageSize,
                    dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
                         "<'row'<'col-sm-12'tr>>" +
                         "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>"
                });
            } catch (error) {
                console.error('Error initializing User DataTable:', error);
            }
        }
        
        if (DOM.agentTable) {
            try {
                const agentTable = new DataTable('#agentsTable', {
                    responsive: true,
                    language: {
                        search: "_INPUT_",
                        searchPlaceholder: "Search agents..."
                    },
                    pageLength: config.defaultPageSize
                });
            } catch (error) {
                console.error('Error initializing Agent DataTable:', error);
            }
        }
        
        // Initialize Select2 for advanced dropdowns
        try {
            const select2Elements = document.querySelectorAll('.select2');
            if (select2Elements.length > 0 && typeof $.fn.select2 === 'function') {
                $('.select2').select2({
                    theme: 'bootstrap-5',
                    width: '100%'
                });
            }
        } catch (error) {
            console.error('Error initializing Select2:', error);
        }
        
        // Initialize flatpickr for date pickers
        try {
            const datePickers = document.querySelectorAll('.datepicker');
            if (datePickers.length > 0 && typeof flatpickr === 'function') {
                flatpickr('.datepicker', {
                    enableTime: false,
                    dateFormat: 'Y-m-d',
                    theme: 'dark'
                });
            }
        } catch (error) {
            console.error('Error initializing Flatpickr:', error);
        }
        
        // Initialize Perfect Scrollbar
        try {
            const scrollableElements = document.querySelectorAll('.scrollable');
            if (scrollableElements.length > 0 && typeof PerfectScrollbar === 'function') {
                scrollableElements.forEach(element => {
                    new PerfectScrollbar(element, {
                        suppressScrollX: true,
                        wheelPropagation: false
                    });
                });
            }
        } catch (error) {
            console.error('Error initializing Perfect Scrollbar:', error);
        }
        
        // Initialize AOS animations
        try {
            if (typeof AOS === 'object' && AOS.init) {
                AOS.init({
                    duration: 800,
                    easing: 'ease-in-out',
                    once: true
                });
            }
        } catch (error) {
            console.error('Error initializing AOS:', error);
        }

        // Initialize charts
        initializeCharts();
    }

    /**
     * Set up all event listeners
     */
    function setupEventListeners() {
        // Sidebar toggle
        if (DOM.sidebarToggle) {
            DOM.sidebarToggle.addEventListener('click', toggleSidebar);
        }
        
        // Mobile sidebar toggle
        if (DOM.mobileSidebarToggle) {
            DOM.mobileSidebarToggle.addEventListener('click', toggleMobileSidebar);
        }
        
        // Close sidebar when clicking overlay
        if (DOM.mobileOverlay) {
            DOM.mobileOverlay.addEventListener('click', closeMobileSidebar);
        }
        
        // Navigation between pages
        if (DOM.navLinks) {
            DOM.navLinks.forEach(link => {
                link.addEventListener('click', function(e) {
                    e.preventDefault();
                    const targetPage = this.getAttribute('data-page');
                    navigateToPage(targetPage);
                });
            });
        }
        
        // Theme toggle
        if (DOM.themeToggle) {
            DOM.themeToggle.addEventListener('click', toggleTheme);
        }
        
        // Dashboard refresh button
        if (DOM.dashboardRefreshBtn) {
            DOM.dashboardRefreshBtn.addEventListener('click', function() {
                refreshDashboardData();
            });
        }
        
        // Global search
        if (DOM.searchInput) {
            DOM.searchInput.addEventListener('keyup', function(e) {
                if (e.key === 'Enter') {
                    searchGlobally(this.value);
                }
            });
        }
        
        // User form submission
        if (DOM.addUserForm) {
            DOM.addUserForm.addEventListener('submit', function(e) {
                e.preventDefault();
                saveUserForm();
            });
        }
        
        // Multi-step form navigation
        setupMultiStepForms();
        
        // Password toggle visibility
        setupPasswordToggles();
        
        // Delete user confirmation
        setupDeleteButtons();
        
        // Window resize handler
        window.addEventListener('resize', handleResponsiveLayout);
    }

    /**
     * Initialize charts throughout the application
     */
    function initializeCharts() {
        // Only initialize if Chart.js is available
        if (typeof Chart === 'undefined') {
            console.error('Chart.js is not loaded');
            return;
        }
        
        try {
            // User Activity Chart
            const userActivityCanvas = document.getElementById('userActivityChart');
            if (userActivityCanvas) {
                const ctx = userActivityCanvas.getContext('2d');
                const userActivityChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                        datasets: [{
                            label: 'Active Users',
                            data: [650, 690, 905, 1250, 1400, 1350, 1640, 2100, 2480, 2780, 3000, 3300],
                            borderColor: '#3B82F6',
                            backgroundColor: 'rgba(59, 130, 246, 0.1)',
                            tension: 0.4,
                            fill: true
                        }, {
                            label: 'New Registrations',
                            data: [120, 150, 180, 220, 250, 240, 280, 390, 420, 450, 520, 540],
                            borderColor: '#10B981',
                            backgroundColor: 'rgba(16, 185, 129, 0.1)',
                            tension: 0.4,
                            fill: true
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                position: 'top',
                                labels: {
                                    color: '#CBD5E1',
                                    padding: 20,
                                    font: {
                                        size: 12
                                    }
                                }
                            }
                        },
                        scales: {
                            x: {
                                grid: {
                                    color: 'rgba(148, 163, 184, 0.1)'
                                },
                                ticks: {
                                    color: '#94A3B8'
                                }
                            },
                            y: {
                                beginAtZero: true,
                                grid: {
                                    color: 'rgba(148, 163, 184, 0.1)'
                                },
                                ticks: {
                                    color: '#94A3B8'
                                }
                            }
                        }
                    }
                });
            }
            
            // User Distribution Chart
            const userDistributionCanvas = document.getElementById('userDistributionChart');
            if (userDistributionCanvas) {
                const ctx = userDistributionCanvas.getContext('2d');
                const userDistributionChart = new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                        labels: ['Administrators', 'Managers', 'Regular Users', 'Guests'],
                        datasets: [{
                            data: [8, 20, 65, 15],
                            backgroundColor: [
                                '#3B82F6',
                                '#10B981',
                                '#7C3AED',
                                '#F59E0B'
                            ],
                            borderWidth: 0,
                            hoverOffset: 10
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        cutout: '75%',
                        plugins: {
                            legend: {
                                position: 'bottom',
                                labels: {
                                    color: '#CBD5E1',
                                    padding: 20,
                                    usePointStyle: true,
                                    pointStyle: 'circle',
                                    font: {
                                        size: 12
                                    }
                                }
                            }
                        }
                    }
                });
            }
            
            // Agent Performance Chart
            const agentPerformanceCanvas = document.getElementById('agentPerformanceChart');
            if (agentPerformanceCanvas) {
                const ctx = agentPerformanceCanvas.getContext('2d');
                const agentPerformanceChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: ['John S.', 'Maria R.', 'David M.', 'Sarah J.', 'Robert T.'],
                        datasets: [{
                            label: 'Performance Score',
                            data: [95, 88, 92, 85, 90],
                            backgroundColor: [
                                '#3B82F6',
                                '#10B981',
                                '#7C3AED',
                                '#F59E0B',
                                '#DC2626'
                            ],
                            borderWidth: 0,
                            borderRadius: 8
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
                            x: {
                                grid: {
                                    display: false
                                },
                                ticks: {
                                    color: '#94A3B8'
                                }
                            },
                            y: {
                                beginAtZero: true,
                                max: 100,
                                grid: {
                                    color: 'rgba(148, 163, 184, 0.1)'
                                },
                                ticks: {
                                    color: '#94A3B8',
                                    callback: function(value) {
                                        return value + '%';
                                    }
                                }
                            }
                        }
                    }
                });
            }
            
            // System Health Chart
            const systemHealthCanvas = document.getElementById('systemHealthChart');
            if (systemHealthCanvas) {
                const ctx = systemHealthCanvas.getContext('2d');
                const systemHealthChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: ['00:00', '04:00', '08:00', '12:00', '16:00', '20:00', '24:00'],
                        datasets: [{
                            label: 'CPU Usage',
                            data: [25, 20, 30, 70, 55, 40, 25],
                            borderColor: '#3B82F6',
                            backgroundColor: 'rgba(59, 130, 246, 0.1)',
                            tension: 0.4,
                            fill: true
                        }, {
                            label: 'Memory Usage',
                            data: [45, 40, 50, 65, 70, 60, 50],
                            borderColor: '#7C3AED',
                            backgroundColor: 'rgba(124, 58, 237, 0.1)',
                            tension: 0.4,
                            fill: true
                        }, {
                            label: 'Disk I/O',
                            data: [10, 15, 35, 45, 40, 30, 15],
                            borderColor: '#10B981',
                            backgroundColor: 'rgba(16, 185, 129, 0.1)',
                            tension: 0.4,
                            fill: true
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                position: 'top',
                                labels: {
                                    color: '#CBD5E1'
                                }
                            }
                        },
                        scales: {
                            x: {
                                grid: {
                                    color: 'rgba(148, 163, 184, 0.1)'
                                },
                                ticks: {
                                    color: '#94A3B8'
                                }
                            },
                            y: {
                                beginAtZero: true,
                                max: 100,
                                grid: {
                                    color: 'rgba(148, 163, 184, 0.1)'
                                },
                                ticks: {
                                    color: '#94A3B8',
                                    callback: function(value) {
                                        return value + '%';
                                    }
                                }
                            }
                        }
                    }
                });
            }
        } catch (error) {
            console.error('Error initializing charts:', error);
        }
    }

    /**
     * Update the current user information display
     */
    function updateUserInfo() {
        const { username, role } = config.currentUser;
        
        if (DOM.currentUsername) {
            DOM.currentUsername.forEach(element => {
                if (element) element.textContent = username;
            });
        }
        
        if (DOM.currentUserRole) {
            DOM.currentUserRole.forEach(element => {
                if (element) element.textContent = role;
            });
        }
        
        // Update state
        state.currentUser = config.currentUser;
    }

    /**
     * Update the displayed date and time
     */
    function updateDateTime() {
        if (DOM.currentDateTime) {
            DOM.currentDateTime.textContent = config.currentDateTime;
        }
    }

    /**
     * Toggle sidebar expanded/collapsed state
     */
    function toggleSidebar() {
        if (DOM.sidebar) {
            DOM.sidebar.classList.toggle('collapsed');
            
            // Update icon
            const icon = DOM.sidebarToggle.querySelector('i');
            if (icon) {
                if (DOM.sidebar.classList.contains('collapsed')) {
                    icon.classList.remove('fa-chevron-left');
                    icon.classList.add('fa-chevron-right');
                    state.sidebarCollapsed = true;
                } else {
                    icon.classList.remove('fa-chevron-right');
                    icon.classList.add('fa-chevron-left');
                    state.sidebarCollapsed = false;
                }
            }
            
            // Save user preference
            try {
                localStorage.setItem('sidebarCollapsed', state.sidebarCollapsed);
            } catch (error) {
                console.error('Error saving sidebar state:', error);
            }
        }
    }

    /**
     * Toggle mobile sidebar for small screens
     */
    function toggleMobileSidebar() {
        if (DOM.sidebar && DOM.mobileOverlay) {
            DOM.sidebar.classList.toggle('mobile-active');
            DOM.mobileOverlay.classList.toggle('show');
        }
    }

    /**
     * Close mobile sidebar
     */
    function closeMobileSidebar() {
        if (DOM.sidebar && DOM.mobileOverlay) {
            DOM.sidebar.classList.remove('mobile-active');
            DOM.mobileOverlay.classList.remove('show');
        }
    }

    /**
     * Toggle between light and dark theme
     */
    function toggleTheme() {
        if (DOM.themeToggle) {
            DOM.themeToggle.classList.toggle('active');
            document.body.classList.toggle('light-mode');
            state.darkMode = !state.darkMode;
            
            try {
                localStorage.setItem('darkMode', state.darkMode);
            } catch (error) {
                console.error('Error saving theme preference:', error);
            }
        }
    }

    /**
     * Navigate between different pages/sections
     * @param {string} page - Target page identifier
     */
    function navigateToPage(page) {
        if (!page) return;
        
        // Update active state in nav
        if (DOM.navLinks) {
            DOM.navLinks.forEach(link => {
                link.classList.remove('active');
                if (link.getAttribute('data-page') === page) {
                    link.classList.add('active');
                }
            });
        }
        
        // Show target content, hide others
        if (DOM.contentSections) {
            DOM.contentSections.forEach(section => {
                section.classList.add('d-none');
            });
            
            const targetSection = document.getElementById(page + 'Content');
            if (targetSection) {
                targetSection.classList.remove('d-none');
            }
        }
        
        // Update page title
        if (DOM.currentPageTitle) {
            DOM.currentPageTitle.textContent = capitalizeFirstLetter(page);
        }
        
        // Update state
        state.currentPage = page;
        
        // Close mobile sidebar if open
        if (window.innerWidth < 992) {
            closeMobileSidebar();
        }
        
        // Update URL without page reload
        try {
            window.history.pushState({page: page}, '', '?page=' + page);
        } catch (error) {
            console.error('Error updating URL:', error);
        }
        
        // Load page-specific data
        loadPageData(page);
    }

    /**
     * Load data specific to the current page
     * @param {string} page - The page identifier
     */
    function loadPageData(page) {
        switch (page) {
            case 'dashboard':
                loadDashboardData();
                break;
            case 'users':
                // Implement user data loading here
                break;
            case 'agents':
                // Implement agent data loading here
                break;
            default:
                // Handle other pages
                break;
        }
    }

    /**
     * Load initial data when the application starts
     */
    function loadInitialData() {
        // Show loading indicator while fetching data
        showLoading();
        
        // Fetch notifications
        fetchNotifications();
        
        // Load current page data
        loadPageData(state.currentPage || 'dashboard');
        
        // Hide loading indicator
        hideLoading();
    }

    /**
     * Load dashboard data
     */
    function loadDashboardData() {
        // This would typically fetch data from an API
        // For now, we'll use static data
        
        // Update last refresh time
        state.lastUpdated = new Date();
    }

    /**
     * Refresh dashboard data
     */
    function refreshDashboardData() {
        // Show loading animation on refresh button
        if (DOM.dashboardRefreshBtn) {
            const btn = DOM.dashboardRefreshBtn;
            const originalHtml = btn.innerHTML;
            
            btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
            btn.disabled = true;
            
            // Simulate API request
            setTimeout(() => {
                // Update last refresh time
                state.lastUpdated = new Date();
                
                // Restore button
                btn.innerHTML = originalHtml;
                btn.disabled = false;
                
                // Show success notification
                showNotification('success', 'Data Refreshed', 'Dashboard data has been updated successfully.');
            }, 1000);
        }
    }

    /**
     * Set up multi-step forms
     */
    function setupMultiStepForms() {
        const multiStepForms = document.querySelectorAll('.multi-step-form');
        
        multiStepForms.forEach(form => {
            const steps = form.querySelectorAll('.step-content');
            const stepIndicators = form.querySelectorAll('.step');
            
            // Next buttons
            form.querySelectorAll('[id$="Next"]').forEach(btn => {
                btn.addEventListener('click', function() {
                    const currentStep = this.closest('.step-content');
                    const currentStepIndex = Array.from(steps).indexOf(currentStep);
                    
                    if (validateStep(currentStep)) {
                        // Hide current step
                        currentStep.classList.remove('active');
                        
                        // Show next step
                        steps[currentStepIndex + 1].classList.add('active');
                        
                        // Update indicators
                        stepIndicators[currentStepIndex].classList.add('completed');
                        stepIndicators[currentStepIndex + 1].classList.add('active');
                    }
                });
            });
            
            // Previous buttons
            form.querySelectorAll('[id$="Prev"]').forEach(btn => {
                btn.addEventListener('click', function() {
                    const currentStep = this.closest('.step-content');
                    const currentStepIndex = Array.from(steps).indexOf(currentStep);
                    
                    // Hide current step
                    currentStep.classList.remove('active');
                    
                    // Show previous step
                    steps[currentStepIndex - 1].classList.add('active');
                    
                    // Update indicators
                    stepIndicators[currentStepIndex].classList.remove('active');
                    stepIndicators[currentStepIndex - 1].classList.remove('completed');
                    stepIndicators[currentStepIndex - 1].classList.add('active');
                });
            });
        });
    }

    /**
     * Set up password toggle visibility buttons
     */
    function setupPasswordToggles() {
        document.querySelectorAll('.toggle-password').forEach(toggleBtn => {
            toggleBtn.addEventListener('click', function() {
                const input = this.closest('.input-group').querySelector('input');
                const icon = this.querySelector('i');
                
                if (input.type === 'password') {
                    input.type = 'text';
                    icon.classList.remove('fa-eye');
                    icon.classList.add('fa-eye-slash');
                } else {
                    input.type = 'password';
                    icon.classList.remove('fa-eye-slash');
                    icon.classList.add('fa-eye');
                }
            });
        });
    }

    /**
     * Set up delete confirmation buttons
     */
    function setupDeleteButtons() {
        // Delete user buttons
        document.querySelectorAll('.delete-user-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                const userId = this.getAttribute('data-id');
                
                // Set up confirmation modal
                document.getElementById('deleteConfirmText').innerHTML = 
                    `Are you sure you want to delete user <strong>${userId}</strong>? This action cannot be undone.`;
                
                const confirmBtn = document.getElementById('confirmDeleteBtn');
                confirmBtn.setAttribute('data-type', 'User');
                confirmBtn.setAttribute('data-id', userId);
                
                // Show modal
                const modal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
                modal.show();
            });
        });
        
        // Confirm delete button
        const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
        if (confirmDeleteBtn) {
            confirmDeleteBtn.addEventListener('click', function() {
                const itemType = this.getAttribute('data-type');
                const itemId = this.getAttribute('data-id');
                
                // Show loading state
                const originalBtn = this.innerHTML;
                this.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Deleting...';
                this.disabled = true;
                
                // Simulate API call
                setTimeout(() => {
                    // Hide modal
                    bootstrap.Modal.getInstance(document.getElementById('deleteConfirmModal')).hide();
                    
                    // Reset button
                    this.innerHTML = originalBtn;
                    this.disabled = false;
                    
                    // Show success message
                    showNotification('success', `${itemType} Deleted`, `${itemType} ${itemId} has been deleted successfully.`);
                }, 1500);
            });
        }
    }

    /**
     * Process and submit user form
     */
    function saveUserForm() {
        // Get form button
        const saveBtn = document.getElementById('saveUserBtn');
        if (!saveBtn) return;
        
        // Show loading state
        const originalBtnHtml = saveBtn.innerHTML;
        saveBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Creating...';
        saveBtn.disabled = true;
        
        // Simulate API call
        setTimeout(() => {
            // Hide modal
            try {
                const userModal = bootstrap.Modal.getInstance(document.getElementById('addUserModal'));
                if (userModal) {
                    userModal.hide();
                }
            } catch (error) {
                console.error('Error hiding modal:', error);
            }
            
            // Reset form
            const form = document.getElementById('addUserForm');
            if (form) {
                form.reset();
            }
            
            // Reset button
            saveBtn.innerHTML = originalBtnHtml;
            saveBtn.disabled = false;
            
            // Show success message
            showNotification('success', 'User Created', 'New user has been created successfully.');
            
            // Reset multi-step form
            resetMultiStepForm();
        }, 1500);
    }

    /**
     * Reset a multi-step form to the first step
     */
    function resetMultiStepForm() {
        const stepContents = document.querySelectorAll('.step-content');
        const stepIndicators = document.querySelectorAll('.step');

        stepContents.forEach((step, index) => {
            step.classList.remove('active');
            if (index === 0) {
                step.classList.add('active');
            }
        });

        stepIndicators.forEach((indicator, index) => {
            indicator.classList.remove('active', 'completed');
            if (index === 0) {
                indicator.classList.add('active');
            }
        });
    }

    /**
     * Validate a form step
     * @param {HTMLElement} step - The step element to validate
     * @returns {boolean} - Whether the step is valid
     */
    function validateStep(step) {
        const requiredFields = step.querySelectorAll('[required]');
        let isValid = true;
        
        requiredFields.forEach(field => {
            if (!field.value.trim()) {
                isValid = false;
                field.classList.add('is-invalid');
                
                // Add event listener to remove validation error when field is edited
                field.addEventListener('input', function() {
                    this.classList.remove('is-invalid');
                }, { once: true });
            } else {
                field.classList.remove('is-invalid');
            }
        });
        
        if (!isValid) {
            showNotification('danger', 'Validation Error', 'Please fill in all required fields before proceeding.');
        }
        
        return isValid;
    }

    /**
     * Show a notification
     * @param {string} type - Notification type: success, info, warning, danger
     * @param {string} title - Notification title
     * @param {string} message - Notification message
     */
    function showNotification(type, title, message) {
        try {
            // Check if Notyf is available
            if (typeof Notyf === 'function') {
                const notyf = new Notyf({
                    duration: config.toastDuration,
                    position: { x: 'right', y: 'top' },
                    types: [
                        {
                            type: 'info',
                            background: '#3B82F6',
                            icon: { className: 'fas fa-info-circle', tagName: 'i' }
                        },
                        {
                            type: 'success',
                            background: '#059669',
                            icon: { className: 'fas fa-check-circle', tagName: 'i' }
                        },
                        {
                            type: 'warning',
                            background: '#D97706',
                            icon: { className: 'fas fa-exclamation-circle', tagName: 'i' }
                        },
                        {
                            type: 'danger',
                            background: '#DC2626',
                            icon: { className: 'fas fa-exclamation-triangle', tagName: 'i' }
                        }
                    ]
                });
                
                notyf.open({
                    type: type,
                    message: `<div><b>${title}</b><br>${message}</div>`
                });
            } else {
                // Fallback to alert for debugging
                if (config.debug) {
                    alert(`${type.toUpperCase()}: ${title} - ${message}`);
                }
            }
        } catch (error) {
            console.error('Error showing notification:', error);
        }
    }

    /**
     * Fetch notifications from the server
     */
    function fetchNotifications() {
        // Simulate API call
        setTimeout(() => {
            // Sample notification data
            const notifications = [
                {
                    id: 'n1',
                    type: 'alert',
                    title: 'System Alert',
                    message: 'Unusual login activity detected',
                    time: '10 minutes ago'
                },
                {
                    id: 'n2',
                    type: 'user',
                    title: 'New User Registered',
                    message: 'Sarah Johnson registered as a new user',
                    time: '2 hours ago'
                },
                {
                    id: 'n3',
                    type: 'report',
                    title: 'Weekly Report Available',
                    message: 'Your weekly analytics report is ready',
                    time: '1 day ago'
                }
            ];
            
            // Update state
            state.notifications = notifications;
            
            // Update notification badge
            updateNotificationBadge();
            
            // Update notification dropdown
            updateNotificationDropdown();
        }, 500);
    }

    /**
     * Update notification badge count
     */
    function updateNotificationBadge() {
        const notificationBadge = document.querySelector('.header-action-item.has-notifications .badge');
        if (notificationBadge && state.notifications) {
            notificationBadge.textContent = state.notifications.length;
        }
    }

    /**
     * Update notification dropdown content
     */
    function updateNotificationDropdown() {
        const notificationList = document.getElementById('notificationList');
        if (!notificationList || !state.notifications) return;
        
        // Clear current notifications
        notificationList.innerHTML = '';
        
        // Add notifications to dropdown
        state.notifications.forEach(notification => {
            const notificationItem = document.createElement('a');
            notificationItem.href = '#';
            notificationItem.className = 'dropdown-menu-item';
            
            let iconClass = '';
            let iconContent = '';
            
            // Determine icon based on notification type
            switch (notification.type) {
                case 'alert':
                    iconClass = 'bg-danger';
                    iconContent = '<i class="fas fa-exclamation-triangle"></i>';
                    break;
                case 'user':
                    iconClass = 'bg-success';
                    iconContent = '<i class="fas fa-user-plus"></i>';
                    break;
                case 'report':
                    iconClass = 'bg-primary';
                    iconContent = '<i class="fas fa-chart-line"></i>';
                    break;
                case 'system':
                    iconClass = 'bg-info';
                    iconContent = '<i class="fas fa-cog"></i>';
                    break;
                default:
                    iconClass = 'bg-primary';
                    iconContent = '<i class="fas fa-bell"></i>';
            }
            
            notificationItem.innerHTML = `
                <div class="dropdown-menu-item-icon ${iconClass}">
                    ${iconContent}
                </div>
                <div class="dropdown-menu-item-content">
                    <div class="dropdown-menu-item-title">${notification.title}</div>
                    <div class="dropdown-menu-item-text">${notification.message}</div>
                    <div class="dropdown-menu-item-meta">${notification.time}</div>
                </div>
            `;
            
            notificationList.appendChild(notificationItem);
        });
    }

    /**
     * Search globally across the application
     * @param {string} query - The search query
     */
    function searchGlobally(query) {
        // Implement global search functionality here
    }

    /**
     * Show loading indicator
     */
    function showLoading() {
        if (DOM.loadingIndicator) {
            DOM.loadingIndicator.classList.remove('d-none');
        }
    }

    /**
     * Hide loading indicator
     */
    function hideLoading() {
        if (DOM.loadingIndicator) {
            DOM.loadingIndicator.classList.add('d-none');
        }
    }

    /**
     * Handle responsive layout changes
     */
    function handleResponsiveLayout() {
        // Implement responsive layout adjustments here
    }

    /**
     * Capitalize the first letter of a string
     * @param {string} str - The string to capitalize
     * @returns {string} - The capitalized string
     */
    function capitalizeFirstLetter(str) {
        return str.charAt(0).toUpperCase() + str.slice(1);
    }
})();