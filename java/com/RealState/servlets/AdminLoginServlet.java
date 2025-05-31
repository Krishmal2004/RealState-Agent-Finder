package com.RealState.servlets;

import com.RealState.services.AdminAuthService;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletContext;
import java.io.IOException;

public class AdminLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final AdminAuthService authService = new AdminAuthService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("isAdmin") != null && 
            (Boolean)session.getAttribute("isAdmin")) {
            // User is already logged in, redirect to admin dashboard
            response.sendRedirect("adminDashboard");
        } else {
            // User is not logged in, show the login page
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        ServletContext servletContext = getServletContext();
        
        if (authService.authenticateAdmin(username, password, servletContext)) {
            // Success - create session and redirect to admin dashboard
            HttpSession session = request.getSession();
            session.setAttribute("adminUsername", username);
            session.setAttribute("isAdmin", true);
            
            // Redirect to the AdminDashboardServlet instead of directly to JSP
            response.sendRedirect("adminDashboard");
        } else {
            // Failed login
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}