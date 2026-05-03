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

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Get the existing session — DO NOT create a new one if missing
        HttpSession session = request.getSession(false);

        System.out.println("=== ADMIN DASHBOARD HIT ===");
        if (session == null) {
            System.out.println("No session found — redirecting to login.");
            response.sendRedirect(request.getContextPath()
                    + "/views/common/login.jsp");
            return;
        }

        Object userIdObj = session.getAttribute("userId");
        Object roleObj   = session.getAttribute("role");

        System.out.println("Session ID: " + session.getId());
        System.out.println("Session userId: " + userIdObj);
        System.out.println("Session role: "   + roleObj);

        // Authentication and authorization check
        if (userIdObj == null || roleObj == null
                || !"admin".equalsIgnoreCase(roleObj.toString())) {
            System.out.println("Auth failed — redirecting to login.");
            response.sendRedirect(request.getContextPath()
                    + "/views/common/login.jsp");
            return;
        }

        // Load dashboard statistics
        try {
            UserDAO        userDAO        = new UserDAO();
            InternshipDAO  internshipDAO  = new InternshipDAO();
            ApplicationDAO applicationDAO = new ApplicationDAO();

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

            System.out.println("Stats loaded successfully — forwarding to JSP.");
            request.getRequestDispatcher("/views/admin/dashboard.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            System.out.println("ERROR loading admin dashboard: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error",
                    "Unable to load dashboard. Please try again.");
            request.getRequestDispatcher("/views/common/error.jsp")
                    .forward(request, response);
        }
    }
}