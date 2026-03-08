package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;
import beans.Product;
import beans.Category;
import beans.ProductDetail;
import beans.DanhGia;
import beans.BinhLuan;
import beans.User;
import dao.DaoProduct;
import dao.DaoCategory;
import dao.DaoProductDetail;
import dao.DaoDanhGia;
import dao.DaoBinhLuan;

@Controller
@RequestMapping("/product")
public class ProductController {
    
    @Autowired
    private DaoProduct daoProduct;
    
    @Autowired
    private DaoCategory daoCategory;
    
    @Autowired
    private DaoProductDetail daoProductDetail;

    @Autowired
    private DaoDanhGia daoDanhGia;
    @Autowired
    private DaoBinhLuan daoBinhLuan;

    @GetMapping("/view")
    public String viewProducts(Model model) {
        List<Product> products = daoProduct.getProducts();
        List<Category> categories = daoCategory.getAllCategories();
        
        for (Product product : products) {
            try {
                Category category = daoCategory.getCategoryById(product.getMaDM());
                if (category != null) {
                    product.setTenDM(category.getTenDM());
                } else {
                    product.setTenDM("Không xác định");
                }
            } catch (Exception e) {
                product.setTenDM("Lỗi");
            }
        }
        model.addAttribute("products", products);
        model.addAttribute("categories", categories);
        return "product_list";
    }

    @GetMapping("/search")
    public String searchProducts(@RequestParam(required = false) String keyword,
                               @RequestParam(required = false) Integer category,
                               Model model) {
        List<Product> products = daoProduct.searchProducts(keyword, category);
        List<Category> categories = daoCategory.getAllCategories();
        
        // Set category names for products
        for (Product product : products) {
            for (Category cat : categories) {
                if (cat.getMaDM() == product.getMaDM()) {
                    product.setTenDM(cat.getTenDM());
                    break;
                }
            }
        }
        
        model.addAttribute("products", products);
        model.addAttribute("categories", categories);
        model.addAttribute("keyword", keyword);
        model.addAttribute("selectedCategory", category);
        
        return "product_list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("product", new Product());
        model.addAttribute("categories", daoCategory.getAllCategories());
        return "product_create_form";
    }

    @PostMapping("/add")
    public String addProduct(@ModelAttribute Product product, BindingResult result, Model model) {
        if (result.hasErrors()) {
            model.addAttribute("categories", daoCategory.getAllCategories());
            return "product_create_form";
        }
        
        daoProduct.save(product);
        return "redirect:/product/view";
    }

    @GetMapping("/edit/{maSP}")
    public String showEditForm(@PathVariable int maSP, Model model) {
        Product product = daoProduct.getProductById(maSP);
        if (product == null) {
            return "redirect:/product/view";
        }
        
        model.addAttribute("product", product);
        model.addAttribute("categories", daoCategory.getAllCategories());
        return "product_edit_form";
    }

    @PostMapping("/edit/{maSP}")
    public String updateProduct(@PathVariable int maSP, @ModelAttribute Product product, 
                              BindingResult result, Model model) {
        if (result.hasErrors()) {
            model.addAttribute("categories", daoCategory.getAllCategories());
            return "product_edit_form";
        }
        
        daoProduct.update(product);
        return "redirect:/product/view";
    }

    @PostMapping("/delete/{maSP}")
    public String deleteProduct(@PathVariable int maSP, @RequestParam(name = "csrfToken", required = false) String token, HttpSession session) {
        if (token == null || !token.equals(session.getAttribute(GlobalControllerAdvice.CSRF_TOKEN))) {
            return "redirect:/product/view";
        }
        daoProduct.delete(maSP);
        return "redirect:/product/view";
    }

    @GetMapping("/detail/{maSP}")
    public String viewDetail(@PathVariable int maSP, Model model) {
        Product product = daoProduct.getProductById(maSP);
        if (product == null) {
            return "redirect:/product/view";
        }
        
        Category category = daoCategory.getCategoryById(product.getMaDM());
        if (category != null) {
            product.setTenDM(category.getTenDM());
        }
        
        ProductDetail detail = daoProductDetail.getProductDetailByProductId(maSP);
        if (detail == null) {
            detail = new ProductDetail();
            detail.setMaSP(maSP);
        }
        
        List<Product> allProducts = daoProduct.getProducts();
        List<Product> relatedProducts = new java.util.ArrayList<>();
        for (Product p : allProducts) {
            if (p.getMaDM() == product.getMaDM() && p.getMaSP() != product.getMaSP()) {
                Category cat = daoCategory.getCategoryById(p.getMaDM());
                if (cat != null) {
                    p.setTenDM(cat.getTenDM());
                }
                relatedProducts.add(p);
                if (relatedProducts.size() >= 4) {
                    break;
                }
            }
        }

        List<DanhGia> reviews = daoDanhGia.findByMaSP(maSP);
        Double avgRating = daoDanhGia.getAverageRating(maSP);
        int totalRatings = daoDanhGia.getTotalRatings(maSP);
        int[] ratingCounts = new int[6];
        for (int i = 1; i <= 5; i++) {
            ratingCounts[i] = daoDanhGia.getCountByDiem(maSP, i);
        }
        List<BinhLuan> comments = daoBinhLuan.findByMaSP(maSP);
        
        model.addAttribute("product", product);
        model.addAttribute("detail", detail);
        model.addAttribute("relatedProducts", relatedProducts);
        model.addAttribute("reviews", reviews);
        model.addAttribute("avgRating", avgRating);
        model.addAttribute("totalRatings", totalRatings);
        model.addAttribute("ratingCounts", ratingCounts);
        model.addAttribute("comments", comments);
        return "product_detail";
    }

    @PostMapping("/detail/{maSP}/review")
    public String addReview(@PathVariable int maSP, @RequestParam int diem, @RequestParam(required = false) String noiDung,
                            HttpSession session, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để đánh giá sản phẩm.");
            return "redirect:/login?redirect=/product/detail/" + maSP;
        }
        if (diem < 1 || diem > 5) {
            redirectAttributes.addFlashAttribute("error", "Điểm đánh giá phải từ 1 đến 5.");
            return "redirect:/product/detail/" + maSP;
        }
        DanhGia d = new DanhGia();
        d.setMaND(user.getMaNd());
        d.setMaSP(maSP);
        d.setDiem(diem);
        d.setNoiDung(noiDung != null ? noiDung.trim() : null);
        daoDanhGia.save(d);
        redirectAttributes.addFlashAttribute("success", "Cảm ơn bạn đã đánh giá sản phẩm!");
        return "redirect:/product/detail/" + maSP;
    }

    @PostMapping("/detail/{maSP}/comment")
    public String addComment(@PathVariable int maSP, @RequestParam String noiDung,
                             HttpSession session, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập để bình luận.");
            return "redirect:/login?redirect=/product/detail/" + maSP;
        }
        if (noiDung == null || noiDung.trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Nội dung bình luận không được để trống.");
            return "redirect:/product/detail/" + maSP;
        }
        BinhLuan b = new BinhLuan();
        b.setMaND(user.getMaNd());
        b.setMaSP(maSP);
        b.setNoiDung(noiDung.trim());
        daoBinhLuan.save(b);
        redirectAttributes.addFlashAttribute("success", "Đã gửi bình luận.");
        return "redirect:/product/detail/" + maSP;
    }

    @PostMapping("/detail/save")
    public String saveDetail(@ModelAttribute ProductDetail detail, RedirectAttributes redirectAttributes) {
        try {
            boolean success;
            if (daoProductDetail.getProductDetailByProductId(detail.getMaSP()) == null) {
                success = daoProductDetail.save(detail);
            } else {
                success = daoProductDetail.update(detail);
            }
            
            if (success) {
                redirectAttributes.addFlashAttribute("success", "Lưu chi tiết sản phẩm thành công!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Không thể lưu chi tiết sản phẩm!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        return "redirect:/product/detail/" + detail.getMaSP();
    }

    @PostMapping("/detail/delete/{maSP}")
    public String deleteDetail(@PathVariable int maSP, @RequestParam(name = "csrfToken", required = false) String token,
                              HttpSession session, RedirectAttributes redirectAttributes) {
        if (token == null || !token.equals(session.getAttribute(GlobalControllerAdvice.CSRF_TOKEN))) {
            return "redirect:/product/view";
        }
        try {
            if (daoProductDetail.delete(maSP)) {
                redirectAttributes.addFlashAttribute("success", "Xóa chi tiết sản phẩm thành công!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Không thể xóa chi tiết sản phẩm!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        return "redirect:/product/view";
    }
} 