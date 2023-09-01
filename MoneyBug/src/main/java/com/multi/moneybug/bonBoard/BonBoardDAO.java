package com.multi.moneybug.bonBoard;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository 
public class BonBoardDAO {
	
	@Autowired
	SqlSessionTemplate my;
	
	
	public void insert(BonBoardDTO bonBoardDTO) {
		my.insert("bonboard.insert", bonBoardDTO);
	}
	
	public List<BonBoardDTO> list(BonBoardPageDTO bonBoardPageDTO){
		return my.selectList("bonboard.list", bonBoardPageDTO);
	}
	
	public BonBoardDTO one(int seq) {
		return my.selectOne("bonboard.one", seq);
	}
	
	public int count() {
		return my.selectOne("bonboard.count");
	} 
	
	public int update(BonBoardDTO bonBoardDTO) {
		return my.update("bonboard.update", bonBoardDTO);
	}
	
	public int delete(int seq) {
		return my.delete("bonboard.delete", seq);
	}
	
	
	
	
	
	 public int viewPlus(BonBoardDTO bonBoardDTO) {
		 return my.update("bonboard.viewplus", bonBoardDTO);
		  
	 }
	 
	 public int view(int seq) {
		 return my.selectOne("bonboard.view", seq);
	 }
	

}
