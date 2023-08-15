package com.multi.moneybug.accountBook;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestClientException;

@Controller
public class AccountGPTController {
	
	private AccountGPTService gptService;
	private AccountGPTDAO accountGPTDAO;

	@Autowired
	public AccountGPTController(AccountGPTService gptService,AccountGPTDAO accountGPTDAO) {
		this.gptService = gptService;
		this.accountGPTDAO = accountGPTDAO;
	}

	
	@GetMapping("accountBook/ai")
	public void gpt(Model model) {
        try {
            String test = gptService.jsonParsing(gptService.sendRequest("hello gpt i want request"));
            model.addAttribute("result", test);
        } catch (RestClientException e) {
        	e.getMessage();
        }
	}
	
	@RequestMapping("accountBook/data")
	public String power(Model model) throws ParseException {
		AccountDetailDTO account = new AccountDetailDTO();
		account.setAccountBookId(1);
		account.setCurrentMonth(2);
		account.setCurrentYear(2023);
		HashMap<String, List<AccountDetailDTO>> data = gptService.accountSort("", account);
		String a = gptService.prompt(gptService.cosumptionSort(data.get("consumption")));
		String test = gptService.sendRequest(a);
		System.out.println(a);
		String result = gptService.jsonParsing(test);
		model.addAttribute("result", result);
		
		AccountGPTDTO accountGPTDTO = new AccountGPTDTO();
		accountGPTDTO.setAccountBookId(1);
		accountGPTDTO.setContent(result);
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		date = dateFormat.parse("2023-02-01"); 
		
		accountGPTDTO.setCreateAt(date);
		gptService.insert(accountGPTDTO);
		
		return "accountBook/gpt";
	}
	

	
}
