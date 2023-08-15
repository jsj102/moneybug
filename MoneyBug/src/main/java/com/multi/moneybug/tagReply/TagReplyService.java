package com.multi.moneybug.tagReply;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TagReplyService {

	@Autowired
	TagReplyDAO tagReplyDAO;

	
	public int insert(TagReplyDTO tagReplyDTO ) {
		return tagReplyDAO.insert(tagReplyDTO);
	}
	public int reinsert(TagReplyDTO tagReplyDTO ) {
		return tagReplyDAO.reinsert(tagReplyDTO);
	}

	public List<TagReplyDTO> tagreplylist(int boardSeq) {
		return tagReplyDAO.tagReplyList(boardSeq);
	}
	
	public int update(TagReplyDTO tagReplyDTO) {
		return tagReplyDAO.update(tagReplyDTO);
	}
	
	public int delete(int seq) {
		return tagReplyDAO.delete(seq);
	}
	
	
	
}
