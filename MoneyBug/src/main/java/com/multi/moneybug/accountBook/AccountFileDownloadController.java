package com.multi.moneybug.accountBook;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AccountFileDownloadController {
	private AccountFileDownloadService accountFileDownloadService;
	private AccountBudgetService accountBudgetService;
	private AccountDetailService accountDetailService;
	private AccountExpensesService accountExpensesService;
	
	@Autowired
	public AccountFileDownloadController(AccountFileDownloadService accountFileDownloadService,
			AccountBudgetService accountBudgetService,
			AccountDetailService accountDetailService,
			AccountExpensesService accountExpensesService
			) {
		this.accountFileDownloadService = accountFileDownloadService;
		this.accountBudgetService = accountBudgetService;
		this.accountDetailService = accountDetailService;
		this.accountExpensesService = accountExpensesService;
	}
	
	
	@RequestMapping("accountBook/downloadPDF")
	@ResponseBody
	public String download(@RequestParam("accountBookId") int accountBookId,@RequestParam("year") int year, @RequestParam("month") int month ) {
		System.out.println("call PDF");
		accountFileDownloadService.createAccountBookPDF();
		
		return "nothing";
	}
}
