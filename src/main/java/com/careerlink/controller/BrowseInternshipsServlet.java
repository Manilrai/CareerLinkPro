package com.careerlink.controller;

import com.careerlink.dao.InternshipDAO;
import com.careerlink.model.Internship;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/student/internships")
public class BrowseInternshipsServlet extends HttpServlet {

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

        String search = request.getParameter("search");

        InternshipDAO internshipDAO = new InternshipDAO();
        List<Internship> internships;

        if (search != null && !search.trim().isEmpty()) {
            internships = internshipDAO.searchInternships(search.trim());
            request.setAttribute("search", search);
        } else {
            internships = internshipDAO.getAllOpenInternships();
        }

        // Load required skills for each internship
        for (Internship internship : internships) {
            List<String> skills = internshipDAO
                    .getSkillsByInternshipId(internship.getInternshipId());
            internship.setRequiredSkills(skills);
        }

        request.setAttribute("internships", internships);
        request.getRequestDispatcher("/views/student/browseInternships.jsp")
                .forward(request, response);
    }
}