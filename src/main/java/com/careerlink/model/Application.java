package com.careerlink.model;

import java.sql.Timestamp;

public class Application {

    private int applicationId;
    private int studentId;
    private int internshipId;
    private Timestamp appliedAt;
    private String status;

    // Extra fields for display
    private String fullName;
    private String email;
    private String phone;
    private String internshipTitle;

    // Constructor
    public Application() {}

    public Application(int studentId, int internshipId) {
        this.studentId = studentId;
        this.internshipId = internshipId;
    }

    // Getters and Setters
    public int getApplicationId() { return applicationId; }
    public void setApplicationId(int applicationId) {
        this.applicationId = applicationId;
    }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public int getInternshipId() { return internshipId; }
    public void setInternshipId(int internshipId) { this.internshipId = internshipId; }

    public Timestamp getAppliedAt() { return appliedAt; }
    public void setAppliedAt(Timestamp appliedAt) { this.appliedAt = appliedAt; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getInternshipTitle() { return internshipTitle; }
    public void setInternshipTitle(String internshipTitle) {
        this.internshipTitle = internshipTitle;
    }
}
