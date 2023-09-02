package com.multi.moneybug.bonBoard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BonVoteService {
    private final BonVoteDAO bonVoteDAO;
    private final BonBoardService bonBoardService;

    @Autowired
    public BonVoteService(BonVoteDAO bonVoteDAO, BonBoardService bonBoardService) {
        this.bonVoteDAO = bonVoteDAO;
        this.bonBoardService = bonBoardService;
    }
	public List<BonVoteDTO> list(BonVoteDTO bonVoteDTO) {

		return bonVoteDAO.list(bonVoteDTO);
	}

	public void update(BonVoteDTO bonVoteDTO) {
		bonVoteDAO.update(bonVoteDTO);
	}


	 public void insert(BonVoteDTO bonVoteDTO) {
	    	
	    	bonVoteDAO.insert(bonVoteDTO);
	    }
	
	 public int voteCheck(BonVoteDTO bonVoteDTO) {
		 
		 return bonVoteDAO.voteCheck(bonVoteDTO);
	 }
	
	 public int upList(int boardSeq) {
		 return bonVoteDAO.upList(boardSeq);
	 }
	 
	 public int downList(int boardSeq) {
		 return bonVoteDAO.downList(boardSeq);
	 }

}
