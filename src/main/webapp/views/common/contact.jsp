<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>

<div class="main-content">

    <div class="page-header">
        <h1>📬 Contact Us</h1>
    </div>

    <div style="display:flex; gap:2rem; flex-wrap:wrap;">

        <!-- Contact Form -->
        <div class="card" style="flex:2; min-width:280px;">
            <h2 class="card-title">Send Us a Message</h2>

            <% if (request.getAttribute("success") != null) { %>
            <div class="alert alert-success"><%= request.getAttribute("success") %></div>
            <% } %>
            <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
            <% } %>

            <form action="${pageContext.request.contextPath}/contact" method="post">

                <div class="form-group">
                    <label for="name">Full Name</label>
                    <input type="text" id="name" name="name"
                           placeholder="Enter your full name" required/>
                </div>

                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email"
                           placeholder="Enter your email" required/>
                </div>

                <div class="form-group">
                    <label for="subject">Subject</label>
                    <input type="text" id="subject" name="subject"
                           placeholder="What is this about?" required/>
                </div>

                <div class="form-group">
                    <label for="message">Message</label>
                    <textarea id="message" name="message"
                              placeholder="Write your message here..." required></textarea>
                </div>

                <button type="submit" class="btn btn-primary" style="width:100%;">
                    Send Message
                </button>
            </form>
        </div>

        <!-- Contact Info -->
        <div style="flex:1; min-width:220px;">

            <div class="card">
                <h2 class="card-title">📍 Find Us</h2>
                <p style="color:var(--gray); line-height:2;">
                    🏢 Itahari International College<br/>
                    📍 Itahari, Sunsari, Nepal<br/>
                    📞 +977-9800000000<br/>
                    📧 support@careerlink.com<br/>
                    🕐 Mon - Fri: 9AM to 5PM
                </p>
            </div>

            <div class="card">
                <h2 class="card-title">🔗 Quick Links</h2>
                <ul style="color:var(--primary); line-height:2.2; font-size:0.95rem;">
                    <li><a href="${pageContext.request.contextPath}/views/common/about.jsp" style="color:var(--primary);">→ About Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/views/common/login.jsp" style="color:var(--primary);">→ Login</a></li>
                    <li><a href="${pageContext.request.contextPath}/views/common/register.jsp" style="color:var(--primary);">→ Register</a></li>
                </ul>
            </div>

        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>