<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>

<div class="main-content">

    <!-- Hero Section -->
    <div class="card" style="text-align:center; padding:3rem 2rem; background: linear-gradient(135deg, #0f172a, #1e40af); color:white;">
        <h1 style="font-size:2.5rem; margin-bottom:1rem;">About <span style="color:#06b6d4;">CareerLink Pro</span></h1>
        <p style="font-size:1.1rem; max-width:600px; margin:0 auto; color:#cbd5e1;">
            A smart internship portal that connects students with opportunities
            and helps them identify skill gaps before applying.
        </p>
    </div>

    <!-- Mission Section -->
    <div class="card" style="margin-top:2rem;">
        <h2 class="card-title">🎯 Our Mission</h2>
        <p style="color:var(--gray); line-height:1.8;">
            CareerLink Pro was built to bridge the gap between students and industry.
            We believe every student deserves a clear path to their career goals.
            Our platform not only helps students discover internship opportunities
            but also empowers them with insights into what skills they need to develop
            to become strong candidates.
        </p>
    </div>

    <!-- Features Section -->
    <div class="card">
        <h2 class="card-title">✨ What We Offer</h2>
        <div style="display:flex; flex-wrap:wrap; gap:1.5rem; margin-top:1rem;">

            <div style="flex:1; min-width:200px; padding:1.2rem; background:var(--light); border-radius:var(--radius); border-left:4px solid var(--primary);">
                <h3 style="margin-bottom:0.5rem;">🔍 Internship Search</h3>
                <p style="color:var(--gray); font-size:0.9rem;">Browse hundreds of internship opportunities posted by verified companies and recruiters.</p>
            </div>

            <div style="flex:1; min-width:200px; padding:1.2rem; background:var(--light); border-radius:var(--radius); border-left:4px solid var(--accent);">
                <h3 style="margin-bottom:0.5rem;">📊 Skill Gap Analyzer</h3>
                <p style="color:var(--gray); font-size:0.9rem;">Compare your skills with internship requirements and discover exactly what you need to learn.</p>
            </div>

            <div style="flex:1; min-width:200px; padding:1.2rem; background:var(--light); border-radius:var(--radius); border-left:4px solid var(--success);">
                <h3 style="margin-bottom:0.5rem;">📝 Easy Applications</h3>
                <p style="color:var(--gray); font-size:0.9rem;">Apply for internships directly through the platform and track your application status in real time.</p>
            </div>

            <div style="flex:1; min-width:200px; padding:1.2rem; background:var(--light); border-radius:var(--radius); border-left:4px solid var(--warning);">
                <h3 style="margin-bottom:0.5rem;">🏢 Recruiter Portal</h3>
                <p style="color:var(--gray); font-size:0.9rem;">Companies can post internships, manage applicants, and find the right talent efficiently.</p>
            </div>

        </div>
    </div>

    <!-- Team Section -->
    <div class="card">
        <h2 class="card-title">👥 Our Team</h2>
        <p style="color:var(--gray); line-height:1.8;">
            CareerLink Pro was developed by a dedicated team of five computer science
            students as part of the Advanced Programming and Technologies module at
            London Metropolitan University (Itahari International College).
            The project reflects our commitment to building practical, real-world solutions
            using Java, JSP, Servlets, MVC Architecture, and MySQL.
        </p>
    </div>

</div>

<%@ include file="footer.jsp" %>