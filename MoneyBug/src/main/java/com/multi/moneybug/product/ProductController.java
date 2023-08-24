package com.multi.moneybug.product;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

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
    @Autowired
    BasketService basketService;
    

    // 쇼핑 목록 페이지
    @RequestMapping("product/shoplist")
    public String getProductList(ProductPageDTO productpageDTO, Model model) {
    	int count = productService.count();
    	int pages = (count / 6) + 1;
    	productpageDTO.setStartEnd(productpageDTO.getPage());
        List<ProductDTO> productList = productService.getAllProducts(productpageDTO);
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
    
    @PostMapping("product/orderlist")
    public String submitOrder(
        @RequestParam("totalAmount") String totalAmount,
        @RequestParam("selectedId") List<String> selectedIdsStr,
        @RequestParam("seletedSeq") List<String> selectedSeqsStr,// 변경된 변수명
        ProductDTO productDTO, Model model
    ) {
    	
    	//int형으로 형변환
        List<Integer> selectedIds = new ArrayList<>();       
        for (String idStr : selectedIdsStr) {
            selectedIds.add(Integer.parseInt(idStr));
        }
        
       	//int형으로 형변환
        List<Integer> selectedSeqs = new ArrayList<>();       
        for (String idStr : selectedSeqsStr) {
        	selectedSeqs.add(Integer.parseInt(idStr));
        }
        
        List<BasketDTO> orderlist = basketService.getOrderlists(selectedSeqs);        
        // selectedIds를 이용하여 필요한 처리 수행
        List<ProductDTO> productlist = productService.getProductsByIds(selectedIds);     
        
        model.addAttribute("orderlist", orderlist);
        model.addAttribute("productlist", productlist);
        model.addAttribute("totalAmount", totalAmount);
        return "product/orderlist"; // orderlist.jsp와 매핑되는 뷰 이름
    }



    
}