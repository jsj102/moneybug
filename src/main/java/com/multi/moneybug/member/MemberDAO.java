package com.multi.moneybug.member;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


	@Repository
	public class MemberDAO {

		@Autowired
		SqlSessionTemplate my;
		
		public int insert(MemberDTO memberDTO) {
			return my.insert("member.insert", memberDTO);
		}
		
		public int find(MemberDTO memberDTO) {
			return my.selectOne("member.find", memberDTO);
		}
		
		public int update(MemberDTO memberDTO) {
			return my.update("member.update", memberDTO);
		}

		public List<MemberDTO> select(MemberDTO memberDTO) {
			return my.selectList("member.findall", memberDTO);
		}

		public int findNick(String userNickname) {
			return my.selectOne("member.findNick", userNickname);
		}
		
		public String getUserIdByUserNickname(String userNickname) {
			 return my.selectOne("member.getUserIdByUserNickname", userNickname);
		}

	
}