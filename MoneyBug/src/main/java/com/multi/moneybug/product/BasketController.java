package com.multi.moneybug.product;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.multi.moneybug.member.MemberService;

@Controller
public class BasketController {
    
    @Autowired
    BasketService basketService;
    
    @Autowired
    MemberService memberService;
    
    @RequestMapping("product/basketlist")
    public String getBasketList(HttpSession session, Model model) {
        // 세션에서 userNickname 얻어오기
        String userNickname = (String) session.getAttribute("userNickname");
        
        // userNickname에 해당하는 user_id 조회하기
        String userId = memberService.getUserIdByUserNickname(userNickname);
        
        // user_id로 장바구니 목록 조회
        List<BasketDTO> basketlist = basketService.getAllBaskets(userId);
        System.out.println(basketlist);
        model.addAttribute("basketList", basketlist);
        return "product/basketlist";
    }
}

        