<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>

<div class="main-content">
    <div style="text-align:center; padding:4rem 2rem;">
        <h1 style="font-size:5rem; color:var(--primary); font-weight:800;">404</h1>
        <h2 style="margin-bottom:1rem;">Page Not Found</h2>
        <p style="color:var(--gray); margin-bottom:2rem;">
            The page you are looking for does not exist or you don't have permission to access it.
        </p>
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
            Go Back Home
        </a>
    </div>
</div>

<%@ include file="footer.jsp" %>
