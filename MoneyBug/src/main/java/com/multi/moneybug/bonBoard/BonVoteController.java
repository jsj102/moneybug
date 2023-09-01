package com.multi.moneybug.bonBoard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.multi.moneybug.member.MemberDTO;

@Controller
public class BonVoteController {
	
    private final BonVoteService bonVoteService;

    private final BonBoardService bonBoardService;
    
    @Autowired
    public BonVoteController(BonVoteService bonVoteService, BonBoardService bonBoardService) {
        this.bonVoteService = bonVoteService;
        this.bonBoardService = bonBoardService;
    }
    
    @RequestMapping("/bonBoard/BonVote_insert")
    @ResponseBody
    public int insert(BonVoteDTO bonVoteDTO, Model model) {
		
		  if(bonVoteService.voteCheck(bonVoteDTO) >= 1) { 
			  return 0;
		  }
		  bonVoteService.insert(bonVoteDTO);
		  
		  return 1;
    }
    

    @RequestMapping("/bonBoard/BonVote_update")
    public String update(BonVoteDTO bonVoteDTO) {
    	
    	bonVoteService.update(bonVoteDTO);
    	return "bonBoard/BonBoard_one?seq="+bonVoteDTO.getBoardSeq();
    }
    
    
    

    @RequestMapping("/bonBoard/BonVote_voteCheck")
    public void voteCheck(BonVoteDTO bonVoteDTO, Model model) {
    	int result = bonVoteService.voteCheck(bonVoteDTO);
    	model.addAttribute("bonVoteDTO", bonVoteDTO);
    	

    }
    
    @RequestMapping("/bonBoard/BonVote_upList")
    @ResponseBody
    public int upList(int boardSeq) {
    	System.out.println("up/boardSeq => " +boardSeq);
        int voteResult = bonVoteService.upList(boardSeq); // 투표 결과를 가져옴
        
        System.out.println("찬성수 = " + voteResult);
        return voteResult; // 투표 결과를 반환
    }
    
    @RequestMapping("/bonBoard/BonVote_downList")
    @ResponseBody
    public int downList(int boardSeq) {
    	System.out.println("down/boardSeq => " +boardSeq);
        int voteResult = bonVoteService.downList(boardSeq); // 투표 결과를 가져옴
        
        System.out.println("반대수 = " + voteResult);
        return voteResult; // 투표 결과를 반환
    }
    
    

 
      
}
