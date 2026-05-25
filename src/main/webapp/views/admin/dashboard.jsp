<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  if (session.getAttribute("userId") == null ||
          !"admin".equalsIgnoreCase((String) session.getAttribute("role"))) {
    response.sendRedirect(request.getContextPath() + "/views/common/login.jsp");
    return;
  }
  String adminName = (String) session.getAttribute("fullName");
  if (adminName == null) adminName = "Admin";

  Integer pending = (Integer) request.getAttribute("pendingRecruiters");
  if (pending == null) pending = 0;
%>
<%@ include file="../common/header.jsp" %>

<div class="main-content">

  <div class="page-header">
    <h1>📊 Admin Dashboard</h1>
    <a href="${pageContext.request.contextPath}/admin/recruiters"
       class="btn btn-primary">✅ Review Pending</a>
  </div>

  <!-- Welcome Card -->
  <div class="card" style="background: linear-gradient(135deg, #1e3a5f, #2563eb); color:white; margin-bottom:1.5rem;">
    <h2 style="margin-bottom:0.5rem;">
      Welcome back, <%= adminName %>! 👋
    </h2>
    <p style="color:#cbd5e1;">
      Manage users, recruiters and internships from one central panel.
    </p>
  </div>

  <!-- Stats -->
  <div class="stats-grid">
    <div class="stat-card">
      <h3>${totalUsers}</h3>
      <p>Total Users</p>
    </div>
    <div class="stat-card">
      <h3>${totalStudents}</h3>
      <p>Students</p>
    </div>
    <div class="stat-card">
      <h3 style="color:#2a7a4a;">${totalRecruiters}</h3>
      <p>Recruiters</p>
    </div>
    <div class="stat-card">
      <h3 style="color:#c03030;">${pendingRecruiters}</h3>
      <p>Pending Approvals</p>
    </div>
    <div class="stat-card">
      <h3>${totalInternships}</h3>
      <p>Internships</p>
    </div>
    <div class="stat-card">
      <h3>${totalApplications}</h3>
      <p>Applications</p>
    </div>
  </div>

  <!-- Quick Actions -->
  <div class="card">
    <h2 class="card-title">⚡ Quick Actions</h2>
    <div style="display:flex; gap:1rem; flex-wrap:wrap;">
      <a href="${pageContext.request.contextPath}/admin/users"
         class="btn btn-primary">👥 Manage Users</a>
      <a href="${pageContext.request.contextPath}/admin/recruiters"
         class="btn btn-outline">🏢 Manage Recruiters</a>
      <a href="${pageContext.request.contextPath}/admin/internships"
         class="btn btn-outline">💼 Manage Internships</a>
    </div>
  </div>

  <!-- Pending Approvals Notice -->
  <% if (pending > 0) { %>
  <div class="alert alert-warning" style="margin-top:1.5rem;">
    ⚠️ You have <strong><%= pending %></strong>
    pending recruiter approval<%= pending > 1 ? "s" : "" %>.
    <a href="${pageContext.request.contextPath}/admin/recruiters"
       style="font-weight:700; text-decoration:underline;">
      Review now
    </a>
  </div>
  <% } %>

</div>

<%@ include file="../common/footer.jsp" %>