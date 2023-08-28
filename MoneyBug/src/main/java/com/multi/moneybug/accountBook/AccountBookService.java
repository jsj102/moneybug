package com.multi.moneybug.accountBook;



import java.util.List;


import org.springframework.stereotype.Service;

@Service
public class AccountBookService {

    private AccountBookDAO accountBookDAO;
    
    public AccountBookService(AccountBookDAO accountBookDAO) {
        this.accountBookDAO = accountBookDAO;
    }

    public void insertAccountBookIfNotExists(AccountBookDTO accountBookDTO) {
        String socialId = accountBookDTO.getSocialId();
        AccountBookDTO existingAccountBook = accountBookDAO.readOne(socialId);
        if (existingAccountBook == null) { // null인 경우가 중복되지 않은 경우입니다.
            accountBookDAO.insert(accountBookDTO);
        }
    }
    
    
    
    public String insertAccountDetailFindSeq(String socialId) {
    	
    	String seq = accountBookDAO.readfind(socialId);
    	return seq;
    }
    

    public List<Integer> readList() {
    	return accountBookDAO.readList();
    }

}
