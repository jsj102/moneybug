package com.multi.moneybug.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.multi.moneybug.product.OrderListDTO;


@Service
public class MemberService {
	
	@Autowired
	MemberDAO memberDAO;
	
	public int insert(MemberDTO memberDTO) {
		return memberDAO.insert(memberDTO);
	}
	
	public int find(MemberDTO memberDTO) {
		int findResult = memberDAO.find(memberDTO);
		return findResult;
	}
	
	public int update(MemberDTO memberDTO) {
		return memberDAO.update(memberDTO);
	}

	public List<MemberDTO> select(MemberDTO memberDTO) {
        List<MemberDTO> selectedMembers = memberDAO.select(memberDTO); // DAO에서 List<MemberDTO>로 반환되는 데이터를 가져옴
        return selectedMembers; // MemberDTO 리스트 반환
    }
	
	public int findNick(String userNickname) {
		int findResult = memberDAO.findNick(userNickname);
		return findResult;
	}
	
	public String getUserIdByUserNickname(String userNickname) {
		String findId = memberDAO.getUserIdByUserNickname(userNickname);
		return findId;
	}
	
	public MemberDTO selectByNickname(String userNickname) {
	    return memberDAO.selectByNickname(userNickname);
	}

	public int usePoint(OrderListDTO orderListDTO, MemberDTO memberDTO) {
	    int newPoint = memberDTO.getPoint() - orderListDTO.getDiscountPrice();
	    memberDTO.setPoint(newPoint);  
	    return memberDAO.usePoint(memberDTO);
	}
	
	public String getEmailByUserNickname(String userNickname) {
		String email = memberDAO.getEmailByUserNickname(userNickname);
		return email;
	}

}