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

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/common/register.jsp")
                .forward(request, response);
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // Get form values
        String fullName = request.getParameter("fullName");
        String email    = request.getParameter("email");
        String phone    = request.getParameter("phone");
        String password = request.getParameter("password");
        String role     = request.getParameter("role");

        // Validate inputs
        if (ValidationUtil.isEmpty(fullName) || ValidationUtil.isEmpty(email) ||
                ValidationUtil.isEmpty(phone)    || ValidationUtil.isEmpty(password) ||
                ValidationUtil.isEmpty(role)) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/views/common/register.jsp")
                    .forward(request, response);
            return;
        }

        if (!ValidationUtil.isValidName(fullName)) {
            request.setAttribute("error", "Full name must contain letters only.");
            request.getRequestDispatcher("/views/common/register.jsp")
                    .forward(request, response);
            return;
        }

        if (!ValidationUtil.isValidEmail(email)) {
            request.setAttribute("error", "Please enter a valid email address.");
            request.getRequestDispatcher("/views/common/register.jsp")
                    .forward(request, response);
            return;
        }

        if (!ValidationUtil.isValidPhone(phone)) {
            request.setAttribute("error", "Phone must be exactly 10 digits.");
            request.getRequestDispatcher("/views/common/register.jsp")
                    .forward(request, response);
            return;
        }

        if (!ValidationUtil.isValidPassword(password)) {
            request.setAttribute("error", "Password must be at least 6 characters.");
            request.getRequestDispatcher("/views/common/register.jsp")
                    .forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();

        // Check for duplicate email
        if (userDAO.emailExists(email)) {
            request.setAttribute("error", "An account with this email already exists.");
            request.getRequestDispatcher("/views/common/register.jsp")
                    .forward(request, response);
            return;
        }

        // Check for duplicate phone
        if (userDAO.phoneExists(phone)) {
            request.setAttribute("error", "An account with this phone number already exists.");
            request.getRequestDispatcher("/views/common/register.jsp")
                    .forward(request, response);
            return;
        }

        // Encrypt password
        String encryptedPassword = PasswordUtil.encrypt(password);

        // Create user object
        User user = new User(fullName, email, encryptedPassword, phone, role);

        // Register user
        boolean registered = userDAO.registerUser(user);

        if (!registered) {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/views/common/register.jsp")
                    .forward(request, response);
            return;
        }

        // If recruiter — also create recruiter profile
        if (role.equals("recruiter")) {
            // Get the newly created user ID
            User newUser = userDAO.getUserByEmail(email);
            if (newUser != null) {
                Recruiter recruiter = new Recruiter();
                recruiter.setUserId(newUser.getUserId());
                recruiter.setCompanyName(request.getParameter("companyName") != null
                        ? request.getParameter("companyName") : "Not Provided");
                recruiter.setIndustry("General");
                RecruiterDAO recruiterDAO = new RecruiterDAO();
                recruiterDAO.addRecruiter(recruiter);
            }
            request.setAttribute("success",
                    "Registration successful! Your account is pending admin approval.");
            request.getRequestDispatcher("/views/common/login.jsp")
                    .forward(request, response);
        } else {
            // Student — redirect to login with success message
            request.setAttribute("success",
                    "Registration successful! You can now log in.");
            request.getRequestDispatcher("/views/common/login.jsp")
                    .forward(request, response);
        }
    }
}