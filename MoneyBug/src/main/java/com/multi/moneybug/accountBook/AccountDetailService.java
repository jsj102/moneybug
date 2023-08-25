package com.multi.moneybug.accountBook;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AccountDetailService {
	
	@Autowired
	private AccountDetailDAO accountDetailDAO;
	
	public int insert(AccountDetailDTO accountDetailDTO) {
		return accountDetailDAO.insert(accountDetailDTO);
	}
	
	public AccountDetailDTO readOne(String seq) {
		return accountDetailDAO.readOne(seq);
	}
	
	public List<AccountDetailDTO> readList(String accountBookId){
		return accountDetailDAO.readList(accountBookId);
	}
	
	public int update(AccountDetailDTO account) {
		return accountDetailDAO.update(account);
	}
	
	public int delete(String seq) {
		return accountDetailDAO.delete(seq);
	}

	public List<AccountDetailDTO> readListPage(AccountDetailDTO data){
		return accountDetailDAO.readListPage(data);
	}
	
	public List<AccountDetailDTO> readListSearch(AccountDetailSearchDTO account){
		return accountDetailDAO.readListSearch(account);
	}
	
	public List<AccountDetailDTO> readListMonth(AccountDetailDTO accountDetailDTO){
		return accountDetailDAO.readListMonth(accountDetailDTO);
	}
	
	public List<AccountDetailDTO> readListMonthAllUser(AccountDetailDTO accountDetailDTO){
		return accountDetailDAO.readListMonthAllUser(accountDetailDTO);
	}
	
	public int countListMonthUseUser(AccountDetailDTO accountDetailDTO) {
		return accountDetailDAO.countListMonthUseUser(accountDetailDTO);
	}
	
	public AccountDetailDTO makeDTOForReadMonth(int accountBookId, int currentYear, int currentMonth) {
		AccountDetailDTO accountDetailDTO = new AccountDetailDTO();
		accountDetailDTO.setAccountBookId(accountBookId);
		accountDetailDTO.setCurrentYear(currentYear);
		accountDetailDTO.setCurrentMonth(currentMonth);
		return accountDetailDTO;
	}
	
	public HashMap<String, Integer> sumCategory(List<AccountDetailDTO> list) {
		HashMap<String, Integer> categoryMapInt = new HashMap<String, Integer>();
		for(AccountDetailDTO temp:list) {
			String tempStr = temp.getAccountCategory();
			Integer tempInt = temp.getPrice();
			categoryMapInt.put(tempStr, tempInt + categoryMapInt.getOrDefault(tempStr, 0));	
			
		}
		return categoryMapInt;
	}
	
	public LinkedHashMap<String, Integer> sumLabelCategory(List<AccountDetailDTO> list) {
		LinkedHashMap<String, Integer> categoryMapInt = new LinkedHashMap<String, Integer>();
		
		String[] labels = {"주거/통신","식비","교통/차량","의료/건강","교육","금융","생활용품",
				"패션/미용","유흥","가족","문화/여가","선물/경조사/회비","마트/편의점/쇼핑",
				"반려동물","기타"};
		for(int i = 0; i< labels.length; i++) {
			categoryMapInt.put(labels[i],0);
		}

		for(AccountDetailDTO temp:list) {
			String tempStr = temp.getAccountCategory();
			Integer tempInt = temp.getPrice();
			if(temp.getAccountType().equals("지출")) {
				categoryMapInt.put(tempStr, tempInt + categoryMapInt.getOrDefault(tempStr, 0));	
			}else {
				categoryMapInt.put(tempStr, - tempInt + categoryMapInt.getOrDefault(tempStr, 0));	
			}
		}
		return categoryMapInt;
	}

}

