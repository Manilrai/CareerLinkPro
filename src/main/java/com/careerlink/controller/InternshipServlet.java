package com.careerlink.controller;

import com.careerlink.dao.InternshipDAO;
import com.careerlink.model.Internship;
import com.careerlink.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/recruiter/internships")
public class InternshipServlet extends HttpServlet {

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

        int recruiterId = (int) session.getAttribute("recruiterId");

        // Check for success/error messages passed via URL
        String success = request.getParameter("success");
        String error   = request.getParameter("error");
        if (success != null) request.setAttribute("success", success);
        if (error   != null) request.setAttribute("error", error);

        // Handle delete action
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            String idStr = request.getParameter("id");
            try {
                int internshipId = Integer.parseInt(idStr);
                InternshipDAO dao = new InternshipDAO();
                boolean deleted  = dao.deleteInternship(internshipId);
                if (deleted) {
                    request.setAttribute("success",
                            "Internship deleted successfully.");
                } else {
                    request.setAttribute("error",
                            "Failed to delete internship.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid internship ID.");
            }
        }

        // Load all internships for this recruiter
        InternshipDAO internshipDAO = new InternshipDAO();
        List<Internship> internships =
                internshipDAO.getInternshipsByRecruiterId(recruiterId);

        request.setAttribute("internships", internships);
        request.getRequestDispatcher("/views/recruiter/manageInternships.jsp")
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

        // Handle edit/update
        String internshipIdStr = request.getParameter("internshipId");
        String title           = request.getParameter("title");
        String location        = request.getParameter("location");
        String description     = request.getParameter("description");
        String duration        = request.getParameter("duration");
        String stipend         = request.getParameter("stipend");
        String deadlineStr     = request.getParameter("deadline");
        String status          = request.getParameter("status");

        // Validate
        if (ValidationUtil.isEmpty(title) || ValidationUtil.isEmpty(location) ||
                ValidationUtil.isEmpty(description) || ValidationUtil.isEmpty(duration) ||
                ValidationUtil.isEmpty(deadlineStr)) {
            request.setAttribute("error", "All required fields must be filled.");
            request.getRequestDispatcher("/views/recruiter/editInternship.jsp")
                    .forward(request, response);
            return;
        }

        try {
            int internshipId = Integer.parseInt(internshipIdStr);
            Date deadline    = Date.valueOf(deadlineStr);

            Internship internship = new Internship();
            internship.setInternshipId(internshipId);
            internship.setTitle(title);
            internship.setLocation(location);
            internship.setDescription(description);
            internship.setDuration(duration);
            internship.setStipend(ValidationUtil.isEmpty(stipend) ? "Unpaid" : stipend);
            internship.setDeadline(deadline);
            internship.setStatus(status);

            InternshipDAO dao = new InternshipDAO();
            boolean updated   = dao.updateInternship(internship);

            if (updated) {
                response.sendRedirect(request.getContextPath()
                        + "/recruiter/internships?success=Internship updated successfully!");
            } else {
                request.setAttribute("error", "Failed to update internship.");
                request.getRequestDispatcher("/views/recruiter/editInternship.jsp")
                        .forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Invalid data. Please check your inputs.");
            request.getRequestDispatcher("/views/recruiter/editInternship.jsp")
                    .forward(request, response);
        }
    }
}