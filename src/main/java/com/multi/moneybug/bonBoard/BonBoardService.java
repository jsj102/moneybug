package com.multi.moneybug.bonBoard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class BonBoardService {
	
	@Autowired
	private BonBoardDAO bonBoardDAO; // Make sure this is properly annotated


	    
	public void insert(BonBoardDTO bonBoardDTO) {
		bonBoardDAO.insert(bonBoardDTO);
	}

	public List<BonBoardDTO> list(BonBoardPageDTO bonBoardPageDTO) {
		return bonBoardDAO.list(bonBoardPageDTO);
	}

	public BonBoardDTO one(int SEQ) {
		return bonBoardDAO.one(SEQ);
	}

	public void update(BonBoardDTO bonBoardDTO) {
		bonBoardDAO.update(bonBoardDTO);
	}

	public int delete(int seq) {
		return bonBoardDAO.delete(seq);
	}

	@Transactional
	public void updateVoteCount(int boardSeq, int newVoteCount) {
		BonBoardDTO boardDTO = bonBoardDAO.one(boardSeq);
		boardDTO.setVoteCount(newVoteCount);
		bonBoardDAO.update(boardDTO);
	}

	 public int count() {
	        return bonBoardDAO.count(); // BonBoardDAO�쓽 count 硫붿냼�뱶 �샇異�
	    }
}
