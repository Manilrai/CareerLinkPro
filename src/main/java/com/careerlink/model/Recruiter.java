package com.careerlink.model;

public class Recruiter {

    private int recruiterId;
    private int userId;
    private String companyName;
    private String companyDescription;
    private String website;
    private String industry;
    private String verified;

    // Full name and email from users table (for display)
    private String fullName;
    private String email;
    private String phone;

    // Constructor
    public Recruiter() {}

    public Recruiter(int userId, String companyName,
                     String companyDescription, String website,
                     String industry) {
        this.userId = userId;
        this.companyName = companyName;
        this.companyDescription = companyDescription;
        this.website = website;
        this.industry = industry;
    }

    // Getters and Setters
    public int getRecruiterId() { return recruiterId; }
    public void setRecruiterId(int recruiterId) { this.recruiterId = recruiterId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }

    public String getCompanyDescription() { return companyDescription; }
    public void setCompanyDescription(String companyDescription) {
        this.companyDescription = companyDescription;
    }

    public String getWebsite() { return website; }
    public void setWebsite(String website) { this.website = website; }

    public String getIndustry() { return industry; }
    public void setIndustry(String industry) { this.industry = industry; }

    public String getVerified() { return verified; }
    public void setVerified(String verified) { this.verified = verified; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
}