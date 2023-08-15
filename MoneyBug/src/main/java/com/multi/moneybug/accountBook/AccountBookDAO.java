package com.multi.moneybug.accountBook;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AccountBookDAO {
	@Autowired
	SqlSessionTemplate my;
	
	public int insert(AccountBookDTO accountBookDTO) {
		return my.insert("accountBook.insert",accountBookDTO);
	}
	
	public AccountBookDTO readOne(String userId) {
		return my.selectOne("accountBook.One", userId);
	}
	
	public List<AccountBookDTO> readList() {
		return my.selectList("accountBook.list");
	}
	public int update(AccountBookDTO accountBookDTO) {
		return my.update("accountBook.update",accountBookDTO);
	}
	public int delete(String userId) {
		return my.delete("accountBook.delete",userId);
	}
	
}
