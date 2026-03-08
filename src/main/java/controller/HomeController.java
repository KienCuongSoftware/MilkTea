package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.ServletContext;
import java.io.File;
import java.util.List;
import beans.Product;
import beans.Category;
import beans.DonHang;
import dao.DaoProduct;
import dao.DaoCategory;
import dao.DaoDonHang;
import dao.DaoChiTietDonHang;
import javax.servlet.http.HttpSession;
import beans.User;

@Controller
public class HomeController {
	
    @Autowired
    private DaoProduct daoProduct;

    @Autowired
    private DaoCategory daoCategory;

    @Autowired
    private DaoDonHang daoDonHang;

    @Autowired
    private DaoChiTietDonHang daoChiTietDonHang;

    @Autowired
    ServletContext servletContext;

    private void checkAndSetSession(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            // Đặt thời gian timeout session là 30 phút
            session.setMaxInactiveInterval(30 * 60);
            model.addAttribute("loggedInUser", loggedInUser);
            model.addAttribute("permission", loggedInUser.getTenQuyen().toLowerCase());
        }
    }

    @RequestMapping(value = {"/", "/home"})
    public String home(Model model, HttpSession session) {
        checkAndSetSession(session, model);
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return redirectToHomeWithProducts(model);
        }
        String permission = user.getTenQuyen() != null ? user.getTenQuyen().toLowerCase() : "";
        if (!"khách hàng".equals(permission)) {
            return "redirect:/dashboard";
        }
        return redirectToHomeWithProducts(model);
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        checkAndSetSession(session, model);
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }
        String permission = user.getTenQuyen() != null ? user.getTenQuyen().toLowerCase() : "";
        if ("khách hàng".equals(permission)) {
            return "redirect:/home";
        }

        if ("nhân viên order".equals(permission)) {
            List<DonHang> orders = daoDonHang.findByStatus(0);
            for (DonHang dh : orders) {
                dh.setChiTiet(daoChiTietDonHang.findByDonHang(dh.getId()));
            }
            List<Object[]> compByDay = daoDonHang.getCompletedOrdersCountByDay(7);
            List<String> compLabels = new java.util.ArrayList<>();
            List<Integer> compData = new java.util.ArrayList<>();
            for (Object[] c : compByDay) {
                compLabels.add((String) c[0]);
                compData.add((Integer) c[1]);
            }
            model.addAttribute("orders", orders);
            model.addAttribute("completedLabels", compLabels);
            model.addAttribute("completedData", compData);
            model.addAttribute("dashboardTitle", "Order");
            model.addAttribute("dashboardRole", "order");
            return "dashboard";
        }
        if ("nhân viên pha chế".equals(permission)) {
            List<DonHang> orders = daoDonHang.findByStatus(1);
            for (DonHang dh : orders) {
                dh.setChiTiet(daoChiTietDonHang.findByDonHang(dh.getId()));
            }
            List<Object[]> compByDay = daoDonHang.getCompletedOrdersCountByDay(7);
            List<String> compLabels = new java.util.ArrayList<>();
            List<Integer> compData = new java.util.ArrayList<>();
            for (Object[] c : compByDay) {
                compLabels.add((String) c[0]);
                compData.add((Integer) c[1]);
            }
            model.addAttribute("orders", orders);
            model.addAttribute("completedLabels", compLabels);
            model.addAttribute("completedData", compData);
            model.addAttribute("dashboardTitle", "Pha chế");
            model.addAttribute("dashboardRole", "brewing");
            return "dashboard";
        }
        if ("nhân viên thu ngân".equals(permission)) {
            List<DonHang> orders = daoDonHang.findByStatus(2);
            for (DonHang dh : orders) {
                dh.setChiTiet(daoChiTietDonHang.findByDonHang(dh.getId()));
            }
            List<Object[]> compByDay = daoDonHang.getCompletedOrdersCountByDay(7);
            List<String> compLabels = new java.util.ArrayList<>();
            List<Integer> compData = new java.util.ArrayList<>();
            for (Object[] c : compByDay) {
                compLabels.add((String) c[0]);
                compData.add((Integer) c[1]);
            }
            model.addAttribute("orders", orders);
            model.addAttribute("completedLabels", compLabels);
            model.addAttribute("completedData", compData);
            model.addAttribute("dashboardTitle", "Thu ngân");
            model.addAttribute("dashboardRole", "cashier");
            return "dashboard";
        }
        if ("nhân viên kho".equals(permission)) {
            List<Product> lowStock = daoProduct.getLowStockProducts(10);
            for (Product p : lowStock) {
                Category c = daoCategory.getCategoryById(p.getMaDM());
                if (c != null) p.setTenDM(c.getTenDM());
            }
            model.addAttribute("totalProducts", daoProduct.getTotalProducts());
            model.addAttribute("lowStockCount", daoProduct.getLowStockCount(10));
            model.addAttribute("lowStockProducts", lowStock);
            model.addAttribute("dashboardTitle", "Quản lý kho");
            model.addAttribute("dashboardRole", "warehouse");
            return "dashboard";
        }
        if ("quản lý".equals(permission) || "chủ quán".equals(permission)) {
            int lastDays = 7;
            List<Object[]> revByDay = daoDonHang.getRevenueByDay(lastDays);
            List<Object[]> compByDay = daoDonHang.getCompletedOrdersCountByDay(lastDays);
            List<String> revLabels = new java.util.ArrayList<>();
            List<java.math.BigDecimal> revData = new java.util.ArrayList<>();
            for (Object[] r : revByDay) {
                revLabels.add((String) r[0]);
                revData.add((java.math.BigDecimal) r[1]);
            }
            List<String> compLabels = new java.util.ArrayList<>();
            List<Integer> compData = new java.util.ArrayList<>();
            for (Object[] c : compByDay) {
                compLabels.add((String) c[0]);
                compData.add((Integer) c[1]);
            }
            model.addAttribute("orderCountConfirm", daoDonHang.countByStatus(0));
            model.addAttribute("orderCountBrewing", daoDonHang.countByStatus(1));
            model.addAttribute("orderCountPayment", daoDonHang.countByStatus(2));
            model.addAttribute("orderCountDone", daoDonHang.countByStatus(3));
            model.addAttribute("totalRevenue", daoDonHang.getTotalRevenue());
            model.addAttribute("totalProducts", daoProduct.getTotalProducts());
            model.addAttribute("revenueLabels", revLabels);
            model.addAttribute("revenueData", revData);
            model.addAttribute("completedLabels", compLabels);
            model.addAttribute("completedData", compData);
            model.addAttribute("dashboardTitle", "Tổng quan");
            model.addAttribute("dashboardRole", "admin");
            return "dashboard";
        }
        return "redirect:/home";
    }

    private String redirectToHomeWithProducts(Model model) {
        List<Product> products = daoProduct.getProducts();
        List<Category> categories = daoCategory.getAllCategories();
        for (Product product : products) {
            Category category = daoCategory.getCategoryById(product.getMaDM());
            if (category != null) {
                product.setTenDM(category.getTenDM());
            }
        }
        model.addAttribute("products", products);
        model.addAttribute("categories", categories);
        return "home";
    }

    @GetMapping("/product_create_form")
    public String showForm(Model model, HttpSession session) {
        checkAndSetSession(session, model);
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }
        model.addAttribute("product", new Product());
        model.addAttribute("categories", daoCategory.getAllCategories());
        return "product_create_form";
    }

    @PostMapping(value="/save")
    public String save(@ModelAttribute("product") Product prd, 
                      @RequestParam("imageFile") MultipartFile file,
                      BindingResult result,
                      Model model,
                      HttpSession session) {
        checkAndSetSession(session, model);
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }
        
        try {
            // Validate giá sản phẩm
            if (prd.getDonGia() != null && prd.getDonGia().doubleValue() > 999999) {
                model.addAttribute("error", "Giá sản phẩm không thể vượt quá 999,999");
                model.addAttribute("categories", daoCategory.getAllCategories());
                return "product_create_form";
            }

            // Xử lý upload file
            if (!file.isEmpty()) {
                // Lấy đường dẫn thực tế đến thư mục images
                String uploadPath = servletContext.getRealPath("/resources/images/");
                
                // Tạo thư mục nếu chưa tồn tại
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                
                // Lấy tên file gốc
                String fileName = file.getOriginalFilename();
                
                // Lưu file vào thư mục
                File uploadedFile = new File(uploadPath + File.separator + fileName);
                file.transferTo(uploadedFile);
                
                // Lưu tên file vào đối tượng Product
                prd.setHinhAnh(fileName);
            }
            
            // Lưu sản phẩm vào database
            daoProduct.save(prd);
            return "redirect:/product/view";
            
        } catch (Exception e) {
            model.addAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            model.addAttribute("categories", daoCategory.getAllCategories());
            return "product_create_form";
        }
    }
    
    

    @RequestMapping("/product/view")
    public String viewProducts(Model model, HttpSession session) {
        checkAndSetSession(session, model);
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }
        
        List<Product> products = daoProduct.getProducts();
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
        model.addAttribute("list", products);
        return "product_list";
    }
    
    

    @RequestMapping(value = "/editproduct/{idSanPham}")
    public String edit(@PathVariable int idSanPham, Model model, HttpSession session) {
        checkAndSetSession(session, model);
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }
        
        Product product = daoProduct.getProductById(idSanPham);
        model.addAttribute("product", product);
        model.addAttribute("categories", daoCategory.getAllCategories());
        return "product_edit_form";
    }

    @RequestMapping(value = "/editsave", method = RequestMethod.POST)
    public String editSave(@ModelAttribute("product") Product product,
                          @RequestParam(value = "imageFile", required = false) MultipartFile file,
                          BindingResult result,
                          Model model,
                          HttpSession session) {
        checkAndSetSession(session, model);
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }
        
        try {
            // Validate giá sản phẩm
            if (product.getDonGia() != null && product.getDonGia().doubleValue() > 999999) {
                model.addAttribute("error", "Giá sản phẩm không thể vượt quá 999,999");
                model.addAttribute("categories", daoCategory.getAllCategories());
                return "product_edit_form";
            }

            if (result.hasErrors()) {
                System.out.println("Có lỗi trong dữ liệu: " + result.getAllErrors());
                return "product_edit_form";
            }

            // Xử lý upload file
            if (file != null && !file.isEmpty()) {
                // Lấy đường dẫn thực tế đến thư mục images
                String uploadPath = servletContext.getRealPath("/resources/images/");
                
                // Tạo thư mục nếu chưa tồn tại
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                
                // Lấy tên file gốc
                String fileName = file.getOriginalFilename();
                
                // Lưu file vào thư mục
                File uploadedFile = new File(uploadPath + File.separator + fileName);
                file.transferTo(uploadedFile);
                
                // Cập nhật tên file vào đối tượng Product
                product.setHinhAnh(fileName);
            }
            
            daoProduct.update(product);
            return "redirect:/product/view";
        } catch (Exception e) {
            model.addAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            model.addAttribute("categories", daoCategory.getAllCategories());
            return "product_edit_form";
        }
    }

    @RequestMapping(value = "/deleteproduct/{idSanPham}", method = RequestMethod.GET)
    public String delete(@PathVariable int idSanPham, HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }
        daoProduct.delete(idSanPham);
        return "redirect:/product/view";
    }
    
    @GetMapping("/search")
    public String searchProducts(@RequestParam(required = false) String keyword,
                               @RequestParam(required = false) Integer category,
                               Model model,
                               HttpSession session) {
        checkAndSetSession(session, model);
        
        List<Product> searchResults = daoProduct.searchProducts(keyword, category);
        List<Category> categories = daoCategory.getAllCategories();
        
        // Set category names for products
        for (Product product : searchResults) {
            for (Category cat : categories) {
                if (cat.getMaDM() == product.getMaDM()) {
                    product.setTenDM(cat.getTenDM());
                    break;
                }
            }
        }
        
        model.addAttribute("products", searchResults);
        model.addAttribute("categories", categories);
        model.addAttribute("keyword", keyword);
        model.addAttribute("selectedCategory", category);
        
        return "home";
    }
}

