package com.multi.moneybug.bonBoard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class BonReplyController {
	@Autowired
	BonReplyService bonReplyService;
	
	
	@RequestMapping("bonBoard/BonReply_insert")
	public String insert(BonReplyDTO bonReplyDTO) {
		bonReplyService.insert(bonReplyDTO);
		return "redirect:/bonBoard/BonBoard_one?seq="+ bonReplyDTO.getBoardSeq();
	}
	
	
	
	@RequestMapping("bonBoard/BonReply_update")
	public String update(int seq, String content, Model model) {
		
		BonReplyDTO bonReplyDTO = new BonReplyDTO();
		bonReplyDTO.setSeq(seq);
		bonReplyDTO.setContent(content);
		bonReplyService.update(bonReplyDTO);
		
		
		//"bonReplyDTO"�씪�뒗 �씠由꾩쑝濡� 媛뽮퀬�삩 �뙎湲� �젙蹂대�� Model�뿉 add�븿
		model.addAttribute("bonReplyDTO", bonReplyDTO);
		
		
		//由ы꽩媛� = �씠�룞�맆 酉� �럹�씠吏� 寃쎈줈 
		return "/bonBoard/BonReply_update"; 
	}
	
	
	
	@RequestMapping("/bonBoard/BonReply_delete")

	public int delete(int seq) {
		int result = bonReplyService.delete(seq);
		return result;   //由ы꽩媛�:  �궘�젣 �꽦怨�-1   �궘�젣�떎�뙣 -0 (int���엯 )  <-�씠�뿉 ���븳 泥섎━�뒗 酉� �럹�씠吏��뿉�꽌 
	}
	
	@RequestMapping("/bonBoard/BonReply_count")
	public int count(int boardSeq) {
		int count = bonReplyService.count(boardSeq);
		return count;
	}
	
	
	
	

}
