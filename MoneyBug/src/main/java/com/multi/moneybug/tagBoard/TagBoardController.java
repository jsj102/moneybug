package com.multi.moneybug.tagBoard;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.multi.moneybug.tagReply.TagReplyDTO;
import com.multi.moneybug.tagReply.TagReplyService;


@Controller
public class TagBoardController {

	@Autowired
	TagBoardService tagBoardService;

	@Autowired
	TagReplyService tagReplyService;

	@RequestMapping("tagBoard/TagBoard_insert")
	public String insert(TagBoardDTO tagBoardDTO, HttpServletRequest request, MultipartFile file, Model model)
	        throws Exception {
	    if (!file.isEmpty()) {
	        String savedName = file.getOriginalFilename();
	        String uploadPath = request.getSession().getServletContext().getRealPath("resources/upload");
	        File target = new File(uploadPath + "/" + savedName);
	        file.transferTo(target);

	        model.addAttribute("savedName", savedName);
	        tagBoardDTO.setImage(savedName);
	    }

	    tagBoardService.insert(tagBoardDTO);
	    return "redirect:TagBoard_list";
	}

	@RequestMapping("tagBoard/TagBoard_list")
	public void list(TagBoardDTO tagBoardDTO, Model model) {
		List<TagBoardDTO> list = tagBoardService.list(tagBoardDTO);
		model.addAttribute("list", list);
	}

	@RequestMapping("tagBoard/TagBoard_one")
	public void one(int seq, Model model) throws Exception {
		TagBoardDTO tagBoardDTO = tagBoardService.one(seq); // 게시물 읽기.
		model.addAttribute("tagBoardDTO", tagBoardDTO);

		List<TagReplyDTO> tagreplylist = tagReplyService.tagreplylist(seq); // 게시글 번호에 연결된 댓글들 목록 읽기.
		model.addAttribute("tagreplylist", tagreplylist);

	}

	
	@RequestMapping("tagBoard/TagBoard_update")
	public String update(int seq, String title, String content, String boardType, HttpServletRequest request, MultipartFile file, Model model)
	        throws Exception {
	    TagBoardDTO tagBoardDTO = new TagBoardDTO();

	    if (!file.isEmpty()) {
	        String savedName = file.getOriginalFilename();
	        String uploadPath = request.getSession().getServletContext().getRealPath("resources/upload");
	        File target = new File(uploadPath + "/" + savedName);
	        file.transferTo(target);

	        tagBoardDTO.setImage(savedName);
	    }

	    tagBoardDTO.setSeq(seq);
	    tagBoardDTO.setTitle(title);
	    tagBoardDTO.setContent(content);
	    tagBoardDTO.setBoardType(boardType);
	    
	    tagBoardService.update(tagBoardDTO);
	    
	    return "redirect:TagBoard_one?seq=" + tagBoardDTO.getSeq();
	}

	@RequestMapping("tagBoard/TagBoard_delete")
	@ResponseBody
	public int delete(int seq) {
		int result = tagBoardService.delete(seq);
		return result;
	}

}
