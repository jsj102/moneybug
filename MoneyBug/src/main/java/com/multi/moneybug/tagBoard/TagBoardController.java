package com.multi.moneybug.tagBoard;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.multi.moneybug.tagReply.TagReplyDTO;
import com.multi.moneybug.tagReply.TagReplyPageDTO;
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
	    String savedName = null; // 초기화

	    if (file != null && !file.isEmpty()) {
	        savedName = file.getOriginalFilename();
	        String uploadPath = request.getSession().getServletContext().getRealPath("resources/upload");
	        File target = new File(uploadPath + "/" + savedName);
	        file.transferTo(target);

	        model.addAttribute("savedName", savedName);
	        tagBoardDTO.setImage(savedName);
	    }

	    tagBoardService.insert(tagBoardDTO); // 파일이 null이든 아니든 데이터 삽입 시도

	    return "redirect:TagBoard_list?Page=1";
	}

	@RequestMapping("tagBoard/TagBoard_list")
	public void list(TagBoardPageDTO tagBoardPageDTO, Model model) {
		int count = tagBoardService.count();
		int pages = count / 10 + 1;
		tagBoardPageDTO.setStartEnd(tagBoardPageDTO.getPage(),count);
		List<TagBoardDTO> list = tagBoardService.list(tagBoardPageDTO);
		model.addAttribute("list", list);
		model.addAttribute("count", count);
		model.addAttribute("pages", pages);
	}

	@RequestMapping("tagBoard/TagBoard_one")
	public void one(TagReplyPageDTO tagReplyPageDTO, Model model) throws Exception {
		TagBoardDTO tagBoardDTO = tagBoardService.one(tagReplyPageDTO.getSeq()); // 게시물 읽기.
		model.addAttribute("tagBoardDTO", tagBoardDTO);

		tagReplyPageDTO.setStartEnd(tagReplyPageDTO.getPage());
		System.out.println(tagReplyPageDTO);
		List<TagReplyDTO> tagreplylist = tagReplyService.tagreplylist(tagReplyPageDTO); //해당 게시글의 댓글 목록 불러오기.
		model.addAttribute("tagreplylist", tagreplylist);
		System.out.println(tagreplylist.size());
		int count = tagReplyService.count(tagReplyPageDTO.getSeq());
		int pages = 0;
		if(count % 3 == 0) {
			pages = count / 3;
		}else {
			pages = count / 3 +1;
		}
		
		
		model.addAttribute("count", count);
		model.addAttribute("pages", pages);
		

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
