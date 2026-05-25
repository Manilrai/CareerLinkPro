package com.careerlink.controller;

import com.careerlink.dao.UserDAO;
import com.careerlink.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {

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

        // Check for messages
        String success = request.getParameter("success");
        String error   = request.getParameter("error");
        if (success != null) request.setAttribute("success", success);
        if (error   != null) request.setAttribute("error",   error);

        UserDAO userDAO = new UserDAO();
        List<User> users = userDAO.getAllUsers();
        request.setAttribute("users", users);

        request.getRequestDispatcher("/views/admin/manageUsers.jsp")
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
        String status    = request.getParameter("status");

        try {
            int userId      = Integer.parseInt(userIdStr);
            UserDAO userDAO = new UserDAO();
            boolean updated = userDAO.updateUserStatus(userId, status);

            if (updated) {
                response.sendRedirect(request.getContextPath()
                        + "/admin/users?success=User status updated successfully.");
            } else {
                response.sendRedirect(request.getContextPath()
                        + "/admin/users?error=Failed to update user status.");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath()
                    + "/admin/users?error=Invalid user ID.");
        }
    }
}