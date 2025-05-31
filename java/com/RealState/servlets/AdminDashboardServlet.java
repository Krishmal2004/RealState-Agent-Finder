package com.RealState.servlets;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminDashboardServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in as admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("isAdmin") == null || 
            !(Boolean)session.getAttribute("isAdmin")) {
            // Not logged in or not an admin, redirect to login
            response.sendRedirect("login");
            return;
        }

        // Load dashboard statistics
        Map<String, Integer> stats = getDashboardStats();
        request.setAttribute("totalExams", stats.get("totalExams"));
        request.setAttribute("registeredStudents", stats.get("registeredStudents"));
        request.setAttribute("upcomingExams", stats.get("upcomingExams"));
        request.setAttribute("resultsPublished", stats.get("resultsPublished"));
        
        // Load recent exams
        List<Map<String, String>> recentExams = getRecentExams();
        request.setAttribute("recentExams", recentExams);
        
        // Forward to the dashboard JSP
        request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle any POST requests to the dashboard
        doGet(request, response);
    }
    
    // Mock method to get dashboard statistics
    private Map<String, Integer> getDashboardStats() {
        Map<String, Integer> stats = new HashMap<>();
        stats.put("totalExams", 42);
        stats.put("registeredStudents", 150);
        stats.put("upcomingExams", 5);
        stats.put("resultsPublished", 28);
        return stats;
    }
    
    // Mock method to get recent exams
    private List<Map<String, String>> getRecentExams() {
        List<Map<String, String>> exams = new ArrayList<>();
        
        Map<String, String> exam1 = new HashMap<>();
        exam1.put("id", "EX001");
        exam1.put("title", "Java Programming Fundamentals");
        exam1.put("date", "2025-03-15");
        exam1.put("status", "Upcoming");
        exams.add(exam1);
        
        Map<String, String> exam2 = new HashMap<>();
        exam2.put("id", "EX002");
        exam2.put("title", "Database Management Systems");
        exam2.put("date", "2025-03-10");
        exam2.put("status", "Completed");
        exams.add(exam2);
        
        Map<String, String> exam3 = new HashMap<>();
        exam3.put("id", "EX003");
        exam3.put("title", "Web Development Basics");
        exam3.put("date", "2025-03-20");
        exam3.put("status", "Upcoming");
        exams.add(exam3);
        
        return exams;
    }
}