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
		return my.selectList("bonvote.list", bonVoteDTO);
	}



	public void update(BonVoteDTO bonVoteDTO) {
		my.update("bonvote.update", bonVoteDTO);
	}

	public void insert(BonVoteDTO bonVoteDTO) {
		my.insert("bonvote.insert", bonVoteDTO);
	}


	public int voteCheck(BonVoteDTO bonVoteDTO) {
		
		return my.selectOne("bonvote.voteCheck", bonVoteDTO);
	}

	
	public int upList(int boardSeq) {
		
		return my.selectOne("bonvote.upList", boardSeq);
		
	}
	
	public int downList(int boardSeq) {
		
		return my.selectOne("bonvote.downList", boardSeq);
		
	}




	


}
