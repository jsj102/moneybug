package com.multi.moneybug.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class ProductController {

    @Autowired
    ProductService productService;

    // 쇼핑 목록 페이지
    @RequestMapping("product/shoplist")
    public String getProductList(ProductDTO productDTO, Model model) {
        // ProductService를 이용하여 상품 리스트를 데이터베이스에서 가져옵니다.
        List<ProductDTO> productList = productService.getAllProducts(productDTO);
        model.addAttribute("productList", productList);
        
        return "/product/shoplist"; 
    }
    
    // 상품 상세페이지로 이동
    @RequestMapping("product/shopDetail")
    public String getProductDetail(@RequestParam("productId") int productId, Model model) {
    	ProductDTO productDTO = productService.getProductById(productId);
        model.addAttribute("productDTO", productDTO);
    	return "product/shopDetail";
    }
    
    // 쇼핑 관리자 페이지 (관리자 상품 리스트 ajax)
    @RequestMapping("product/manageList")
    public void showManageList(ProductDTO productDTO,Model model) {
    	List<ProductDTO> productList = productService.list(productDTO);
    	model.addAttribute("productList", productList);
    }
    
    // 쇼핑 관리자 페이지 (상품 추가폼으로 이동)
    @RequestMapping("product/manageInsert")
    public void goManageInsert() {
    }
    
    // 쇼핑 관리자 페이지 (상품 DB에 추가)
    @RequestMapping("product/productInsert")
    public String productInsert(ProductDTO productDTO) {
    	productService.insertNewProduct(productDTO);
    	return "redirect:../product/shopmanager.jsp";
    }
    
    
}