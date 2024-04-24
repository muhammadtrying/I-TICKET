package uz.muhammadtrying.iticketproject.config;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebFilter(urlPatterns = "/*")
public class MyFilter implements Filter {
    private final List<String> openUrls = new ArrayList<>(List.of(
            "/",
            "/auth-servlet"
    ));

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        String requestURI = request.getRequestURI();
        if (openUrls.contains(requestURI)) {
            filterChain.doFilter(request, servletResponse);
            return;
        }
        Object object = request.getSession().getAttribute("currentUser");
        if (object != null) {
            filterChain.doFilter(servletRequest, servletResponse);
            return;
        }
        response.sendRedirect("/");
    }
}
