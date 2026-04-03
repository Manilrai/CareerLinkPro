package com.careerlink.dao;

import com.careerlink.model.Student;
import com.careerlink.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {

    // Get student profile by user ID
    public Student getStudentByUserId(int userId) {
        String sql = "SELECT s.*, u.full_name, u.email, u.phone " +
                "FROM students s " +
                "JOIN users u ON s.user_id = u.user_id " +
                "WHERE s.user_id = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Student student = new Student();
                student.setStudentId(rs.getInt("student_id"));
                student.setUserId(rs.getInt("user_id"));
                student.setDateOfBirth(rs.getString("date_of_birth"));
                student.setAddress(rs.getString("address"));
                student.setEducationLevel(rs.getString("education_level"));
                student.setInstitution(rs.getString("institution"));
                student.setYearOfStudy(rs.getInt("year_of_study"));
                student.setFullName(rs.getString("full_name"));
                student.setEmail(rs.getString("email"));
                student.setPhone(rs.getString("phone"));
                return student;
            }
        } catch (SQLException e) {
            System.out.println("Error getting student: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return null;
    }

    // Create blank student profile after registration
    public boolean createStudentProfile(int userId) {
        String sql = "INSERT INTO students (user_id) VALUES (?)";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error creating student profile: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Update student profile
    public boolean updateStudentProfile(Student student) {
        String sql = "UPDATE students SET date_of_birth=?, address=?, " +
                "education_level=?, institution=?, year_of_study=? " +
                "WHERE student_id=?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, student.getDateOfBirth());
            ps.setString(2, student.getAddress());
            ps.setString(3, student.getEducationLevel());
            ps.setString(4, student.getInstitution());
            ps.setInt(5,    student.getYearOfStudy());
            ps.setInt(6,    student.getStudentId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error updating student: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Get all skills of a student
    public List<String> getSkillsByStudentId(int studentId) {
        String sql = "SELECT skill_name FROM student_skills " +
                "WHERE student_id = ?";
        List<String> skills = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, studentId);
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

    // Add a skill
    public boolean addSkill(int studentId, String skillName) {
        String sql = "INSERT INTO student_skills (student_id, skill_name) " +
                "VALUES (?, ?)";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, studentId);
            ps.setString(2, skillName.trim());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error adding skill: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Delete a skill
    public boolean deleteSkill(int skillId) {
        String sql = "DELETE FROM student_skills WHERE skill_id = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, skillId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error deleting skill: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Get skills with their IDs (for delete button)
    public List<int[]> getSkillsWithIdByStudentId(int studentId) {
        String sql = "SELECT skill_id, skill_name FROM student_skills " +
                "WHERE student_id = ?";
        List<int[]> skills = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                skills.add(new int[]{
                        rs.getInt("skill_id"),
                        rs.getInt("skill_id")
                });
            }
        } catch (SQLException e) {
            System.out.println("Error getting skills: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return skills;
    }
}