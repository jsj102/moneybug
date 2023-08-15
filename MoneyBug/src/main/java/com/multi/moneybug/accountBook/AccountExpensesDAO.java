package com.multi.moneybug.accountBook;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AccountExpensesDAO {
	
	@Autowired
	private SqlSessionTemplate my;
	

	public int insert(AccountExpensesDTO accountExpensesDTO) {
		return my.insert("accountExpenses.insert",accountExpensesDTO);
	}
	
	public AccountExpensesDTO readOne(AccountExpensesDTO accountExpensesDTO) {
		return my.selectOne("accountExpenses.one",accountExpensesDTO);
	}
	
	public List<AccountExpensesDTO> readList(AccountExpensesDTO accountExpensesDTO){
		return my.selectList("accountExpenses.list",accountExpensesDTO);	
	}
	
	public int update(AccountExpensesDTO accountExpensesDTO) {
		return my.update("accountExpenses.update", accountExpensesDTO);
	}
	
	public int delete(int  accountBookId) {
		return my.delete("accountExpenses.delete", accountBookId);
	}
	
	
	
	
	
	
}
