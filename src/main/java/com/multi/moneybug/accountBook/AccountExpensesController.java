package com.multi.moneybug.accountBook;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AccountExpensesController {
	@Autowired
	private AccountExpensesService accountExpensesService;

	@RequestMapping("accountBook/expensesupdate")
	public void budgetupdate(@RequestParam("accountBookId") int accountBookId,
			@RequestParam("expensesList") String expensesList, @RequestParam("moneyList") String moneyList,
			Model model) {
		// 추가로 세션값으로 체크해서 account_id값 받아와서 변수로 넘겨주기
		accountExpensesService.newExpenses(accountBookId, expensesList, moneyList);

		model.addAttribute("expensesList", accountExpensesService.getListExpenses(accountBookId));
	}

	@RequestMapping("accountBook/expensesfirst")
	public String budgetFirstRead(@RequestParam("accountBookId") int accountBookId, Model model) {
		// 페이지 초기접속시 입력해둔 데이터에 대한 값을 read
		model.addAttribute("expensesList",
				accountExpensesService.addTotal(accountExpensesService.getListExpenses(accountBookId)));
		return "accountBook/expensesupdate";
	}

}
