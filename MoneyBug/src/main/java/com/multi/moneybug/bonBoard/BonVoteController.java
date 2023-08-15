package com.multi.moneybug.bonBoard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class BonVoteController {
    private final BonVoteService bonVoteService;

    @Autowired
    public BonVoteController(BonVoteService bonVoteService) {
        this.bonVoteService = bonVoteService;
    }
    

    @RequestMapping("BonVote_list/{seq}") // 투표 보여주는 핸들러 메서드
    public String list(@PathVariable int seq, BonVoteDTO bonVoteDTO, Model model) {
        List<BonVoteDTO> list = bonVoteService.list(bonVoteDTO);
        model.addAttribute("list", list);
        return "bonVote/BonVote_list"; // View로 이동함 
    }
    

    @RequestMapping("BonVote_list/{seq}/vote") // 투표 처리 핸들러 메소드 
    public String vote(@PathVariable int seq, @RequestParam boolean isUpVote, BonVoteDTO bonVoteDTO) {
        bonVoteService.insert(seq, isUpVote);
        bonVoteService.update(bonVoteDTO);
//서비스에게 값 넘겨줌 
        return "redirect:/BonVote_list/{seq}"; 
    }  
}
