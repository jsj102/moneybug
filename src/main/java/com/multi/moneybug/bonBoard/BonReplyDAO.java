package com.multi.moneybug.bonBoard;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


//살까말까 게시판 댓글 클래스 
@Repository 
public class BonReplyDAO {
	@Autowired
	SqlSessionTemplate my;
	
	//살말 댓글 작성
	public void insert(BonReplyDTO BonReplyDTO) {
		my.insert("bonreply.insert", BonReplyDTO);
	}
	
	
	//살말 댓글 리스트
	public List<BonReplyDTO> bonReplyList(int boardSeq){
		return my.selectList("bonreply.list", boardSeq);
	}
	
	
	//살말 댓글 수정
	public void update(BonReplyDTO bonReplyDTO) {
		my.update("bonreply.update", bonReplyDTO);
	}
	
	//살말 댓글 삭제 
	public int delete(int seq) {
		return my.delete("bonreply.delete", seq);
	}

	public int count(int boardSeq) {
		return my.selectOne("bonreply.count", boardSeq);
	}
}
