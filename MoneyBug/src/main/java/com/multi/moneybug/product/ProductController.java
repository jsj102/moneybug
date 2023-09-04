package com.multi.moneybug.product;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.multi.moneybug.member.MemberDTO;
import com.multi.moneybug.member.MemberService;

import com.multi.moneybug.member.MemberDTO;
import com.multi.moneybug.member.MemberService;


@Controller
public class ProductController {

	@Autowired
	ProductService productService;

	@Autowired
	BasketService basketService;

	@Autowired
	MemberService memberService;

	// 쇼핑 목록 페이지
	@RequestMapping("product/shoplist")
	public String getProductList(ProductPageDTO productpageDTO, Model model) {
		int count = productService.count();
		int pages = (count / 6) + 1;
		
		productpageDTO.setStartEnd(productpageDTO.getPage());
		
		List<ProductDTO> productList = productService.getAllProducts(productpageDTO);
		
		model.addAttribute("productList", productList);
		model.addAttribute("count", count);
		model.addAttribute("pages", pages);
		
		return "/product/shoplist"; 
	}

	// 상품 상세페이지로 이동
	@RequestMapping("product/shopDetail")
	public String getProductDetail(@RequestParam("productId") int productId, Model model) {
		ProductDTO productDTO = productService.getProductById(productId);
		model.addAttribute("productDTO", productDTO);
		return "product/shopDetail";
	}

	// 쇼핑 관리자 페이지 (관리자 상품 리스트 ajax)
	@RequestMapping("product/manageList")
	public void showManageList(ProductDTO productDTO,Model model) {
		List<ProductDTO> productList = productService.list(productDTO);
		model.addAttribute("productList", productList);
	}

	// 쇼핑 관리자 페이지 (상품 추가폼으로 이동)
	@RequestMapping("product/manageInsert")
	public void goManageInsert() {
	}

	// 쇼핑 관리자 페이지(주문사항 list출력)
	@RequestMapping("product/manageOrder")
	public String goManageOrder(OrderListDTO orderListDTO,Model model) {
		List<OrderListDTO> orderList = productService.orderlist(orderListDTO);
		model.addAttribute("orderList", orderList);
		return "product/manageOrder";
	}

	// 쇼핑 관리자 페이지 (상품 DB에 추가)
	@RequestMapping("product/productInsert")
	public String productInsert(ProductDTO productDTO) {
		productService.insertNewProduct(productDTO);
		return "redirect:../product/shopmanager.jsp";
	}

	
	@PostMapping("product/submitOrder")
	public String submitOrder(ProductDTO productDTO) {
		//TODO 체크된 항목만 가져가기
		return "product/orderlist";
	}

	//주문서로 이동
	@PostMapping("product/orderlist")
	public String submitOrder(
			@RequestParam("totalAmount") String totalAmount,
			@RequestParam("selectedId") List<String> selectedIdsStr,
			@RequestParam("seletedSeq") List<String> selectedSeqsStr,// 변경된 변수명

			ProductDTO productDTO, MemberDTO memberDTO, BasketDTO basketDTO, Model model, HttpSession session

			) {

		//int형으로 형변환
		List<Integer> selectedIds = new ArrayList<>();       
		for (String idStr : selectedIdsStr) {
			selectedIds.add(Integer.parseInt(idStr));
		}

		//int형으로 형변환
		List<Integer> selectedSeqs = new ArrayList<>();       
		for (String idStr : selectedSeqsStr) {
			selectedSeqs.add(Integer.parseInt(idStr));
		}

		List<BasketDTO> orderlist = basketService.getOrderlists(selectedSeqs);        
		// selectedIds를 이용하여 필요한 처리 수행
		List<ProductDTO> productlist = productService.getProductsByIds(selectedIds);     

		String userNickname = (String) session.getAttribute("userNickname");

		if (userNickname != null && !userNickname.isEmpty()) {
			/* MemberDTO memberDTO1 = new MemberDTO(); */
			memberDTO.setUserNickname(userNickname);
			MemberDTO member = memberService.selectByNickname(memberDTO.getUserNickname());
			memberDTO.setUserId(member.getUserId());
			memberDTO.setEmail(member.getEmail());
			memberDTO.setPoint(member.getPoint());
			memberDTO.setUserName(member.getUserName());
			memberDTO.setUserNickname(member.getUserNickname());
		} else {
			System.out.println("session없음");
		}

		model.addAttribute("orderlist", orderlist);
		model.addAttribute("productlist", productlist);
		model.addAttribute("totalAmount", totalAmount);
		model.addAttribute("member", memberDTO);
		model.addAttribute("basket", basketDTO);
		return "product/orderlist"; // orderlist.jsp와 매핑되는 뷰 이름
	}

	@PostMapping("product/updateOrderStatus")
	public String updateOrderStatus(@ModelAttribute("orderNumber") String orderNumber,
			@ModelAttribute("newStatus") String newStatus,
			Model model, OrderListDTO orderListDTO) {

		// 주문 상태 업데이트 로직을 호출하여 주문 상태 업데이트 처리
		boolean updateResult = productService.updateOrderStatus(orderNumber, newStatus);

		// 업데이트 결과에 따라 메시지 설정
		String message;
		if (updateResult) {
			message = "주문 상태가 업데이트되었습니다.";
		} else {
			message = "주문 상태 업데이트에 실패했습니다.";
		}
		model.addAttribute("updateMessage", message);

		// 주문 목록을 다시 가져와 모델에 추가
		List<OrderListDTO> orderList = productService.orderlist(orderListDTO);
		model.addAttribute("orderList", orderList);

		return "product/manageOrder"; // 주문 관리 페이지로 리다이렉트
	}

	//결제 후 이동
	@PostMapping("product/paySuccess.do") 
	@ResponseBody
	public String payOrder(OrderListDTO orderListDTO, MemberDTO memberDTO, Model model, BasketDTO basketDTO, HttpSession session, String userId, int productId, @RequestParam("seqList") String seqList){ 
		int result = productService.payOrder(orderListDTO);
		String[] seqStr = seqList.split(",");
		for(String s : seqStr) {
			int seq = Integer.parseInt(s);
			basketService.deleteProductFromBasket(userId,productId,seq);
		}
		String userNickname = (String) session.getAttribute("userNickname");
		memberDTO.setUserNickname(userNickname);
		memberService.usePoint(orderListDTO, memberDTO);
		return result + ""; 
	}
	
	@RequestMapping("product/manageDelete")
	public String goManageDelete(int productId) {
		productService.goManageDelete(productId);
		return "redirect:../product/shopmanager.jsp";
	}
	
	// 쇼핑 관리자 페이지 (상품 수정폼으로 이동)
	@RequestMapping("product/manageUpdate")
	public String goManageUpdate(int productId, Model model) {
	    // productId를 이용하여 수정할 상품 정보를 가져오는 로직을 추가
	    ProductDTO product = productService.getProductById(productId);
	    System.out.println("실행");
	    // 가져온 상품 정보를 모델에 추가
	    model.addAttribute("product", product);

	    // 상품 수정폼으로 이동
	    return "product/manageUpdate";
	}
	
	@RequestMapping("product/updateProducts")
	public String updateById(ProductDTO productDTO) {
		productService.updateProduct(productDTO);
		return "redirect:../product/shopmanager.jsp";
	}

	
}