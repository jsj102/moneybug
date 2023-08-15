package com.multi.moneybug.bonBoard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

public class BonReplyController {
	@Autowired
	BonReplyService bonReplyService;
	
	
	@RequestMapping("BonReply_insert")
	public String insert(BonReplyDTO bonReplyDTO) {
		bonReplyService.insert(bonReplyDTO);
		return "bonBoard/BonBoard_insert";
	}
	
	@RequestMapping("BonReply_list")   //<에대한 요청을 처리하는 메서드 
	public String list(BonReplyDTO bonReplyDTO, Model model) {
		List<BonReplyDTO> list = bonReplyService.list(bonReplyDTO);
		model.addAttribute("list",list);
		return "bonReply/BonReply_list";
	}
	
	@RequestMapping("BongReply_update")
	public String update(int seq, String content, Model model) {
		
		BonReplyDTO bonReplyDTO = new BonReplyDTO();
		bonReplyDTO.setSeq(seq);
		bonReplyDTO.setContent(content);
		bonReplyService.update(bonReplyDTO);
		
		
		//"bonReplyDTO"라는 이름으로 갖고온 댓글 정보를 Model에 add함
		model.addAttribute("bonReplyDTO", bonReplyDTO);
		
		
		//리턴값 = 이동될 뷰 페이지 경로 
		return "bonReply/BonReply_update"; 
	}
	
	
	@RequestMapping("BonReply_delete")
	@ResponseBody
	public int delete(int seq) {
		int result = bonReplyService.delete(seq);
		return result;   //리턴값:  삭제 성공-1   삭제실패 -0 (int타입 )  <-이에 대한 처리는 뷰 페이지에서 
	}

}
