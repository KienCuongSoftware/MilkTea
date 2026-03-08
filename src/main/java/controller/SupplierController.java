package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import beans.Supplier;
import dao.DaoSupplier;

@Controller
@RequestMapping("/supplier")
public class SupplierController {
	@Autowired
    private DaoSupplier daoSupplier;
	
	@GetMapping("/view")
    public String views(Model model) {
        List<Supplier> suppliers = daoSupplier.list();
        model.addAttribute("suppliers", suppliers);
        return "supplier_list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("supplier", new Supplier());
        return "supplier_create_form";
    }

    @PostMapping("/add")
    public String add(@ModelAttribute Supplier supplier, BindingResult result, Model model, HttpSession session) {
        if (result.hasErrors()) {
            return "supplier_create_form";
        }
        daoSupplier.save(supplier);
        return "redirect:/supplier/view";
    }
    
    @PostMapping("/delete/{maNhaCungCap}")
    public String deleteSupplier(@PathVariable int maNhaCungCap, @RequestParam(name = "csrfToken", required = false) String token, HttpSession session) {
        if (token == null || !token.equals(session.getAttribute(GlobalControllerAdvice.CSRF_TOKEN))) {
            return "redirect:/supplier/view";
        }
        daoSupplier.delete(maNhaCungCap);
        return "redirect:/supplier/view";
    }
    
    @GetMapping("/edit/{maNhaCungCap}")
    public String showEditForm(@PathVariable int maNhaCungCap, Model model, HttpSession session) {
    	Supplier supplier = daoSupplier.getSupplierById(maNhaCungCap);
        if (supplier == null) {
            return "redirect:/supplier/view";
        }
        model.addAttribute("supplier", supplier);
        return "supplier_edit_form";
    }

    @PostMapping("/edit/{maNhaCungCap}")
    public String updateProduct(@PathVariable int maNhaCungCap, @ModelAttribute Supplier supplier, 
                              BindingResult result, Model model, HttpSession session) {
        if (result.hasErrors()) {
            return "supplier_edit_form";
        }
        supplier.setCode(maNhaCungCap);
        daoSupplier.update(supplier);
        return "redirect:/supplier/view";
    }
}
