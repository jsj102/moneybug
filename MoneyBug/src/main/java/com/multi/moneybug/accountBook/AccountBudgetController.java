package com.multi.moneybug.accountBook;


import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Controller
public class AccountBudgetController {
	@Autowired
	private AccountBudgetService accountBudgetService;
	
	@RequestMapping("accountBook/budgetupdate")
	public void budgetupdate(@RequestParam("accountBookId") int accountBookId,@RequestParam("budgetList") String budgetList, @RequestParam("moneyList") String moneyList, Model model) {
		LocalDate currentDate = LocalDate.now();
		//추가로 세션값으로 체크해서 account_id값 받아와서 변수로 넘겨주기
		accountBudgetService.newBudget(accountBookId,budgetList,moneyList);

		model.addAttribute("budgetList", accountBudgetService.getListBudget(accountBookId,currentDate.getYear(),currentDate.getMonthValue()));
	}
	
	@RequestMapping("accountBook/budgetfirst")
	public String budgetFirstRead(@RequestParam("accountBookId") int accountBookId,Model model) {
		LocalDate currentDate = LocalDate.now();
		
		//페이지 초기접속시 입력해둔 데이터에 대한 값을 read
		model.addAttribute("budgetList", accountBudgetService.addTotal(accountBudgetService.getListBudget(accountBookId,currentDate.getYear(),currentDate.getMonthValue())));
		return "accountBook/budgetupdate";
	}
	
	
	@Autowired
	private AccountExpensesService accountExpensesService;
	
	@RequestMapping("accountBook/monthlyReportRequestBudgetAndExpenses")
	@ResponseBody
	public LinkedHashMap<String,Integer> getBudgetAndExpenses(@RequestParam("accountBookId") int accountBookId,@RequestParam("year") int year, @RequestParam("month") int month) {
		List<AccountBudgetDTO> budgetList = accountBudgetService.getListBudget(accountBookId,year,month);
		List<AccountExpensesDTO> expensesList = accountExpensesService.getListExpenses(accountBookId);
		LinkedHashMap<String,Integer> sumMap = accountBudgetService.sumBudgetAndExpensesToMap(budgetList,expensesList);
		return sumMap;
	}
	
}
