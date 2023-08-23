package com.multi.moneybug.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class ProductController {

    @Autowired
    ProductService productService;

    // 쇼핑 목록 페이지
    @RequestMapping("product/shoplist")
    public String getProductList(ProductPageDTO productpageDTO, Model model) {
    	int count = productService.count();
    	int pages = (count / 6) + 1;
    	productpageDTO.setStartEnd(productpageDTO.getPage());
        List<ProductDTO> productList = productService.getAllProducts(productpageDTO);
        System.out.println(productList);
        model.addAttribute("productList", productList);
        model.addAttribute("count", count);
        model.addAttribute("pages", pages);
        
        return "/product/shoplist"; 
    }
    
    // 상품 상세페이지로 이동
    @RequestMapping("product/shopDetail")
    public String getProductDetail(@RequestParam("productId") int productId, Model model) {
    	ProductDTO productDTO = productService.getProductById(productId);
        model.addAttribute("productDTO", productDTO);
        System.out.println(productDTO);
    	return "product/shopDetail";
    }
    
    // 쇼핑 관리자 페이지 (관리자 상품 리스트 ajax)
    @RequestMapping("product/manageList")
    public void showManageList(ProductDTO productDTO,Model model) {
    	List<ProductDTO> productList = productService.list(productDTO);
    	System.out.println(productList);
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
    
    @PostMapping("product/submitOrder")
    public String submitOrder(ProductDTO productDTO) {
    	//TODO 체크된 항목만 가져가기
    	return "product/orderlist";
    }
    
    
}