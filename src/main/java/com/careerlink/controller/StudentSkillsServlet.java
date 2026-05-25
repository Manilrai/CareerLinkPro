package com.careerlink.controller;

import com.careerlink.dao.StudentDAO;
import com.careerlink.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/student/skills")
public class StudentSkillsServlet extends HttpServlet {

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
        StudentDAO studentDAO = new StudentDAO();
        List<String> skills = studentDAO.getSkillsByStudentId(studentId);

        request.setAttribute("skills", skills);
        request.getRequestDispatcher("/views/student/mySkills.jsp")
                .forward(request, response);
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (session.getAttribute("userId") == null ||
                !session.getAttribute("role").equals("student")) {
            response.sendRedirect(request.getContextPath()
                    + "/views/common/login.jsp");
            return;
        }

        int studentId  = (int) session.getAttribute("studentId");
        String action  = request.getParameter("action");
        StudentDAO dao = new StudentDAO();

        if ("add".equals(action)) {
            String skillName = request.getParameter("skillName");
            if (ValidationUtil.isEmpty(skillName)) {
                request.setAttribute("error", "Skill name cannot be empty.");
            } else {
                boolean added = dao.addSkill(studentId, skillName);
                if (added) {
                    request.setAttribute("success",
                            "Skill '" + skillName + "' added successfully!");
                } else {
                    request.setAttribute("error", "Failed to add skill.");
                }
            }
        } else if ("delete".equals(action)) {
            String skillIdStr = request.getParameter("skillId");
            try {
                int skillId      = Integer.parseInt(skillIdStr);
                boolean deleted  = dao.deleteSkill(skillId);
                if (deleted) {
                    request.setAttribute("success", "Skill removed successfully.");
                } else {
                    request.setAttribute("error", "Failed to remove skill.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid skill ID.");
            }
        }

        // Reload skills list
        List<String> skills = dao.getSkillsByStudentId(studentId);
        request.setAttribute("skills", skills);
        request.getRequestDispatcher("/views/student/mySkills.jsp")
                .forward(request, response);
    }
}