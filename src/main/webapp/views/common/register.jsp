<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Register — CareerLink Pro</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

<div class="auth-wrapper">
    <div class="auth-box" style="max-width:520px;">

        <!-- Logo -->
        <div class="auth-logo">
            <h1>Career<span>Link</span> Pro</h1>
            <p>Create your free account today</p>
        </div>

        <h2 class="auth-title">Create Account 🚀</h2>
        <p class="auth-subtitle">Join thousands of students finding internships</p>

        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger">
            ⚠️ <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/register" method="post">

            <div class="form-group">
                <label for="fullName">👤 Full Name</label>
                <input type="text" id="fullName" name="fullName"
                       placeholder="Enter your full name" required/>
            </div>

            <div style="display:flex; gap:1rem; flex-wrap:wrap;">
                <div class="form-group" style="flex:1; min-width:180px;">
                    <label for="email">📧 Email Address</label>
                    <input type="email" id="email" name="email"
                           placeholder="your@email.com" required/>
                </div>
                <div class="form-group" style="flex:1; min-width:180px;">
                    <label for="phone">📱 Phone Number</label>
                    <input type="text" id="phone" name="phone"
                           placeholder="10-digit number" required/>
                </div>
            </div>

            <div class="form-group">
                <label for="password">🔒 Password</label>
                <input type="password" id="password" name="password"
                       placeholder="Minimum 6 characters" required/>
            </div>

            <div class="form-group">
                <label for="role">🎯 Register As</label>
                <select id="role" name="role" required
                        onchange="toggleCompany(this.value)">
                    <option value="">-- Select your role --</option>
                    <option value="student">🎓 Student — Looking for internships</option>
                    <option value="recruiter">🏢 Recruiter — Posting internships</option>
                </select>
            </div>

            <!-- Company name shown only for recruiter -->
            <div class="form-group" id="companyGroup" style="display:none;">
                <label for="companyName">🏢 Company Name</label>
                <input type="text" id="companyName" name="companyName"
                       placeholder="Your company or organization name"/>
            </div>

            <button type="submit" class="btn btn-primary"
                    style="width:100%; padding:0.8rem; font-size:1rem;
                           margin-top:0.5rem; border-radius:10px;">
                Create My Account →
            </button>

        </form>

        <div style="text-align:center; margin-top:1.5rem;
                    padding-top:1.5rem; border-top:1px solid var(--border);">
            <p style="color:var(--gray); font-size:0.9rem;">
                Already have an account?
                <a href="${pageContext.request.contextPath}/views/common/login.jsp"
                   style="color:var(--primary); font-weight:700;">
                    Login here
                </a>
            </p>
        </div>
    </div>
</div>

<script>
    function toggleCompany(role) {
        const companyGroup = document.getElementById('companyGroup');
        companyGroup.style.display = role === 'recruiter' ? 'block' : 'none';
    }
</script>

</body>
</html>