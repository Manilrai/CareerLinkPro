package com.careerlink.controller;

import com.careerlink.dao.ApplicationDAO;
import com.careerlink.dao.InternshipDAO;
import com.careerlink.model.Application;
import com.careerlink.model.Internship;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/recruiter/applicants")
public class ApplicationStatusServlet extends HttpServlet {

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

        String idStr = request.getParameter("id");
        try {
            int internshipId = Integer.parseInt(idStr);

            InternshipDAO internshipDAO  = new InternshipDAO();
            ApplicationDAO applicationDAO = new ApplicationDAO();

            Internship internship =
                    internshipDAO.getInternshipById(internshipId);
            List<Application> applicants =
                    applicationDAO.getApplicantsByInternshipId(internshipId);

            if (internship == null) {
                response.sendRedirect(request.getContextPath()
                        + "/recruiter/internships?error=Internship not found.");
                return;
            }

            // Success message if redirected after update
            String success = request.getParameter("success");
            if (success != null) {
                request.setAttribute("success", success);
            }

            request.setAttribute("internshipTitle", internship.getTitle());
            request.setAttribute("internshipId",    internshipId);
            request.setAttribute("applicants",      applicants);

            request.getRequestDispatcher("/views/recruiter/viewApplicants.jsp")
                    .forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath()
                    + "/recruiter/internships?error=Invalid internship ID.");
        }
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

        String applicationIdStr = request.getParameter("applicationId");
        String internshipIdStr  = request.getParameter("internshipId");
        String status           = request.getParameter("status");

        try {
            int applicationId    = Integer.parseInt(applicationIdStr);
            int internshipId     = Integer.parseInt(internshipIdStr);
            ApplicationDAO dao   = new ApplicationDAO();
            boolean updated      = dao.updateStatus(applicationId, status);

            if (updated) {
                response.sendRedirect(request.getContextPath()
                        + "/recruiter/applicants?id=" + internshipId
                        + "&success=Status updated successfully.");
            } else {
                response.sendRedirect(request.getContextPath()
                        + "/recruiter/applicants?id=" + internshipId
                        + "&error=Failed to update status.");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath()
                    + "/recruiter/internships?error=Invalid data.");
        }
    }
}