package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import beans.Voucher;
import dao.DaoVoucher;

/**
 * Trang xem / chọn mã giảm giá cho khách hàng (chỉ list, không thêm sửa xóa).
 */
@Controller
@RequestMapping("/voucher")
public class VoucherController {

    @Autowired
    private DaoVoucher daoVoucher;

    @GetMapping("/list")
    public String list(Model model) {
        List<Voucher> vouchers = daoVoucher.findAll();
        model.addAttribute("vouchers", vouchers);
        return "voucher_list";
    }
}
