package com.RealState.servlets;
 
import com.RealState.services.AgentAuthService;
import com.RealState.model.User;
 
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
 
public class AgentLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final AgentAuthService authService = new AgentAuthService();
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Simply forward to the login page
        request.getRequestDispatcher("AgentLogin.jsp").forward(request, response);
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User aUser = authService.getAuthenticatedUser(username, password, getServletContext());

        // Pass the ServletContext as the third parameter
        if (aUser != null) {
            // Success - create session and redirect to admin dashboard
            HttpSession session = request.getSession();
            session.setAttribute("user", aUser);
            session.setAttribute("Username", aUser.getUsername());
            session.setAttribute("isUser", true);
 
            response.sendRedirect("agentDashBoard.jsp");
        } else {
            // Failed login
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("UserLogin.jsp").forward(request, response);
        }
    }
}