package com.careerlink.controller;

import com.careerlink.dao.InternshipDAO;
import com.careerlink.model.Internship;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/recruiter/editInternship")
public class EditInternshipServlet extends HttpServlet {

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
            int internshipId      = Integer.parseInt(idStr);
            InternshipDAO dao     = new InternshipDAO();
            Internship internship = dao.getInternshipById(internshipId);

            if (internship == null) {
                response.sendRedirect(request.getContextPath()
                        + "/recruiter/internships?error=Internship not found.");
                return;
            }

            request.setAttribute("internship", internship);
            request.getRequestDispatcher("/views/recruiter/editInternship.jsp")
                    .forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath()
                    + "/recruiter/internships?error=Invalid internship ID.");
        }
    }
}