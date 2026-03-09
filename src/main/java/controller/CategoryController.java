package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;
import beans.Category;
import dao.DaoCategory;
import dao.DaoProduct;
import dao.DaoProductDetail;
import dao.DaoChiTietDonHang;

@Controller
@RequestMapping("/category")
public class CategoryController {
    
    @Autowired
    private DaoCategory daoCategory;
    @Autowired
    private DaoProduct daoProduct;
    @Autowired
    private DaoProductDetail daoProductDetail;
    @Autowired
    private DaoChiTietDonHang daoChiTietDonHang;
    
    @GetMapping("/view")
    public String viewCategories(Model model) {
        try {
            System.out.println("Fetching all categories...");
            List<Category> categories = daoCategory.getAllCategories();
            System.out.println("Found " + categories.size() + " categories");
            model.addAttribute("categories", categories);
            return "category_list";
        } catch (Exception e) {
            System.out.println("Error in viewCategories: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Có lỗi xảy ra khi tải danh sách danh mục");
            return "category_list";
        }
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("category", new Category());
        return "category_create_form";
    }

    @PostMapping("/add")
    public String addCategory(@ModelAttribute Category category, RedirectAttributes redirectAttributes) {
        try {
            System.out.println("Adding new category: " + category.getTenDM());
            // Kiểm tra xem tên danh mục có bị trống không
            if (category.getTenDM() == null || category.getTenDM().trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Tên danh mục không được để trống!");
                return "redirect:/category/add";
            }
            
            // Thực hiện thêm danh mục
            if (daoCategory.addCategory(category)) {
                System.out.println("Category added successfully");
                redirectAttributes.addFlashAttribute("success", "Thêm danh mục thành công!");
            } else {
                System.out.println("Failed to add category");
                redirectAttributes.addFlashAttribute("error", "Không thể thêm danh mục!");
            }
            return "redirect:/category/view";
        } catch (Exception e) {
            System.out.println("Error in addCategory: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            return "redirect:/category/add";
        }
    }

    @GetMapping("/edit/{maDM}")
    public String showEditForm(@PathVariable int maDM, Model model, RedirectAttributes redirectAttributes) {
        Category category = daoCategory.getCategoryById(maDM);
        if (category == null) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy danh mục!");
            return "redirect:/category/view";
        }
        model.addAttribute("category", category);
        return "category_edit_form";
    }

    @PostMapping("/edit/{maDM}")
    public String updateCategory(@PathVariable int maDM, @ModelAttribute Category category, 
                               RedirectAttributes redirectAttributes) {
        try {
            // Kiểm tra xem tên danh mục có bị trống không
            if (category.getTenDM() == null || category.getTenDM().trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Tên danh mục không được để trống!");
                return "redirect:/category/edit/" + maDM;
            }
            
            category.setMaDM(maDM); // Đảm bảo maDM được set đúng
            if (daoCategory.updateCategory(category)) {
                redirectAttributes.addFlashAttribute("success", "Cập nhật danh mục thành công!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Không thể cập nhật danh mục!");
            }
            return "redirect:/category/view";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            return "redirect:/category/edit/" + maDM;
        }
    }

    @PostMapping("/delete/{maDM}")
    public String deleteCategory(@PathVariable int maDM, @RequestParam(name = "csrfToken", required = false) String token,
                                 HttpSession session, RedirectAttributes redirectAttributes) {
        if (token == null || !token.equals(session.getAttribute(GlobalControllerAdvice.CSRF_TOKEN))) {
            return "redirect:/category/view";
        }
        try {
            // Xóa cascade: trước khi xóa danh mục, xóa hết sản phẩm thuộc danh mục (và phụ thuộc)
            List<Integer> productIds = daoProduct.getMaSPByMaDM(maDM);
            for (Integer maSP : productIds) {
                daoChiTietDonHang.nullOutSanPham(maSP);
                daoProductDetail.delete(maSP);
                daoProduct.delete(maSP);
            }
            if (daoCategory.deleteCategory(maDM)) {
                redirectAttributes.addFlashAttribute("success", "Xóa danh mục thành công!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Không thể xóa danh mục!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        return "redirect:/category/view";
    }

    @GetMapping("/search")
    public String searchCategories(@RequestParam(required = false) String keyword, Model model) {
        List<Category> categories;
        if (keyword != null && !keyword.trim().isEmpty()) {
            categories = daoCategory.searchCategories(keyword);
            model.addAttribute("keyword", keyword);
        } else {
            categories = daoCategory.getAllCategories();
        }
        model.addAttribute("categories", categories);
        return "category_list";
    }
} 