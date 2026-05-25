<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%
  if (session.getAttribute("userId") == null ||
          !session.getAttribute("role").equals("student")) {
    response.sendRedirect(request.getContextPath() + "/views/common/login.jsp");
    return;
  }
  int studentId = (int) session.getAttribute("studentId");
  com.careerlink.dao.StudentDAO dao = new com.careerlink.dao.StudentDAO();
  List<String[]> skills = dao.getSkillsWithNameAndId(studentId);
%>
<%@ include file="../common/header.jsp" %>

<div class="main-content">

  <div class="page-header">
    <h1>🛠️ My Skills</h1>
    <a href="${pageContext.request.contextPath}/student/dashboard"
       class="btn btn-outline">← Back</a>
  </div>

  <% if (request.getAttribute("success") != null) { %>
  <div class="alert alert-success"><%= request.getAttribute("success") %></div>
  <% } %>
  <% if (request.getAttribute("error") != null) { %>
  <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
  <% } %>

  <div style="display:flex; gap:2rem; flex-wrap:wrap;">

    <!-- Add Skill Form -->
    <div class="card" style="flex:1; min-width:250px;">
      <h2 class="card-title">➕ Add New Skill</h2>
      <p style="color:var(--gray); font-size:0.9rem; margin-bottom:1rem;">
        Add skills that you have learned or are proficient in.
        These will be used in the Skill Gap Analyzer.
      </p>
      <form action="${pageContext.request.contextPath}/student/skills"
            method="post">
        <input type="hidden" name="action" value="add"/>
        <div class="form-group">
          <label for="skillName">Skill Name</label>
          <input type="text" id="skillName" name="skillName"
                 placeholder="e.g. Java, MySQL, Git, HTML..."
                 required/>
        </div>
        <button type="submit" class="btn btn-primary" style="width:100%;">
          + Add Skill
        </button>
      </form>

      <!-- Common skills suggestion -->
      <div style="margin-top:1.5rem;">
        <p style="font-size:0.85rem; color:var(--gray);
                          margin-bottom:0.5rem;">
          💡 Common skills:
        </p>
        <div style="display:flex; flex-wrap:wrap; gap:0.5rem;">
          <% String[] common = {"Java", "MySQL", "HTML", "CSS",
                  "JavaScript", "Git", "Python",
                  "JSP", "Spring", "React"};
            for (String s : common) { %>
          <span onclick="document.getElementById('skillName').value='<%= s %>'"
                style="cursor:pointer; padding:0.3rem 0.8rem;
                                 background:var(--light);
                                 border:1px solid var(--border);
                                 border-radius:999px; font-size:0.8rem;">
                        <%= s %>
                    </span>
          <% } %>
        </div>
      </div>
    </div>

    <!-- Skills List -->
    <div class="card" style="flex:2; min-width:300px;">
      <h2 class="card-title">📋 My Current Skills</h2>
      <% if (skills == null || skills.isEmpty()) { %>
      <div class="alert alert-warning">
        You have not added any skills yet.
        Add your first skill to use the Skill Gap Analyzer!
      </div>
      <% } else { %>
      <div style="display:flex; flex-wrap:wrap; gap:0.8rem;">
        <% for (String[] skill : skills) { %>
        <div style="display:flex; align-items:center; gap:0.5rem;
                                padding:0.5rem 1rem;
                                background:var(--light);
                                border:1px solid var(--border);
                                border-radius:999px;">
                        <span style="font-size:0.9rem;">
                            🔧 <%= skill[1] %>
                        </span>
          <form action="${pageContext.request.contextPath}/student/skills"
                method="post" style="margin:0;">
            <input type="hidden" name="action" value="delete"/>
            <input type="hidden" name="skillId" value="<%= skill[0] %>"/>
            <button type="submit"
                    style="background:none; border:none;
                                           color:var(--danger); cursor:pointer;
                                           font-size:1rem; padding:0;"
                    onclick="return confirm('Remove this skill?')">
              ✕
            </button>
          </form>
        </div>
        <% } %>
      </div>
      <p style="margin-top:1rem; color:var(--gray); font-size:0.85rem;">
        Total skills: <%= skills.size() %>
      </p>
      <% } %>
    </div>
  </div>
</div>

<%@ include file="../common/footer.jsp" %>