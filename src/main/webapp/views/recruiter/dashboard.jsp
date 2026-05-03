<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.careerlink.model.Internship" %>
<%
    if (session.getAttribute("userId") == null ||
            !session.getAttribute("role").equals("recruiter")) {
        response.sendRedirect(request.getContextPath() + "/views/common/login.jsp");
        return;
    }
    String recruiterName = session.getAttribute("fullName") != null
            ? session.getAttribute("fullName").toString() : "Recruiter";
%>
<%@ include file="../common/header.jsp" %>

<div class="main-content">

    <div class="page-header">
        <h1>👋 Welcome, <%= recruiterName %>!</h1>
        <a href="${pageContext.request.contextPath}/recruiter/postInternship"
           class="btn btn-primary">+ Post New Internship</a>
    </div>

    <% if (request.getAttribute("pending") != null) { %>
    <div class="alert alert-warning">
        ⚠️ Your account is pending admin approval.
    </div>
    <% } %>

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
            <h3 style="color:#2a7a4a;">${openInternships != null ? openInternships : 0}</h3>
            <p>Open Internships</p>
        </div>
        <div class="stat-card">
            <h3 style="color:#4a7cdc;">${shortlisted != null ? shortlisted : 0}</h3>
            <p>Shortlisted Applicants</p>
        </div>
    </div>

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
                    <th>#</th><th>Title</th><th>Location</th>
                    <th>Deadline</th><th>Status</th><th>Applications</th><th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    List<Internship> internships = (List<Internship>) request.getAttribute("internships");
                    if (internships != null && !internships.isEmpty()) {
                        int count = 1;
                        for (Internship internship : internships) {
                %>
                <tr>
                    <td><%= count++ %></td>
                    <td><strong><%= internship.getTitle() %></strong></td>
                    <td><%= internship.getLocation() %></td>
                    <td><%= internship.getDeadline() %></td>
                    <td>
                        <span class="badge <%= internship.getStatus().equals("open") ? "badge-success" : "badge-danger" %>">
                            <%= internship.getStatus() %>
                        </span>
                    </td>
                    <td><%= internship.getApplicationCount() %></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/recruiter/applicants?id=<%= internship.getInternshipId() %>"
                           class="btn btn-primary" style="padding:0.3rem 0.8rem; font-size:0.8rem;">
                            View Applicants
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