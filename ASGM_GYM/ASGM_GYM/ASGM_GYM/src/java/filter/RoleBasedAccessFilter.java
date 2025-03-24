package filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.User;

@WebFilter(urlPatterns = {"/adminDashboard.jsp","/admindashboard", "/courseList", "/course", "/courseStat", "/customerList.jsp"})
public class RoleBasedAccessFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(); // Don't create a session if one doesn't exist

        boolean isLoggedIn = (session.getAttribute("user") != null);

        if (isLoggedIn) {
            User user = (User) session.getAttribute("user");
            String role = user.getRole();

            if (role.equals("Admin")) {
                // Allow access to admin resources
                chain.doFilter(request, response);
                return;
            }

        }
        // If not authorized then direct back to login
         httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");

    }

    @Override
    public void destroy() {
    }
}