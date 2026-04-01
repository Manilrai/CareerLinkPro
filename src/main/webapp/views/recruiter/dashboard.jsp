<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%
    // Redirect if not logged in as recruiter
    if (session.getAttribute("userId") == null ||
            !session.getAttribute("role").equals("recruiter")) {
        response.sendRedirect(request.getContextPath() + "/views/common/login.jsp");
        return;
    }
    String fullName = session.getAttribute("fullName").toString();
%>
<%@ include file="../common/header.jsp" %>

<div class="main-content">

    <!-- Welcome Header -->
    <div class="page-header">
        <h1>👋 Welcome, <%= fullName %>!</h1>
        <a href="${pageContext.request.contextPath}/recruiter/postInternship"
           class="btn btn-primary">+ Post New Internship</a>
    </div>

    <!-- Pending Approval Notice -->
    <% if (request.getAttribute("pending") != null) { %>
    <div class="alert alert-warning">
        ⚠️ Your account is pending admin approval.
        Some features may be limited until approved.
    </div>
    <% } %>

    <!-- Stats Cards -->
    <div class="stats-grid">
        <div class="stat-card">
            <h3>${totalInternships != null ? totalInternships : 0}</h3>
            <p>Total Internships Posted</p>
        </div>
        <div class="stat-card">
            <h3>${totalApplications != null ? totalApplications : 0}</h3>
            <p>Total Applications Received</p>
        </div>
        <div class="stat-card">
            <h3>${openInternships != null ? openInternships : 0}</h3>
            <p>Open Internships</p>
        </div>
        <div class="stat-card">
            <h3>${shortlisted != null ? shortlisted : 0}</h3>
            <p>Shortlisted Applicants</p>
        </div>
    </div>

    <!-- Recent Internships Table -->
    <div class="card">
        <div class="page-header">
            <h2 class="card-title">📋 My Recent Internships</h2>
            <a href="${pageContext.request.contextPath}/recruiter/internships"
               class="btn btn-outline">View All</a>
        </div>

        <div class="table-container">
            <table>
                <thead>
                <tr>
                    <th>#</th>
                    <th>Title</th>
                    <th>Location</th>
                    <th>Deadline</th>
                    <th>Status</th>
                    <th>Applications</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    List internships = (List) request.getAttribute("internships");
                    if (internships != null && !internships.isEmpty()) {
                        int count = 1;
                        for (Object obj : internships) {
                            Map internship = (Map) obj;
                %>
                <tr>
                    <td><%= count++ %></td>
                    <td><%= internship.get("title") %></td>
                    <td><%= internship.get("location") %></td>
                    <td><%= internship.get("deadline") %></td>
                    <td>
                            <span class="badge <%= internship.get("status").equals("open") ? "badge-success" : "badge-danger" %>">
                                <%= internship.get("status") %>
                            </span>
                    </td>
                    <td><%= internship.get("applicationCount") %></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/recruiter/applicants?id=<%= internship.get("internshipId") %>"
                           class="btn btn-primary" style="padding:0.3rem 0.8rem; font-size:0.8rem;">
                            View
                        </a>
                    </td>
                </tr>
                <%  }
                } else { %>
                <tr>
                    <td colspan="7" style="text-align:center; color:var(--gray); padding:2rem;">
                        No internships posted yet.
                        <a href="${pageContext.request.contextPath}/recruiter/postInternship"
                           style="color:var(--primary);">Post your first one!</a>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>