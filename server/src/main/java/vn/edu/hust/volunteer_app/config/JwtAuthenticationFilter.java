package vn.edu.hust.volunteer_app.config;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.function.Predicate;

import lombok.RequiredArgsConstructor;
import vn.edu.hust.volunteer_app.models.entity.User;
import vn.edu.hust.volunteer_app.service.JwtService;
import vn.edu.hust.volunteer_app.service.UserService;

import org.springframework.lang.NonNull;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.filter.OncePerRequestFilter;

@Component
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtService jwtService;
    private final UserService userDetailsService;
    private final AntPathMatcher pathMatcher = new AntPathMatcher();

    private final List<String> whitelist = Arrays.asList(
            "/test",
            "/api/v1/auth/*",
            "/swagger-ui/**",
            "/v3/api-docs/**");

    @Override
    protected void doFilterInternal(
            @NonNull HttpServletRequest request,
            @NonNull HttpServletResponse response,
            @NonNull FilterChain filterChain) throws IOException {
        String authHeader = request.getHeader("Authorization");
        String jwt;
        String email;
        int userId;

        try {
            jwt = authHeader.substring(7);
            email = jwtService.extractEmail(jwt);
            System.out.println("check email extracted from jwt" + email);
            userId = jwtService.extractUserId(jwt);
            System.out.println("check email extracted from jwt" + userId);
            if (email != null && SecurityContextHolder.getContext().getAuthentication() == null) {
                User userDetails = this.userDetailsService.loadUserByUsername(email);
                if (jwtService.isTokenValid(jwt, userDetails)) {
                    UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(
                            userDetails,
                            null,
                            userDetails.getAuthorities());
                    authToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                    SecurityContextHolder.getContext().setAuthentication(authToken);
                }
            }
            request.setAttribute("email", email);
            request.setAttribute("userId", userId);
            filterChain.doFilter(request, response);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.setContentType("application/json");
            response.getWriter().write(e.getMessage());
        }
    }

    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) throws ServletException {
        String requestURI = request.getRequestURI();
        return whitelist.stream().anyMatch(pattern -> pathMatcher.match(pattern, requestURI));
    }

}
