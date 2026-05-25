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
    <h1>👤 My Profile</h1>
    <a href="${pageContext.request.contextPath}/student/dashboard"
       class="btn btn-outline">← Back to Dashboard</a>
  </div>

  <% if (request.getAttribute("success") != null) { %>
  <div class="alert alert-success"><%= request.getAttribute("success") %></div>
  <% } %>
  <% if (request.getAttribute("error") != null) { %>
  <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
  <% } %>

  <div style="display:flex; gap:2rem; flex-wrap:wrap;">

    <!-- Account Info (read only) -->
    <div class="card" style="flex:1; min-width:250px;">
      <h2 class="card-title">🔐 Account Information</h2>
      <div class="form-group">
        <label>Full Name</label>
        <input type="text"
               value="<%= student != null ? student.getFullName() : "" %>"
               disabled
               style="background:#f1f5f9; color:var(--gray);"/>
      </div>
      <div class="form-group">
        <label>Email Address</label>
        <input type="text"
               value="<%= student != null ? student.getEmail() : "" %>"
               disabled
               style="background:#f1f5f9; color:var(--gray);"/>
      </div>
      <div class="form-group">
        <label>Phone Number</label>
        <input type="text"
               value="<%= student != null ? student.getPhone() : "" %>"
               disabled
               style="background:#f1f5f9; color:var(--gray);"/>
      </div>
      <p style="font-size:0.85rem; color:var(--gray);">
        ℹ️ Account details cannot be changed here.
      </p>
    </div>

    <!-- Academic Info (editable) -->
    <div class="card" style="flex:2; min-width:300px;">
      <h2 class="card-title">🎓 Academic Information</h2>
      <form action="${pageContext.request.contextPath}/student/profile"
            method="post">

        <div style="display:flex; gap:1.5rem; flex-wrap:wrap;">
          <div class="form-group" style="flex:1; min-width:200px;">
            <label for="dateOfBirth">Date of Birth</label>
            <input type="date" id="dateOfBirth" name="dateOfBirth"
                   value="<%= student != null &&
                                          student.getDateOfBirth() != null ?
                                          student.getDateOfBirth() : "" %>"/>
          </div>
          <div class="form-group" style="flex:1; min-width:200px;">
            <label for="yearOfStudy">Year of Study</label>
            <select id="yearOfStudy" name="yearOfStudy">
              <option value="1" <%= student != null &&
                      student.getYearOfStudy() == 1 ? "selected" : "" %>>
                Year 1
              </option>
              <option value="2" <%= student != null &&
                      student.getYearOfStudy() == 2 ? "selected" : "" %>>
                Year 2
              </option>
              <option value="3" <%= student != null &&
                      student.getYearOfStudy() == 3 ? "selected" : "" %>>
                Year 3
              </option>
              <option value="4" <%= student != null &&
                      student.getYearOfStudy() == 4 ? "selected" : "" %>>
                Year 4
              </option>
            </select>
          </div>
        </div>

        <div class="form-group">
          <label for="educationLevel">Education Level *</label>
          <select id="educationLevel" name="educationLevel" required>
            <option value="">-- Select Level --</option>
            <option value="Bachelor" <%= student != null &&
                    "Bachelor".equals(student.getEducationLevel()) ?
                    "selected" : "" %>>Bachelor's Degree</option>
            <option value="Master" <%= student != null &&
                    "Master".equals(student.getEducationLevel()) ?
                    "selected" : "" %>>Master's Degree</option>
            <option value="Diploma" <%= student != null &&
                    "Diploma".equals(student.getEducationLevel()) ?
                    "selected" : "" %>>Diploma</option>
            <option value="Other" <%= student != null &&
                    "Other".equals(student.getEducationLevel()) ?
                    "selected" : "" %>>Other</option>
          </select>
        </div>

        <div class="form-group">
          <label for="institution">Institution / College Name *</label>
          <input type="text" id="institution" name="institution"
                 placeholder="e.g. Itahari International College"
                 value="<%= student != null &&
                                      student.getInstitution() != null ?
                                      student.getInstitution() : "" %>"
                 required/>
        </div>

        <div class="form-group">
          <label for="address">Address</label>
          <textarea id="address" name="address"
                    placeholder="Your current address"
                    style="min-height:80px;"><%= student != null &&
                  student.getAddress() != null ?
                  student.getAddress() : "" %></textarea>
        </div>

        <button type="submit" class="btn btn-primary">
          💾 Save Profile
        </button>
      </form>
    </div>
  </div>
</div>

<%@ include file="../common/footer.jsp" %>