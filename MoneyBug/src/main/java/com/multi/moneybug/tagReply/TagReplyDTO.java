package com.multi.moneybug.tagReply;

import java.util.Date;

import lombok.Data;

@Data
public class TagReplyDTO {

	
	private int rowNo;
	private int seq;
	private int boardSeq;
	private String content;
	private String writerId;
	private Date createAt;
	
	//답글 기능 추가
	private int originSeq; //답글단 댓글의 seq 
	private int replyOrder;  //원댓글 + 답글들 그룹으로 묶어 원댓글(0) -> 답글1(1) -> 답글2(2) ... 순서 
	private int replyLevel; //원댓글 0, 답글들 1
	private int groupSeq; //댓글 그룹 
	private String originWriter;
	
}
