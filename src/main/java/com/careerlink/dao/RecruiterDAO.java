package com.careerlink.dao;

import com.careerlink.model.Recruiter;
import com.careerlink.util.DBConnection;

import java.sql.*;

public class RecruiterDAO {

    // Add recruiter profile after registration
    public boolean addRecruiter(Recruiter recruiter) {
        String sql = "INSERT INTO recruiters (user_id, company_name, " +
                "company_description, website, industry) " +
                "VALUES (?, ?, ?, ?, ?)";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, recruiter.getUserId());
            ps.setString(2, recruiter.getCompanyName());
            ps.setString(3, recruiter.getCompanyDescription());
            ps.setString(4, recruiter.getWebsite());
            ps.setString(5, recruiter.getIndustry());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error adding recruiter: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Get recruiter by user ID
    public Recruiter getRecruiterByUserId(int userId) {
        String sql = "SELECT r.*, u.full_name, u.email, u.phone " +
                "FROM recruiters r " +
                "JOIN users u ON r.user_id = u.user_id " +
                "WHERE r.user_id = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Recruiter recruiter = new Recruiter();
                recruiter.setRecruiterId(rs.getInt("recruiter_id"));
                recruiter.setUserId(rs.getInt("user_id"));
                recruiter.setCompanyName(rs.getString("company_name"));
                recruiter.setCompanyDescription(rs.getString("company_description"));
                recruiter.setWebsite(rs.getString("website"));
                recruiter.setIndustry(rs.getString("industry"));
                recruiter.setVerified(rs.getString("verified"));
                recruiter.setFullName(rs.getString("full_name"));
                recruiter.setEmail(rs.getString("email"));
                recruiter.setPhone(rs.getString("phone"));
                return recruiter;
            }
        } catch (SQLException e) {
            System.out.println("Error getting recruiter: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return null;
    }

    // Get recruiter ID by user ID
    public int getRecruiterIdByUserId(int userId) {
        String sql = "SELECT recruiter_id FROM recruiters WHERE user_id = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("recruiter_id");
            }
        } catch (SQLException e) {
            System.out.println("Error getting recruiter ID: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return -1;
    }
}