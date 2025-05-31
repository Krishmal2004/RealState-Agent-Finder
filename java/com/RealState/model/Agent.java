package com.RealState.model;

import java.util.ArrayList;
import java.util.List;

public class Agent {
    private String id;
    private String fullName;
    private String email;
    private String phone;
    private String specialty;
    private double rating;
    private int ratingCount;
    private int propertiesSold;
    private int yearsExperience;
    private String imageUrl;
    private List<Rating> ratings;
    private CriteriaRating criteriaRatings;
    
    public Agent() {
        this.ratings = new ArrayList<>();
        this.criteriaRatings = new CriteriaRating();
    }
    
    // Getters and setters
    public String getId() {
        return id;
    }
    
    public void setId(String id) {
        this.id = id;
    }
    
    public String getFullName() {
        return fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
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
    
    public String getSpecialty() {
        return specialty;
    }
    
    public void setSpecialty(String specialty) {
        this.specialty = specialty;
    }
    
    public double getRating() {
        return rating;
    }
    
    public void setRating(double rating) {
        this.rating = rating;
    }
    
    public int getRatingCount() {
        return ratingCount;
    }
    
    public void setRatingCount(int ratingCount) {
        this.ratingCount = ratingCount;
    }
    
    public int getPropertiesSold() {
        return propertiesSold;
    }
    
    public void setPropertiesSold(int propertiesSold) {
        this.propertiesSold = propertiesSold;
    }
    
    public int getYearsExperience() {
        return yearsExperience;
    }
    
    public void setYearsExperience(int yearsExperience) {
        this.yearsExperience = yearsExperience;
    }
    
    public String getImageUrl() {
        return imageUrl;
    }
    
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    
    public List<Rating> getRatings() {
        return ratings;
    }
    
    public void setRatings(List<Rating> ratings) {
        this.ratings = ratings;
    }
    
    public void addRating(Rating rating) {
        this.ratings.add(rating);
        updateOverallRating();
    }
    
    public CriteriaRating getCriteriaRatings() {
        return criteriaRatings;
    }
    
    public void setCriteriaRatings(CriteriaRating criteriaRatings) {
        this.criteriaRatings = criteriaRatings;
    }
    
    // Update overall rating when a new rating is added
    private void updateOverallRating() {
        if (ratings.isEmpty()) {
            this.rating = 0.0;
            this.ratingCount = 0;
            return;
        }
        
        double sum = 0.0;
        for (Rating r : ratings) {
            sum += r.getRating();
        }
        
        this.rating = sum / ratings.size();
        this.ratingCount = ratings.size();
    }
    
    // Get avatar URL based on ID for consistent images
    public String getAvatarUrl() {
        if (imageUrl != null && !imageUrl.isEmpty()) {
            return imageUrl;
        }
        
        // Generate a deterministic but seemingly random avatar based on agent ID
        int hashCode = Math.abs(id.hashCode());
        int gender = hashCode % 2;
        int avatarId = hashCode % 99 + 1;
        return "https://randomuser.me/api/portraits/" + (gender == 0 ? "men" : "women") + "/" + avatarId + ".jpg";
    }
    
    // Get rank CSS class
    public String getRankClass(int rank) {
        if (rank == 1) return "gold";
        if (rank == 2) return "silver";
        if (rank == 3) return "bronze";
        return "";
    }
    
    // Inner classes for JSON structure
    public static class Rating {
        private String userId;
        private int rating;
        private String review;
        private String date;
        
        public String getUserId() {
            return userId;
        }
        
        public void setUserId(String userId) {
            this.userId = userId;
        }
        
        public int getRating() {
            return rating;
        }
        
        public void setRating(int rating) {
            this.rating = rating;
        }
        
        public String getReview() {
            return review;
        }
        
        public void setReview(String review) {
            this.review = review;
        }
        
        public String getDate() {
            return date;
        }
        
        public void setDate(String date) {
            this.date = date;
        }
    }
    
    public static class CriteriaRating {
        private double communication;
        private double knowledge;
        private double negotiation;
        private double responsiveness;
        private double professionalism;
        
        public double getCommunication() {
            return communication;
        }
        
        public void setCommunication(double communication) {
            this.communication = communication;
        }
        
        public double getKnowledge() {
            return knowledge;
        }
        
        public void setKnowledge(double knowledge) {
            this.knowledge = knowledge;
        }
        
        public double getNegotiation() {
            return negotiation;
        }
        
        public void setNegotiation(double negotiation) {
            this.negotiation = negotiation;
        }
        
        public double getResponsiveness() {
            return responsiveness;
        }
        
        public void setResponsiveness(double responsiveness) {
            this.responsiveness = responsiveness;
        }
        
        public double getProfessionalism() {
            return professionalism;
        }
        
        public void setProfessionalism(double professionalism) {
            this.professionalism = professionalism;
        }
    }
}