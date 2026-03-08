package controller;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import beans.DonHang;
import beans.User;
import dao.DaoChiTietDonHang;
import dao.DaoDonHang;

/**
 * Đơn hàng: success/bill cho khách; list + xác nhận/pha chế/thanh toán cho nhân viên.
 */
@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private DaoDonHang daoDonHang;
    @Autowired
    private DaoChiTietDonHang daoChiTietDonHang;

    @GetMapping("/success/{id}")
    public String success(@PathVariable int id, Model model) {
        DonHang dh = daoDonHang.findById(id);
        if (dh == null) {
            return "redirect:/cart";
        }
        dh.setChiTiet(daoChiTietDonHang.findByDonHang(id));
        model.addAttribute("order", dh);
        return "order_success";
    }

    @GetMapping("/bill/{id}")
    public String bill(@PathVariable int id, Model model) {
        DonHang dh = daoDonHang.findById(id);
        if (dh == null) {
            return "redirect:/cart";
        }
        dh.setChiTiet(daoChiTietDonHang.findByDonHang(id));
        model.addAttribute("order", dh);
        return "order_bill";
    }

    @GetMapping("/list")
    public String list(@RequestParam(name = "tab", defaultValue = "confirm") String tab,
                      HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        int status = 0;
        if ("brewing".equals(tab)) status = 1;
        else if ("payment".equals(tab)) status = 2;
        else if ("done".equals(tab)) status = 3;
        List<DonHang> orders = daoDonHang.findByStatus(status);
        for (DonHang dh : orders) {
            dh.setChiTiet(daoChiTietDonHang.findByDonHang(dh.getId()));
        }
        model.addAttribute("orders", orders);
        model.addAttribute("tab", tab);
        model.addAttribute("permission", user != null ? user.getTenQuyen() : "");
        return "order_list";
    }

    @PostMapping("/confirm/{id}")
    public String confirm(@PathVariable int id, RedirectAttributes ra) {
        daoDonHang.updateStatus(id, 1);
        ra.addFlashAttribute("success", "Đã xác nhận đơn #" + id);
        return "redirect:/order/list?tab=confirm";
    }

    @PostMapping("/brewed/{id}")
    public String brewed(@PathVariable int id, RedirectAttributes ra) {
        daoDonHang.updateStatus(id, 2);
        ra.addFlashAttribute("success", "Đã chuyển đơn #" + id + " cho thu ngân.");
        return "redirect:/order/list?tab=brewing";
    }

    @PostMapping("/pay/{id}")
    public String pay(@PathVariable int id, RedirectAttributes ra) {
        daoDonHang.updateStatus(id, 3);
        ra.addFlashAttribute("success", "Đã thanh toán đơn #" + id);
        return "redirect:/order/list?tab=payment";
    }
}
