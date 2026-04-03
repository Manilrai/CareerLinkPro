<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  if (session.getAttribute("userId") == null ||
          !session.getAttribute("role").equals("admin")) {
    response.sendRedirect(request.getContextPath() + "/views/common/login.jsp");
    return;
  }
%>
<%@ include file="../common/header.jsp" %>

<div class="main-content">

  <div class="page-header">
    <h1>🛡️ Admin Dashboard</h1>
    <span style="color:var(--gray); font-size:0.9rem;">
            Welcome back, <%= session.getAttribute("fullName") %>
        </span>
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
      <h3>${totalRecruiters}</h3>
      <p>Recruiters</p>
    </div>
    <div class="stat-card">
      <h3 style="color:var(--warning);">${pendingRecruiters}</h3>
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

  <!-- Quick Links -->
  <div class="card">
    <h2 class="card-title">⚡ Quick Actions</h2>
    <div style="display:flex; gap:1rem; flex-wrap:wrap;">
      <a href="${pageContext.request.contextPath}/admin/users"
         class="btn btn-primary">👥 Manage Users</a>
      <a href="${pageContext.request.contextPath}/admin/recruiters"
         class="btn btn-warning">🏢 Approve Recruiters
        <% if ((int)request.getAttribute("pendingRecruiters") > 0) { %>
        (${pendingRecruiters} pending)
        <% } %>
      </a>
      <a href="${pageContext.request.contextPath}/admin/internships"
         class="btn btn-success">📋 Manage Internships</a>
    </div>
  </div>

</div>

<%@ include file="../common/footer.jsp" %>