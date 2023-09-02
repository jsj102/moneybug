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
        
        if (basketlist.isEmpty()) {
            model.addAttribute("basketIsEmpty", true); // 장바구니가 비어있음을 표시
        } else {
            model.addAttribute("basketIsEmpty", false); // 장바구니가 비어있지 않음을 표시
            
            // 장바구니에 있는 각 product_ID 추출하여 리스트에 저장
            List<Integer> productIds = new ArrayList<>();
            for (BasketDTO basket : basketlist) {
                productIds.add(basket.getProductId());
            }
            
            // product_ID 리스트를 이용하여 상품 목록 조회
            List<ProductDTO> productlist = productService.getProductsByIds(productIds);
            // 상품 목록을 모델에 추가
            model.addAttribute("productList", productlist);
            model.addAttribute("basketList",basketlist);
        }
        
        return "product/basketlist";
    }

    
    
    @RequestMapping("/addToCart")
    @ResponseBody
    public String addToCart(@RequestParam int productId, @RequestParam String userNickname, @RequestParam int count) {
        // 세션의 닉네임 값으로 user_id 조회하기
        String userId = memberService.getUserIdByUserNickname(userNickname);
        // productId와 userId를 이용하여 장바구니에 해당 상품이 있는지 확인
        boolean productInBasket = basketService.checkProductInBasket(userId, productId);
        if (productInBasket == true) {
            // 이미 장바구니에 있는 경우 업데이트 로직 실행
            basketService.updateProductInBasket(userId, productId, count);
        } else {
            // 장바구니에 없는 경우 새로운 레코드 삽입 로직 실행
            basketService.addToBasket(userId, productId, count);
        }

        return "successfully";
    }
    
    @RequestMapping("/updateQuantity")
    @ResponseBody
    public String updateQuantity(
        @RequestParam("productId") int productId,
        @RequestParam("newCount") int newCount, HttpSession session
    ) {

        // userNickname로 userId 조회
        String userNickname = (String) session.getAttribute("userNickname");
        String userId = memberService.getUserIdByUserNickname(userNickname);

        List<Integer> seqList = basketService.getSeqList(); // getSeqList() 메소드는 List<String> 타입으로 seq 값을 반환하는 것으로 가정합니다
        
        // 업데이트 로직 실행
        for (int seq : seqList) {
            basketService.updateProductCount(userId, productId, seq, newCount);
        }

        return "success";
    }


    @RequestMapping("/deleteProduct")
    @ResponseBody
    public String deleteProduct(
        @RequestParam int productId,
        @RequestParam int seq, HttpSession session
    ) {
    	
    	 String userNickname = (String) session.getAttribute("userNickname");
        // userNickname로 userId 조회
        String userId = memberService.getUserIdByUserNickname(userNickname);
        
        // 삭제 로직 실행
        basketService.deleteProductFromBasket(userId, productId, seq);

        return "success";
    }


}

        