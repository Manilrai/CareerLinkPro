<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>

<div class="main-content">
    <div style="max-width: 550px; margin: 3rem auto;">
        <div class="card">
            <h2 class="card-title" style="text-align:center;">Create Account 🚀</h2>
            <p style="text-align:center; color:var(--gray); margin-bottom:1.5rem;">
                Join CareerLink Pro today
            </p>

            <!-- Error Message -->
            <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
            <% } %>

            <form action="${pageContext.request.contextPath}/register" method="post">

                <div class="form-group">
                    <label for="fullName">Full Name</label>
                    <input type="text" id="fullName" name="fullName"
                           placeholder="Enter your full name" required/>
                </div>

                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email"
                           placeholder="Enter your email" required/>
                </div>

                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="text" id="phone" name="phone"
                           placeholder="10-digit phone number" required/>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password"
                           placeholder="Minimum 6 characters" required/>
                </div>

                <div class="form-group">
                    <label for="role">Register As</label>
                    <select id="role" name="role" required>
                        <option value="">-- Select Role --</option>
                        <option value="student">Student</option>
                        <option value="recruiter">Recruiter / Company</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary"
                        style="width:100%; margin-top:0.5rem;">
                    Create Account
                </button>
            </form>

            <p style="text-align:center; margin-top:1.2rem; font-size:0.9rem; color:var(--gray);">
                Already have an account?
                <a href="${pageContext.request.contextPath}/views/common/login.jsp"
                   style="color:var(--primary); font-weight:600;">Login here</a>
            </p>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
