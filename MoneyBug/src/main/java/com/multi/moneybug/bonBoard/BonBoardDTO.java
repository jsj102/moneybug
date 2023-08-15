package com.multi.moneybug.bonBoard;

import java.sql.Date;

import lombok.Data;

@Data
public class BonBoardDTO {
	private int seq;
	private String writerId;
	private String title;
	private String content;
	private int views;
	private String itemLink;
	private int voteCount; //
	private Date createAt;
	private Date voteEndAt;

}
