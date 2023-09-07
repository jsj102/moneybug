package com.multi.moneybug.member;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.multi.moneybug.product.OrderListDTO;
import com.multi.moneybug.product.ProductService;

import lombok.extern.java.Log;

@Log
@Controller
public class MemberController {

	@Autowired
	MemberService memberService;
	
	@Autowired
	ProductService productService;

	// 중복회원 검사
	@PostMapping("/member/findMember.do")
	@ResponseBody
	public String findMember(MemberDTO memberDTO, HttpSession session) throws Exception {
		// 회원있음
		if (memberService.find(memberDTO) == 1) {
			session.setAttribute("socialId", memberDTO.getSocialId());
			return "old";
		} else {
			session.setAttribute("socialId", memberDTO.getSocialId());
			memberService.insert(memberDTO);
			log.info("인서트성공");
			return "new";
		}
	}

	// 메인페이지로 이동
	@PostMapping("main.do")
	public String main(MemberDTO memberDTO, Model model, HttpSession session) {
		String socialId = (String) session.getAttribute("socialId");
		memberDTO.setSocialId(socialId);

		List<MemberDTO> selectedMembers = memberService.select(memberDTO); // select 메서드 실행 후 반환된 리스트

		if (!selectedMembers.isEmpty()) {
			MemberDTO selectedMember = selectedMembers.get(0); // 첫 번째 멤버 선택
			session.setAttribute("userNickname", selectedMember.getUserNickname());

			setUserNicknameToSession(session, selectedMember.getUserNickname());

		}	
		return "redirect:/main.jsp";
	}

	@GetMapping("/logout.do")
	public String logout(HttpSession session) {
		// 세션을 지워서 로그아웃 처리

		session.invalidate();
		
		return "redirect:/main.jsp"; // 로그아웃 후 메인 페이지로 리다이렉트
	}

	// 마이페이지로 이동 (신규, 기존회원 모두)

		@RequestMapping("/member/myPage.do")
		public String myPage(MemberDTO memberDTO, Model model, HttpSession session) {
			String socialId = (String) session.getAttribute("socialId");
			memberDTO.setSocialId(socialId);
			String userId = null;

			List<MemberDTO> selectedMembers = memberService.select(memberDTO); // select 메서드 실행 후 반환된 리스트
			if (!selectedMembers.isEmpty()) {
				MemberDTO selectedMember = selectedMembers.get(0); // 첫 번째 멤버 선택
				model.addAttribute("email", selectedMember.getEmail());
				model.addAttribute("userName", selectedMember.getUserName());
				model.addAttribute("socialId", selectedMember.getSocialId());
				model.addAttribute("point", selectedMember.getPoint());

				userId = selectedMember.getUserId();
			}

			List<OrderListDTO> orderlist = productService.myOrderList(userId);
			model.addAttribute("orderlist", orderlist);

			return "member/myPage";
		}


		
		// 마이페이지로 이동 (신규, 기존회원 모두)
				@PostMapping("/member/signUp.do")
				public String signUp(MemberDTO memberDTO, Model model, HttpSession session) {
					String socialId = (String) session.getAttribute("socialId");
					memberDTO.setSocialId(socialId);

					List<MemberDTO> selectedMembers = memberService.select(memberDTO); // select 메서드 실행 후 반환된 리스트
					if (!selectedMembers.isEmpty()) {
						MemberDTO selectedMember = selectedMembers.get(0); // 첫 번째 멤버 선택
						model.addAttribute("email", selectedMember.getEmail());
						model.addAttribute("userName", selectedMember.getUserName());
						model.addAttribute("socialId", selectedMember.getSocialId());
						model.addAttribute("point", selectedMember.getPoint());
						model.addAttribute("userNickname",selectedMember.getUserNickname());
					}
					return "member/signUp";
				}



	private void setUserNicknameToSession(HttpSession session, String userNickname) {
		session.setAttribute("userNickname", userNickname);
	}

	@PostMapping("/member/myInfoUpdate.do")
	public String updateNickname(@RequestParam String userNickname, MemberDTO memberDTO, HttpSession session, Model model) {
	    String socialId = (String) session.getAttribute("socialId");
	    memberDTO.setUserNickname(userNickname); // 사용자 닉네임 설정
	    memberDTO.setSocialId(socialId); // 소셜 회원 id
	    // DAO를 사용하여 닉네임 업데이트
	    memberService.update(memberDTO);
	    // 세션에 업데이트된 닉네임 저장
	    session.setAttribute("userNickname", userNickname);	   
	    return "redirect:/main.jsp";
	}
	
	@PostMapping("/member/checkNickname.do")
	@ResponseBody
	public String checkNickname(@RequestParam String userNickname) {
	    // 닉네임 중복 체크
	    int isNicknameAvailable = memberService.findNick(userNickname);

	    if (isNicknameAvailable == 1) {
	        return "unavailable";
	    }
	    return "available";
	}

	
	@GetMapping("checkLogin")
    @ResponseBody
    public int checkLoginStatus(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String userNickname = (String) session.getAttribute("userNickname");
        
        if (userNickname != null) {
            return 1; // 로그인 상태면 1 반환
        } else {
            return 0; // 로그인되지 않은 상태면 0 반환
        }
    }
	
	@PostMapping("accountBook/getEmail")
	@ResponseBody
	public String getEmail(HttpSession session) {
		String userNickname = (String) session.getAttribute("userNickname");
		return memberService.getEmailByUserNickname(userNickname);
	}
}