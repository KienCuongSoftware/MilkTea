package controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import beans.CartItem;
import beans.Product;
import dao.DaoProduct;

/**
 * Giỏ hàng lưu trong session (database không có bảng giỏ hàng;
 * khi thanh toán sẽ tạo don_hang + chi_tiet_don_hang).
 */
@Controller
@RequestMapping("/cart")
public class CartController {

    private static final String SESSION_CART = "cart";

    @Autowired
    private DaoProduct daoProduct;

    @SuppressWarnings("unchecked")
    private List<CartItem> getOrCreateCart(HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute(SESSION_CART);
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute(SESSION_CART, cart);
        }
        return cart;
    }

    @GetMapping
    public String view(HttpSession session, Model model) {
        List<CartItem> cart = getOrCreateCart(session);
        BigDecimal tong = BigDecimal.ZERO;
        for (CartItem item : cart) {
            if (item.getThanhTien() != null) {
                tong = tong.add(item.getThanhTien());
            }
        }
        model.addAttribute("cart", cart);
        model.addAttribute("tong", tong);
        return "cart";
    }

    @GetMapping("/add/{maSP}")
    public String add(@PathVariable int maSP,
                     @RequestParam(name = "from", required = false) String from,
                     HttpSession session, RedirectAttributes redirectAttributes) {
        Product p;
        try {
            p = daoProduct.getProductById(maSP);
        } catch (org.springframework.dao.EmptyResultDataAccessException e) {
            redirectAttributes.addFlashAttribute("error", "Sản phẩm không tồn tại.");
            return "redirect:/product/view";
        }
        List<CartItem> cart = getOrCreateCart(session);
        for (CartItem item : cart) {
            if (item.getMaSP() == maSP) {
                item.setSoLuong(item.getSoLuong() + 1);
                redirectAttributes.addFlashAttribute("success", "Đã thêm vào giỏ hàng.");
                return redirectAfterAdd(maSP, from);
            }
        }
        CartItem item = new CartItem();
        item.setMaSP(p.getMaSP());
        item.setTenSP(p.getTenSP());
        item.setDonGia(p.getDonGia());
        item.setSoLuong(1);
        item.setHinhAnh(p.getHinhAnh());
        cart.add(item);
        redirectAttributes.addFlashAttribute("success", "Đã thêm vào giỏ hàng.");
        return redirectAfterAdd(maSP, from);
    }

    /** Sau khi thêm vào giỏ: nếu từ trang chi tiết thì quay lại chi tiết, không trỏ về danh sách. */
    private String redirectAfterAdd(int maSP, String from) {
        if ("detail".equals(from)) {
            return "redirect:/product/detail/" + maSP;
        }
        return "redirect:/product/view";
    }

    @GetMapping("/remove/{maSP}")
    public String remove(@PathVariable int maSP, HttpSession session, RedirectAttributes redirectAttributes) {
        List<CartItem> cart = getOrCreateCart(session);
        cart.removeIf(item -> item.getMaSP() == maSP);
        redirectAttributes.addFlashAttribute("success", "Đã xóa khỏi giỏ hàng.");
        return "redirect:/cart";
    }
}
