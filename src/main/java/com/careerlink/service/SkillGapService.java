package com.careerlink.service;

import com.careerlink.dao.InternshipDAO;
import com.careerlink.dao.StudentDAO;
import com.careerlink.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SkillGapService {

    // Main method — compare student skills vs internship requirements
    public List<String> getMissingSkills(int studentId, int internshipId) {

        InternshipDAO internshipDAO = new InternshipDAO();
        StudentDAO studentDAO       = new StudentDAO();

        // Get required skills for the internship
        List<String> required = internshipDAO
                .getSkillsByInternshipId(internshipId);

        // Get student's current skills
        List<String> studentSkills = studentDAO
                .getSkillsByStudentId(studentId);

        // Convert student skills to lowercase for comparison
        List<String> studentSkillsLower = new ArrayList<>();
        for (String s : studentSkills) {
            studentSkillsLower.add(s.toLowerCase().trim());
        }

        // Find missing skills
        List<String> missing = new ArrayList<>();
        for (String req : required) {
            if (!studentSkillsLower.contains(req.toLowerCase().trim())) {
                missing.add(req);
            }
        }

        // Log the gap result in database
        logGapResult(studentId, internshipId, missing);

        return missing;
    }

    // Save gap analysis result to skill_gap_log table
    private void logGapResult(int studentId, int internshipId,
                              List<String> missing) {
        String sql = "INSERT INTO skill_gap_log " +
                "(student_id, internship_id, missing_skills) " +
                "VALUES (?, ?, ?) " +
                "ON DUPLICATE KEY UPDATE " +
                "missing_skills = VALUES(missing_skills), " +
                "checked_at = CURRENT_TIMESTAMP";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, studentId);
            ps.setInt(2, internshipId);
            ps.setString(3, String.join(", ", missing));
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error logging gap: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Get percentage match
    public int getMatchPercentage(int studentId, int internshipId) {
        InternshipDAO internshipDAO = new InternshipDAO();
        List<String> required = internshipDAO
                .getSkillsByInternshipId(internshipId);

        if (required.isEmpty()) return 100;

        List<String> missing = getMissingSkills(studentId, internshipId);
        int matched = required.size() - missing.size();
        return (int) ((matched / (double) required.size()) * 100);
    }
}