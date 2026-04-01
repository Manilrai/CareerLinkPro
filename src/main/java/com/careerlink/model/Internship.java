package com.careerlink.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

public class Internship {

    private int internshipId;
    private int recruiterId;
    private String title;
    private String description;
    private String location;
    private String duration;
    private String stipend;
    private Date deadline;
    private String status;
    private Timestamp createdAt;

    // Extra fields for display
    private String companyName;
    private int applicationCount;
    private List<String> requiredSkills;

    // Constructor
    public Internship() {}

    public Internship(int recruiterId, String title, String description,
                      String location, String duration, String stipend,
                      Date deadline) {
        this.recruiterId = recruiterId;
        this.title = title;
        this.description = description;
        this.location = location;
        this.duration = duration;
        this.stipend = stipend;
        this.deadline = deadline;
    }

    // Getters and Setters
    public int getInternshipId() { return internshipId; }
    public void setInternshipId(int internshipId) { this.internshipId = internshipId; }

    public int getRecruiterId() { return recruiterId; }
    public void setRecruiterId(int recruiterId) { this.recruiterId = recruiterId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getDuration() { return duration; }
    public void setDuration(String duration) { this.duration = duration; }

    public String getStipend() { return stipend; }
    public void setStipend(String stipend) { this.stipend = stipend; }

    public Date getDeadline() { return deadline; }
    public void setDeadline(Date deadline) { this.deadline = deadline; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }

    public int getApplicationCount() { return applicationCount; }
    public void setApplicationCount(int applicationCount) {
        this.applicationCount = applicationCount;
    }

    public List<String> getRequiredSkills() { return requiredSkills; }
    public void setRequiredSkills(List<String> requiredSkills) {
        this.requiredSkills = requiredSkills;
    }
}