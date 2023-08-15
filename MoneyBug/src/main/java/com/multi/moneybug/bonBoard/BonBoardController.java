package com.multi.moneybug.bonBoard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("BonBoard/*")
public class BonBoardController {
	@Autowired
	BonBoardService bonBoardService;  //본보드 서비스를 변수에 담음
	

    public BonBoardController(BonBoardService bonBoardService) {
        this.bonBoardService = bonBoardService;
    }
	//새 게시물 등록 처리하는 핸들러메서드
	@RequestMapping("/insert") //URL 경로 "/BonBoard_insert"에 대한 요청을 처리하는 메서드
	public String insert(BonBoardDTO bonBoardDTO) {
		bonBoardService.insert(bonBoardDTO);
		return "BonBoard/insert";  // 등록 후 보여줄 뷰의 이름 반환 ( 해당 뷰 페이지로 이동됨)
	}
	
	@RequestMapping("/list")//"BonBoard_list"에 대한 요청 처리하는 메서드
	public void list(BonBoardDTO bonBoardDTO, Model model) {
		
		
		
		List<BonBoardDTO> list = bonBoardService.list(bonBoardDTO);
		model.addAttribute("list", list);
	
	}
	
	
	
	
	
	
	@RequestMapping("/one")
	public String one(int seq, Model model) throws Exception{
		BonBoardDTO bonBoardDTO = bonBoardService.one(seq);
		model.addAttribute("bonBoardDTO", bonBoardDTO);
		return "bonBoard/BonBoard_one";
	}
	
	
	@RequestMapping("/update") //"/BonBoard_one"에 대한 요청을 처리하는 메서드
	public String update(int seq, String title, String content, String itemLink, Model model) {
		
		BonBoardDTO bonBoardDTO = new BonBoardDTO();
		bonBoardDTO.setSeq(seq);      //수정할 게시물 번호
		bonBoardDTO.setTitle(title);  //수정할 게시물 제목
		bonBoardDTO.setContent(content);   //수정할 게시물 ㄴ용
		bonBoardDTO.setItemLink(itemLink);  // 수정할 상품 링크-----여기까지 bonBoardDTO set함 
		bonBoardService.update(bonBoardDTO);  //본보드 서비스의  update 메소드 이용하여ㅛ bonBoardDTO를 업데이트함 
		//"bonBoardDTO"라는 이름으로 가져온 게시물 정보(DTO)를 Model에 add
		model.addAttribute("bonBoardDTO", bonBoardDTO);
	
		return "redirect:/BonBoard/list";//"bonBoard/BonBoard_one" 뷰 페이지로 이동
		
	}
	
	
	@RequestMapping("/delete")
	@ResponseBody
	public int delete(int seq) {
		int result = bonBoardService.delete(seq);
		return result;    //삭제 성공시 1, 실패시 0 반환됨   >이에대한 처리는  뷰 페이지에서  ㅇㅇ
	}

}
