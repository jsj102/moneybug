package com.multi.moneybug.bonBoard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BonBoardService {
	
	@Autowired
	BonBoardDAO BonBoardDAO;

	public void insert(BonBoardDTO bonBoardDTO) {
		BonBoardDAO.insert(bonBoardDTO);
	}

	public List<BonBoardDTO> list(BonBoardDTO bonBoardDTO) {
		return BonBoardDAO.bonBoardList(bonBoardDTO);
	}

	public BonBoardDTO one(int SEQ) {
		return BonBoardDAO.one(SEQ);
	}

	public void update(BonBoardDTO bonBoardDTO) {
		BonBoardDAO.update(bonBoardDTO);
	}

	public int delete(int seq) {
		return BonBoardDAO.delete(seq);
	}

}
