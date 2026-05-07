package com.careerlink.dao;

import com.careerlink.model.Application;
import com.careerlink.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ApplicationDAO {

    // Get all applicants for an internship
    public List<Application> getApplicantsByInternshipId(int internshipId) {
        String sql = "SELECT a.*, u.full_name, u.email, u.phone " +
                "FROM applications a " +
                "JOIN students s ON a.student_id = s.student_id " +
                "JOIN users u ON s.user_id = u.user_id " +
                "WHERE a.internship_id = ? " +
                "ORDER BY a.applied_at DESC";
        List<Application> list = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, internshipId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Application app = new Application();
                app.setApplicationId(rs.getInt("application_id"));
                app.setStudentId(rs.getInt("student_id"));
                app.setInternshipId(rs.getInt("internship_id"));
                app.setAppliedAt(rs.getTimestamp("applied_at"));
                app.setStatus(rs.getString("status"));
                app.setFullName(rs.getString("full_name"));
                app.setEmail(rs.getString("email"));
                app.setPhone(rs.getString("phone"));
                list.add(app);
            }
        } catch (SQLException e) {
            System.out.println("Error getting applicants: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return list;
    }

    // Update application status
    public boolean updateStatus(int applicationId, String status) {
        String sql = "UPDATE applications SET status = ? " +
                "WHERE application_id = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, applicationId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error updating status: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Count total applications for a recruiter
    public int countApplicationsByRecruiterId(int recruiterId) {
        String sql = "SELECT COUNT(*) FROM applications a " +
                "JOIN internships i ON a.internship_id = i.internship_id " +
                "WHERE i.recruiter_id = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, recruiterId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("Error counting applications: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return 0;
    }

    // Count shortlisted for a recruiter
    public int countShortlistedByRecruiterId(int recruiterId) {
        String sql = "SELECT COUNT(*) FROM applications a " +
                "JOIN internships i ON a.internship_id = i.internship_id " +
                "WHERE i.recruiter_id = ? AND a.status = 'shortlisted'";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, recruiterId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("Error counting shortlisted: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return 0;
    }
    // Count all applications (for admin)
    public int countAllApplications() {
        String sql = "SELECT COUNT(*) FROM applications";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("Error counting applications: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return 0;
    }
    // Count applications by student
    public int countApplicationsByStudentId(int studentId) {
        String sql = "SELECT COUNT(*) FROM applications " +
                "WHERE student_id = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("Error counting: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return 0;
    }
    // Apply for internship
    public boolean applyForInternship(Application application) {
        String sql = "INSERT INTO applications (student_id, internship_id) " +
                "VALUES (?, ?)";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, application.getStudentId());
            ps.setInt(2, application.getInternshipId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error applying: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Check if student already applied
    public boolean hasApplied(int studentId, int internshipId) {
        String sql = "SELECT application_id FROM applications " +
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
            System.out.println("Error checking application: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Get all applications by student
    public List<Application> getApplicationsByStudentId(int studentId) {
        String sql = "SELECT a.*, i.title as internship_title, " +
                "r.company_name FROM applications a " +
                "JOIN internships i ON a.internship_id = i.internship_id " +
                "JOIN recruiters r ON i.recruiter_id = r.recruiter_id " +
                "WHERE a.student_id = ? ORDER BY a.applied_at DESC";
        List<Application> list = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Application app = new Application();
                app.setApplicationId(rs.getInt("application_id"));
                app.setStudentId(rs.getInt("student_id"));
                app.setInternshipId(rs.getInt("internship_id"));
                app.setAppliedAt(rs.getTimestamp("applied_at"));
                app.setStatus(rs.getString("status"));
                app.setInternshipTitle(rs.getString("internship_title"));
                app.setFullName(rs.getString("company_name"));
                list.add(app);
            }
        } catch (SQLException e) {
            System.out.println("Error getting applications: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return list;
    }
}
