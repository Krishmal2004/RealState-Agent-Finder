package com.RealState.servlets;

import com.google.gson.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.*;
import java.util.*;
import java.time.*;
import java.time.format.DateTimeFormatter;

@WebServlet("/UserAppointmentServlet/*")
public class UserAppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Gson gson = new GsonBuilder().setPrettyPrinting().create();
    private static final String DATA_FILE = "C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\data\\userAppointments.json";
    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    private static final Object FILE_LOCK = new Object();

    // Current user data
    private static final String CURRENT_USER = "Krishmal2004";

    // Appointment model class
    private static class Appointment {
        String appointmentId;
        String buyerName;
        String buyerEmail;
        String buyerPhone;
        String appointmentDate;
        String appointmentTime;
        String agentId;
        String agentName;
        String status;
        String notes;
        String createdDate;
        String updatedDate;
        String createdBy;

        public Appointment() {
            this.appointmentId = "APT" + System.currentTimeMillis();
            this.createdDate = getCurrentDateTime();
            this.updatedDate = getCurrentDateTime();
            this.status = "Pending";
            this.createdBy = CURRENT_USER;
        }
    }

    // Data container class
    private static class AppointmentData {
        List<Appointment> appointments;
        Map<String, AgentInfo> agents;
        String lastUpdated;

        public AppointmentData() {
            appointments = new ArrayList<>();
            agents = new HashMap<>();
            lastUpdated = getCurrentDateTime();
        }
    }

    // Agent information class
    private static class AgentInfo {
        String agentId;
        String name;
        String specialty;
        boolean available;
        int appointmentCount;
    }

    private static String getCurrentDateTime() {
        return LocalDateTime.now(ZoneOffset.UTC).format(formatter);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String contentType = request.getContentType();
        Appointment newAppointment;
        
        try {
            if (contentType != null && contentType.contains("application/json")) {
                newAppointment = handleJsonRequest(request);
            } else {
                newAppointment = handleFormRequest(request);
            }
            
            validateAppointment(newAppointment);
            
            synchronized (FILE_LOCK) {
                AppointmentData data = loadAppointmentData(request.getServletContext());
                data.appointments.add(newAppointment);
                data.lastUpdated = getCurrentDateTime();
                updateAgentAppointmentCount(data, newAppointment.agentId);
                saveAppointmentData(request.getServletContext(), data);
                
                System.out.println("Appointment saved successfully: " + newAppointment.appointmentId);
            }
            
            if (contentType == null || !contentType.contains("application/json")) {
                response.sendRedirect(request.getContextPath() + "/appointmnets.jsp?success=true");
                return;
            }
            
            sendSuccessResponse(response, newAppointment);
            
        } catch (Exception e) {
            handleError(request, response, contentType, e);
        }
    }

    private void sendSuccessResponse(HttpServletResponse response, Appointment appointment) 
            throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        JsonObject jsonResponse = new JsonObject();
        jsonResponse.addProperty("status", "success");
        jsonResponse.addProperty("message", "Appointment scheduled successfully");
        jsonResponse.addProperty("appointmentId", appointment.appointmentId);
        jsonResponse.addProperty("timestamp", getCurrentDateTime());
        
        PrintWriter out = response.getWriter();
        out.println(gson.toJson(jsonResponse));
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response, 
                           String contentType, Exception e) throws IOException {
        if (contentType != null && contentType.contains("application/json")) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            sendErrorResponse(response.getWriter(), e.getMessage());
        } else {
            response.sendRedirect(request.getContextPath() + 
                "/appointments.jsp?error=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }

    private Appointment handleJsonRequest(HttpServletRequest request) throws IOException {
        String jsonData = readRequestData(request);
        return gson.fromJson(jsonData, Appointment.class);
    }
    
    private Appointment handleFormRequest(HttpServletRequest request) {
        Appointment appointment = new Appointment();
        appointment.buyerName = request.getParameter("buyerName");
        appointment.buyerEmail = request.getParameter("buyerEmail");
        appointment.buyerPhone = request.getParameter("buyerPhone");
        appointment.appointmentDate = request.getParameter("appointmentDate");
        appointment.appointmentTime = request.getParameter("appointmentTime");
        appointment.agentId = request.getParameter("agent");
        appointment.status = request.getParameter("status");
        appointment.notes = request.getParameter("notes");
        
        // Map agent names
        Map<String, String> agentNames = new HashMap<>();
        agentNames.put("AGT001", "John Doe");
        agentNames.put("AGT002", "Jane Smith");
        agentNames.put("AGT003", "Michael Brown");
        agentNames.put("AGT004", "Emily Wilson");
        agentNames.put("AGT005", "Robert Johnson");
        
        appointment.agentName = agentNames.getOrDefault(appointment.agentId, "Unknown Agent");
        
        return appointment;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String action = request.getPathInfo();
            AppointmentData data = loadAppointmentData(request.getServletContext());

            if (action != null && "/agents".equals(action)) {
                out.println(gson.toJson(data.agents));
                System.out.println("Returned " + data.agents.size() + " agents");
            } else {
                String agentId = request.getParameter("agentId");
                List<Appointment> filteredAppointments = filterAppointmentsByAgent(
                    data.appointments, agentId);
                out.println(gson.toJson(filteredAppointments));
                System.out.println("Returned " + filteredAppointments.size() + " appointments");
            }
        } catch (Exception e) {
            System.err.println("Error in doGet: " + e.getMessage());
            e.printStackTrace();
            sendErrorResponse(out, "Error retrieving data: " + e.getMessage());
        }
    }

    private void validateAppointment(Appointment appointment) throws Exception {
        if (appointment.buyerName == null || appointment.buyerName.trim().isEmpty()) {
            throw new Exception("Buyer name is required");
        }
        if (appointment.buyerEmail == null || appointment.buyerEmail.trim().isEmpty()) {
            throw new Exception("Buyer email is required");
        }
        if (appointment.appointmentDate == null || appointment.appointmentDate.trim().isEmpty()) {
            throw new Exception("Appointment date is required");
        }
        if (appointment.agentId == null || appointment.agentId.trim().isEmpty()) {
            throw new Exception("Agent selection is required");
        }
    }

    private String readRequestData(HttpServletRequest request) throws IOException {
        StringBuilder jsonBuilder = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                jsonBuilder.append(line);
            }
        }
        return jsonBuilder.toString();
    }

    private AppointmentData loadAppointmentData(ServletContext context) throws IOException {
        String realPath =(DATA_FILE);
        File file = new File(realPath);
        
        System.out.println("Loading data from: " + realPath);
        
        if (!file.exists()) {
            System.out.println("Data file does not exist, creating new data file");
            File parentDir = file.getParentFile();
            if (!parentDir.exists()) {
                boolean created = parentDir.mkdirs();
                System.out.println("Created directory structure: " + created);
            }
            AppointmentData newData = createInitialData();
            saveAppointmentData(context, newData);
            return newData;
        }
        
        try (Reader reader = new FileReader(file)) {
            AppointmentData data = gson.fromJson(reader, AppointmentData.class);
            return data != null ? data : createInitialData();
        } catch (Exception e) {
            System.err.println("Error reading appointment data: " + e.getMessage());
            e.printStackTrace();
            return createInitialData();
        }
    }

    private AppointmentData createInitialData() {
        AppointmentData data = new AppointmentData();
        
        // Add sample agents
        AgentInfo agent1 = new AgentInfo();
        agent1.agentId = "AGT001";
        agent1.name = "John Doe";
        agent1.specialty = "Residential Properties";
        agent1.available = true;
        agent1.appointmentCount = 0;
        data.agents.put(agent1.agentId, agent1);
        
        AgentInfo agent2 = new AgentInfo();
        agent2.agentId = "AGT002";
        agent2.name = "Jane Smith";
        agent2.specialty = "Commercial Properties";
        agent2.available = true;
        agent2.appointmentCount = 0;
        data.agents.put(agent2.agentId, agent2);
        
        return data;
    }

    private void saveAppointmentData(ServletContext context, AppointmentData data) throws IOException {
        String realPath =(DATA_FILE);
        File file = new File(realPath);
        
        System.out.println("Saving data to: " + realPath);
        
        // Create backup before saving
        if (file.exists()) {
            File backup = new File(realPath + ".backup");
            try (FileInputStream in = new FileInputStream(file);
                 FileOutputStream out = new FileOutputStream(backup)) {
                byte[] buffer = new byte[1024];
                int length;
                while ((length = in.read(buffer)) > 0) {
                    out.write(buffer, 0, length);
                }
            }
        }
        
        // Ensure directory exists
        File parentDir = file.getParentFile();
        if (!parentDir.exists()) {
            boolean created = parentDir.mkdirs();
            if (!created) {
                throw new IOException("Failed to create directory: " + parentDir.getAbsolutePath());
            }
        }
        
        // Save the file
        try (Writer writer = new FileWriter(file)) {
            gson.toJson(data, writer);
            System.out.println("Successfully saved appointment data");
        } catch (IOException e) {
            System.err.println("Error saving appointment data: " + e.getMessage());
            throw e;
        }
    }

    private List<Appointment> filterAppointmentsByAgent(List<Appointment> appointments, String agentId) {
        if (agentId == null) return appointments;
        
        return appointments.stream()
            .filter(apt -> agentId.equals(apt.agentId))
            .collect(java.util.stream.Collectors.toList());
    }

    private void updateAgentAppointmentCount(AppointmentData data, String agentId) {
        AgentInfo agent = data.agents.get(agentId);
        if (agent != null) {
            agent.appointmentCount++;
        }
    }

    private void sendErrorResponse(PrintWriter out, String message) {
        JsonObject error = new JsonObject();
        error.addProperty("status", "error");
        error.addProperty("message", message);
        error.addProperty("timestamp", getCurrentDateTime());
        out.println(gson.toJson(error));
    }
}