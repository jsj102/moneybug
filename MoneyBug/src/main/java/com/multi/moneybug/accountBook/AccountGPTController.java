package com.multi.moneybug.accountBook;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
		account.setAccountBookId(0);
		account.setCurrentMonth(8);
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
	
	
	@RequestMapping("accountBook/OpenApiRead")
	public String readOne(AccountGPTDTO accountGPTDTO,Model model){
		Date start = new Date();
		Date end = new Date();
		LocalDate today = LocalDate.now();
		LocalDate firstDayOfMonth = today.with(TemporalAdjusters.firstDayOfMonth()); // 이번 달의 첫째 날
	    LocalDate lastDayOfMonth = today.with(TemporalAdjusters.lastDayOfMonth());   // 이번 달의 마지막 날
	    
	    String startDate = firstDayOfMonth.toString();
	    String endDate = lastDayOfMonth.toString();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			start = dateFormat.parse(startDate);
			end = dateFormat.parse(endDate);
		} catch (ParseException e) {
			e.printStackTrace();
		} 
		accountGPTDTO.setStartDate(start);
		accountGPTDTO.setEndDate(end);
		accountGPTDTO.setAccountBookId(1);
		accountGPTDTO = gptService.readOne(accountGPTDTO);
		model.addAttribute("gptData", accountGPTDTO.getContent());
		return "accountBook/gpt";
	}

	@RequestMapping(value = "accountBook/monthlyGPT", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String monthlyGPT(@RequestParam("year") int year, @RequestParam("month") int month) {
		int accountBookId = 0;
		AccountGPTDTO accountGPTDTO = new AccountGPTDTO();
		accountGPTDTO.setAccountBookId(accountBookId);
		accountGPTDTO.setCurrentYear(year);
		accountGPTDTO.setCurrentMonth(month);
		accountGPTDTO = gptService.readOne(accountGPTDTO);
		return accountGPTDTO.getContent();
	}
}