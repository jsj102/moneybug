package com.multi.moneybug.accountBook;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AccountAverageService {
	@Autowired
	private AccountAverageDAO accountAverageDAO;
	
	
	
	public void insertAvgList(HashMap<String,Integer> accountDetailMap,int year,int month) {
		AccountAverageDTO accountAverageDTO = new AccountAverageDTO();
		Set<String> keys = accountDetailMap.keySet();
		accountAverageDTO.setCurrentYear(year);
		accountAverageDTO.setCurrentMonth(month);
		for(String key : keys) {
			accountAverageDTO.setAccountCategory(key);
			accountAverageDTO.setPrice(accountDetailMap.get(key));
			
		}
	}
	
	public HashMap<String,Integer> divideUserAvg(HashMap<String,Integer> accountDetailMap, int users) {
		Set<String> keys = accountDetailMap.keySet();
		for(String key : keys) {
			accountDetailMap.put(key, accountDetailMap.get(key)/users);
		}
		return accountDetailMap;
	}
	
	public LinkedHashMap<String, Integer> addLabel(){
		return null; //for table
	}
}
