package edu.mum.cs.cs472.finalproject.filter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(description = "PageAuthFilter", urlPatterns = {"/transfer", "/history", "/home", "/billPay"})
public class PageAuthFilter extends HttpFilter {
    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest)req;
        Cookie[] cookies = request.getCookies();

        int userId = 0;
        for(Cookie cookie: cookies) {
            if(cookie.getName().equals("USER_ID")) {
                userId = Integer.parseInt(cookie.getValue());
            }
        }

        if(userId == 0) {
            HttpServletResponse httpResponse = (HttpServletResponse) res;
            httpResponse.sendRedirect("login");
        } else {
            req.setAttribute("userId", userId);
            chain.doFilter(req, res);
        }
    }
}
