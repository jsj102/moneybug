package com.multi.moneybug.bonBoard;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository 
public class BonBoardDAO {
	@Autowired
	SqlSessionTemplate my;
	
	
	public void insert(BonBoardDTO BonBoardDTO) {
		my.insert("bonboard.insert", BonBoardDTO);
	}
	
	public List<BonBoardDTO> bonBoardList(BonBoardDTO bonBoardDTO){
		return my.selectList("bonboard.list", bonBoardDTO);
	}
	
	public BonBoardDTO one(int seq) {
		return my.selectOne("bonboard.one", seq);
	}
	
	public void update(BonBoardDTO bonBoardDTO) {
		my.update("bonboard.update", bonBoardDTO);
	}
	
	public int delete(int seq) {
		return my.delete("bonboard.delete", seq);
	}

}
