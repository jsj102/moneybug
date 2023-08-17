package com.multi.moneybug.accountBook;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.pdfbox.pdmodel.PDDocument;

@Controller
public class AccountFileDownloadController {
	private AccountFileDownloadService accountFileDownloadService;
	private AccountBudgetService accountBudgetService;
	private AccountExpensesService accountExpensesService;
	private AccountDetailService accountDetailService;
	
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
	
	
//	@RequestMapping("accountBook/downloadPDF")
//	@ResponseBody
//	public PDDocument download(@RequestParam("accountBookId") int accountBookId,@RequestParam("year") int year, @RequestParam("month") int month ) {
//		System.out.println("call PDF");
//		
//		//accountBookId로 유저 네임 구한뒤 year,month로 각종 데이터 받아오기, 이후 service단에 데이터 List, Map, 유저이름 보낸뒤 파일로 만들어서 내려주기 파일명 - 유저명-년-월 형태
//		List<AccountBudgetDTO> budgetList = accountBudgetService.getListBudget(accountBookId, year, month);
//		List<AccountExpensesDTO> expensesList = accountExpensesService.getListExpenses(accountBookId);
//		LinkedHashMap<String,Integer> budgetAndExpensesMap = accountBudgetService.sumBudgetAndExpensesToMap(budgetList, expensesList);
//		//데이터 가져오는 부분
//		
//		
//		
//		PDDocument accountBookPDF = accountFileDownloadService.createAccountBookPDF();
//		
//		return accountBookPDF;
//	}
    @RequestMapping("/accountBook/downloadPDF")
    public void downloadPDF(HttpServletRequest request, HttpServletResponse response,
                            @RequestParam("accountBookId") int accountBookId,
                            @RequestParam("year") int year,
                            @RequestParam("month") int month) {
		System.out.println("call PDF");
		
		//accountBookId로 유저 네임 구한뒤 year,month로 각종 데이터 받아오기, 이후 service단에 데이터 List, Map, 유저이름 보낸뒤 파일로 만들어서 내려주기 파일명 - 유저명-년-월 형태
		List<AccountBudgetDTO> budgetList = accountBudgetService.getListBudget(accountBookId, year, month);
		List<AccountExpensesDTO> expensesList = accountExpensesService.getListExpenses(accountBookId);
		LinkedHashMap<String,Integer> budgetAndExpensesMap = accountBudgetService.sumBudgetAndExpensesToMap(budgetList, expensesList);
		List<AccountDetailDTO> detailList= accountDetailService.readListMonth(accountDetailService.makeDTOForReadMonth(accountBookId, year, month));
		LinkedHashMap<String,Integer> detailMap = accountDetailService.sumLabelCategory(detailList);
		//데이터 가져오는 부분
        accountFileDownloadService.downloadPDF(request, response, accountBookId, year, month);
    }

}
