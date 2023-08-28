package com.multi.moneybug.product;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.multi.moneybug.member.MemberService;

@Controller
public class BasketController {
    
    @Autowired
    BasketService basketService;
    @Autowired
    MemberService memberService;
    @Autowired
    ProductService productService;
    
    @RequestMapping("product/basketlist")
    public String getBasketList(HttpSession session, Model model) {
        // 세션에서 userNickname 얻어오기
        String userNickname = (String) session.getAttribute("userNickname");
        
        // userNickname에 해당하는 user_id 조회하기
        String userId = memberService.getUserIdByUserNickname(userNickname);

        // user_id로 장바구니 목록 조회
        List<BasketDTO> basketlist = basketService.getAllBaskets(userId);
        model.addAttribute("basketList", basketlist);
        
        // 장바구니에 있는 각 product_ID 추출하여 리스트에 저장
        List<Integer> productIds = new ArrayList<>();
        for (BasketDTO basket : basketlist) {
            productIds.add(basket.getProductId());
        }
        
        // product_ID 리스트를 이용하여 상품 목록 조회
        List<ProductDTO> productlist = productService.getProductsByIds(productIds);
        // 상품 목록을 모델에 추가
        model.addAttribute("productList", productlist);
        		
        return "product/basketlist";
    }
    
    
    @RequestMapping("/addToCart")
    @ResponseBody
    public String addToCart(@RequestParam int productId, @RequestParam String userNickname, @RequestParam int count) {
        // 세션의 닉네임 값으로 user_id 조회하기
        String userId = memberService.getUserIdByUserNickname(userNickname);

        // productId와 userId를 이용하여 장바구니에 해당 상품이 있는지 확인
        boolean productInBasket = basketService.checkProductInBasket(userId, productId);
        
        System.out.println(productInBasket);
        if (productInBasket == true) {
            // 이미 장바구니에 있는 경우 업데이트 로직 실행
        	System.out.println("업데이트실행");
            basketService.updateProductInBasket(userId, productId, count);
        } else {
            // 장바구니에 없는 경우 새로운 레코드 삽입 로직 실행
            basketService.addToBasket(userId, productId, count);
        }

        return "successfully";
    }

}

        