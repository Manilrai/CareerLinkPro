package com.careerlink.controller;

import com.careerlink.dao.StudentDAO;
import com.careerlink.dao.ApplicationDAO;
import com.careerlink.dao.InternshipDAO;
import com.careerlink.model.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/student/dashboard")
public class StudentDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Security check
        if (session.getAttribute("userId") == null ||
                !session.getAttribute("role").equals("student")) {
            response.sendRedirect(request.getContextPath()
                    + "/views/common/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        StudentDAO studentDAO = new StudentDAO();
        Student student = studentDAO.getStudentByUserId(userId);

        // If student profile doesn't exist yet — create it
        if (student == null) {
            studentDAO.createStudentProfile(userId);
            student = studentDAO.getStudentByUserId(userId);
        }

        // Store studentId in session for later use
        if (student != null) {
            session.setAttribute("studentId", student.getStudentId());

            // Get stats
            ApplicationDAO applicationDAO = new ApplicationDAO();
            InternshipDAO internshipDAO   = new InternshipDAO();

            int totalApplications = applicationDAO
                    .countApplicationsByStudentId(student.getStudentId());
            int openInternships   = internshipDAO.countAllOpenInternships();

            request.setAttribute("student",           student);
            request.setAttribute("totalApplications", totalApplications);
            request.setAttribute("openInternships",   openInternships);
        }

        request.getRequestDispatcher("/views/student/dashboard.jsp")
                .forward(request, response);
    }
}