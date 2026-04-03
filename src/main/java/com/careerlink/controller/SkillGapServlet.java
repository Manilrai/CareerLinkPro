package com.careerlink.controller;

import com.careerlink.dao.InternshipDAO;
import com.careerlink.dao.StudentDAO;
import com.careerlink.model.Internship;
import com.careerlink.service.SkillGapService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/student/checkSkills")
public class SkillGapServlet extends HttpServlet {

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

        String idStr = request.getParameter("id");
        try {
            int internshipId = Integer.parseInt(idStr);
            int studentId    = (int) session.getAttribute("studentId");

            InternshipDAO internshipDAO = new InternshipDAO();
            StudentDAO studentDAO       = new StudentDAO();
            SkillGapService gapService  = new SkillGapService();

            // Get internship details
            Internship internship = internshipDAO
                    .getInternshipById(internshipId);

            if (internship == null) {
                response.sendRedirect(request.getContextPath()
                        + "/student/internships");
                return;
            }

            // Get required skills
            List<String> requiredSkills = internshipDAO
                    .getSkillsByInternshipId(internshipId);
            internship.setRequiredSkills(requiredSkills);

            // Get student skills
            List<String> studentSkills = studentDAO
                    .getSkillsByStudentId(studentId);

            // Get missing skills
            List<String> missingSkills = gapService
                    .getMissingSkills(studentId, internshipId);

            // Get match percentage
            int matchPercentage = gapService
                    .getMatchPercentage(studentId, internshipId);

            // Set all attributes for JSP
            request.setAttribute("internship",      internship);
            request.setAttribute("requiredSkills",  requiredSkills);
            request.setAttribute("studentSkills",   studentSkills);
            request.setAttribute("missingSkills",   missingSkills);
            request.setAttribute("matchPercentage", matchPercentage);

            request.getRequestDispatcher("/views/student/skillGapResult.jsp")
                    .forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath()
                    + "/student/internships");
        }
    }
}