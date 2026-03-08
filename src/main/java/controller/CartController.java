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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import beans.CartItem;
import beans.ChiTietDonHang;
import beans.DonHang;
import beans.Product;
import beans.User;
import beans.Voucher;
import dao.DaoChiTietDonHang;
import dao.DaoDonHang;
import dao.DaoProduct;
import dao.DaoVoucher;

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
    @Autowired
    private DaoDonHang daoDonHang;
    @Autowired
    private DaoChiTietDonHang daoChiTietDonHang;
    @Autowired
    private DaoVoucher daoVoucher;

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

    /** API áp dụng mã giảm giá: trả về JSON discountAmount, totalAfter để hiển thị trực quan. */
    @GetMapping(value = "/voucher/apply", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String applyVoucher(@RequestParam String code, @RequestParam java.math.BigDecimal total) {
        if (code == null || code.trim().isEmpty()) {
            return "{\"valid\":false,\"message\":\"Vui lòng nhập mã giảm giá\"}";
        }
        Voucher v = daoVoucher.findByMa(code.trim());
        if (v == null) {
            return "{\"valid\":false,\"message\":\"Mã không tồn tại hoặc đã hết hạn\"}";
        }
        int totalInt = total != null ? total.intValue() : 0;
        int discountAmount = 0;
        String discountLabel = "";
        if (v.getPhanTramGiamGia() != null && v.getPhanTramGiamGia() > 0) {
            discountAmount = totalInt * v.getPhanTramGiamGia() / 100;
            discountLabel = v.getPhanTramGiamGia() + "%";
        } else if (v.getGiaTriGiamGia() != null && v.getGiaTriGiamGia() > 0) {
            discountAmount = Math.min(v.getGiaTriGiamGia(), totalInt);
            discountLabel = discountAmount + "đ";
        }
        int totalAfter = Math.max(0, totalInt - discountAmount);
        String msg = "Đã áp dụng " + code.trim();
        return "{\"valid\":true,\"discountAmount\":" + discountAmount + ",\"discountLabel\":\"" + escapeJson(discountLabel) + "\",\"totalAfter\":" + totalAfter + ",\"message\":\"" + escapeJson(msg) + "\"}";
    }

    private static String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n");
    }

    @GetMapping("/remove/{maSP}")
    public String remove(@PathVariable int maSP, HttpSession session, RedirectAttributes redirectAttributes) {
        List<CartItem> cart = getOrCreateCart(session);
        cart.removeIf(item -> item.getMaSP() == maSP);
        redirectAttributes.addFlashAttribute("success", "Đã xóa khỏi giỏ hàng.");
        return "redirect:/cart";
    }

    @PostMapping("/checkout")
    public String checkout(@RequestParam String ten,
                          @RequestParam String diachi,
                          @RequestParam String sdt,
                          @RequestParam(required = false) String voucher,
                          HttpSession session,
                          RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("loggedInUser");
        List<CartItem> cart = getOrCreateCart(session);
        if (cart == null || cart.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Giỏ hàng trống.");
            return "redirect:/cart";
        }
        BigDecimal tong = BigDecimal.ZERO;
        for (CartItem item : cart) {
            if (item.getThanhTien() != null) tong = tong.add(item.getThanhTien());
        }
        DonHang dh = new DonHang();
        dh.setMaND(user != null ? user.getMaNd() : null);
        dh.setTen(ten != null ? ten.trim() : "");
        dh.setDiachi(diachi != null ? diachi.trim() : "");
        dh.setSdt(sdt != null ? sdt.trim() : "");
        dh.setNgaydat(new java.util.Date());
        dh.setVoucher(voucher != null && !voucher.trim().isEmpty() ? voucher.trim() : null);
        dh.setTongTien(tong);
        dh.setStatus(0);
        int orderId = daoDonHang.save(dh);
        if (orderId <= 0) {
            redirectAttributes.addFlashAttribute("error", "Không tạo được đơn hàng.");
            return "redirect:/cart";
        }
        for (CartItem item : cart) {
            ChiTietDonHang ct = new ChiTietDonHang();
            ct.setDonHang(orderId);
            ct.setSanPham(item.getMaSP());
            ct.setSize(1);
            ct.setSoLuong(item.getSoLuong());
            daoChiTietDonHang.save(ct);
        }
        cart.clear();
        redirectAttributes.addFlashAttribute("success", "Đặt hàng thành công. Mã đơn: #" + orderId);
        return "redirect:/order/success/" + orderId;
    }
}
