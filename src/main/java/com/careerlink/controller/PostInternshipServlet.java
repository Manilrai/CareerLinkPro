package com.careerlink.controller;

import com.careerlink.dao.InternshipDAO;
import com.careerlink.model.Internship;
import com.careerlink.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet("/recruiter/postInternship")
public class PostInternshipServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (session.getAttribute("userId") == null ||
                !session.getAttribute("role").equals("recruiter")) {
            response.sendRedirect(request.getContextPath()
                    + "/views/common/login.jsp");
            return;
        }

        request.getRequestDispatcher("/views/recruiter/postInternship.jsp")
                .forward(request, response);
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (session.getAttribute("userId") == null ||
                !session.getAttribute("role").equals("recruiter")) {
            response.sendRedirect(request.getContextPath()
                    + "/views/common/login.jsp");
            return;
        }

        int recruiterId = (int) session.getAttribute("recruiterId");

        // Get form values
        String title       = request.getParameter("title");
        String location    = request.getParameter("location");
        String description = request.getParameter("description");
        String duration    = request.getParameter("duration");
        String stipend     = request.getParameter("stipend");
        String deadlineStr = request.getParameter("deadline");
        String[] skills    = request.getParameterValues("skills");

        // Validate required fields
        if (ValidationUtil.isEmpty(title) || ValidationUtil.isEmpty(location) ||
                ValidationUtil.isEmpty(description) || ValidationUtil.isEmpty(duration) ||
                ValidationUtil.isEmpty(deadlineStr)) {
            request.setAttribute("error", "All required fields must be filled in.");
            request.getRequestDispatcher("/views/recruiter/postInternship.jsp")
                    .forward(request, response);
            return;
        }

        // Validate deadline
        Date deadline;
        try {
            deadline = Date.valueOf(deadlineStr);
            if (deadline.before(new Date(System.currentTimeMillis()))) {
                request.setAttribute("error", "Deadline must be a future date.");
                request.getRequestDispatcher("/views/recruiter/postInternship.jsp")
                        .forward(request, response);
                return;
            }
        } catch (Exception e) {
            request.setAttribute("error", "Invalid deadline date format.");
            request.getRequestDispatcher("/views/recruiter/postInternship.jsp")
                    .forward(request, response);
            return;
        }

        // Validate skills
        if (skills == null || skills.length == 0) {
            request.setAttribute("error",
                    "Please add at least one required skill.");
            request.getRequestDispatcher("/views/recruiter/postInternship.jsp")
                    .forward(request, response);
            return;
        }

        // Filter out empty skill entries
        List<String> skillList = new ArrayList<>();
        for (String skill : skills) {
            if (!ValidationUtil.isEmpty(skill)) {
                skillList.add(skill.trim());
            }
        }

        if (skillList.isEmpty()) {
            request.setAttribute("error",
                    "Please add at least one valid required skill.");
            request.getRequestDispatcher("/views/recruiter/postInternship.jsp")
                    .forward(request, response);
            return;
        }

        // Create internship object
        Internship internship = new Internship(
                recruiterId, title, description,
                location, duration,
                ValidationUtil.isEmpty(stipend) ? "Unpaid" : stipend,
                deadline
        );

        // Save to database
        InternshipDAO internshipDAO = new InternshipDAO();
        int internshipId = internshipDAO.addInternship(internship);

        if (internshipId == -1) {
            request.setAttribute("error",
                    "Failed to post internship. Please try again.");
            request.getRequestDispatcher("/views/recruiter/postInternship.jsp")
                    .forward(request, response);
            return;
        }

        // Save required skills
        internshipDAO.addInternshipSkills(internshipId, skillList);

        // Success — redirect to manage internships
        response.sendRedirect(request.getContextPath()
                + "/recruiter/internships?success=Internship posted successfully!");
    }
}