<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>

<div class="main-content">
    <div style="max-width: 450px; margin: 3rem auto;">
        <div class="card">
            <h2 class="card-title" style="text-align:center;">Welcome Back 👋</h2>
            <p style="text-align:center; color:var(--gray); margin-bottom:1.5rem;">
                Login to your CareerLink Pro account
            </p>

            <!-- Error / Success Messages -->
            <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
            <% } %>
            <% if (request.getAttribute("success") != null) { %>
            <div class="alert alert-success"><%= request.getAttribute("success") %></div>
            <% } %>

            <form action="${pageContext.request.contextPath}/login" method="post">

                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email"
                           placeholder="Enter your email" required/>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password"
                           placeholder="Enter your password" required/>
                </div>

                <button type="submit" class="btn btn-primary"
                        style="width:100%; margin-top:0.5rem;">
                    Login
                </button>
            </form>

            <p style="text-align:center; margin-top:1.2rem; font-size:0.9rem; color:var(--gray);">
                Don't have an account?
                <a href="${pageContext.request.contextPath}/views/common/register.jsp"
                   style="color:var(--primary); font-weight:600;">Register here</a>
            </p>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>