package com.careerlink.controller;

import com.careerlink.dao.RecruiterDAO;
import com.careerlink.dao.UserDAO;
import com.careerlink.model.Recruiter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/recruiters")
public class AdminRecruiterServlet extends HttpServlet {

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

        RecruiterDAO recruiterDAO = new RecruiterDAO();
        List<Recruiter> recruiters = recruiterDAO.getAllRecruiters();
        request.setAttribute("recruiters", recruiters);

        request.getRequestDispatcher("/views/admin/manageRecruiters.jsp")
                .forward(request, response);
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (session.getAttribute("userId") == null ||
                !session.getAttribute("role").equals("admin")) {
            response.sendRedirect(request.getContextPath()
                    + "/views/common/login.jsp");
            return;
        }

        String userIdStr = request.getParameter("userId");
        String action    = request.getParameter("action");

        try {
            int userId      = Integer.parseInt(userIdStr);
            UserDAO userDAO = new UserDAO();
            RecruiterDAO recruiterDAO = new RecruiterDAO();
            boolean success = false;

            if ("approve".equals(action)) {
                // Activate user account
                userDAO.updateUserStatus(userId, "active");
                // Set recruiter as verified
                success = recruiterDAO.updateVerifiedStatus(userId, "yes");
                if (success) {
                    response.sendRedirect(request.getContextPath()
                            + "/admin/recruiters?success=Recruiter approved successfully!");
                } else {
                    response.sendRedirect(request.getContextPath()
                            + "/admin/recruiters?error=Failed to approve recruiter.");
                }
            } else if ("reject".equals(action)) {
                userDAO.updateUserStatus(userId, "inactive");
                success = recruiterDAO.updateVerifiedStatus(userId, "no");
                if (success) {
                    response.sendRedirect(request.getContextPath()
                            + "/admin/recruiters?success=Recruiter rejected.");
                } else {
                    response.sendRedirect(request.getContextPath()
                            + "/admin/recruiters?error=Failed to reject recruiter.");
                }
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath()
                    + "/admin/recruiters?error=Invalid ID.");
        }
    }
}