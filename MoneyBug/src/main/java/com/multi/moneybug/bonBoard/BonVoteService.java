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


	  public void insert(int seq, boolean isUpVote) {
	        try {
	            int voteValue = isUpVote ? 1 : 0;
	            BonVoteDTO bonVoteDTO = new BonVoteDTO();
	            bonVoteDTO.setBoardSeq(seq);
	            bonVoteDTO.setVote(voteValue);
	            bonVoteDAO.insert(bonVoteDTO);

	            // �닾�몴 �궫�엯 �썑 �빐�떦 寃뚯떆臾쇱쓽 珥� �닾�몴�닔瑜� 怨꾩궛
	            int totalVotes = bonVoteDAO.calculateTotalVotes(seq);

	            // 珥� �닾�몴�옄 �닔瑜� BonBoardService瑜� �넻�빐 �뾽�뜲�씠�듃
	            bonBoardService.updateVoteCount(seq, totalVotes);

	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	  public void updateVoteCount(int boardSeq, int newVoteCount) {
	        bonBoardService.updateVoteCount(boardSeq, newVoteCount);
	    }
	
	

}
