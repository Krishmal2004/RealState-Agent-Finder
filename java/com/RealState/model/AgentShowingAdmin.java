package com.RealState.model;

import java.util.List;

public class AgentShowingAdmin {
    private String currentDate;
    private String currentUser;
    private List<Agent> agents;
    
    // Getters and setters
    public String getCurrentDate() {
        return currentDate;
    }
    
    public void setCurrentDate(String currentDate) {
        this.currentDate = currentDate;
    }
    
    public String getCurrentUser() {
        return currentUser;
    }
    
    public void setCurrentUser(String currentUser) {
        this.currentUser = currentUser;
    }
    
    public List<Agent> getAgents() {
        return agents;
    }
    
    public void setAgents(List<Agent> agents) {
        this.agents = agents;
    }
}