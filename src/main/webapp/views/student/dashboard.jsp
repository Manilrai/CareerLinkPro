<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.careerlink.model.Student" %>
<%
  if (session.getAttribute("userId") == null ||
          !session.getAttribute("role").equals("student")) {
    response.sendRedirect(request.getContextPath() + "/views/common/login.jsp");
    return;
  }
  Student student = (Student) request.getAttribute("student");
%>
<%@ include file="../common/header.jsp" %>

<div class="main-content">

  <div class="page-header">
    <h1>🎓 Student Dashboard</h1>
    <a href="${pageContext.request.contextPath}/student/internships"
       class="btn btn-primary">🔍 Browse Internships</a>
  </div>

  <!-- Welcome Card -->
  <div class="card" style="background: linear-gradient(135deg, #1e3a5f, #2563eb); color:white; margin-bottom:1.5rem;">
    <h2 style="margin-bottom:0.5rem;">
      Welcome back, <%= student != null ? student.getFullName() : "Student" %>! 👋
    </h2>
    <p style="color:#cbd5e1;">
      Find your perfect internship and analyze your skill gaps today.
    </p>
  </div>

  <!-- Stats -->
  <div class="stats-grid">
    <div class="stat-card">
      <h3>${totalApplications}</h3>
      <p>My Applications</p>
    </div>
    <div class="stat-card">
      <h3>${openInternships}</h3>
      <p>Open Internships</p>
    </div>
    <div class="stat-card">
      <h3 style="color:var(--accent);">📊</h3>
      <p>Skill Gap Analyzer</p>
    </div>
  </div>

  <!-- Quick Actions -->
  <div class="card">
    <h2 class="card-title">⚡ Quick Actions</h2>
    <div style="display:flex; gap:1rem; flex-wrap:wrap;">
      <a href="${pageContext.request.contextPath}/student/internships"
         class="btn btn-primary">🔍 Browse Internships</a>
      <a href="${pageContext.request.contextPath}/student/applications"
         class="btn btn-outline">📋 My Applications</a>
      <a href="${pageContext.request.contextPath}/student/profile"
         class="btn btn-outline">👤 My Profile</a>
      <a href="${pageContext.request.contextPath}/student/skills"
         class="btn btn-outline">🛠️ My Skills</a>
      <a href="${pageContext.request.contextPath}/student/wishlist"
         class="btn btn-outline">❤️ Wishlist</a>
    </div>
  </div>

  <!-- Profile Completion Notice -->
  <% if (student != null && (student.getInstitution() == null ||
          student.getInstitution().isEmpty())) { %>
  <div class="alert alert-warning">
    ⚠️ Your profile is incomplete.
    <a href="${pageContext.request.contextPath}/student/profile"
       style="color:var(--secondary); font-weight:700;">
      Complete your profile
    </a>
    to improve your internship applications.
  </div>
  <% } %>

</div>

<%@ include file="../common/footer.jsp" %>