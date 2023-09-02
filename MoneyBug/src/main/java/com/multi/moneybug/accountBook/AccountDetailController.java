package com.multi.moneybug.accountBook;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Controller
public class AccountDetailController {

	@Autowired
	private AccountDetailService accountDetailService;
	@Autowired
	private AccountBookService accountBookService;

	@RequestMapping("insert.accountDetail")
	public String insert(AccountDetailDTO accountDetailDTO, Model model) {
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
	public String readAll(Model model,HttpSession session) {
		String convert = (String) session.getAttribute("socialId");
		String accountBookId = accountBookService.insertAccountDetailFindSeq(convert);
		List<AccountDetailDTO> list = accountDetailService.readList(accountBookId);
		model.addAttribute("list", list);
		model.addAttribute("accountBookId", accountBookId);
		return "accountBook/accountDetail_read";
	}
	
	@RequestMapping("updateForm.accountDetail")
	public String updateForm(@ModelAttribute AccountDetailDTO account,Model model) {
		model.addAttribute("account", account);
		return "accountBook/accountDetail_update";
	}
	
	@RequestMapping("update.accountDeatil")
	public String update(@ModelAttribute AccountDetailDTO account) {
		accountDetailService.update(account);
		return "accountBook/accountDetail_read";
	}
	
	@RequestMapping("delete.accountDetail")
	public String delete(String seq) {
		accountDetailService.delete(seq);
		return "accountBook/accountDetail_read_one";
	}

	@RequestMapping("accountBook/monthlyReportRequestJSON")
	@ResponseBody

	public HashMap<String,Object> monthlyReportRequestJSON(@RequestParam("accountBookId") int accountBookId,Model model,@RequestParam("year") int year, @RequestParam("month") int month) {	
		AccountDetailDTO accountDetailDTO = new AccountDetailDTO();
		accountDetailDTO.setAccountBookId(accountBookId);
		accountDetailDTO.setCurrentYear(year);
		accountDetailDTO.setCurrentMonth(month);
		
		
		HashMap<String,Object> map =  new LinkedHashMap<String,Object>();
		
		List<AccountDetailDTO> accountDetailList = accountDetailService.readListMonth(accountDetailDTO);
		
		LinkedHashMap<String, Integer> accountDetailMap = accountDetailService.sumLabelCategory(accountDetailList);
		
		map.put("list", accountDetailList = accountDetailList.subList(0, (accountDetailList.size()<5) ? accountDetailList.size() : 5)); //0~4번까지 5개 리스트 입력
		map.put("map", accountDetailMap);
		return map;
	}
	
	@RequestMapping("readListPage.accountDetail")
	public String readListPage(AccountDetailDTO searchDTO,Model model) {
		List<AccountDetailDTO> list = accountDetailService.readListPage(searchDTO);
		model.addAttribute("list", list);
		model.addAttribute("offset", searchDTO.getOffset());
		return "accountBook/accountDetail_read";
	}
	
	@RequestMapping("readListSearch.accountDetail")
	public String readListSearch(AccountDetailSearchDTO account,Model model,HttpSession session) {
		String convert = (String) session.getAttribute("socialId");
		String accountBookId = accountBookService.insertAccountDetailFindSeq(convert);
		account.setAccountBookId(Integer.parseInt(accountBookId));
		List<AccountDetailDTO> list = accountDetailService.readListSearch(account);
		model.addAttribute("list", list);
		model.addAttribute("data", account);
		return "accountBook/accountDetail_search";
	}

}