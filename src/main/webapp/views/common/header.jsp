<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String role = (session.getAttribute("role") != null)
            ? session.getAttribute("role").toString() : "";
    String fullName = (session.getAttribute("fullName") != null)
            ? session.getAttribute("fullName").toString() : "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CareerLink Pro</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<nav class="navbar">
    <div class="logo">Career<span>Link</span> Pro</div>

    <div class="hamburger" onclick="toggleMenu()">
        <span></span>
        <span></span>
        <span></span>
    </div>

    <ul class="nav-links" id="navLinks">
        <% if (role.equals("admin")) { %>
        <li><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/users">Users</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/internships">Internships</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/recruiters">Recruiters</a></li>
        <li><a href="${pageContext.request.contextPath}/logout" class="btn-nav">Logout</a></li>

        <% } else if (role.equals("recruiter")) { %>
        <li><a href="${pageContext.request.contextPath}/recruiter/dashboard">Dashboard</a></li>
        <li><a href="${pageContext.request.contextPath}/recruiter/internships">My Internships</a></li>
        <li><a href="${pageContext.request.contextPath}/recruiter/applicants">Applicants</a></li>
        <li><a href="${pageContext.request.contextPath}/logout" class="btn-nav">Logout</a></li>

        <% } else if (role.equals("student")) { %>
        <li><a href="${pageContext.request.contextPath}/student/dashboard">Dashboard</a></li>
        <li><a href="${pageContext.request.contextPath}/student/internships">Internships</a></li>
        <li><a href="${pageContext.request.contextPath}/student/applications">My Applications</a></li>
        <li><a href="${pageContext.request.contextPath}/student/wishlist">Wishlist</a></li>
        <li><a href="${pageContext.request.contextPath}/logout" class="btn-nav">Logout</a></li>

        <% } else { %>
        <li><a href="${pageContext.request.contextPath}/views/common/about.jsp">About</a></li>
        <li><a href="${pageContext.request.contextPath}/views/common/contact.jsp">Contact</a></li>
        <li><a href="${pageContext.request.contextPath}/views/common/login.jsp">Login</a></li>
        <li><a href="${pageContext.request.contextPath}/views/common/register.jsp" class="btn-nav">Register</a></li>
        <% } %>
    </ul>
</nav>