package com.multi.moneybug.bonBoard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class BonBoardController {
	
    private final BonBoardService bonBoardService;
    private final BonReplyService bonReplyService;
    
    @Autowired
    public BonBoardController(BonBoardService bonBoardService, BonReplyService bonReplyService) {
        this.bonBoardService = bonBoardService;
        this.bonReplyService = bonReplyService;
        
    
    }

	@RequestMapping("bonBoard/BonBoard_insert") //URL 寃쎈줈 "�뿉 ���븳 �슂泥��쓣 泥섎━�븯�뒗 硫붿꽌�뱶
	public String insert(BonBoardDTO bonBoardDTO) {
		bonBoardService.insert(bonBoardDTO);
		return "bonBoard/BonBoard_one";  // �벑濡� �썑 蹂댁뿬以� 酉곗쓽 �씠由� 諛섑솚 ( �빐�떦 酉� �럹�씠吏�濡� �씠�룞�맖)
	}
	
	
	//파일첨부 수정중 
//	@RequestMapping("bonBoard/BonBoard_insert2") //URL 寃쎈줈 "�뿉 ���븳 �슂泥��쓣 泥섎━�븯�뒗 硫붿꽌�뱶
//	public String insert2(BonBoardDTO bonBoardDTO, MultipartFile[] upfile) {
//		bonBoardService.insert(bonBoardDTO);
//		
//		
//		BonFileDTO bonFileDTO = new BonFileDTO();
//		bonFileDTO.setFileName(filename);
//		return "bonBoard/BonBoard_one";  // �벑濡� �썑 蹂댁뿬以� 酉곗쓽 �씠由� 諛섑솚 ( �빐�떦 酉� �럹�씠吏�濡� �씠�룞�맖)
//	}
//	
	
	/*
	 
	@RequestMapping("/list")//"BonBoard_list"�뿉 ���븳 �슂泥� 泥섎━�븯�뒗 硫붿꽌�뱶
	public void list(BonBoardDTO bonBoardDTO, Model model) {
		
		List<BonBoardDTO> list = bonBoardService.list(bonBoardDTO);
		model.addAttribute("list", list);
	
	}
	*/
	
	@RequestMapping("/bonBoard/BonBoard_list")
	public void all2(BonBoardPageDTO bonBoardPageDTO, Model model) {
		bonBoardPageDTO.setStartEnd(bonBoardPageDTO.getPage());
		List<BonBoardDTO> list =bonBoardService.list(bonBoardPageDTO);
		int count = bonBoardService.count();
		System.out.println("all count>> " + count);
		int pages = count / 10 + 1; //�쟾泥� �럹�씠吏� 媛쒖닔 援ы븯湲� 
		model.addAttribute("list", list);
		model.addAttribute("count", count);
		model.addAttribute("pages", pages);
		
		System.out.println(list);
	}
	

	
	
	
	@RequestMapping("/bonBoard/BonBoard_one")
	public String one(int seq, Model model) throws Exception{
		BonBoardDTO bonBoardDTO = bonBoardService.one(seq);
		//one 내용
		//REPLY LIST(BOARD SEQ)
		List<BonReplyDTO> list = bonReplyService.list(seq);
	System.out.println(list.size());
	
		model.addAttribute("bonBoardDTO", bonBoardDTO);
	//REPLY LIST MODEL
		model.addAttribute("list", list);
		return "/bonBoard/BonBoard_one";
	}
	
	@RequestMapping("/bonBoard/BonBoard_update") //"/BonBoard_one"�뿉 ���븳 �슂泥��쓣 泥섎━�븯�뒗 硫붿꽌�뱶
	public String update(BonBoardDTO bonBoardDTO, Model model) {
		

		bonBoardService.update(bonBoardDTO);  //蹂몃낫�뱶 �꽌鍮꾩뒪�쓽  update 硫붿냼�뱶 �씠�슜�븯�뿬�뀤 bonBoardDTO瑜� �뾽�뜲�씠�듃�븿 
		//"bonBoardDTO"�씪�뒗 �씠由꾩쑝濡� 媛��졇�삩 寃뚯떆臾� �젙蹂�(DTO)瑜� Model�뿉 add
		model.addAttribute("bonBoardDTO", bonBoardDTO);
	
		return "redirect:/bonBoard/BonBoard_one?seq=" + bonBoardDTO.getSeq();//"bonBoard/BonBoard_one" 酉� �럹�씠吏�濡� �씠�룞
		
	}
	
	
	@RequestMapping("/bonBoard/BonBoard_delete")
	public String delete(int seq) {
		 bonBoardService.delete(seq);
	 return "/bonBoard/BonBoard_list";
	
	}
	
	
	
	

	
	
}