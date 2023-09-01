package com.multi.moneybug.tagReply;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class TagReplyDAO {
	@Autowired
	SqlSessionTemplate my;
	
	
	public int insert(TagReplyDTO tagReplyDTO) {
		return my.insert("tagreply.insert", tagReplyDTO);
	}
	
	public int reinsert(TagReplyDTO tagReplyDTO) {
		return my.insert("tagreply.reinsert", tagReplyDTO);
	}
	
	public List<TagReplyDTO> tagReplyList(int boardSeq) {
        return my.selectList("tagreply.list",boardSeq);
    }
	
	
	public int update(TagReplyDTO tagReplyDTO) {
		return my.update("tagreply.update", tagReplyDTO);
	}
	public int delupdate(TagReplyDTO tagReplyDTO) {
		return my.update("tagreply.delupdate", tagReplyDTO);
	}
	
	
	public int delete(int seq) {
		 return my.delete("tagreply.delete", seq);
	}
	
	public int count(int boardSeq) {
		return my.selectOne("tagreply.count", boardSeq);
	}
}
