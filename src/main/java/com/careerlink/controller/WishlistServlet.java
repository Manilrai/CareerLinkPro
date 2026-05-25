package com.careerlink.controller;

import com.careerlink.dao.WishlistDAO;
import com.careerlink.model.Internship;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/student/wishlist")
public class WishlistServlet extends HttpServlet {

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

        String success = request.getParameter("success");
        String error   = request.getParameter("error");
        if (success != null) request.setAttribute("success", success);
        if (error   != null) request.setAttribute("error",   error);

        WishlistDAO wishlistDAO = new WishlistDAO();
        List<Internship> wishlist = wishlistDAO.getWishlist(studentId);

        request.setAttribute("wishlist", wishlist);
        request.getRequestDispatcher("/views/student/wishlist.jsp")
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

        int studentId          = (int) session.getAttribute("studentId");
        String action          = request.getParameter("action");
        String internshipIdStr = request.getParameter("internshipId");

        try {
            int internshipId    = Integer.parseInt(internshipIdStr);
            WishlistDAO dao     = new WishlistDAO();

            if ("add".equals(action)) {
                if (dao.isWishlisted(studentId, internshipId)) {
                    response.sendRedirect(request.getContextPath()
                            + "/student/wishlist?error=Already in your wishlist.");
                    return;
                }
                boolean added = dao.addToWishlist(studentId, internshipId);
                if (added) {
                    response.sendRedirect(request.getContextPath()
                            + "/student/wishlist?success=Added to wishlist!");
                } else {
                    response.sendRedirect(request.getContextPath()
                            + "/student/wishlist?error=Failed to add to wishlist.");
                }
            } else if ("remove".equals(action)) {
                boolean removed = dao.removeFromWishlist(studentId, internshipId);
                if (removed) {
                    response.sendRedirect(request.getContextPath()
                            + "/student/wishlist?success=Removed from wishlist.");
                } else {
                    response.sendRedirect(request.getContextPath()
                            + "/student/wishlist?error=Failed to remove.");
                }
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath()
                    + "/student/wishlist");
        }
    }
}