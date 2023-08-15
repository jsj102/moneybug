package com.multi.moneybug.member;

import java.util.List;

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

import lombok.extern.java.Log;

@Log
@Controller
public class MemberController {

	@Autowired
	MemberService memberService;

	// 중복회원 검사
	@RequestMapping(value = "/member/findMember.do", method = { RequestMethod.POST })
	@ResponseBody
	public String findMember(MemberDTO memberDTO, HttpSession session) throws Exception {
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

	// 마이페이지로 이동 (신규, 기존회원 모두)
	@RequestMapping("/member/myPage.do")
	public String myPage(MemberDTO memberDTO, Model model, HttpSession session) {
		String socialId = (String) session.getAttribute("socialId");
		memberDTO.setSocialId(socialId);

		List<MemberDTO> selectedMembers = memberService.select(memberDTO); // select 메서드 실행 후 반환된 리스트

		if (!selectedMembers.isEmpty()) {
			MemberDTO selectedMember = selectedMembers.get(0); // 첫 번째 멤버 선택
			model.addAttribute("email", selectedMember.getEmail());
			model.addAttribute("userName", selectedMember.getUserName());
			model.addAttribute("socialId", selectedMember.getSocialId());

		}
		return "member/myPage";
	}

	
	/*
	 * @GetMapping("/updateNicknameForm") public ModelAndView updateNicknameForm() {
	 * ModelAndView modelAndView = new ModelAndView("myPage"); // JSP 페이지 이름 return
	 * modelAndView; }
	 */
	 

	@PostMapping("/member/myInfoUpdate.do")
	public ModelAndView updateNickname(@RequestParam String userNickname, MemberDTO memberDTO, HttpSession session) {
		// 세션에서 사용자 정보 가져오기 (이메일, 이름 등)
		
		String socialId = (String) session.getAttribute("socialId");

		memberDTO.setUserNickname(userNickname); // 사용자 닉네임 설정
	    memberDTO.setSocialId(socialId);//소셜회원id

		System.out.println(memberDTO);
		// DAO를 사용하여 닉네임 업데이트
		memberService.update(memberDTO);

		ModelAndView modelAndView = new ModelAndView("redirect:../main.jsp"); // 업데이트 후 리다이렉트할 페이지
		return modelAndView;
	}

}
