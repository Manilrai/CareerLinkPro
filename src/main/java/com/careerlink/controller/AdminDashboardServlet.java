package com.careerlink.controller;

import com.careerlink.dao.ApplicationDAO;
import com.careerlink.dao.InternshipDAO;
import com.careerlink.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Security check
        if (session.getAttribute("userId") == null ||
                !session.getAttribute("role").equals("admin")) {
            response.sendRedirect(request.getContextPath()
                    + "/views/common/login.jsp");
            return;
        }

        UserDAO        userDAO        = new UserDAO();
        InternshipDAO  internshipDAO  = new InternshipDAO();
        ApplicationDAO applicationDAO = new ApplicationDAO();

        // Load stats
        int totalUsers        = userDAO.countAllUsers();
        int totalStudents     = userDAO.countByRole("student");
        int totalRecruiters   = userDAO.countByRole("recruiter");
        int pendingRecruiters = userDAO.countPendingRecruiters();
        int totalInternships  = internshipDAO.countAllInternships();
        int totalApplications = applicationDAO.countAllApplications();

        request.setAttribute("totalUsers",        totalUsers);
        request.setAttribute("totalStudents",     totalStudents);
        request.setAttribute("totalRecruiters",   totalRecruiters);
        request.setAttribute("pendingRecruiters", pendingRecruiters);
        request.setAttribute("totalInternships",  totalInternships);
        request.setAttribute("totalApplications", totalApplications);

        request.getRequestDispatcher("/views/admin/dashboard.jsp")
                .forward(request, response);
    }
}