package com.RealState.servlets;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import java.io.*;
import java.lang.reflect.Type;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@WebServlet("/AppointmentServlet")
public class AppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DATA_FILE = "C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\data\\appointments.json";
    private final Gson gson = new GsonBuilder().setPrettyPrinting().create();
    
    // Data classes
    public static class AppointmentData {
        String lastUpdated;
        String updatedBy;
        List<Appointment> appointments;
        
        public AppointmentData() {
            this.appointments = new ArrayList<>();
        }
    }
    
    public static class Appointment {
        int id;
        String date;
        String time;
        int duration;
        String propertyName;
        String customerName;
        String status;
        String createdAt;
        String lastModified;
    }
    
    private AppointmentData getAppointmentsData() throws IOException {
        String filePath = DATA_FILE;
        File file = new File(filePath);
        
        if (!file.exists()) {
            return initializeDefaultData();
        }
        
        try (Reader reader = new FileReader(file)) {
            Type type = new TypeToken<AppointmentData>(){}.getType();
            return gson.fromJson(reader, type);
        }
    }
    
    private void saveAppointmentsData(AppointmentData data) throws IOException {
        String filePath = DATA_FILE;
        System.out.println(filePath);
        try (Writer writer = new FileWriter(filePath)) {
            gson.toJson(data, writer);
        }
    }
    
    private AppointmentData initializeDefaultData() {
        AppointmentData data = new AppointmentData();
        data.lastUpdated = getCurrentTimestamp();
        data.updatedBy = "Krishmal2004";
        data.appointments = new ArrayList<>();
        return data;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        Map<String, Object> jsonResponse = new HashMap<>();
        
        try {
            AppointmentData appointmentsData = getAppointmentsData();
            
            switch (action) {
                case "edit":
                    handleEdit(request, appointmentsData);
                    break;
                case "delete":
                    handleDelete(request, appointmentsData);
                    break;
                default:
                    throw new ServletException("Invalid action");
            }
            
            // Update metadata
            appointmentsData.lastUpdated = getCurrentTimestamp();
            appointmentsData.updatedBy = "Krishmal2004";
            
            // Save changes
            saveAppointmentsData(appointmentsData);
            
            jsonResponse.put("success", true);
            jsonResponse.put("message", action.equals("edit") ? 
                           "Appointment updated successfully" : "Appointment deleted successfully");
            jsonResponse.put("timestamp", getCurrentTimestamp());
            
        } catch (Exception e) {
            jsonResponse.put("success", false);
            jsonResponse.put("error", e.getMessage());
        }
        
        sendJsonResponse(response, jsonResponse);
    }
    
    private void handleEdit(HttpServletRequest request, AppointmentData data) {
        int id = Integer.parseInt(request.getParameter("id"));
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        int duration = Integer.parseInt(request.getParameter("duration"));
        String propertyName = request.getParameter("propertyName");
        String customerName = request.getParameter("customerName");
        
        // Find and update the appointment
        for (Appointment appointment : data.appointments) {
            if (appointment.id == id) {
                appointment.date = date;
                appointment.time = time;
                appointment.duration = duration;
                appointment.propertyName = propertyName;
                appointment.customerName = customerName;
                appointment.lastModified = getCurrentTimestamp();
                break;
            }
        }
    }
    
    private void handleDelete(HttpServletRequest request, AppointmentData data) {
        int id = Integer.parseInt(request.getParameter("id"));
        data.appointments.removeIf(appointment -> appointment.id == id);
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        AppointmentData appointmentsData = getAppointmentsData();
        sendJsonResponse(response, appointmentsData);
    }
    
    private String getCurrentTimestamp() {
        return LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }
    
    private void sendJsonResponse(HttpServletResponse response, Object data) 
            throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String jsonResponse = gson.toJson(data);
        response.getWriter().write(jsonResponse);
    }
}