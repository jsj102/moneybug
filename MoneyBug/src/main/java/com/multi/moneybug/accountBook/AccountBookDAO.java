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
	
	 public AccountBookDTO readOne(String socialId) {
	        return my.selectOne("accountBook.one", socialId);
	 }
	 public String readfind(String socialId) {
		 return my.selectOne("accountBook.find", socialId);
	 }

	 public List<Integer>readList() {
		 return my.selectList("accountBook.list");
	 }

}
