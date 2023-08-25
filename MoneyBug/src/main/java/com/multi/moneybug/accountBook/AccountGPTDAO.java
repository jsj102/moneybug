package com.multi.moneybug.accountBook;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AccountGPTDAO {

	@Autowired
	SqlSessionTemplate my;
	
	public int insert(AccountGPTDTO accountGPTDTO) {
		return my.insert("accountGPT.insert",accountGPTDTO);
	}
	
	public AccountGPTDTO readOne(AccountGPTDTO accountGPTDTO) {
		return my.selectOne("accountGPT.one",accountGPTDTO);
	}
	
	public void deleteAll() {
		my.delete("accountGPT.deleteAll");
	}
}