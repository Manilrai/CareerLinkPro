<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Login — CareerLink Pro</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

<div class="auth-wrapper">
    <div class="auth-box">

        <!-- Logo -->
        <div class="auth-logo">
            <h1>Career<span>Link</span> Pro</h1>
            <p>Internship Portal with Skill Gap Analyzer</p>
        </div>

        <h2 class="auth-title">Welcome Back 👋</h2>
        <p class="auth-subtitle">Login to your account to continue</p>

        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger">
            ⚠️ <%= request.getAttribute("error") %>
        </div>
        <% } %>
        <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success">
            ✅ <%= request.getAttribute("success") %>
        </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/login" method="post">

            <div class="form-group">
                <label for="email">📧 Email Address</label>
                <input type="email" id="email" name="email"
                       placeholder="Enter your email address" required/>
            </div>

            <div class="form-group">
                <label for="password">🔒 Password</label>
                <input type="password" id="password" name="password"
                       placeholder="Enter your password" required/>
            </div>

            <button type="submit" class="btn btn-primary"
                    style="width:100%; padding:0.8rem; font-size:1rem;
                           margin-top:0.5rem; border-radius:10px;">
                Login to Account →
            </button>
        </form>

        <div style="text-align:center; margin-top:1.5rem;
                    padding-top:1.5rem; border-top:1px solid var(--border);">
            <p style="color:var(--gray); font-size:0.9rem;">
                Don't have an account?
                <a href="${pageContext.request.contextPath}/views/common/register.jsp"
                   style="color:var(--primary); font-weight:700;">
                    Register here
                </a>
            </p>
            <div style="margin-top:1rem; display:flex; gap:0.5rem;
                        justify-content:center; flex-wrap:wrap;">
                <a href="${pageContext.request.contextPath}/views/common/about.jsp"
                   style="color:var(--gray-light); font-size:0.85rem;">About</a>
                <span style="color:var(--border);">•</span>
                <a href="${pageContext.request.contextPath}/views/common/contact.jsp"
                   style="color:var(--gray-light); font-size:0.85rem;">Contact</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>