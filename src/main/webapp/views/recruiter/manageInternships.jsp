<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%
    if (session.getAttribute("userId") == null ||
            !session.getAttribute("role").equals("recruiter")) {
        response.sendRedirect(request.getContextPath() + "/views/common/login.jsp");
        return;
    }
%>
<%@ include file="../common/header.jsp" %>

<div class="main-content">

    <div class="page-header">
        <h1>📋 My Internships</h1>
        <a href="${pageContext.request.contextPath}/recruiter/postInternship"
           class="btn btn-primary">+ Post New</a>
    </div>

    <% if (request.getAttribute("success") != null) { %>
    <div class="alert alert-success"><%= request.getAttribute("success") %></div>
    <% } %>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>

    <div class="card">
        <div class="table-container">
            <table>
                <thead>
                <tr>
                    <th>#</th>
                    <th>Title</th>
                    <th>Location</th>
                    <th>Duration</th>
                    <th>Deadline</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    List internships = (List) request.getAttribute("internships");
                    if (internships != null && !internships.isEmpty()) {
                        int count = 1;
                        for (Object obj : internships) {
                            Map i = (Map) obj;
                %>
                <tr>
                    <td><%= count++ %></td>
                    <td><%= i.get("title") %></td>
                    <td><%= i.get("location") %></td>
                    <td><%= i.get("duration") %></td>
                    <td><%= i.get("deadline") %></td>
                    <td>
                        <span class="badge <%= i.get("status").equals("open") ? "badge-success" : "badge-danger" %>">
                            <%= i.get("status") %>
                        </span>
                    </td>
                    <td style="display:flex; gap:0.5rem; flex-wrap:wrap;">
                        <a href="${pageContext.request.contextPath}/recruiter/editInternship?id=<%= i.get("internshipId") %>"
                           class="btn btn-warning" style="padding:0.3rem 0.8rem; font-size:0.8rem;">Edit</a>
                        <a href="${pageContext.request.contextPath}/recruiter/applicants?id=<%= i.get("internshipId") %>"
                           class="btn btn-primary" style="padding:0.3rem 0.8rem; font-size:0.8rem;">Applicants</a>
                        <a href="${pageContext.request.contextPath}/recruiter/deleteInternship?id=<%= i.get("internshipId") %>"
                           class="btn btn-danger" style="padding:0.3rem 0.8rem; font-size:0.8rem;"
                           onclick="return confirm('Are you sure you want to delete this internship?')">Delete</a>
                    </td>
                </tr>
                <% } } else { %>
                <tr>
                    <td colspan="7" style="text-align:center; color:var(--gray); padding:2rem;">
                        No internships found.
                        <a href="${pageContext.request.contextPath}/recruiter/postInternship"
                           style="color:var(--primary);">Post your first internship!</a>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
