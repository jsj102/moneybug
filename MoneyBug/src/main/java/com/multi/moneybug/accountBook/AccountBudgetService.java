package com.multi.moneybug.accountBook;

import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AccountBudgetService {
	@Autowired
	private AccountBudgetDAO accountBudgetDAO;

	public int newBudget(int accountBookId,String budgetList, String moneyList) {
		int resultCount = 0;
		int money = 0;
		
		budgetList=budgetList.replace("[", "");
		budgetList=budgetList.replace("]", "");
		budgetList=budgetList.replace("\"", "");
		String[] budgetArray=budgetList.split(",");
		moneyList=moneyList.replace("[", "");
		moneyList=moneyList.replace("]", "");
		moneyList=moneyList.replace("\"", "");
		String[] moneyArray=moneyList.split(",");	

		LocalDate currentDate = LocalDate.now();
		for (int i = 0; i < moneyArray.length; i++) {
			if(isInteger(moneyArray[i])) {
				money = Integer.parseInt(moneyArray[i]);
				AccountBudgetDTO accountBudgetDTO = new AccountBudgetDTO();
				accountBudgetDTO.setAccountBookId(accountBookId);	
				accountBudgetDTO.setCurrentMonth(currentDate.getMonthValue());
				accountBudgetDTO.setCurrentYear(currentDate.getYear());
				accountBudgetDTO.setFixedCategory(budgetArray[i]);
				accountBudgetDTO.setPrice(money);

				if(isBudgetNull(accountBudgetDAO.readOne(accountBudgetDTO))) {
					//insert해주기
					accountBudgetDAO.insert(accountBudgetDTO);
				}else {
					//update해주기
					accountBudgetDAO.update(accountBudgetDTO);
				}
				
			}//endif
		}

		return resultCount;
	}


	public List<AccountBudgetDTO> getListBudget(int accountBookId,int selectYear,int selectMonth) {
		AccountBudgetDTO accountBudgetDTO = new AccountBudgetDTO();
		accountBudgetDTO.setAccountBookId(accountBookId);	
		accountBudgetDTO.setCurrentMonth(selectMonth);
		accountBudgetDTO.setCurrentYear(selectYear);
		
		return accountBudgetDAO.readList(accountBudgetDTO);
	}
	
	public List<AccountBudgetDTO> addTotal(List<AccountBudgetDTO> list){
		int total = 0;
		for(int i=0;i<list.size();i++) {
			AccountBudgetDTO accountBudgetDTO = list.get(i);
			int tempInt = accountBudgetDTO.getPrice();
			total+=tempInt;
		}
		AccountBudgetDTO accountBudgetDTO = new AccountBudgetDTO();
		accountBudgetDTO.setFixedCategory("총 예산 : ");
		accountBudgetDTO.setPrice(total);
		list.add(accountBudgetDTO);
		return list;
	}
	
	public LinkedHashMap<String,Integer> sumBudgetAndExpensesToMap(List<AccountBudgetDTO> budgetList,List<AccountExpensesDTO> expensesList){
		LinkedHashMap<String,Integer> sumMap = new LinkedHashMap<String,Integer>();
		String[] labels = {"주거/통신","식비","교통/차량","의료/건강","교육","금융","생활용품",
				"패션/미용","유흥","가족","문화/여가","선물/경조사/회비","마트/편의점/쇼핑",
				"반려동물","기타"};
		for(String label : labels) {
			sumMap.put(label,0);
		}
		
		for(AccountBudgetDTO budget : budgetList) {
			String tempKey = budget.getFixedCategory();
			Integer tempInt = budget.getPrice();
			sumMap.put(tempKey, sumMap.getOrDefault(tempKey, 0)+tempInt);
		}
		for(AccountExpensesDTO expenses : expensesList) {
			String tempKey = expenses.getFixedCategory();
			Integer tempInt = expenses.getPrice();
			sumMap.put(tempKey, sumMap.getOrDefault(tempKey, 0)-tempInt);
		}
		return sumMap;
	}
	
	
	private boolean isBudgetNull(AccountBudgetDTO accountBudgetDTO) {
		try {
			accountBudgetDTO.getUsedAt();
			return false;
		} catch (NullPointerException e) {
			return true;
		}
		
	}
	
	
	private boolean isInteger(String str) {
		try {
			Integer.parseInt(str);
			return true;
		} catch (NumberFormatException e) {
			System.out.println("예산에 숫자외의 값 입력 들어옴");
			return false;
		}

	}

}
