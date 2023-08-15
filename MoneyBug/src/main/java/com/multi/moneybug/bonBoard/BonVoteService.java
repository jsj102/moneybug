package com.multi.moneybug.bonBoard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class BonVoteService {
	private final BonVoteDAO bonVoteDAO;

	@Autowired
	public BonVoteService(BonVoteDAO bonVoteDAO) {
		this.bonVoteDAO = bonVoteDAO;
	}

	

	public List<BonVoteDTO> list(BonVoteDTO bonVoteDTO) {

		return bonVoteDAO.list(bonVoteDTO);
	}

	public void update(BonVoteDTO bonVoteDTO) {
		bonVoteDAO.update(bonVoteDTO);
	}

	@Transactional
	public void insert(int seq, boolean isUpVote) {
	    try {
	        int voteValue = isUpVote ? 1 : 0; // 찬성인 경우 1, 반대인 경우 0
	        BonVoteDTO bonVoteDTO = new BonVoteDTO();
	        bonVoteDTO.setBoardSeq(seq);
	        bonVoteDTO.setVote(voteValue);  //값이 투표DTO의 Vote변수에 담김 
	        bonVoteDAO.insert(bonVoteDTO);
	        
	    } catch (Exception e) {
	        // 예외 처리 로직
	        e.printStackTrace();
	      
	    }
	}

	

	

}
