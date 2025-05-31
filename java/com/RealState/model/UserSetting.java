package com.RealState.model;

import java.util.Map;

public class UserSetting {
    private String username;
    private String password;
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
    private String bio;
    private String language;
    private String timezone;
    private Map<String, Boolean> notifications;
    private ListingPreferences listingPreferences;
    
    public UserSetting() {
    }
    
    // Getters and setters
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getFirstName() {
        return firstName;
    }
    
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    
    public String getLastName() {
        return lastName;
    }
    
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public String getBio() {
        return bio;
    }
    
    public void setBio(String bio) {
        this.bio = bio;
    }
    
    public String getLanguage() {
        return language;
    }
    
    public void setLanguage(String language) {
        this.language = language;
    }
    
    public String getTimezone() {
        return timezone;
    }
    
    public void setTimezone(String timezone) {
        this.timezone = timezone;
    }
    
    public Map<String, Boolean> getNotifications() {
        return notifications;
    }
    
    public void setNotifications(Map<String, Boolean> notifications) {
        this.notifications = notifications;
    }
    
    public ListingPreferences getListingPreferences() {
        return listingPreferences;
    }
    
    public void setListingPreferences(ListingPreferences listingPreferences) {
        this.listingPreferences = listingPreferences;
    }
    
    public static class ListingPreferences {
        private String defaultPropertyType;
        private String displayCurrency;
        
        public String getDefaultPropertyType() {
            return defaultPropertyType;
        }
        
        public void setDefaultPropertyType(String defaultPropertyType) {
            this.defaultPropertyType = defaultPropertyType;
        }
        
        public String getDisplayCurrency() {
            return displayCurrency;
        }
        
        public void setDisplayCurrency(String displayCurrency) {
            this.displayCurrency = displayCurrency;
        }
    }
}