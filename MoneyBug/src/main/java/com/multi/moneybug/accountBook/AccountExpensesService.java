package com.multi.moneybug.accountBook;

import java.text.DecimalFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AccountExpensesService {
	@Autowired
	private AccountExpensesDAO accountExpensesDAO;

	public int newExpenses(int accountBookId,String expensesList, String moneyList) {
		int resultCount = 0;
		int money = 0;
		
		expensesList=expensesList.replace("[", "");
		expensesList=expensesList.replace("]", "");
		expensesList=expensesList.replace("\"", "");
		String[] expensesArray=expensesList.split(",");
		moneyList=moneyList.replace("[", "");
		moneyList=moneyList.replace("]", "");
		moneyList=moneyList.replace("\"", "");
		String[] moneyArray=moneyList.split(",");	

		for (int i = 0; i < moneyArray.length; i++) {
			if(isInteger(moneyArray[i])) {
				money = Integer.parseInt(moneyArray[i]);
				AccountExpensesDTO accountExpensesDTO = new AccountExpensesDTO();
				accountExpensesDTO.setAccountBookId(accountBookId);	
				accountExpensesDTO.setFixedCategory(expensesArray[i]);
				accountExpensesDTO.setPrice(money);

				// 파라메터 DTO / 현재 년,월, account_book_id, category(expenses) , price(money) ,
				if(isExpensesNull(accountExpensesDAO.readOne(accountExpensesDTO))) {
					//insert해주기
					accountExpensesDAO.insert(accountExpensesDTO);
				}else {
					//update해주기
					accountExpensesDAO.update(accountExpensesDTO);
				}
				
			}//endif
		}

		return resultCount;
	}


	public List<AccountExpensesDTO> getListExpenses(int accountBookId) {
		AccountExpensesDTO accountExpensesDTO = new AccountExpensesDTO();
		accountExpensesDTO.setAccountBookId(accountBookId);	
		
		return accountExpensesDAO.readList(accountExpensesDTO);
	}
	
	public List<AccountExpensesDTO> addTotal(List<AccountExpensesDTO> list){
		int total = 0;
		for(int i=0;i<list.size();i++) {
			AccountExpensesDTO accountExpensesDTO = list.get(i);
			total+=accountExpensesDTO.getPrice();
		}
		AccountExpensesDTO accountExpensesDTO = new AccountExpensesDTO();
		
		accountExpensesDTO.setFixedCategory("총 고정지출 : ");
		accountExpensesDTO.setPrice(total);
		list.add(accountExpensesDTO);
		return list;
	}
	
	
	
	private boolean isExpensesNull(AccountExpensesDTO accountExpensesDTO) {
		try {
			accountExpensesDTO.getFixedCategory();
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
			System.out.println("고정지출에 숫자외의 값 입력 들어옴");
			return false;
		}

	}

}
