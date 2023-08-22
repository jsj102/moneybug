package com.multi.moneybug.accountBook;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AccountGPTController {

	private AccountGPTService gptService;
	private AccountBookService accountBookService;
	@Autowired
	public AccountGPTController(AccountGPTService gptService,AccountBookService accountBookService) {
		this.gptService = gptService;
		this.accountBookService = accountBookService;
	}

	@RequestMapping("accountBook/data")
	public String power(Model model,HttpSession session) throws ParseException {
		String convert = (String) session.getAttribute("socialId");
		String accountBookId = accountBookService.insertAccountDetailFindSeq(convert);
		
		AccountDetailDTO account = new AccountDetailDTO();
		// 날짜 설정
		LocalDate localDate = LocalDate.now();
		account.setAccountBookId(Integer.parseInt(accountBookId));
		account.setCurrentMonth(localDate.getMonthValue());
		account.setCurrentYear(localDate.getYear());
		// 데이터 가져와 gpt로 전송
		HashMap<String, List<AccountDetailDTO>> data = gptService.accountSort("", account);
		String consumption = gptService.prompt(gptService.cosumptionSort(data.get("consumption")));
		String gptData = gptService.sendRequest(consumption);
		String result = gptService.jsonParsing(gptData);
		
		AccountGPTDTO accountGPTDTO = new AccountGPTDTO();
		accountGPTDTO.setAccountBookId(Integer.parseInt(accountBookId));
		accountGPTDTO.setContent(result);
		Date date = new Date();
		String local = localDate.toString();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		date = dateFormat.parse(local);

		accountGPTDTO.setCreateAt(date);
		gptService.insert(accountGPTDTO);
		return "redirect:/accountBook/accountbookFrom.jsp";
	}

	@RequestMapping("accountBook/OpenApiRead")
	public String readOne(AccountGPTDTO accountGPTDTO, Model model,HttpSession session) {
		String convert = (String) session.getAttribute("socialId");
		String accountBookId = accountBookService.insertAccountDetailFindSeq(convert);
		
		Date start = new Date();
		Date end = new Date();
		LocalDate today = LocalDate.now();
		LocalDate firstDayOfMonth = today.with(TemporalAdjusters.firstDayOfMonth()); // 이번 달의 첫째 날
		LocalDate lastDayOfMonth = today.with(TemporalAdjusters.lastDayOfMonth()); // 이번 달의 마지막 날

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
		accountGPTDTO.setAccountBookId(Integer.parseInt(accountBookId));
		accountGPTDTO = gptService.readOne(accountGPTDTO);
		if (accountGPTDTO != null) {
			model.addAttribute("gptData", accountGPTDTO.getContent());
			return "accountBook/gpt";
		} else {
			model.addAttribute("error", "데이터가 없습니다.");
			return "accountBook/gpt";
		}
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
		if (accountGPTDTO != null) {
			return accountGPTDTO.getContent();
		} else {
			return "데이터가 없습니다.";
		}
	}
}