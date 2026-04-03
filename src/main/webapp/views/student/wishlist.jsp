<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.careerlink.model.Internship" %>
<%
  if (session.getAttribute("userId") == null ||
          !session.getAttribute("role").equals("student")) {
    response.sendRedirect(request.getContextPath() + "/views/common/login.jsp");
    return;
  }
  List<Internship> wishlist =
          (List<Internship>) request.getAttribute("wishlist");
%>
<%@ include file="../common/header.jsp" %>

<div class="main-content">

  <div class="page-header">
    <h1>❤️ My Wishlist</h1>
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

  <% if (wishlist == null || wishlist.isEmpty()) { %>
  <div class="card" style="text-align:center; padding:3rem;">
    <p style="font-size:1.2rem; color:var(--gray);">
      💔 Your wishlist is empty.
    </p>
    <p style="color:var(--gray); margin-bottom:1.5rem;">
      Browse internships and click the Wishlist button
      to save them here.
    </p>
    <a href="${pageContext.request.contextPath}/student/internships"
       class="btn btn-primary">Browse Internships</a>
  </div>
  <% } else { %>
  <% for (Internship i : wishlist) { %>
  <div class="card" style="margin-bottom:1.2rem;">
    <div style="display:flex; justify-content:space-between;
                        align-items:center; flex-wrap:wrap; gap:1rem;">

      <!-- Left: Details -->
      <div style="flex:1; min-width:200px;">
        <h2 style="font-size:1.1rem; margin-bottom:0.3rem;">
          <%= i.getTitle() %>
        </h2>
        <p style="color:var(--primary); font-weight:600;
                              margin-bottom:0.5rem;">
          🏢 <%= i.getCompanyName() %>
        </p>
        <div style="display:flex; flex-wrap:wrap; gap:1rem;
                                color:var(--gray); font-size:0.85rem;">
          <span>📍 <%= i.getLocation() %></span>
          <span>⏱️ <%= i.getDuration() %></span>
          <span>💰 <%= i.getStipend() %></span>
          <span>📅 Deadline: <%= i.getDeadline() %></span>
          <span>
                            <span class="badge <%=
                                i.getStatus().equals("open")
                                ? "badge-success" : "badge-danger" %>">
                                <%= i.getStatus() %>
                            </span>
                        </span>
        </div>
      </div>

      <!-- Right: Buttons -->
      <div style="display:flex; gap:0.5rem; flex-wrap:wrap;">
        <a href="${pageContext.request.contextPath}/student/checkSkills?id=<%= i.getInternshipId() %>"
           class="btn btn-primary"
           style="padding:0.4rem 1rem; font-size:0.9rem;">
          📊 Check & Apply
        </a>
        <form action="${pageContext.request.contextPath}/student/wishlist"
              method="post" style="margin:0;">
          <input type="hidden" name="action" value="remove"/>
          <input type="hidden" name="internshipId"
                 value="<%= i.getInternshipId() %>"/>
          <button type="submit"
                  class="btn btn-danger"
                  style="padding:0.4rem 1rem; font-size:0.9rem;"
                  onclick="return confirm('Remove from wishlist?')">
            ✕ Remove
          </button>
        </form>
      </div>
    </div>
  </div>
  <% } %>
  <p style="color:var(--gray); font-size:0.9rem;">
    Total wishlisted: <%= wishlist.size() %>
  </p>
  <% } %>
</div>

<%@ include file="../common/footer.jsp" %>