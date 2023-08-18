package com.multi.moneybug.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BasketService {
	@Autowired
	BasketDAO basketDAO;
	
	public List<BasketDTO> getAllBaskets(String userId){
		List<BasketDTO> basketList = basketDAO.getAllBasksets(userId);
		return basketList;
	}
}
