package com.multi.moneybug.product;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BasketDAO {
	@Autowired
SqlSessionTemplate my;
	
	public List<BasketDTO> getAllBasksets(String userId) {
		return my.selectList("basket.basket_List", userId);
	}
}
