package com.RealState.servlets;

import javax.servlet.*;
import javax.servlet.http.*;

import java.io.IOException;


public class AdminDashboardDataServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.getWriter().write("{\"status\":\"success\",\"message\":\"Admin dashboard data retrieved\"}");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Add implementation as needed
    }
}