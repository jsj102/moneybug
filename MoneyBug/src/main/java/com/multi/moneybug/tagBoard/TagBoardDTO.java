package com.multi.moneybug.tagBoard;

import java.util.Date;
import java.util.List;

import lombok.Data;


@Data
public class TagBoardDTO {
	private int rowNo;
	private int seq;
	private String writerId;
	private String title;
	private String content;
	private int views;
	private String image;
	private Date createAt;
	private String boardType;
	
	private int start;
    private int end;
    private int page;
	
}