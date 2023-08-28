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
	
	@RequestMapping("/accountBook/downloadExcel")
	public void downloadExcel(HttpServletResponse response,
            @RequestParam("accountBookId") int accountBookId,
            @RequestParam("year") int year,
            @RequestParam("month") int month,
            @RequestParam("userNickname") String userNickname
            ) throws Exception {
		System.out.println("Excelcontroller");
		//데이터 가져오는 부분
		List<AccountBudgetDTO> budgetList = accountBudgetService.getListBudget(accountBookId, year, month);
		List<AccountExpensesDTO> expensesList = accountExpensesService.getListExpenses(accountBookId);
		//LinkedHashMap<String,Integer> budgetAndExpensesMap = accountBudgetService.sumBudgetAndExpensesToMap(budgetList, expensesList); //예산-고정지출
		List<AccountDetailDTO> detailList= accountDetailService.readListMonth(accountDetailService.makeDTOForReadMonth(accountBookId, year, month));
		LinkedHashMap<String,Integer> detailMap = accountDetailService.sumLabelCategory(detailList);
		//파일다운로드
		accountFileDownloadService.downloadExcel(response, budgetList, expensesList, detailList, detailMap, year, month, userNickname);
		
	}
	
	
	
    @RequestMapping("/accountBook/downloadPDF")
    public void downloadPDF(HttpServletResponse response,
                            @RequestParam("accountBookId") int accountBookId,
                            @RequestParam("year") int year,
                            @RequestParam("month") int month,
                            @RequestParam("chartImage") String chartImage,
                            @RequestParam("userNickname") String userNickname
    		) {
		//데이터 가져오는 부분
		List<AccountBudgetDTO> budgetList = accountBudgetService.getListBudget(accountBookId, year, month);
		List<AccountExpensesDTO> expensesList = accountExpensesService.getListExpenses(accountBookId);
		LinkedHashMap<String,Integer> budgetAndExpensesMap = accountBudgetService.sumBudgetAndExpensesToMap(budgetList, expensesList);
		List<AccountDetailDTO> detailList= accountDetailService.readListMonth(accountDetailService.makeDTOForReadMonth(accountBookId, year, month));
		LinkedHashMap<String,Integer> detailMap = accountDetailService.sumLabelCategory(detailList);
		//파일다운로드
        accountFileDownloadService.downloadPDF(response,budgetList,expensesList,budgetAndExpensesMap,detailList,detailMap,year,month,chartImage,userNickname);
    }

}
