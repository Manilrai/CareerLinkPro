<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%
    if (session.getAttribute("userId") == null ||
            !session.getAttribute("role").equals("recruiter")) {
        response.sendRedirect(request.getContextPath() + "/views/common/login.jsp");
        return;
    }
    Map internship = (Map) request.getAttribute("internship");
%>
<%@ include file="../common/header.jsp" %>

<div class="main-content">

    <div class="page-header">
        <h1>✏️ Edit Internship</h1>
        <a href="${pageContext.request.contextPath}/recruiter/internships"
           class="btn btn-outline">← Back</a>
    </div>

    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>

    <div class="card">
        <form action="${pageContext.request.contextPath}/recruiter/editInternship" method="post">

            <input type="hidden" name="internshipId"
                   value="<%= internship.get("internshipId") %>"/>

            <div style="display:flex; gap:1.5rem; flex-wrap:wrap;">
                <div class="form-group" style="flex:1; min-width:200px;">
                    <label for="title">Internship Title *</label>
                    <input type="text" id="title" name="title"
                           value="<%= internship.get("title") %>" required/>
                </div>
                <div class="form-group" style="flex:1; min-width:200px;">
                    <label for="location">Location *</label>
                    <input type="text" id="location" name="location"
                           value="<%= internship.get("location") %>" required/>
                </div>
            </div>

            <div class="form-group">
                <label for="description">Description *</label>
                <textarea id="description" name="description"
                          required><%= internship.get("description") %></textarea>
            </div>

            <div style="display:flex; gap:1.5rem; flex-wrap:wrap;">
                <div class="form-group" style="flex:1; min-width:200px;">
                    <label for="duration">Duration *</label>
                    <input type="text" id="duration" name="duration"
                           value="<%= internship.get("duration") %>" required/>
                </div>
                <div class="form-group" style="flex:1; min-width:200px;">
                    <label for="stipend">Stipend</label>
                    <input type="text" id="stipend" name="stipend"
                           value="<%= internship.get("stipend") %>"/>
                </div>
                <div class="form-group" style="flex:1; min-width:200px;">
                    <label for="deadline">Deadline *</label>
                    <input type="date" id="deadline" name="deadline"
                           value="<%= internship.get("deadline") %>" required/>
                </div>
            </div>

            <div class="form-group">
                <label for="status">Status</label>
                <select id="status" name="status">
                    <option value="open"
                            <%= internship.get("status").equals("open") ? "selected" : "" %>>Open</option>
                    <option value="closed"
                            <%= internship.get("status").equals("closed") ? "selected" : "" %>>Closed</option>
                </select>
            </div>

            <div style="display:flex; gap:1rem; margin-top:1rem;">
                <button type="submit" class="btn btn-primary">
                    💾 Save Changes
                </button>
                <a href="${pageContext.request.contextPath}/recruiter/internships"
                   class="btn btn-outline">Cancel</a>
            </div>

        </form>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
