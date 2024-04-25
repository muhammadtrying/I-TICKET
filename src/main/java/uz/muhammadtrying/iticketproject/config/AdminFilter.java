package uz.muhammadtrying.iticketproject.config;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.muhammadtrying.iticketproject.entity.User;

import java.io.IOException;

@WebFilter(urlPatterns = "/admin.jsp")
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        Object object = request.getSession().getAttribute("currentUser");
        if (object != null) {
            User user = (User) object;
            if (user.getUsername().equals("Eshmat13")) {
                filterChain.doFilter(servletRequest, servletResponse);
                return;
            }
        }
        response.sendRedirect("/");
    }
}
