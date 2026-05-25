<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.careerlink.model.Recruiter" %>
<%
  if (session.getAttribute("userId") == null ||
          !session.getAttribute("role").equals("admin")) {
    response.sendRedirect(request.getContextPath() + "/views/common/login.jsp");
    return;
  }
  List<Recruiter> recruiters = (List<Recruiter>) request.getAttribute("recruiters");
%>
<%@ include file="../common/header.jsp" %>

<div class="main-content">

  <div class="page-header">
    <h1>🏢 Manage Recruiters</h1>
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
          <th>Company Name</th>
          <th>Contact Person</th>
          <th>Email</th>
          <th>Industry</th>
          <th>Account Status</th>
          <th>Verified</th>
          <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% if (recruiters == null || recruiters.isEmpty()) { %>
        <tr>
          <td colspan="8" style="text-align:center;
                        color:var(--gray); padding:2rem;">
            No recruiters found.
          </td>
        </tr>
        <% } else {
          int count = 1;
          for (Recruiter r : recruiters) {
            String verified = r.getVerified();
            String status   = r.getStatus();
        %>
        <tr>
          <td><%= count++ %></td>
          <td><strong><%= r.getCompanyName() %></strong></td>
          <td><%= r.getFullName() %></td>
          <td><%= r.getEmail() %></td>
          <td><%= r.getIndustry() != null ? r.getIndustry() : "N/A" %></td>
          <td>
                        <span class="badge <%=
                            status.equals("active")  ? "badge-success" :
                            status.equals("pending") ? "badge-warning" :
                            "badge-danger" %>">
                            <%= status %>
                        </span>
          </td>
          <td>
                        <span class="badge <%=
                            verified.equals("yes")     ? "badge-success" :
                            verified.equals("pending") ? "badge-warning" :
                            "badge-danger" %>">
                            <%= verified %>
                        </span>
          </td>
          <td>
            <form action="${pageContext.request.contextPath}/admin/recruiters"
                  method="post"
                  style="display:flex; gap:0.4rem; flex-wrap:wrap;">
              <input type="hidden" name="userId"
                     value="<%= r.getUserId() %>"/>
              <% if (!verified.equals("yes")) { %>
              <button type="submit" name="action" value="approve"
                      class="btn btn-success"
                      style="padding:0.3rem 0.7rem; font-size:0.8rem;">
                ✅ Approve
              </button>
              <% } %>
              <% if (!verified.equals("no")) { %>
              <button type="submit" name="action" value="reject"
                      class="btn btn-danger"
                      style="padding:0.3rem 0.7rem; font-size:0.8rem;"
                      onclick="return confirm('Reject this recruiter?')">
                ❌ Reject
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