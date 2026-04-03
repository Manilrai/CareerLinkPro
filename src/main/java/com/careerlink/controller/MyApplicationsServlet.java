package com.careerlink.controller;

import com.careerlink.dao.ApplicationDAO;
import com.careerlink.model.Application;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/student/applications")
public class MyApplicationsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (session.getAttribute("userId") == null ||
                !session.getAttribute("role").equals("student")) {
            response.sendRedirect(request.getContextPath()
                    + "/views/common/login.jsp");
            return;
        }

        int studentId = (int) session.getAttribute("studentId");

        // Check for success/error messages
        String success = request.getParameter("success");
        String error   = request.getParameter("error");
        if (success != null) request.setAttribute("success", success);
        if (error   != null) request.setAttribute("error",   error);

        ApplicationDAO dao = new ApplicationDAO();
        List<Application> applications =
                dao.getApplicationsByStudentId(studentId);

        request.setAttribute("applications", applications);
        request.getRequestDispatcher("/views/student/myApplications.jsp")
                .forward(request, response);
    }
}