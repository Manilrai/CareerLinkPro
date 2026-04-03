<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.careerlink.model.Internship" %>
<%
  if (session.getAttribute("userId") == null ||
          !session.getAttribute("role").equals("student")) {
    response.sendRedirect(request.getContextPath() + "/views/common/login.jsp");
    return;
  }
  Internship internship      = (Internship) request.getAttribute("internship");
  List<String> requiredSkills = (List<String>) request.getAttribute("requiredSkills");
  List<String> studentSkills  = (List<String>) request.getAttribute("studentSkills");
  List<String> missingSkills  = (List<String>) request.getAttribute("missingSkills");
  int matchPercentage         = (int) request.getAttribute("matchPercentage");

  // Convert student skills to lowercase for comparison
  List<String> studentSkillsLower = new ArrayList<>();
  if (studentSkills != null) {
    for (String s : studentSkills) {
      studentSkillsLower.add(s.toLowerCase().trim());
    }
  }
%>
<%@ include file="../common/header.jsp" %>

<div class="main-content">

  <div class="page-header">
    <h1>📊 Skill Gap Analysis</h1>
    <a href="${pageContext.request.contextPath}/student/internships"
       class="btn btn-outline">← Back to Internships</a>
  </div>

  <!-- Internship Info -->
  <div class="card">
    <h2 style="margin-bottom:0.3rem;"><%= internship.getTitle() %></h2>
    <p style="color:var(--primary); font-weight:600; margin-bottom:0.5rem;">
      🏢 <%= internship.getCompanyName() %>
    </p>
    <div style="display:flex; flex-wrap:wrap; gap:1.5rem;
                    color:var(--gray); font-size:0.9rem;">
      <span>📍 <%= internship.getLocation() %></span>
      <span>⏱️ <%= internship.getDuration() %></span>
      <span>💰 <%= internship.getStipend() %></span>
      <span>📅 Deadline: <%= internship.getDeadline() %></span>
    </div>
  </div>

  <!-- Match Score -->
  <div class="card" style="text-align:center;">
    <h2 style="margin-bottom:1rem;">Your Skill Match Score</h2>

    <!-- Progress bar -->
    <div style="background:var(--border); border-radius:999px;
                    height:24px; margin:0 auto 1rem;
                    max-width:500px; overflow:hidden;">
      <div style="height:100%; width:<%= matchPercentage %>%;
              background:<%= matchPercentage >= 80 ? "#22c55e" :
                                       matchPercentage >= 50 ? "#f59e0b" :
                                       "#ef4444" %>;
              border-radius:999px;
              transition:width 0.5s ease;
              display:flex; align-items:center;
              justify-content:center; color:white;
              font-weight:700; font-size:0.85rem;">
        <%= matchPercentage %>%
      </div>
    </div>

    <% if (matchPercentage == 100) { %>
    <div class="alert alert-success" style="max-width:500px; margin:0 auto;">
      🎉 <strong>Perfect Match!</strong>
      You have ALL the required skills for this internship!
    </div>
    <% } else if (matchPercentage >= 50) { %>
    <div class="alert alert-warning" style="max-width:500px; margin:0 auto;">
      ⚡ <strong>Good Match!</strong>
      You have most skills but are missing a few.
    </div>
    <% } else { %>
    <div class="alert alert-danger" style="max-width:500px; margin:0 auto;">
      📚 <strong>Skill Gap Detected.</strong>
      Consider improving your skills before applying.
    </div>
    <% } %>
  </div>

  <!-- Skills Comparison -->
  <div style="display:flex; gap:2rem; flex-wrap:wrap;">

    <!-- Required Skills -->
    <div class="card" style="flex:1; min-width:220px;">
      <h2 class="card-title">📋 Required Skills</h2>
      <% if (requiredSkills == null || requiredSkills.isEmpty()) { %>
      <p style="color:var(--gray);">No specific skills listed.</p>
      <% } else {
        for (String skill : requiredSkills) {
          boolean hasIt = studentSkillsLower.contains(
                  skill.toLowerCase().trim());
      %>
      <div style="display:flex; align-items:center; gap:0.8rem;
                        padding:0.6rem 0;
                        border-bottom:1px solid var(--border);">
                <span style="font-size:1.2rem;">
                    <%= hasIt ? "✅" : "❌" %>
                </span>
        <span style="font-weight:<%= hasIt ? "600" : "400" %>;
                color:<%= hasIt ? "var(--success)" :
                                              "var(--danger)" %>;">
                    <%= skill %>
                </span>
        <span class="badge <%= hasIt ? "badge-success" : "badge-danger" %>"
              style="margin-left:auto;">
                    <%= hasIt ? "You have it" : "Missing" %>
                </span>
      </div>
      <% } } %>
    </div>

    <!-- Missing Skills -->
    <div class="card" style="flex:1; min-width:220px;">
      <h2 class="card-title">🚨 Missing Skills</h2>
      <% if (missingSkills == null || missingSkills.isEmpty()) { %>
      <div class="alert alert-success">
        ✅ You have all required skills!
      </div>
      <% } else { %>
      <p style="color:var(--gray); margin-bottom:1rem; font-size:0.9rem;">
        You need to learn these <%= missingSkills.size() %> skill(s):
      </p>
      <% for (String skill : missingSkills) { %>
      <div style="display:flex; align-items:center; gap:0.8rem;
                            padding:0.6rem 1rem; margin-bottom:0.5rem;
                            background:#fee2e2; border-radius:var(--radius);
                            border-left:4px solid var(--danger);">
        <span>❌</span>
        <span style="font-weight:600; color:#991b1b;">
                        <%= skill %>
                    </span>
      </div>
      <% } %>
      <a href="${pageContext.request.contextPath}/student/skills"
         class="btn btn-outline" style="margin-top:1rem; width:100%;
                          text-align:center;">
        🛠️ Update My Skills
      </a>
      <% } %>
    </div>
  </div>

  <!-- Action Buttons -->
  <div class="card" style="text-align:center; padding:2rem;">
    <h2 style="margin-bottom:1rem;">Ready to Apply?</h2>
    <p style="color:var(--gray); margin-bottom:1.5rem;">
      <% if (missingSkills == null || missingSkills.isEmpty()) { %>
      You are fully qualified! Go ahead and apply.
      <% } else { %>
      You can still apply even with missing skills.
      The recruiter will make the final decision.
      <% } %>
    </p>
    <div style="display:flex; gap:1rem; justify-content:center; flex-wrap:wrap;">
      <form action="${pageContext.request.contextPath}/student/apply"
            method="post">
        <input type="hidden" name="internshipId"
               value="<%= internship.getInternshipId() %>"/>
        <button type="submit" class="btn btn-primary"
                style="padding:0.8rem 2rem; font-size:1rem;">
          🚀 Apply Now
        </button>
      </form>
      <a href="${pageContext.request.contextPath}/student/internships"
         class="btn btn-outline"
         style="padding:0.8rem 2rem; font-size:1rem;">
        Browse More
      </a>
    </div>
  </div>

</div>

<%@ include file="../common/footer.jsp" %>