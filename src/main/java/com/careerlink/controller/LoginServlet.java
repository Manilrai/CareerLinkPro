package com.careerlink.controller;

import com.careerlink.dao.RecruiterDAO;
import com.careerlink.dao.UserDAO;
import com.careerlink.model.User;
import com.careerlink.util.PasswordUtil;
import com.careerlink.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        // If already logged in, redirect to appropriate dashboard
        HttpSession existing = request.getSession(false);
        if (existing != null && existing.getAttribute("userId") != null) {
            redirectByRole(request, response, (String) existing.getAttribute("role"));
            return;
        }
        request.getRequestDispatcher("/views/common/login.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email    = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("=== LOGIN ATTEMPT ===");
        System.out.println("Email: " + email);

        // Step 1: Validate input
        if (ValidationUtil.isEmpty(email) || ValidationUtil.isEmpty(password)) {
            forwardWithError(request, response,
                    "Email and password are required.");
            return;
        }

        // Step 2: Encrypt password using SHA-256
        String encryptedPassword = PasswordUtil.encrypt(password.trim());
        System.out.println("Encrypted hash: " + encryptedPassword);

        // Step 3: Authenticate with the database
        UserDAO userDAO = new UserDAO();
        User user = userDAO.loginUser(email.trim(), encryptedPassword);

        if (user == null) {
            System.out.println("LOGIN FAILED — no user matched.");
            forwardWithError(request, response,
                    "Invalid email or password.");
            return;
        }

        System.out.println("DB MATCH — userId=" + user.getUserId()
                + ", role=" + user.getRole()
                + ", status=" + user.getStatus());

        // Step 4: Check account status
        if ("pending".equalsIgnoreCase(user.getStatus())) {
            forwardWithError(request, response,
                    "Your account is pending approval. Please wait for admin approval.");
            return;
        }
        if ("inactive".equalsIgnoreCase(user.getStatus())) {
            forwardWithError(request, response,
                    "Your account has been deactivated. Please contact admin.");
            return;
        }

        // Step 5: Create the session
        // Invalidate any old session first to avoid session-fixation issues
        HttpSession oldSession = request.getSession(false);
        if (oldSession != null) {
            oldSession.invalidate();
        }
        HttpSession session = request.getSession(true);
        session.setMaxInactiveInterval(30 * 60); // 30 minutes

        session.setAttribute("userId",   user.getUserId());
        session.setAttribute("fullName", user.getFullName());
        session.setAttribute("role",     user.getRole());
        session.setAttribute("email",    user.getEmail());

        System.out.println("SESSION CREATED — sessionId=" + session.getId()
                + ", userId=" + session.getAttribute("userId")
                + ", role=" + session.getAttribute("role"));

        // Step 6: Store the role-specific ID if applicable
        if ("recruiter".equalsIgnoreCase(user.getRole())) {
            RecruiterDAO recruiterDAO = new RecruiterDAO();
            int recruiterId = recruiterDAO.getRecruiterIdByUserId(user.getUserId());
            session.setAttribute("recruiterId", recruiterId);
        }

        // Step 7: Redirect to the right dashboard
        redirectByRole(request, response, user.getRole());
    }

    /** Forward back to the login page with an error message. */
    private void forwardWithError(HttpServletRequest request,
                                  HttpServletResponse response,
                                  String message)
            throws ServletException, IOException {
        request.setAttribute("error", message);
        request.getRequestDispatcher("/views/common/login.jsp")
                .forward(request, response);
    }

    /** Send the user to the dashboard that matches their role. */
    private void redirectByRole(HttpServletRequest request,
                                HttpServletResponse response,
                                String role) throws IOException {
        String ctx = request.getContextPath();
        if ("admin".equalsIgnoreCase(role)) {
            response.sendRedirect(ctx + "/admin/dashboard");
        } else if ("recruiter".equalsIgnoreCase(role)) {
            response.sendRedirect(ctx + "/recruiter/dashboard");
        } else {
            response.sendRedirect(ctx + "/student/dashboard");
        }
    }
}