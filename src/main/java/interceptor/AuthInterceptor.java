package interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.lang.NonNull;
import org.springframework.lang.Nullable;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import beans.User;

public class AuthInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(@NonNull HttpServletRequest request, @NonNull HttpServletResponse response,
            @Nullable Object handler) throws Exception {
        
        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();
        
        // Cho phép truy cập các trang không cần xác thực
        if (isPublicPage(requestURI, contextPath)) {
            return true;
        }
        
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(contextPath + "/login");
            return false;
        }
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            response.sendRedirect(contextPath + "/login");
            return false;
        }

        String path = requestURI.substring(contextPath.length());
        if (path.isEmpty()) {
            path = "/";
        }
        String role = loggedInUser.getTenQuyen() != null ? loggedInUser.getTenQuyen().toLowerCase() : "";

        if (!hasPermission(path, role)) {
            response.sendRedirect(contextPath + "/home");
            return false;
        }
        return true;
    }

    private boolean hasPermission(String path, String role) {
        if (path.startsWith("/product")) {
            // Khách hàng và mọi role được xem danh sách + chi tiết sản phẩm
            if (path.equals("/product/view") || path.startsWith("/product/detail/")) {
                return true;
            }
            // Thêm/sửa/xóa/tìm kiếm chỉ quản lý, chủ quán
            return "quản lý".equals(role) || "chủ quán".equals(role);
        }
        if (path.startsWith("/category") || path.startsWith("/supplier")) {
            return "quản lý".equals(role) || "chủ quán".equals(role);
        }
        if (path.startsWith("/user")) {
            if (path.equals("/user/profile") || path.startsWith("/user/upload-avatar") || path.startsWith("/user/update")) {
                return true;
            }
            return "quản lý".equals(role) || "chủ quán".equals(role);
        }
        if (path.startsWith("/warehouse")) {
            return "nhân viên kho".equals(role) || "quản lý".equals(role) || "chủ quán".equals(role);
        }
        if (path.startsWith("/order")) {
            if (path.startsWith("/order/success/") || path.startsWith("/order/bill/")) {
                return true;
            }
            return "nhân viên order".equals(role) || "nhân viên pha chế".equals(role)
                || "nhân viên thu ngân".equals(role) || "quản lý".equals(role) || "chủ quán".equals(role);
        }
        return true;
    }

    private boolean isPublicPage(String requestURI, String contextPath) {
        if (requestURI.contains("/login") ||
            requestURI.contains("/resources/") ||
            requestURI.contains("/search") ||
            requestURI.equals(contextPath + "/") ||
            requestURI.equals(contextPath + "/home")) {
            return true;
        }
        // Cho khách xem danh sách sản phẩm và chi tiết sản phẩm
        String path = requestURI.startsWith(contextPath) ? requestURI.substring(contextPath.length()) : requestURI;
        if (path.isEmpty()) path = "/";
        return path.equals("/product/view") || path.startsWith("/product/detail/");
    }
    
    @Override
    public void postHandle(@NonNull HttpServletRequest request, @NonNull HttpServletResponse response,
            @Nullable Object handler, @Nullable ModelAndView modelAndView) throws Exception {
        if (modelAndView != null) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                User loggedInUser = (User) session.getAttribute("loggedInUser");
                if (loggedInUser != null) {
                    modelAndView.addObject("loggedInUser", loggedInUser);
                }
            }
        }
    }
    
    @Override
    public void afterCompletion(@NonNull HttpServletRequest request, @NonNull HttpServletResponse response,
            @Nullable Object handler, @Nullable Exception ex) throws Exception {
    }
} 