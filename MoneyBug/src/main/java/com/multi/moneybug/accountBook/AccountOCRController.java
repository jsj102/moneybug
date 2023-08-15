package com.multi.moneybug.accountBook;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestClientException;

@Controller
public class AccountOCRController {

	private AccountOCRService accountOCRService;
	
	 @Autowired
	  public AccountOCRController(AccountOCRService accountOCRService) {
	       this.accountOCRService = accountOCRService;
	  }
	 

	 
 
	 @RequestMapping("ocr")
	 public void ocr(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
	     String result = accountOCRService.processOCR(request);
	     session.setAttribute("result", result);
	     response.setContentType("text/plain");
	     response.getWriter().write(result);
	 }
}
