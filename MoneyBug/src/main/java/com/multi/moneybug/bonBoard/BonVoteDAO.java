package com.multi.moneybug.bonBoard;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BonVoteDAO {
	@Autowired
	SqlSessionTemplate my;//매퍼를 활용함 

	
	public List<BonVoteDTO> list(BonVoteDTO bonVoteDTO) {
		// TODO Auto-generated method stub
		return my.selectList("bonvote.list", bonVoteDTO);
	}




	public void update(BonVoteDTO bonVoteDTO) {
		my.update("bonvote.update", bonVoteDTO);
	}

	public int insert(BonVoteDTO bonVoteDTO) {
		return my.insert("bonvote.insert", bonVoteDTO);
	}

	


}
