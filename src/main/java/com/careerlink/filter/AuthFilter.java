package com.careerlink.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    // URLs that do NOT require login
    private static final String[] PUBLIC_URLS = {
            "/views/common/login.jsp",
            "/views/common/register.jsp",
            "/views/common/about.jsp",
            "/views/common/contact.jsp",
            "/views/common/error.jsp",
            "/login",
            "/register",
            "/logout",
            "/contact",
            "/css/",
            "/js/"
    };

    public void doFilter(ServletRequest req, ServletResponse res,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  request  = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String path = request.getRequestURI()
                .substring(request.getContextPath().length());

        // Check if URL is public
        boolean isPublic = false;
        for (String url : PUBLIC_URLS) {
            if (path.startsWith(url)) {
                isPublic = true;
                break;
            }
        }

        // Get session
        HttpSession session = request.getSession(false);
        boolean loggedIn    = (session != null &&
                session.getAttribute("userId") != null);

        if (isPublic || loggedIn) {
            // Allow the request to continue
            chain.doFilter(request, response);
        } else {
            // Block and redirect to log in
            response.sendRedirect(request.getContextPath()
                    + "/views/common/login.jsp");
        }
    }

    public void init(FilterConfig config) throws ServletException {}
    public void destroy() {}
}