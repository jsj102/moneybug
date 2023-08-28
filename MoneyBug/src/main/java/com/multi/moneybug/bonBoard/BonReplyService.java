package com.multi.moneybug.bonBoard;

import java.text.SimpleDateFormat;
import java.util.Date;
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
	
	public List<BonReplyDTO> list(int seq ) {
		return BonReplyDAO.bonReplyList(seq);
	}
	
	

	public void update(BonReplyDTO bonReplyDTO) {
		
		BonReplyDAO.update(bonReplyDTO);
	}

	public int delete(int seq) {
		return BonReplyDAO.delete(seq);
	}
	public int count (int boardSeq) {
		return BonReplyDAO.count(boardSeq);
	}
	

	
}
	
	
