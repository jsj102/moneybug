package com.multi.moneybug.accountBook;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AccountAverageDAO {
	
	@Autowired
	SqlSessionTemplate my;
	
	public int insert(AccountAverageDTO accountAverageDTO) {
		return my.insert("accountAverage.insert", accountAverageDTO);
	}
}
