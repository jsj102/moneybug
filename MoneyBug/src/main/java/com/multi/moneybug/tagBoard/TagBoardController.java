package com.multi.moneybug.tagBoard;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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

	    return "redirect:/tagBoard/TagBoard_list?page=1";
	}

	@RequestMapping("tagBoard/TagBoard_list")
	public void list(TagBoardDTO tagBoardDTO, TagBoardPageDTO tagBoardPageDTO, Model model) {
		int count = tagBoardService.count();
		int pages = 0;
		if(count % 10 == 0) {
			pages = count / 10;
		}else {
			pages = count / 10 +1;
		}
		tagBoardPageDTO.setStartEnd(tagBoardPageDTO.getPage(),count);
		List<TagBoardDTO> list = tagBoardService.list(tagBoardPageDTO);
		model.addAttribute("list", list);
		model.addAttribute("count", count);
		model.addAttribute("pages", pages);
		
		List<TagBoardDTO> todaylist = tagBoardService.todaylist(tagBoardDTO);
		model.addAttribute("todaylist", todaylist);
		List<TagBoardDTO> weeklylist = tagBoardService.weeklylist(tagBoardDTO);
		model.addAttribute("weeklylist", weeklylist);
	}
	
	@RequestMapping("tagBoard/TagBoard_taglist")
	public void taglist(TagBoardPageDTO tagBoardPageDTO, Model model) {
		int count = tagBoardService.tagcount();
		int pages = 0;
		if(count % 10 == 0) {
			pages = count / 10;
		}else {
			pages = count / 10 +1;
		}
		tagBoardPageDTO.setStartEnd(tagBoardPageDTO.getPage(),count);
		List<TagBoardDTO> list = tagBoardService.taglist(tagBoardPageDTO);
		model.addAttribute("list", list);
		model.addAttribute("count", count);
		model.addAttribute("pages", pages);
	}
	
	
	@RequestMapping("tagBoard/TagBoard_searchlist")
	public void searchlist(TagBoardPageDTO tagBoardPageDTO, Model model) {
		int count = tagBoardService.searchcount();
		int pages = 0;
		if(count % 10 == 0) {
			pages = count / 10;
		}else {
			pages = count / 10 +1;
		}
		tagBoardPageDTO.setStartEnd(tagBoardPageDTO.getPage(),count);
		List<TagBoardDTO> list = tagBoardService.searchlist(tagBoardPageDTO);
		model.addAttribute("list", list);
		model.addAttribute("count", count);
		model.addAttribute("pages", pages);
	}
	
	

	@RequestMapping("tagBoard/TagBoard_one")
	public void one(int seq, Model model) throws Exception {
		TagBoardDTO tagBoardDTO = tagBoardService.one(seq); // 게시물 읽기.
		model.addAttribute("tagBoardDTO", tagBoardDTO);

		List<TagReplyDTO> tagreplylist = tagReplyService.tagreplylist(seq); // 게시글 번호에 연결된 댓글들 목록 읽기.
		model.addAttribute("tagreplylist", tagreplylist);
		
		List<TagBoardDTO> plmilist = tagBoardService.plmilist(seq);
		model.addAttribute("plmilist", plmilist);

	}

	
	@RequestMapping("tagBoard/TagBoard_update")
	public String update(TagBoardDTO tagBoardDTO, HttpServletRequest request, MultipartFile file, Model model)
	        throws Exception {
	    

	    if (!file.isEmpty()) {
	        String savedName = file.getOriginalFilename();
	        String uploadPath = request.getSession().getServletContext().getRealPath("resources/upload");
	        File target = new File(uploadPath + "/" + savedName);
	        file.transferTo(target);

	        tagBoardDTO.setImage(savedName);
	    }

	    model.addAttribute("tagBoardDTO", tagBoardDTO);
	    tagBoardService.update(tagBoardDTO);
	    
	    return "redirect:TagBoard_one?seq=" + tagBoardDTO.getSeq();
	}

	@RequestMapping("tagBoard/TagBoard_delete")
	@ResponseBody
	public int delete(int seq) {
		int result = tagBoardService.delete(seq);
		return result;
	}
	
	@RequestMapping("tagBoard/TagBoard_updateViews")
    @ResponseBody
    public ResponseEntity<?> updateViews(@RequestParam("seq") Long seq) {
        try {
            // 게시글 조회수 증가 처리
            tagBoardService.updateViews(seq);
            
            // 조회수 증가 후의 게시글 정보를 가져와서 클라이언트에 반환
            TagBoardDTO updatedBoard = tagBoardService.getBoardById(seq);
            return ResponseEntity.ok(updatedBoard);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

}
