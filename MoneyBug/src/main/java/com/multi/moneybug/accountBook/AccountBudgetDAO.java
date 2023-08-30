package com.multi.moneybug.accountBook;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AccountBudgetDAO {
	
	@Autowired
	private SqlSessionTemplate my;
	

	public int insert(AccountBudgetDTO accountBudgetDTO) {
		return my.insert("accountBudget.insert",accountBudgetDTO);
	}
	
	public AccountBudgetDTO readOne(AccountBudgetDTO accountBudgetDTO) {
		return my.selectOne("accountBudget.one",accountBudgetDTO);
	}
	
	public List<AccountBudgetDTO> readList(AccountBudgetDTO accountBudgetDTO){
		return my.selectList("accountBudget.list",accountBudgetDTO);	
	}
	
	public int update(AccountBudgetDTO accountBudgetDTO) {
		return my.update("accountBudget.update", accountBudgetDTO);
	}
	
	public int delete(int  accountBookId) {
		return my.delete("accountBudget.delete", accountBookId);
	}
	
	public int insertDate(AccountBudgetDTO accountBudgetDTO) {
		return my.insert("accountBudget.insertDate",accountBudgetDTO);
	}
	
	
	
	
}
