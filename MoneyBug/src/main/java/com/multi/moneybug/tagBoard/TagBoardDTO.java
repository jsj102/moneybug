package com.multi.moneybug.tagBoard;

import java.util.Date;

import lombok.Data;


@Data
public class TagBoardDTO {
	private int seq;
	private String writerId;
	private String title;
	private String content;
	private int views;
	private String image;
	private Date createAt;
	private String boardType;
	
}