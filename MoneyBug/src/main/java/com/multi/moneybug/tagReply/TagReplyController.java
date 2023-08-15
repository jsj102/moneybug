package com.multi.moneybug.tagReply;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TagReplyController {
	
	@Autowired
	TagReplyService tagReplyService;
	
	
	@RequestMapping("tagReply/TagReply_insert")
	public void insert(TagReplyDTO tagReplyDTO) {
		tagReplyService.insert(tagReplyDTO);
		
	}
	
	@RequestMapping("tagReply/TagReply_reinsert")
	public void reinsert(TagReplyDTO tagReplyDTO) {
		tagReplyService.reinsert(tagReplyDTO);
	}
	
	
	@RequestMapping("tagReply/TagReply_list")
	public void list(int boardSeq, Model model) {
		List<TagReplyDTO> tagreplylist = tagReplyService.tagreplylist(boardSeq);
		model.addAttribute("tagReplylist", boardSeq);
		
	}
	
	@RequestMapping("tagReply/TagReply_update")
	public void update(TagReplyDTO tagReplyDTO, Model model) {
System.out.println(tagReplyDTO);
		model.addAttribute("tagBoardDTO", tagReplyDTO);
		tagReplyService.update(tagReplyDTO);
	}
	
	
	
	
	@RequestMapping("tagReply/TagReply_delete")
	@ResponseBody
	public int delete(int seq) {
		int result = tagReplyService.delete(seq);
		return result;
	}
	
	
	
}
