<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.careerlink.model.Application" %>
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
        <h1>👥 Applicants for: <span style="color:var(--primary);">${internshipTitle}</span></h1>
        <a href="${pageContext.request.contextPath}/recruiter/internships"
           class="btn btn-outline">← Back to Internships</a>
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
                    <th>Student Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Applied Date</th>
                    <th>Current Status</th>
                    <th>Update Status</th>
                </tr>
                </thead>
                <tbody>
                <%
                    List<Application> applicants =
                            (List<Application>) request.getAttribute("applicants");
                    if (applicants != null && !applicants.isEmpty()) {
                        int count = 1;
                        for (Application a : applicants) {
                            String status = a.getStatus() != null
                                    ? a.getStatus() : "pending";
                            String badgeClass = "badge-warning";
                            if (status.equals("shortlisted")) badgeClass = "badge-info";
                            else if (status.equals("accepted")) badgeClass = "badge-success";
                            else if (status.equals("rejected")) badgeClass = "badge-danger";
                %>
                <tr>
                    <td><%= count++ %></td>
                    <td><%= a.getFullName() != null ? a.getFullName() : "N/A" %></td>
                    <td><%= a.getEmail()    != null ? a.getEmail()    : "N/A" %></td>
                    <td><%= a.getPhone()    != null ? a.getPhone()    : "N/A" %></td>
                    <td><%= a.getAppliedAt() %></td>
                    <td>
                        <span class="badge <%= badgeClass %>"><%= status %></span>
                    </td>
                    <td>
                        <form action="${pageContext.request.contextPath}/recruiter/applicants"
                              method="post"
                              style="display:flex; gap:0.5rem; align-items:center;">
                            <input type="hidden" name="applicationId"
                                   value="<%= a.getApplicationId() %>"/>
                            <input type="hidden" name="internshipId"
                                   value="<%= a.getInternshipId() %>"/>
                            <select name="status"
                                    style="padding:0.4rem; border:1px solid var(--border);
                                           border-radius:var(--radius); font-size:0.85rem;">
                                <option value="pending"     <%= status.equals("pending")     ? "selected" : "" %>>Pending</option>
                                <option value="shortlisted" <%= status.equals("shortlisted") ? "selected" : "" %>>Shortlisted</option>
                                <option value="accepted"    <%= status.equals("accepted")    ? "selected" : "" %>>Accepted</option>
                                <option value="rejected"    <%= status.equals("rejected")    ? "selected" : "" %>>Rejected</option>
                            </select>
                            <button type="submit" class="btn btn-primary"
                                    style="padding:0.3rem 0.8rem; font-size:0.8rem;">
                                Update
                            </button>
                        </form>
                    </td>
                </tr>
                <% } } else { %>
                <tr>
                    <td colspan="7" style="text-align:center; color:var(--gray); padding:2rem;">
                        No applicants yet for this internship.
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>