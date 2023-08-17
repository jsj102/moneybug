package com.multi.moneybug.accountBook;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AccountDetailController {

	@Autowired
	private AccountDetailService accountDetailService;
	
	@RequestMapping("insert.accountDetail")
	public String insert(AccountDetailDTO accountDetailDTO, Model model) {
		System.out.println("hello");
		int result = accountDetailService.insert(accountDetailDTO);
		model.addAttribute("result", result);
		return "redirect: accountBook/accountDetail_List.jsp";
	}

	@RequestMapping("readSeq.accountDetail")
	public String readSeq(Model model, String seq) {
		AccountDetailDTO account = accountDetailService.readOne(seq);
		model.addAttribute("account", account);
		return "accountBook/accountDetail_read_one";
	}

	@RequestMapping("readAll.accountDetail")
	public String readAll(Model model,@RequestParam String accountBookId) {
		List<AccountDetailDTO> list = accountDetailService.readList(accountBookId);
		model.addAttribute("list", list);
		return "accountBook/accountDetail_read";
	}
	
	@RequestMapping("updateForm.accountDetail")
	public String updateForm(@ModelAttribute AccountDetailDTO account,Model model) {
		model.addAttribute("account",account);	
		return "accountBook/accountDetail_update";
	}
	
	@RequestMapping("update.accountDeatil")
	public String update(@ModelAttribute AccountDetailDTO account) {
		accountDetailService.update(account);
		System.out.println(account.toString());
		return "accountBook/accountDetail_read";
	}
	
	@RequestMapping("delete.accountDetail")
	public String delete(String seq) {
		accountDetailService.delete(seq);
		return "accountBook/accountDetail_read_one";
	}

	// 성능비교용 Service1개 사용 Join 사용추가

// 성능비교용 Service 3개 사용
	@RequestMapping("accountBook/monthlyReportRequestJSON")
	@ResponseBody
	public HashMap<String,Object> monthlyReportRequestJSON(Model model,@RequestParam("year") int year, @RequestParam("month") int month) {
		int accountBookId=0; 									//나중에 accountBookId값 넣어주기
		AccountDetailDTO accountDetailDTO = new AccountDetailDTO();
		accountDetailDTO.setAccountBookId(accountBookId);
		accountDetailDTO.setCurrentYear(year);
		accountDetailDTO.setCurrentMonth(month);
		
		
		HashMap<String,Object> map =  new LinkedHashMap<String,Object>();
		
		List<AccountDetailDTO> accountDetailList = accountDetailService.readListMonth(accountDetailDTO);
		
		LinkedHashMap<String, Integer> accountDetailMap = accountDetailService.sumLabelCategory(accountDetailList);
		
		map.put("list", accountDetailList = accountDetailList.subList(0, (accountDetailList.size()<5) ? accountDetailList.size() : 5)); //0~4번까지 5개 리스트 입력
		map.put("map", accountDetailMap);
		 //최근 5개만 골라서 전송
		
		return map;
	}
	
	@RequestMapping("readListPage.accountDetail")
	public String readListPage(AccountDetailDTO searchDTO,Model model) {
		System.out.println(searchDTO.toString());
		List<AccountDetailDTO> list = accountDetailService.readListPage(searchDTO);
		System.out.println("리스트 :"  + list.toString());
		model.addAttribute("list", list);
		model.addAttribute("offset", searchDTO.getOffset());
		return "accountBook/accountDetail_read";
	}
	
	@RequestMapping("readListSearch.accountDetail")
	public String readListSearch(AccountDetailSearchDTO account,Model model) {
		account.setAccountBookId(1);
		List<AccountDetailDTO> list = accountDetailService.readListSearch(account);
		System.out.println(account.toString());
		System.out.println(list.toString());
		model.addAttribute("list", list);
		model.addAttribute("data", account);
		return "accountBook/accountDetail_search";
	}

}