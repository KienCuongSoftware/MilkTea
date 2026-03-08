package controller;

import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import beans.User;
import dao.DaoDonHang;

/**
 * Thêm loggedInUser, permission, csrfToken và số đơn theo trạng thái (cho badge navbar) vào model cho mọi view.
 */
@ControllerAdvice
public class GlobalControllerAdvice {

    public static final String CSRF_TOKEN = "csrfToken";

    @Autowired
    private DaoDonHang daoDonHang;

    @ModelAttribute
    public void addGlobalAttributes(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            model.addAttribute("loggedInUser", loggedInUser);
            String permission = loggedInUser.getTenQuyen() != null ? loggedInUser.getTenQuyen().toLowerCase() : "";
            model.addAttribute("permission", permission);
            // Số đơn theo trạng thái cho badge navbar (chỉ khi là nhân viên order/pha chế/thu ngân hoặc quản lý/chủ quán)
            if (permission.contains("order") || permission.contains("pha chế") || permission.contains("thu ngân")
                    || "quản lý".equals(permission) || "chủ quán".equals(permission)) {
                model.addAttribute("orderCountConfirm", daoDonHang.countByStatus(0));
                model.addAttribute("orderCountBrewing", daoDonHang.countByStatus(1));
                model.addAttribute("orderCountPayment", daoDonHang.countByStatus(2));
            }
        }
        String token = (String) session.getAttribute(CSRF_TOKEN);
        if (token == null) {
            token = UUID.randomUUID().toString();
            session.setAttribute(CSRF_TOKEN, token);
        }
        model.addAttribute(CSRF_TOKEN, token);
    }
}
