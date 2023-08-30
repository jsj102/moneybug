package com.multi.moneybug.openApi;

import java.sql.Date;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.multi.moneybug.accountBook.AccountBudgetDAO;
import com.multi.moneybug.accountBook.AccountBudgetDTO;
import com.multi.moneybug.accountBook.AccountDetailDAO;
import com.multi.moneybug.accountBook.AccountDetailDTO;
import com.multi.moneybug.accountBook.AccountExpensesDAO;
import com.multi.moneybug.accountBook.AccountExpensesDTO;

@Repository
public class OpenApiDAO {

	private AccountDetailDAO accountDetailDAO;
	private AccountBudgetDAO accountBudgetDAO;
	private AccountExpensesDAO accountExpensesDAO;
	private SqlSessionTemplate my;

	@Autowired
	public OpenApiDAO(AccountDetailDAO accountDetailDAO, AccountBudgetDAO accountBudgetDAO,
			AccountExpensesDAO accountExpensesDAO, SqlSessionTemplate my) {
		this.accountDetailDAO = accountDetailDAO;
		this.accountBudgetDAO = accountBudgetDAO;
		this.accountExpensesDAO = accountExpensesDAO;
		this.my = my;
	}

	public List<AccountDetailDTO> readListDetail(int accountBookId) {
		return accountDetailDAO.readListAll(accountBookId);
	}

	public List<AccountExpensesDTO> readListExpenses(int accountBookId) {
		AccountExpensesDTO accountExpensesDTO = new AccountExpensesDTO();
		accountExpensesDTO.setAccountBookId(accountBookId);
		return accountExpensesDAO.readList(accountExpensesDTO);
	}

	public List<AccountBudgetDTO> readListBudget(AccountBudgetDTO accountBudgetDTO) {
		return accountBudgetDAO.readList(accountBudgetDTO);
	}

	public void insert(OpenApiDTO openApiDTO) {
		my.insert("openApi.insert", openApiDTO);
	}

	public OpenApiDTO readOne(int accountBookId) {
		return my.selectOne("openApi.readOne", accountBookId);
	}

	public int delete(Date expireDate) {
		return my.delete("openApi.delete", expireDate);
	}

	public OpenApiDTO readOneKey(OpenApiDTO openApiDTO) {
		return my.selectOne("openApi.readOneKey", openApiDTO);
	}

	public List<OpenApiDTO> readList(OpenApiDTO openApiDTO) {
		return my.selectList("openApi.list", openApiDTO);
	}

	public void deleteId(int accountBookId) {
		my.delete("openApi.deleteId", accountBookId);
	}

	public void insertToken(OpenApiTokenDTO apiTokenDTO) {
		my.insert("openApi.insertToken", apiTokenDTO);
	}

	public OpenApiTokenDTO readToken(String secretKey) {
		return my.selectOne("openApi.readToken", secretKey);
	}
	
	public void updateToken(OpenApiTokenDTO apiTokenDTO) {
		my.update("openApi.updateToken",apiTokenDTO);
	}

}
