package com.careerlink.controller;

import com.careerlink.dao.RecruiterDAO;
import com.careerlink.dao.UserDAO;
import com.careerlink.model.Recruiter;
import com.careerlink.model.User;
import com.careerlink.util.PasswordUtil;
import com.careerlink.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/common/login.jsp")
                .forward(request, response);
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email    = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate
        if (ValidationUtil.isEmpty(email) || ValidationUtil.isEmpty(password)) {
            request.setAttribute("error", "Email and password are required.");
            request.getRequestDispatcher("/views/common/login.jsp")
                    .forward(request, response);
            return;
        }

        // Encrypt password for comparison
        String encryptedPassword = PasswordUtil.encrypt(password);

        // Check credentials
        UserDAO userDAO = new UserDAO();
        User user = userDAO.loginUser(email, encryptedPassword);

        if (user == null) {
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("/views/common/login.jsp")
                    .forward(request, response);
            return;
        }

        // Check account status
        if (user.getStatus().equals("pending")) {
            request.setAttribute("error",
                    "Your account is pending approval. Please wait for admin approval.");
            request.getRequestDispatcher("/views/common/login.jsp")
                    .forward(request, response);
            return;
        }

        if (user.getStatus().equals("inactive")) {
            request.setAttribute("error",
                    "Your account has been deactivated. Please contact admin.");
            request.getRequestDispatcher("/views/common/login.jsp")
                    .forward(request, response);
            return;
        }

        // Create session and store user info
        HttpSession session = request.getSession();
        session.setAttribute("userId", user.getUserId());
        session.setAttribute("fullName", user.getFullName());
        session.setAttribute("role", user.getRole());
        session.setAttribute("email", user.getEmail());

        // Store role-specific ID in session
        if (user.getRole().equals("recruiter")) {
            RecruiterDAO recruiterDAO = new RecruiterDAO();
            int recruiterId = recruiterDAO.getRecruiterIdByUserId(user.getUserId());
            session.setAttribute("recruiterId", recruiterId);
            response.sendRedirect(request.getContextPath() + "/recruiter/dashboard");

        } else if (user.getRole().equals("admin")) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");

        } else {
            // Student — for now redirect to student dashboard
            response.sendRedirect(request.getContextPath() + "/student/dashboard");
        }
    }
}