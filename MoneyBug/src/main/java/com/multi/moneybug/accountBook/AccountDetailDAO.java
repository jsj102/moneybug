package com.multi.moneybug.accountBook;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AccountDetailDAO {

	@Autowired
	SqlSessionTemplate my;

	public int insert(AccountDetailDTO AccountDetailDTO) {
		return my.insert("accountDetail.insert", AccountDetailDTO);
	}

	public AccountDetailDTO readOne(String seq) {
		return my.selectOne("accountDetail.one", seq);
	}

	public List<AccountDetailDTO> readList(String accountBookId) {
		return my.selectList("accountDetail.list",accountBookId);
	}

	public int update(AccountDetailDTO account) {
		return my.update("accountDetail.update", account);
	}

	public int delete(String seq) {
		return my.delete("accountDetail.delete", seq);
	}
	
	public List<AccountDetailDTO> readListPage(AccountDetailDTO data) {
	    return my.selectList("accountDetail.listPage", data);
	}
	
	public List<AccountDetailDTO> readListSearch(AccountDetailSearchDTO account){
		return my.selectList("accountDetail.listSearch", account);
	}
	
	
	public List<AccountDetailDTO> readListMonth(AccountDetailDTO accountDetailDTO) {
		return my.selectList("accountDetail.listMonth",accountDetailDTO);
	}

	public List<AccountDetailDTO> readListMonthAllUser(AccountDetailDTO accountDetailDTO) {
		return my.selectList("accountDetail.listMonthAllUser",accountDetailDTO);
	}
	
	public int countListMonthUseUser(AccountDetailDTO accountDetailDTO) {
		return my.selectOne("accountDetail.listMonthCountUseUser",accountDetailDTO);
	}
	
	public List<AccountDetailDTO> readListAll(int accountBookId){
		return my.selectList("accountDetail.listAll", accountBookId);
	}
	
}