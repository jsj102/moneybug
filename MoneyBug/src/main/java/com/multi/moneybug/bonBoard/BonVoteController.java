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
    

    @RequestMapping("BonVote_list/{seq}") // �닾�몴 蹂댁뿬二쇰뒗 �빖�뱾�윭 硫붿꽌�뱶
    public String list(@PathVariable int seq, BonVoteDTO bonVoteDTO, Model model) {
        List<BonVoteDTO> list = bonVoteService.list(bonVoteDTO);
        model.addAttribute("list", list);
        return "bonVote/BonVote_list"; // View濡� �씠�룞�븿 
    }
    

    @RequestMapping("BonVote_list/{seq}/vote") // �닾�몴 泥섎━ �빖�뱾�윭 硫붿냼�뱶 
    public String vote(@PathVariable int seq, @RequestParam boolean isUpVote, BonVoteDTO bonVoteDTO) {
        bonVoteService.insert(seq, isUpVote);
        bonVoteService.update(bonVoteDTO);
//�꽌鍮꾩뒪�뿉寃� 媛� �꽆寃⑥쨲 
        return "redirect:/BonVote_list/{seq}"; 
    }  
}
