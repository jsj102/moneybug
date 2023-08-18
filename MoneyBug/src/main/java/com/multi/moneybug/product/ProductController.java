package com.multi.moneybug.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ProductController {

    @Autowired
    ProductService productService;

    @RequestMapping("product/shoplist")
    public String getProductList(ProductDTO productDTO, Model model) {
        // ProductService를 이용하여 상품 리스트를 데이터베이스에서 가져옵니다.
        List<ProductDTO> productList = productService.getAllProducts(productDTO);
        // 가져온 상품 리스트를 Model에 담아서 뷰로 전달합니다.
        model.addAttribute("productList", productList);

        // 뷰 이름을 반환합니다. 뷰는 Thymeleaf 등을 사용해서 생성할 수 있습니다.
        return "product/shoplist"; // 여기에 실제 뷰 이름을 적어야 합니다.
    }
}
