package com.multi.moneybug.bonBoard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BonReplyService {
	
	@Autowired
	BonReplyDAO BonReplyDAO; 
	
	public void insert(BonReplyDTO bonReplyDTO) {
		BonReplyDAO.insert(bonReplyDTO);
	}
	
	public List<BonReplyDTO> list(BonReplyDTO bonReplyDTO) {
		return BonReplyDAO.bonReplyList(bonReplyDTO);
	}
	
	public void update(BonReplyDTO bonReplyDTO) {
		
		BonReplyDAO.update(bonReplyDTO);
	}
	
	public int delete(int seq) {
		return BonReplyDAO.delete(seq);
	}
	
	
	
	
}
	
	
