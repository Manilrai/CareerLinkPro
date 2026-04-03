package com.careerlink.dao;

import com.careerlink.model.Internship;
import com.careerlink.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InternshipDAO {

    // Post a new internship
    public int addInternship(Internship internship) {
        String sql = "INSERT INTO internships (recruiter_id, title, description, " +
                "location, duration, stipend, deadline) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql,
                    Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, internship.getRecruiterId());
            ps.setString(2, internship.getTitle());
            ps.setString(3, internship.getDescription());
            ps.setString(4, internship.getLocation());
            ps.setString(5, internship.getDuration());
            ps.setString(6, internship.getStipend());
            ps.setDate(7, internship.getDeadline());
            ps.executeUpdate();

            // Return the generated internship ID
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next()) {
                return keys.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error adding internship: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return -1;
    }

    // Add required skills for an internship
    public boolean addInternshipSkills(int internshipId, List<String> skills) {
        String sql = "INSERT INTO internship_skills (internship_id, skill_name) " +
                "VALUES (?, ?)";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            for (String skill : skills) {
                if (!skill.trim().isEmpty()) {
                    ps.setInt(1, internshipId);
                    ps.setString(2, skill.trim());
                    ps.addBatch();
                }
            }
            ps.executeBatch();
            return true;
        } catch (SQLException e) {
            System.out.println("Error adding skills: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Get all internships by recruiter ID
    public List<Internship> getInternshipsByRecruiterId(int recruiterId) {
        String sql = "SELECT i.*, " +
                "(SELECT COUNT(*) FROM applications a " +
                "WHERE a.internship_id = i.internship_id) AS app_count " +
                "FROM internships i " +
                "WHERE i.recruiter_id = ? " +
                "ORDER BY i.created_at DESC";
        List<Internship> list = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, recruiterId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Internship i = new Internship();
                i.setInternshipId(rs.getInt("internship_id"));
                i.setRecruiterId(rs.getInt("recruiter_id"));
                i.setTitle(rs.getString("title"));
                i.setLocation(rs.getString("location"));
                i.setDuration(rs.getString("duration"));
                i.setStipend(rs.getString("stipend"));
                i.setDeadline(rs.getDate("deadline"));
                i.setStatus(rs.getString("status"));
                i.setApplicationCount(rs.getInt("app_count"));
                list.add(i);
            }
        } catch (SQLException e) {
            System.out.println("Error getting internships: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return list;
    }

    // Get internship by ID
    public Internship getInternshipById(int internshipId) {
        String sql = "SELECT i.*, r.company_name FROM internships i " +
                "JOIN recruiters r ON i.recruiter_id = r.recruiter_id " +
                "WHERE i.internship_id = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, internshipId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Internship i = new Internship();
                i.setInternshipId(rs.getInt("internship_id"));
                i.setRecruiterId(rs.getInt("recruiter_id"));
                i.setTitle(rs.getString("title"));
                i.setDescription(rs.getString("description"));
                i.setLocation(rs.getString("location"));
                i.setDuration(rs.getString("duration"));
                i.setStipend(rs.getString("stipend"));
                i.setDeadline(rs.getDate("deadline"));
                i.setStatus(rs.getString("status"));
                i.setCompanyName(rs.getString("company_name"));
                return i;
            }
        } catch (SQLException e) {
            System.out.println("Error getting internship: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return null;
    }

    // Update internship
    public boolean updateInternship(Internship internship) {
        String sql = "UPDATE internships SET title=?, description=?, location=?, " +
                "duration=?, stipend=?, deadline=?, status=? " +
                "WHERE internship_id=?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, internship.getTitle());
            ps.setString(2, internship.getDescription());
            ps.setString(3, internship.getLocation());
            ps.setString(4, internship.getDuration());
            ps.setString(5, internship.getStipend());
            ps.setDate(6, internship.getDeadline());
            ps.setString(7, internship.getStatus());
            ps.setInt(8, internship.getInternshipId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error updating internship: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Delete internship
    public boolean deleteInternship(int internshipId) {
        String sql = "DELETE FROM internships WHERE internship_id = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, internshipId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error deleting internship: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Get required skills for an internship
    public List<String> getSkillsByInternshipId(int internshipId) {
        String sql = "SELECT skill_name FROM internship_skills " +
                "WHERE internship_id = ?";
        List<String> skills = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, internshipId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                skills.add(rs.getString("skill_name"));
            }
        } catch (SQLException e) {
            System.out.println("Error getting skills: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return skills;
    }

    // Count stats for recruiter dashboard
    public int countByRecruiterId(int recruiterId, String status) {
        String sql = status.equals("all")
                ? "SELECT COUNT(*) FROM internships WHERE recruiter_id = ?"
                : "SELECT COUNT(*) FROM internships WHERE recruiter_id = ? AND status = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, recruiterId);
            if (!status.equals("all")) ps.setString(2, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("Error counting internships: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return 0;
    }
    // Count all internships
    public int countAllInternships() {
        String sql = "SELECT COUNT(*) FROM internships";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("Error counting internships: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return 0;
    }

    // Get all open internships (for student browsing)
    public List<Internship> getAllOpenInternships() {
        String sql = "SELECT i.*, r.company_name FROM internships i " +
                "JOIN recruiters r ON i.recruiter_id = r.recruiter_id " +
                "WHERE i.status = 'open' AND i.deadline >= CURDATE() " +
                "ORDER BY i.created_at DESC";
        List<Internship> list = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Internship i = new Internship();
                i.setInternshipId(rs.getInt("internship_id"));
                i.setTitle(rs.getString("title"));
                i.setDescription(rs.getString("description"));
                i.setLocation(rs.getString("location"));
                i.setDuration(rs.getString("duration"));
                i.setStipend(rs.getString("stipend"));
                i.setDeadline(rs.getDate("deadline"));
                i.setStatus(rs.getString("status"));
                i.setCompanyName(rs.getString("company_name"));
                list.add(i);
            }
        } catch (SQLException e) {
            System.out.println("Error getting internships: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return list;
    }
    // Count all open internships
    public int countAllOpenInternships() {
        String sql = "SELECT COUNT(*) FROM internships " +
                "WHERE status = 'open' AND deadline >= CURDATE()";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("Error counting: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return 0;
    }
    // Search internships by keyword
    public List<Internship> searchInternships(String keyword) {
        String sql = "SELECT i.*, r.company_name FROM internships i " +
                "JOIN recruiters r ON i.recruiter_id = r.recruiter_id " +
                "WHERE i.status = 'open' AND i.deadline >= CURDATE() " +
                "AND (i.title LIKE ? OR i.location LIKE ? " +
                "OR r.company_name LIKE ? " +
                "OR i.internship_id IN ( " +
                "  SELECT internship_id FROM internship_skills " +
                "  WHERE skill_name LIKE ?)) " +
                "ORDER BY i.created_at DESC";
        List<Internship> list = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            String kw = "%" + keyword + "%";
            ps.setString(1, kw);
            ps.setString(2, kw);
            ps.setString(3, kw);
            ps.setString(4, kw);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Internship i = new Internship();
                i.setInternshipId(rs.getInt("internship_id"));
                i.setTitle(rs.getString("title"));
                i.setDescription(rs.getString("description"));
                i.setLocation(rs.getString("location"));
                i.setDuration(rs.getString("duration"));
                i.setStipend(rs.getString("stipend"));
                i.setDeadline(rs.getDate("deadline"));
                i.setStatus(rs.getString("status"));
                i.setCompanyName(rs.getString("company_name"));
                list.add(i);
            }
        } catch (SQLException e) {
            System.out.println("Error searching: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return list;
    }
}