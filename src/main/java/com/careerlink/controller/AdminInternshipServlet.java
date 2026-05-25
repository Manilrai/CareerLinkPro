package com.careerlink.controller;

import com.careerlink.dao.InternshipDAO;
import com.careerlink.model.Internship;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/internships")
public class AdminInternshipServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (session.getAttribute("userId") == null ||
                !session.getAttribute("role").equals("admin")) {
            response.sendRedirect(request.getContextPath()
                    + "/views/common/login.jsp");
            return;
        }

        String success = request.getParameter("success");
        String error   = request.getParameter("error");
        if (success != null) request.setAttribute("success", success);
        if (error   != null) request.setAttribute("error",   error);

        // Handle delete
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            String idStr = request.getParameter("id");
            try {
                int internshipId    = Integer.parseInt(idStr);
                InternshipDAO dao   = new InternshipDAO();
                boolean deleted     = dao.deleteInternship(internshipId);
                if (deleted) {
                    request.setAttribute("success",
                            "Internship deleted successfully.");
                } else {
                    request.setAttribute("error",
                            "Failed to delete internship.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid ID.");
            }
        }

        InternshipDAO internshipDAO = new InternshipDAO();
        List<Internship> internships = internshipDAO.getAllInternshipsForAdmin();
        request.setAttribute("internships", internships);

        request.getRequestDispatcher("/views/admin/manageInternships.jsp")
                .forward(request, response);
    }
}