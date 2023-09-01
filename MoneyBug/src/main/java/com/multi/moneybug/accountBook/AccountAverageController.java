package com.multi.moneybug.accountBook;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

//가계부 통계 & 평균
@Controller
public class AccountAverageController {
	private AccountAverageService accountAverageService;
	private AccountDetailService accountDetailService;
	
	@Autowired
	public AccountAverageController(AccountAverageService accountAverageService, AccountDetailService accountDetailService) {
		this.accountAverageService = accountAverageService;
		this.accountDetailService = accountDetailService;
	}
	
	@RequestMapping("/accountBook/status")
	public void accountStatus() {}
	
	//스케쥴러 활용해서 전체 월간 평균내고 DB에 저장하는함수
	public void monthlyAccountBookAvgDBUpdate() {
		int currentYear = 0;
		int currentMonth = 0;
		AccountDetailDTO accountDetailDTO = accountDetailService.makeDTOForReadMonth(0, currentYear, currentMonth);
		List<AccountDetailDTO> accountDetailList = accountDetailService.readListMonthAllUser(accountDetailDTO);
		HashMap<String,Integer> accountDetailMap = accountDetailService.sumCategory(accountDetailList);
		int users = accountDetailService.countListMonthUseUser(accountDetailDTO);
		accountDetailMap = accountAverageService.divideUserAvg(accountDetailMap,users); //평균값
		accountAverageService.insertAvgList(accountDetailMap);
	}
	
	@RequestMapping("/accountBook/getAvginfo")
	public void monthlyAccountBookAvgRead() {}
}
