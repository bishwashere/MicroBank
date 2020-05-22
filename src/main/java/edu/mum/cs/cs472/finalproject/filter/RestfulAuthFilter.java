package edu.mum.cs.cs472.finalproject.filter;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import edu.mum.cs.cs472.finalproject.controller.protocol.Result;

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

@WebFilter(description = "PageAuthFilter", urlPatterns = {"/api/*"})
public class RestfulAuthFilter extends HttpFilter {
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

        userId = 1;

        if(userId == 0) {
            Result result = new Result(1, "You have no right");
            Gson gson = new GsonBuilder().create();
            String json = gson.toJson(result);

            res.setContentType("application/json; charset=utf-8");
            res.setCharacterEncoding("UTF-8");
            res.getWriter().append(json);

        } else {
            req.setAttribute("userId", userId);
            chain.doFilter(req, res);
        }
    }
}
