package com.careerlink.controller;

import com.careerlink.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/common/contact.jsp")
                .forward(request, response);
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String name    = request.getParameter("name");
        String email   = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // Validate all fields
        if (ValidationUtil.isEmpty(name)    ||
                ValidationUtil.isEmpty(email)   ||
                ValidationUtil.isEmpty(subject) ||
                ValidationUtil.isEmpty(message)) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/views/common/contact.jsp")
                    .forward(request, response);
            return;
        }

        if (!ValidationUtil.isValidEmail(email)) {
            request.setAttribute("error", "Please enter a valid email address.");
            request.getRequestDispatcher("/views/common/contact.jsp")
                    .forward(request, response);
            return;
        }

        if (!ValidationUtil.isValidName(name)) {
            request.setAttribute("error", "Name must contain letters only.");
            request.getRequestDispatcher("/views/common/contact.jsp")
                    .forward(request, response);
            return;
        }

        // In a real system you would save to DB or send email
        // For now just show success message
        request.setAttribute("success",
                "Thank you " + name + "! Your message has been sent successfully.");
        request.getRequestDispatcher("/views/common/contact.jsp")
                .forward(request, response);
    }
}