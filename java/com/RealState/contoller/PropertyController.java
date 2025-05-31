package com.RealState.contoller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.RealState.services.PropertyService;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

@WebServlet("/properties")
public class PropertyController extends HttpServlet {
    
    private PropertyService propertyService;
    private Gson gson;
    
    @Override
    public void init() {
        String jsonFilePath = ("C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\data\\properties.json");
        System.out.println(jsonFilePath);
        propertyService = new PropertyService(jsonFilePath);
        gson = new Gson();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) {
            // Set the current user information in the request
            request.setAttribute("currentUser", "IT24103866");
            request.setAttribute("currentDateTime", "2025-04-07 21:02:53");
            
            // Forward to the JSP to display all properties
            request.setAttribute("properties", propertyService.getProperties());
            request.getRequestDispatcher("/propertyListing.jsp").forward(request, response);
            return;
        }
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        switch (action) {
            case "getAll":
                out.print(gson.toJson(propertyService.getProperties()));
                break;
                
            case "getById":
                int id = Integer.parseInt(request.getParameter("id"));
                JsonObject property = propertyService.getPropertyById(id);
                out.print(property != null ? gson.toJson(property) : "{}");
                break;
                
            case "getByStatus":
                String status = request.getParameter("status");
                JsonArray propertiesByStatus = propertyService.getPropertiesByStatus(status);
                out.print(gson.toJson(propertiesByStatus));
                break;
                
            case "getByPriceRange":
                double min = Double.parseDouble(request.getParameter("min"));
                double max = Double.parseDouble(request.getParameter("max"));
                JsonArray propertiesByPrice = propertyService.getPropertiesByPriceRange(min, max);
                out.print(gson.toJson(propertiesByPrice));
                break;
                
            case "getByBedrooms":
                int minBeds = Integer.parseInt(request.getParameter("minBeds"));
                JsonArray propertiesByBeds = propertyService.getPropertiesByBedrooms(minBeds);
                out.print(gson.toJson(propertiesByBeds));
                break;
                
            case "search":
                String query = request.getParameter("query");
                JsonArray searchResults = propertyService.searchProperties(query);
                out.print(gson.toJson(searchResults));
                break;
                
            default:
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"error\": \"Invalid action\"}");
        }
    }
}