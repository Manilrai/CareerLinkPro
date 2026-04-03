package com.careerlink.dao;

import com.careerlink.model.Internship;
import com.careerlink.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WishlistDAO {

    // Add to wishlist
    public boolean addToWishlist(int studentId, int internshipId) {
        String sql = "INSERT INTO wishlist (student_id, internship_id) " +
                "VALUES (?, ?)";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, studentId);
            ps.setInt(2, internshipId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error adding wishlist: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Remove from wishlist
    public boolean removeFromWishlist(int studentId, int internshipId) {
        String sql = "DELETE FROM wishlist " +
                "WHERE student_id = ? AND internship_id = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, studentId);
            ps.setInt(2, internshipId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error removing wishlist: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Check if already wishlisted
    public boolean isWishlisted(int studentId, int internshipId) {
        String sql = "SELECT wishlist_id FROM wishlist " +
                "WHERE student_id = ? AND internship_id = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, studentId);
            ps.setInt(2, internshipId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println("Error checking wishlist: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Get all wishlisted internships
    public List<Internship> getWishlist(int studentId) {
        String sql = "SELECT i.*, r.company_name FROM wishlist w " +
                "JOIN internships i " +
                "ON w.internship_id = i.internship_id " +
                "JOIN recruiters r " +
                "ON i.recruiter_id = r.recruiter_id " +
                "WHERE w.student_id = ? " +
                "ORDER BY w.added_at DESC";
        List<Internship> list = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Internship i = new Internship();
                i.setInternshipId(rs.getInt("internship_id"));
                i.setTitle(rs.getString("title"));
                i.setLocation(rs.getString("location"));
                i.setDuration(rs.getString("duration"));
                i.setStipend(rs.getString("stipend"));
                i.setDeadline(rs.getDate("deadline"));
                i.setStatus(rs.getString("status"));
                i.setCompanyName(rs.getString("company_name"));
                list.add(i);
            }
        } catch (SQLException e) {
            System.out.println("Error getting wishlist: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return list;
    }
}