<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.careerlink.model.Internship" %>
<%
  if (session.getAttribute("userId") == null ||
          !session.getAttribute("role").equals("admin")) {
    response.sendRedirect(request.getContextPath() + "/views/common/login.jsp");
    return;
  }
  List<Internship> internships =
          (List<Internship>) request.getAttribute("internships");
%>
<%@ include file="../common/header.jsp" %>

<div class="main-content">

  <div class="page-header">
    <h1>📋 Manage Internships</h1>
    <a href="${pageContext.request.contextPath}/admin/dashboard"
       class="btn btn-outline">← Dashboard</a>
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
    <div class="table-container">
      <table>
        <thead>
        <tr>
          <th>#</th>
          <th>Title</th>
          <th>Company</th>
          <th>Location</th>
          <th>Deadline</th>
          <th>Applications</th>
          <th>Status</th>
          <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% if (internships == null || internships.isEmpty()) { %>
        <tr>
          <td colspan="8" style="text-align:center;
                        color:var(--gray); padding:2rem;">
            No internships found.
          </td>
        </tr>
        <% } else {
          int count = 1;
          for (Internship i : internships) { %>
        <tr>
          <td><%= count++ %></td>
          <td><strong><%= i.getTitle() %></strong></td>
          <td><%= i.getCompanyName() %></td>
          <td><%= i.getLocation() %></td>
          <td><%= i.getDeadline() %></td>
          <td>
                        <span class="badge badge-info">
                            <%= i.getApplicationCount() %>
                        </span>
          </td>
          <td>
                        <span class="badge <%=
                            i.getStatus().equals("open")
                            ? "badge-success" : "badge-danger" %>">
                            <%= i.getStatus() %>
                        </span>
          </td>
          <td>
            <a href="${pageContext.request.contextPath}/admin/internships?action=delete&id=<%= i.getInternshipId() %>"
               class="btn btn-danger"
               style="padding:0.3rem 0.7rem; font-size:0.8rem;"
               onclick="return confirm('Delete this internship?')">
              🗑️ Delete
            </a>
          </td>
        </tr>
        <% } } %>
        </tbody>
      </table>
    </div>
  </div>
</div>

<%@ include file="../common/footer.jsp" %>