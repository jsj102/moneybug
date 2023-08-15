package com.multi.moneybug.accountBook;


import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AccountBudgetController {
	@Autowired
	AccountBudgetService accountBudgetService;
	
	@RequestMapping("accountBook/budgetupdate")
	public void budgetupdate(@RequestParam("budgetList") String budgetList, @RequestParam("moneyList") String moneyList, Model model) {

		int accountBookId = 0;								 //TODO : id값 나중에 변경해줘야함!
		//추가로 세션값으로 체크해서 account_id값 받아와서 변수로 넘겨주기
		accountBudgetService.newBudget(accountBookId,budgetList,moneyList);

		model.addAttribute("budgetList", accountBudgetService.getListBudget(accountBookId));
	}
	
	@RequestMapping("accountBook/budgetfirst")
	public String budgetFirstRead(Model model) {
		//페이지 초기접속시 입력해둔 데이터에 대한 값을 read
		int accountBookId = 0;								 //TODO : id값 나중에 변경해줘야함!
		model.addAttribute("budgetList", accountBudgetService.addTotal(accountBudgetService.getListBudget(accountBookId)));
		return "accountBook/budgetupdate";
	}
	
	
	@Autowired
	AccountExpensesService accountExpensesService;
	
	@RequestMapping("accountBook/monthlyReportRequestBudgetAndExpenses")
	@ResponseBody
	public LinkedHashMap<String,Integer> getBudgetAndExpenses() {
		int accountBookId = 0;
		List<AccountBudgetDTO> budgetList = accountBudgetService.getListBudget(accountBookId);
		List<AccountExpensesDTO> expensesList = accountExpensesService.getListExpenses(accountBookId);
		LinkedHashMap<String,Integer> sumMap = accountBudgetService.sumBudgetAndExpensesToMap(budgetList,expensesList);
		return sumMap;
	}
	
}
