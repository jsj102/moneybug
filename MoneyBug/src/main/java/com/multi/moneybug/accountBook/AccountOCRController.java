package com.multi.moneybug.accountBook;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AccountOCRController {

	private AccountOCRService accountOCRService;
	
	 @Autowired
	  public AccountOCRController(AccountOCRService accountOCRService) {
	       this.accountOCRService = accountOCRService;
	  }
	 
	 @RequestMapping("ocr")
	 @ResponseBody
	 public String ocr(HttpServletRequest request) throws IOException {
	     String result = accountOCRService.processOCR(request);
	     return result;
	 }
}
