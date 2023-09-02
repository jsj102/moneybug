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

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@EnableScheduling
public class AccountGPTController {

	private AccountGPTService gptService;
	private AccountBookService accountBookService;

	@Autowired
	public AccountGPTController(AccountGPTService gptService, AccountBookService accountBookService) {
		this.gptService = gptService;
		this.accountBookService = accountBookService;
	}

	// try catch
	@Scheduled(cron = "0 0 0 1 * *") // 초 분 시
	public void montlyGptInsert() {
		List<Integer> idList = accountBookService.readList();
		AccountDetailDTO account = new AccountDetailDTO();
		AccountGPTDTO accountGPTDTO = new AccountGPTDTO();
		LocalDate today = LocalDate.now();
		int year = today.getYear();
		int month = today.getMonthValue()-1;
		if(month==0) {
			month=12;
			year -=1;
		}
		// 데이터 삽입
		for (Integer accountBookId : idList) {
			account.setAccountBookId(accountBookId);
			account.setCurrentMonth(month);
			account.setCurrentYear(year);
			HashMap<String, List<AccountDetailDTO>> data = gptService.accountSort(account);
			HashMap<String, Integer> sendData = gptService.cosumptionSort(data.get("consumption"));
			System.out.println(sendData.toString());
			if (!sendData.isEmpty() && !(sendData == null)) {
				String request = gptService.prompt(sendData);
				String gptResponse = gptService.sendRequest(request);
				String finalData = gptService.jsonParsing(gptResponse);
				accountGPTDTO.setAccountBookId(accountBookId);
				accountGPTDTO.setContent(finalData);
				gptService.insert(accountGPTDTO);
			} else {
				System.out.println("데이터가 없어서 작성 실패");
			}
		}
	}

	@RequestMapping("accountBook/OpenApiRead")
	public String readOne(AccountGPTDTO accountGPTDTO, Model model, HttpSession session) {
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

	public String monthlyGPT(@RequestParam("accountBookId") int accountBookId, @RequestParam("year") int year,
			@RequestParam("month") int month) {
		AccountGPTDTO accountGPTDTO = new AccountGPTDTO();
		accountGPTDTO.setAccountBookId(accountBookId);
		month+=1;
		if(month==13) {
			month=1;
			year+=1;
		}
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