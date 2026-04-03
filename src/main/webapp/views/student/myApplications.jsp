<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.careerlink.model.Application" %>
<%
  if (session.getAttribute("userId") == null ||
          !session.getAttribute("role").equals("student")) {
    response.sendRedirect(request.getContextPath() + "/views/common/login.jsp");
    return;
  }
  List<Application> applications =
          (List<Application>) request.getAttribute("applications");
%>
<%@ include file="../common/header.jsp" %>

<div class="main-content">

  <div class="page-header">
    <h1>📋 My Applications</h1>
    <a href="${pageContext.request.contextPath}/student/internships"
       class="btn btn-primary">🔍 Browse More</a>
  </div>

  <% if (request.getAttribute("success") != null) { %>
  <div class="alert alert-success">
    <%= request.getAttribute("success") %>
  </div>
  <% } %>
  <% if (request.getAttribute("error") != null) { %>
  <div class="alert alert-danger">
    <%= request.getAttribute("error") %>
  </div>
  <% } %>

  <div class="card">
    <% if (applications == null || applications.isEmpty()) { %>
    <div style="text-align:center; padding:3rem;">
      <p style="font-size:1.2rem; color:var(--gray);">
        😔 You have not applied for any internships yet.
      </p>
      <a href="${pageContext.request.contextPath}/student/internships"
         class="btn btn-primary" style="margin-top:1rem;">
        Browse Internships
      </a>
    </div>
    <% } else { %>
    <div class="table-container">
      <table>
        <thead>
        <tr>
          <th>#</th>
          <th>Internship Title</th>
          <th>Company</th>
          <th>Applied Date</th>
          <th>Status</th>
        </tr>
        </thead>
        <tbody>
        <%
          int count = 1;
          for (Application app : applications) {
            String status = app.getStatus();
            String badgeClass = "badge-gray";
            if (status.equals("shortlisted"))
              badgeClass = "badge-info";
            else if (status.equals("accepted"))
              badgeClass = "badge-success";
            else if (status.equals("rejected"))
              badgeClass = "badge-danger";
            else if (status.equals("pending"))
              badgeClass = "badge-warning";
        %>
        <tr>
          <td><%= count++ %></td>
          <td><strong><%= app.getInternshipTitle() %></strong></td>
          <td><%= app.getFullName() %></td>
          <td><%= app.getAppliedAt() != null
                  ? app.getAppliedAt().toString().substring(0, 10)
                  : "N/A" %></td>
          <td>
                            <span class="badge <%= badgeClass %>">
                                <%= status.substring(0,1).toUpperCase()
                                        + status.substring(1) %>
                            </span>
          </td>
        </tr>
        <% } %>
        </tbody>
      </table>
    </div>
    <p style="margin-top:1rem; color:var(--gray); font-size:0.9rem;">
      Total applications: <%= applications.size() %>
    </p>
    <% } %>
  </div>
</div>

<%@ include file="../common/footer.jsp" %>