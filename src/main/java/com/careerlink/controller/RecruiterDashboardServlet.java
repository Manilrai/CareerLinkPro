package com.careerlink.controller;

import com.careerlink.dao.ApplicationDAO;
import com.careerlink.dao.InternshipDAO;
import com.careerlink.model.Internship;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/recruiter/dashboard")
public class RecruiterDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Security check
        if (session.getAttribute("userId") == null ||
                !session.getAttribute("role").equals("recruiter")) {
            response.sendRedirect(request.getContextPath()
                    + "/views/common/login.jsp");
            return;
        }

        int recruiterId = (int) session.getAttribute("recruiterId");

        InternshipDAO internshipDAO = new InternshipDAO();
        ApplicationDAO applicationDAO = new ApplicationDAO();

        // Get stats
        int totalInternships  = internshipDAO.countByRecruiterId(recruiterId, "all");
        int openInternships   = internshipDAO.countByRecruiterId(recruiterId, "open");
        int totalApplications = applicationDAO.countApplicationsByRecruiterId(recruiterId);
        int shortlisted       = applicationDAO.countShortlistedByRecruiterId(recruiterId);

        // Get recent internships
        List<Internship> internships =
                internshipDAO.getInternshipsByRecruiterId(recruiterId);

        // Set attributes for JSP
        request.setAttribute("totalInternships",  totalInternships);
        request.setAttribute("openInternships",   openInternships);
        request.setAttribute("totalApplications", totalApplications);
        request.setAttribute("shortlisted",       shortlisted);
        request.setAttribute("internships",       internships);

        request.getRequestDispatcher("/views/recruiter/dashboard.jsp")
                .forward(request, response);
    }
}