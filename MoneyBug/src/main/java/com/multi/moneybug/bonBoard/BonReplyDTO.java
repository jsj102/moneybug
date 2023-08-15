package com.multi.moneybug.bonBoard;

import java.sql.Date;

import lombok.Data;

@Data
public class BonReplyDTO {
	private int seq;
	private int boardSeq;
	private String content;
	private String writerId;
	private Date createAt;
}
