<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // If already logged in redirect to dashboard
    if (session.getAttribute("userId") != null) {
        String role = session.getAttribute("role").toString();
        if (role.equals("admin")) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else if (role.equals("recruiter")) {
            response.sendRedirect(request.getContextPath() + "/recruiter/dashboard");
        } else {
            response.sendRedirect(request.getContextPath() + "/student/dashboard");
        }
        return;
    }
%>
<%@ include file="views/common/header.jsp" %>

<style>
    .hero {
        background: linear-gradient(135deg, #0f172a 0%, #1e3a5f 50%, #2563eb 100%);
        color: white;
        padding: 6rem 2rem;
        text-align: center;
    }
    .hero h1 {
        font-size: 3rem;
        font-weight: 800;
        margin-bottom: 1rem;
        line-height: 1.2;
    }
    .hero h1 span {
        color: #06b6d4;
    }
    .hero p {
        font-size: 1.2rem;
        color: #94a3b8;
        max-width: 600px;
        margin: 0 auto 2.5rem;
        line-height: 1.8;
    }
    .hero-buttons {
        display: flex;
        gap: 1rem;
        justify-content: center;
        flex-wrap: wrap;
    }
    .btn-hero-primary {
        background: #2563eb;
        color: white;
        padding: 0.9rem 2.5rem;
        border-radius: 8px;
        font-size: 1rem;
        font-weight: 600;
        transition: all 0.25s ease;
        border: 2px solid #2563eb;
    }
    .btn-hero-primary:hover {
        background: #1d4ed8;
        transform: translateY(-2px);
        box-shadow: 0 8px 20px rgba(37,99,235,0.4);
    }
    .btn-hero-outline {
        background: transparent;
        color: white;
        padding: 0.9rem 2.5rem;
        border-radius: 8px;
        font-size: 1rem;
        font-weight: 600;
        border: 2px solid rgba(255,255,255,0.3);
        transition: all 0.25s ease;
    }
    .btn-hero-outline:hover {
        background: rgba(255,255,255,0.1);
        transform: translateY(-2px);
    }

    /* Features section */
    .features {
        padding: 5rem 2rem;
        background: #f1f5f9;
    }
    .features h2 {
        text-align: center;
        font-size: 2rem;
        font-weight: 700;
        color: #0f172a;
        margin-bottom: 0.5rem;
    }
    .features-subtitle {
        text-align: center;
        color: #64748b;
        margin-bottom: 3rem;
        font-size: 1rem;
    }
    .features-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 1.5rem;
        max-width: 1100px;
        margin: 0 auto;
    }
    .feature-card {
        background: white;
        border-radius: 12px;
        padding: 2rem;
        box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        transition: all 0.25s ease;
        border: 1px solid #e2e8f0;
    }
    .feature-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 10px 20px rgba(0,0,0,0.1);
    }
    .feature-icon {
        font-size: 2.5rem;
        margin-bottom: 1rem;
    }
    .feature-card h3 {
        font-size: 1.1rem;
        font-weight: 700;
        color: #0f172a;
        margin-bottom: 0.5rem;
    }
    .feature-card p {
        color: #64748b;
        font-size: 0.9rem;
        line-height: 1.6;
    }

    /* How it works */
    .how-it-works {
        padding: 5rem 2rem;
        background: white;
    }
    .how-it-works h2 {
        text-align: center;
        font-size: 2rem;
        font-weight: 700;
        color: #0f172a;
        margin-bottom: 0.5rem;
    }
    .how-subtitle {
        text-align: center;
        color: #64748b;
        margin-bottom: 3rem;
    }
    .steps-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
        gap: 2rem;
        max-width: 1000px;
        margin: 0 auto;
    }
    .step {
        text-align: center;
        padding: 1.5rem;
    }
    .step-number {
        width: 56px;
        height: 56px;
        background: linear-gradient(135deg, #2563eb, #06b6d4);
        color: white;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.3rem;
        font-weight: 800;
        margin: 0 auto 1rem;
    }
    .step h3 {
        font-size: 1rem;
        font-weight: 700;
        color: #0f172a;
        margin-bottom: 0.5rem;
    }
    .step p {
        color: #64748b;
        font-size: 0.85rem;
        line-height: 1.6;
    }

    /* Roles section */
    .roles {
        padding: 5rem 2rem;
        background: #f1f5f9;
    }
    .roles h2 {
        text-align: center;
        font-size: 2rem;
        font-weight: 700;
        color: #0f172a;
        margin-bottom: 0.5rem;
    }
    .roles-subtitle {
        text-align: center;
        color: #64748b;
        margin-bottom: 3rem;
    }
    .roles-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 1.5rem;
        max-width: 1000px;
        margin: 0 auto;
    }
    .role-card {
        background: white;
        border-radius: 12px;
        padding: 2rem;
        border: 1px solid #e2e8f0;
        text-align: center;
        transition: all 0.25s ease;
    }
    .role-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 10px 20px rgba(0,0,0,0.1);
    }
    .role-card.student { border-top: 4px solid #2563eb; }
    .role-card.recruiter { border-top: 4px solid #06b6d4; }
    .role-card.admin { border-top: 4px solid #f59e0b; }
    .role-icon { font-size: 3rem; margin-bottom: 1rem; }
    .role-card h3 { font-size: 1.2rem; font-weight: 700; margin-bottom: 0.75rem; color: #0f172a; }
    .role-card p { color: #64748b; font-size: 0.9rem; line-height: 1.6; margin-bottom: 1.5rem; }
    .role-btn {
        display: inline-block;
        padding: 0.6rem 1.5rem;
        border-radius: 6px;
        font-size: 0.9rem;
        font-weight: 600;
        transition: all 0.25s ease;
    }
    .role-card.student .role-btn { background: #2563eb; color: white; }
    .role-card.recruiter .role-btn { background: #06b6d4; color: white; }
    .role-card.admin .role-btn { background: #f59e0b; color: white; }
    .role-btn:hover { opacity: 0.9; transform: translateY(-1px); }

    /* CTA section */
    .cta {
        padding: 5rem 2rem;
        background: linear-gradient(135deg, #0f172a 0%, #2563eb 100%);
        text-align: center;
        color: white;
    }
    .cta h2 {
        font-size: 2rem;
        font-weight: 700;
        margin-bottom: 1rem;
    }
    .cta p {
        color: #94a3b8;
        margin-bottom: 2rem;
        font-size: 1rem;
    }

    /* Stats bar */
    .stats-bar {
        background: #2563eb;
        padding: 2rem;
        display: flex;
        justify-content: center;
        gap: 4rem;
        flex-wrap: wrap;
    }
    .stat-item {
        text-align: center;
        color: white;
    }
    .stat-item h3 {
        font-size: 2rem;
        font-weight: 800;
    }
    .stat-item p {
        font-size: 0.85rem;
        color: rgba(255,255,255,0.7);
        text-transform: uppercase;
        letter-spacing: 0.05em;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .hero h1 { font-size: 2rem; }
        .stats-bar { gap: 2rem; }
    }
</style>

<!-- HERO SECTION -->
<section class="hero">
    <h1>Find Your Perfect<br><span>Internship Match</span></h1>
    <p>CareerLink Pro connects students with top internship opportunities and helps them understand exactly which skills they need to succeed.</p>
    <div class="hero-buttons">
        <a href="${pageContext.request.contextPath}/views/common/register.jsp" class="btn-hero-primary">
            🚀 Get Started Free
        </a>
        <a href="${pageContext.request.contextPath}/views/common/login.jsp" class="btn-hero-outline">
            🔑 Login to Account
        </a>
    </div>
</section>

<!-- STATS BAR -->
<div class="stats-bar">
    <div class="stat-item">
        <h3>500+</h3>
        <p>Internships Posted</p>
    </div>
    <div class="stat-item">
        <h3>1,200+</h3>
        <p>Students Registered</p>
    </div>
    <div class="stat-item">
        <h3>150+</h3>
        <p>Companies</p>
    </div>
    <div class="stat-item">
        <h3>95%</h3>
        <p>Placement Rate</p>
    </div>
</div>

<!-- FEATURES SECTION -->
<section class="features">
    <h2>Why CareerLink Pro?</h2>
    <p class="features-subtitle">Everything you need to land your dream internship</p>
    <div class="features-grid">
        <div class="feature-card">
            <div class="feature-icon">🎯</div>
            <h3>Skill Gap Analyzer</h3>
            <p>Our unique feature compares your skills against any internship's requirements and shows you exactly what you're missing — so you can improve.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">🔍</div>
            <h3>Smart Search</h3>
            <p>Search internships by title, company, or location. Filter results to find the perfect opportunity that matches your profile.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">📋</div>
            <h3>Easy Applications</h3>
            <p>Apply to internships with one click. Track all your applications and their status in one central dashboard.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">❤️</div>
            <h3>Wishlist</h3>
            <p>Save interesting internships to your wishlist and apply when you're ready. Never miss an opportunity again.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">🏢</div>
            <h3>Recruiter Tools</h3>
            <p>Recruiters can post internships, manage listings, review applicants, and update application statuses efficiently.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">🔒</div>
            <h3>Secure Platform</h3>
            <p>SHA-256 password encryption, session management, and role-based access control keep your data safe at all times.</p>
        </div>
    </div>
</section>

<!-- HOW IT WORKS -->
<section class="how-it-works">
    <h2>How It Works</h2>
    <p class="how-subtitle">Get started in just 4 simple steps</p>
    <div class="steps-grid">
        <div class="step">
            <div class="step-number">1</div>
            <h3>Create Account</h3>
            <p>Register as a student or recruiter in less than 2 minutes.</p>
        </div>
        <div class="step">
            <div class="step-number">2</div>
            <h3>Build Your Profile</h3>
            <p>Add your skills, education, and experience to your profile.</p>
        </div>
        <div class="step">
            <div class="step-number">3</div>
            <h3>Analyze Skill Gap</h3>
            <p>Check your skill match percentage for any internship instantly.</p>
        </div>
        <div class="step">
            <div class="step-number">4</div>
            <h3>Apply & Track</h3>
            <p>Apply with one click and track your application status in real time.</p>
        </div>
    </div>
</section>

<!-- ROLES SECTION -->
<section class="roles">
    <h2>Choose Your Role</h2>
    <p class="roles-subtitle">CareerLink Pro works for everyone</p>
    <div class="roles-grid">
        <div class="role-card student">
            <div class="role-icon">🎓</div>
            <h3>Student</h3>
            <p>Browse internships, analyze your skill gaps, apply with one click, and track all your applications in one place.</p>
            <a href="${pageContext.request.contextPath}/views/common/register.jsp" class="role-btn">Register as Student</a>
        </div>
        <div class="role-card recruiter">
            <div class="role-icon">🏢</div>
            <h3>Recruiter</h3>
            <p>Post internship listings, define required skills, review applicants, and manage your entire recruitment pipeline.</p>
            <a href="${pageContext.request.contextPath}/views/common/register.jsp" class="role-btn">Register as Recruiter</a>
        </div>
        <div class="role-card admin">
            <div class="role-icon">⚙️</div>
            <h3>Admin</h3>
            <p>Manage all users, approve recruiter registrations, and oversee all internship listings on the platform.</p>
            <a href="${pageContext.request.contextPath}/views/common/login.jsp" class="role-btn">Admin Login</a>
        </div>
    </div>
</section>

<!-- CTA SECTION -->
<section class="cta">
    <h2>Ready to Start Your Career Journey?</h2>
    <p>Join thousands of students who found their dream internship through CareerLink Pro</p>
    <div class="hero-buttons">
        <a href="${pageContext.request.contextPath}/views/common/register.jsp" class="btn-hero-primary">
            🚀 Create Free Account
        </a>
        <a href="${pageContext.request.contextPath}/views/common/login.jsp" class="btn-hero-outline">
            🔑 Login
        </a>
    </div>
</section>

<%@ include file="views/common/footer.jsp" %>