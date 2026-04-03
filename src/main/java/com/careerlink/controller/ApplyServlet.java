package com.careerlink.controller;

import com.careerlink.dao.ApplicationDAO;
import com.careerlink.model.Application;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/student/apply")
public class ApplyServlet extends HttpServlet {

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

        String internshipIdStr = request.getParameter("internshipId");
        int studentId          = (int) session.getAttribute("studentId");

        try {
            int internshipId = Integer.parseInt(internshipIdStr);

            ApplicationDAO dao = new ApplicationDAO();

            // Check if already applied
            if (dao.hasApplied(studentId, internshipId)) {
                response.sendRedirect(request.getContextPath()
                        + "/student/applications?error=You have already applied"
                        + " for this internship.");
                return;
            }

            // Create application
            Application application = new Application(studentId, internshipId);
            boolean applied = dao.applyForInternship(application);

            if (applied) {
                response.sendRedirect(request.getContextPath()
                        + "/student/applications?success=Application submitted"
                        + " successfully!");
            } else {
                response.sendRedirect(request.getContextPath()
                        + "/student/internships?error=Failed to submit application.");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath()
                    + "/student/internships");
        }
    }
}