package com.multi.moneybug.bonBoard;

import java.text.ParseException;
import java.time.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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

    @RequestMapping("/bonBoard/BonBoard_insert") 
	public String insert(BonBoardDTO bonBoardDTO, Model model) {
    
    	System.out.println("테스트"+bonBoardDTO);
    	bonBoardService.insert(bonBoardDTO);
    	
    	

        // 새로 생성된 게시글의 seq 값을 모델에 추가하여 반환
        model.addAttribute("seq", bonBoardDTO.getSeq());
        System.out.println("작성된 글 번호 : " +bonBoardDTO.getSeq());

		return "redirect:/bonBoard/BonBoard_list?page=1";  
	}
	

	
	@RequestMapping("/bonBoard/BonBoard_list")
	public void all2(BonBoardPageDTO bonBoardPageDTO, Model model) {
		bonBoardPageDTO.setStartEnd(bonBoardPageDTO.getPage());
		List<BonBoardDTO> list =bonBoardService.list(bonBoardPageDTO);
		int count = bonBoardService.count();
		System.out.println("all count>> " + count);
		int pages = count / 10 + 1; 
		model.addAttribute("list", list);
		model.addAttribute("count", count);
		model.addAttribute("pages", pages);
		
		System.out.println(list);
	}
	
	
	@RequestMapping("/bonBoard/BonBoard_one")
	public String one(int seq, Model model) throws Exception{
		int views =  bonBoardService.view(seq);
		BonBoardDTO bonBoardDTO=new BonBoardDTO();
		bonBoardDTO.setViews(views + 1); //whghltn1증가 
		bonBoardDTO.setSeq(seq);
		bonBoardService.viewPlus(bonBoardDTO);
		BonVoteDTO bonVoteDTO = new BonVoteDTO();
		bonVoteDTO.setSeq(seq);
		
	
		bonBoardDTO = bonBoardService.one(seq);
		//one 내용
		//REPLY LIST(BOARD SEQ)
		List<BonReplyDTO> list = bonReplyService.list(seq);
		System.out.println(list.size());
	
		model.addAttribute("bonBoardDTO", bonBoardDTO);
	//REPLY LIST MODEL
		model.addAttribute("list", list);
		model.addAttribute("bonVoteDTO", bonVoteDTO);
		
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
	@ResponseBody
	public int delete(int seq) {
		
		 int result = bonBoardService.delete(seq);
	 return result;
	
	}
	
	@GetMapping("/bonBoard/bonBoard_main")
	public String main() {
		return "redirect:/bonBoard/BonBoard_list?page=1";
	}
	
	
	
	/*
	 * @RequestMapping("/bonBoard/BonBoard_compareDates") public int
	 * compareDates(String voteEndAt) { try { // 현재 날짜 가져오기 Date currentDate = new
	 * Date();
	 * 
	 * // voteEndAt을 Date 객체로 파싱 SimpleDateFormat dateFormat = new
	 * SimpleDateFormat("yyyy-MM-dd"); String endDate = voteEndAt;
	 * 
	 * System.out.println(" voteEndAt(param값)= "+ voteEndAt);
	 * System.out.println("currentDate = "+currentDate);
	 * System.out.println("endDate= " + endDate); // 현재 날짜와 voteEndAt을 비교 if (ㅅ겨) {
	 * // 현재 날짜가 voteEndAt을 지났을 경우 0 반환 return 0; } else { // 현재 날짜가 voteEndAt을 지나지
	 * 않았을 경우 1 반환 return 1; } } catch (Exception e) {
	 * 
	 * e.printStackTrace(); return -1; } }
	 */
	
	
	

	
	
}