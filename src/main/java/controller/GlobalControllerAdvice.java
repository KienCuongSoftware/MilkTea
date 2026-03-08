package controller;

import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import beans.User;

/**
 * Thêm loggedInUser, permission và csrfToken vào model cho mọi view.
 */
@ControllerAdvice
public class GlobalControllerAdvice {

    public static final String CSRF_TOKEN = "csrfToken";

    @ModelAttribute
    public void addGlobalAttributes(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen() != null ? loggedInUser.getTenQuyen().toLowerCase() : "");
        }
        String token = (String) session.getAttribute(CSRF_TOKEN);
        if (token == null) {
            token = UUID.randomUUID().toString();
            session.setAttribute(CSRF_TOKEN, token);
        }
        model.addAttribute(CSRF_TOKEN, token);
    }
}
