package com.careerlink.controller;

import com.careerlink.dao.StudentDAO;
import com.careerlink.model.Student;
import com.careerlink.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/student/profile")
public class StudentProfileServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (session.getAttribute("userId") == null ||
                !session.getAttribute("role").equals("student")) {
            response.sendRedirect(request.getContextPath()
                    + "/views/common/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        StudentDAO studentDAO = new StudentDAO();
        Student student = studentDAO.getStudentByUserId(userId);

        request.setAttribute("student", student);
        request.getRequestDispatcher("/views/student/profile.jsp")
                .forward(request, response);
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (session.getAttribute("userId") == null ||
                !session.getAttribute("role").equals("student")) {
            response.sendRedirect(request.getContextPath()
                    + "/views/common/login.jsp");
            return;
        }

        int userId        = (int) session.getAttribute("userId");
        String dob        = request.getParameter("dateOfBirth");
        String address    = request.getParameter("address");
        String education  = request.getParameter("educationLevel");
        String institution= request.getParameter("institution");
        String yearStr    = request.getParameter("yearOfStudy");

        // Validate
        if (ValidationUtil.isEmpty(education) ||
                ValidationUtil.isEmpty(institution)) {
            request.setAttribute("error",
                    "Education level and institution are required.");
            StudentDAO dao = new StudentDAO();
            request.setAttribute("student", dao.getStudentByUserId(userId));
            request.getRequestDispatcher("/views/student/profile.jsp")
                    .forward(request, response);
            return;
        }

        StudentDAO studentDAO = new StudentDAO();
        Student student = studentDAO.getStudentByUserId(userId);

        if (student == null) {
            request.setAttribute("error", "Student profile not found.");
            request.getRequestDispatcher("/views/student/profile.jsp")
                    .forward(request, response);
            return;
        }

        student.setDateOfBirth(ValidationUtil.isEmpty(dob) ? null : dob);
        student.setAddress(address);
        student.setEducationLevel(education);
        student.setInstitution(institution);

        try {
            student.setYearOfStudy(Integer.parseInt(yearStr));
        } catch (NumberFormatException e) {
            student.setYearOfStudy(1);
        }

        boolean updated = studentDAO.updateStudentProfile(student);

        if (updated) {
            request.setAttribute("success", "Profile updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update profile.");
        }

        request.setAttribute("student", studentDAO.getStudentByUserId(userId));
        request.getRequestDispatcher("/views/student/profile.jsp")
                .forward(request, response);
    }
}