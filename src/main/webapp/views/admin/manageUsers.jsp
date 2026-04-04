<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.careerlink.model.User" %>
<%
  if (session.getAttribute("userId") == null ||
          !session.getAttribute("role").equals("admin")) {
    response.sendRedirect(request.getContextPath() + "/views/common/login.jsp");
    return;
  }
  List<User> users = (List<User>) request.getAttribute("users");
%>
<%@ include file="../common/header.jsp" %>

<div class="main-content">

  <div class="page-header">
    <h1>👥 Manage Users</h1>
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
          <th>Full Name</th>
          <th>Email</th>
          <th>Phone</th>
          <th>Role</th>
          <th>Status</th>
          <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% if (users == null || users.isEmpty()) { %>
        <tr>
          <td colspan="7" style="text-align:center;
                        color:var(--gray); padding:2rem;">
            No users found.
          </td>
        </tr>
        <% } else {
          int count = 1;
          for (User user : users) {
            String status = user.getStatus();
            String badgeClass =
                    status.equals("active")  ? "badge-success" :
                            status.equals("pending") ? "badge-warning" :
                                    "badge-danger";
        %>
        <tr>
          <td><%= count++ %></td>
          <td><strong><%= user.getFullName() %></strong></td>
          <td><%= user.getEmail() %></td>
          <td><%= user.getPhone() %></td>
          <td>
                        <span class="badge <%=
                            user.getRole().equals("student")
                            ? "badge-info" : "badge-warning" %>">
                            <%= user.getRole() %>
                        </span>
          </td>
          <td>
                        <span class="badge <%= badgeClass %>">
                            <%= status %>
                        </span>
          </td>
          <td>
            <form action="${pageContext.request.contextPath}/admin/users"
                  method="post"
                  style="display:flex; gap:0.4rem; flex-wrap:wrap;">
              <input type="hidden" name="userId"
                     value="<%= user.getUserId() %>"/>
              <% if (!status.equals("active")) { %>
              <button type="submit" name="status" value="active"
                      class="btn btn-success"
                      style="padding:0.3rem 0.7rem; font-size:0.8rem;">
                Activate
              </button>
              <% } %>
              <% if (!status.equals("inactive")) { %>
              <button type="submit" name="status" value="inactive"
                      class="btn btn-danger"
                      style="padding:0.3rem 0.7rem; font-size:0.8rem;"
                      onclick="return confirm('Deactivate this user?')">
                Deactivate
              </button>
              <% } %>
            </form>
          </td>
        </tr>
        <% } } %>
        </tbody>
      </table>
    </div>
  </div>
</div>

<%@ include file="../common/footer.jsp" %>