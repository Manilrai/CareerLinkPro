<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.careerlink.model.Internship" %>
<%
    if (session.getAttribute("userId") == null ||
            !session.getAttribute("role").equals("student")) {
        response.sendRedirect(request.getContextPath() + "/views/common/login.jsp");
        return;
    }
    List<Internship> internships = (List<Internship>) request.getAttribute("internships");
    String search = request.getAttribute("search") != null
            ? request.getAttribute("search").toString() : "";
%>
<%@ include file="../common/header.jsp" %>

<div class="main-content">

    <div class="page-header">
        <h1>🔍 Browse Internships</h1>
        <a href="${pageContext.request.contextPath}/student/dashboard"
           class="btn btn-outline">← Back</a>
    </div>

    <!-- Search Bar -->
    <div class="card" style="padding:1.2rem;">
        <form action="${pageContext.request.contextPath}/student/internships"
              method="get"
              style="display:flex; gap:1rem; align-items:center; flex-wrap:wrap;">
            <input type="text" name="search"
                   value="<%= search %>"
                   placeholder="Search by title, skill, company, or location..."
                   style="flex:1; min-width:200px; padding:0.6rem 1rem;
                          border:1px solid var(--border);
                          border-radius:var(--radius); font-size:0.95rem;"/>
            <button type="submit" class="btn btn-primary">
                🔍 Search
            </button>
            <% if (!search.isEmpty()) { %>
            <a href="${pageContext.request.contextPath}/student/internships"
               class="btn btn-outline">Clear</a>
            <% } %>
        </form>
    </div>

    <!-- Results Count -->
    <p style="color:var(--gray); margin-bottom:1rem; font-size:0.9rem;">
        <%= internships != null ? internships.size() : 0 %> internship(s) found
        <% if (!search.isEmpty()) { %>
        for "<strong><%= search %></strong>"
        <% } %>
    </p>

    <!-- Internship Cards -->
    <% if (internships == null || internships.isEmpty()) { %>
    <div class="card" style="text-align:center; padding:3rem;">
        <p style="font-size:1.2rem; color:var(--gray);">
            😔 No internships found.
        </p>
        <% if (!search.isEmpty()) { %>
        <a href="${pageContext.request.contextPath}/student/internships"
           class="btn btn-primary" style="margin-top:1rem;">
            View All Internships
        </a>
        <% } %>
    </div>
    <% } else {
        for (Internship i : internships) { %>
    <div class="card" style="margin-bottom:1.2rem;">
        <div style="display:flex; justify-content:space-between;
                    align-items:flex-start; flex-wrap:wrap; gap:1rem;">

            <!-- Left: Details -->
            <div style="flex:1; min-width:200px;">
                <h2 style="font-size:1.2rem; margin-bottom:0.3rem;">
                    <%= i.getTitle() %>
                </h2>
                <p style="color:var(--primary); font-weight:600;
                          margin-bottom:0.5rem;">
                    🏢 <%= i.getCompanyName() %>
                </p>
                <div style="display:flex; flex-wrap:wrap; gap:1rem;
                            color:var(--gray); font-size:0.9rem;
                            margin-bottom:0.8rem;">
                    <span>📍 <%= i.getLocation() %></span>
                    <span>⏱️ <%= i.getDuration() %></span>
                    <span>💰 <%= i.getStipend() %></span>
                    <span>📅 Deadline: <%= i.getDeadline() %></span>
                </div>

                <!-- Description preview -->
                <p style="color:var(--gray); font-size:0.9rem;
                          line-height:1.6; margin-bottom:0.8rem;">
                    <%= i.getDescription() != null &&
                            i.getDescription().length() > 150
                            ? i.getDescription().substring(0, 150) + "..."
                            : i.getDescription() %>
                </p>

                <!-- Required Skills -->
                <% if (i.getRequiredSkills() != null &&
                        !i.getRequiredSkills().isEmpty()) { %>
                <div style="display:flex; flex-wrap:wrap; gap:0.5rem;">
                    <span style="font-size:0.85rem; color:var(--gray);">
                        Required:
                    </span>
                    <% for (String skill : i.getRequiredSkills()) { %>
                    <span class="badge badge-info"><%= skill %></span>
                    <% } %>
                </div>
                <% } %>
            </div>

            <!-- Right: Action Buttons -->
            <div style="display:flex; flex-direction:column;
                        gap:0.5rem; min-width:160px;">
                <a href="${pageContext.request.contextPath}/student/checkSkills?id=<%= i.getInternshipId() %>"
                   class="btn btn-primary" style="text-align:center;">
                    📊 Check Skills & Apply
                </a>
                <form action="${pageContext.request.contextPath}/student/wishlist"
                      method="post" style="margin:0;">
                    <input type="hidden" name="action" value="add"/>
                    <input type="hidden" name="internshipId"
                           value="<%= i.getInternshipId() %>"/>
                    <button type="submit" class="btn btn-outline"
                            style="width:100%;">
                        ❤️ Wishlist
                    </button>
                </form>
            </div>
        </div>
    </div>
    <% } } %>
</div>

<%@ include file="../common/footer.jsp" %>