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
        <h1>👥 Applicants for: <span style="color:var(--primary);">${internshipTitle}</span></h1>
        <a href="${pageContext.request.contextPath}/recruiter/internships"
           class="btn btn-outline">← Back to Internships</a>
    </div>

    <% if (request.getAttribute("success") != null) { %>
    <div class="alert alert-success"><%= request.getAttribute("success") %></div>
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
                    List applicants = (List) request.getAttribute("applicants");
                    if (applicants != null && !applicants.isEmpty()) {
                        int count = 1;
                        for (Object obj : applicants) {
                            Map a = (Map) obj;
                %>
                <tr>
                    <td><%= count++ %></td>
                    <td><%= a.get("fullName") %></td>
                    <td><%= a.get("email") %></td>
                    <td><%= a.get("phone") %></td>
                    <td><%= a.get("appliedAt") %></td>
                    <td>
                        <%
                            String status = a.get("status").toString();
                            String badgeClass = "badge-gray";
                            if (status.equals("shortlisted")) badgeClass = "badge-info";
                            else if (status.equals("accepted")) badgeClass = "badge-success";
                            else if (status.equals("rejected")) badgeClass = "badge-danger";
                            else if (status.equals("pending")) badgeClass = "badge-warning";
                        %>
                        <span class="badge <%= badgeClass %>"><%= status %></span>
                    </td>
                    <td>
                        <form action="${pageContext.request.contextPath}/recruiter/updateStatus"
                              method="post" style="display:flex; gap:0.5rem; align-items:center;">
                            <input type="hidden" name="applicationId"
                                   value="<%= a.get("applicationId") %>"/>
                            <input type="hidden" name="internshipId"
                                   value="<%= a.get("internshipId") %>"/>
                            <select name="status"
                                    style="padding:0.4rem; border:1px solid var(--border); border-radius:var(--radius); font-size:0.85rem;">
                                <option value="pending"
                                        <%= status.equals("pending") ? "selected" : "" %>>Pending</option>
                                <option value="shortlisted"
                                        <%= status.equals("shortlisted") ? "selected" : "" %>>Shortlisted</option>
                                <option value="accepted"
                                        <%= status.equals("accepted") ? "selected" : "" %>>Accepted</option>
                                <option value="rejected"
                                        <%= status.equals("rejected") ? "selected" : "" %>>Rejected</option>
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

<%@ include file="../common/footer.jsp" %><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
        <h1>👥 Applicants for: <span style="color:var(--primary);">${internshipTitle}</span></h1>
        <a href="${pageContext.request.contextPath}/recruiter/internships"
           class="btn btn-outline">← Back to Internships</a>
    </div>

    <% if (request.getAttribute("success") != null) { %>
    <div class="alert alert-success"><%= request.getAttribute("success") %></div>
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
                    List applicants = (List) request.getAttribute("applicants");
                    if (applicants != null && !applicants.isEmpty()) {
                        int count = 1;
                        for (Object obj : applicants) {
                            Map a = (Map) obj;
                %>
                <tr>
                    <td><%= count++ %></td>
                    <td><%= a.get("fullName") %></td>
                    <td><%= a.get("email") %></td>
                    <td><%= a.get("phone") %></td>
                    <td><%= a.get("appliedAt") %></td>
                    <td>
                        <%
                            String status = a.get("status").toString();
                            String badgeClass = "badge-gray";
                            if (status.equals("shortlisted")) badgeClass = "badge-info";
                            else if (status.equals("accepted")) badgeClass = "badge-success";
                            else if (status.equals("rejected")) badgeClass = "badge-danger";
                            else if (status.equals("pending")) badgeClass = "badge-warning";
                        %>
                        <span class="badge <%= badgeClass %>"><%= status %></span>
                    </td>
                    <td>
                        <form action="${pageContext.request.contextPath}/recruiter/updateStatus"
                              method="post" style="display:flex; gap:0.5rem; align-items:center;">
                            <input type="hidden" name="applicationId"
                                   value="<%= a.get("applicationId") %>"/>
                            <input type="hidden" name="internshipId"
                                   value="<%= a.get("internshipId") %>"/>
                            <select name="status"
                                    style="padding:0.4rem; border:1px solid var(--border); border-radius:var(--radius); font-size:0.85rem;">
                                <option value="pending"
                                        <%= status.equals("pending") ? "selected" : "" %>>Pending</option>
                                <option value="shortlisted"
                                        <%= status.equals("shortlisted") ? "selected" : "" %>>Shortlisted</option>
                                <option value="accepted"
                                        <%= status.equals("accepted") ? "selected" : "" %>>Accepted</option>
                                <option value="rejected"
                                        <%= status.equals("rejected") ? "selected" : "" %>>Rejected</option>
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