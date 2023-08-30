package com.multi.moneybug.accountBook;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Date;

@Controller
public class AccountBookController {


	private final AccountBookService accountBookService;

	@Autowired
	public AccountBookController(AccountBookService accountBookService) {
		this.accountBookService = accountBookService;
	}

	@GetMapping("/duplicateCheck")
	@ResponseBody
	public void getAccountFromPage(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String socialId = (String) session.getAttribute("socialId");
		AccountBookDTO accountBookDTO = new AccountBookDTO();
		accountBookDTO.setSocialId(socialId);
		accountBookDTO.setCreateAt(new Date(System.currentTimeMillis()));
		accountBookService.insertAccountBookIfNotExists(accountBookDTO); // 이메일이 중복되지 않게 생성
	}
        
    @GetMapping("accountBook/seq")
    @ResponseBody
    public String getSeq(HttpServletRequest request) {
    	HttpSession session = request.getSession();
    	String socialId = (String) session.getAttribute("socialId");
    	String seq = accountBookService.insertAccountDetailFindSeq(socialId);
    	return seq;
    }

    
    @GetMapping("accountBook/getUserNickname")
    @ResponseBody
    public String getUserNickname(HttpServletRequest request) {
    	HttpSession session = request.getSession();
    	String userNickname = (String) session.getAttribute("userNickname");
    	return userNickname;
    }


}
