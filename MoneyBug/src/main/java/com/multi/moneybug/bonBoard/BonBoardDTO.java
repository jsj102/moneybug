package com.multi.moneybug.bonBoard;

import java.time.*;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;


public class BonBoardDTO {
	private int seq;
	private int rowNo;
	private String userNickname;
	private String title;
	private String content;
	private int views;
	private String itemLink;
	
	private int voteCount; 
	private Date createAt;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date voteEndAt;
	
	

	
	public int getRowNo() {
		return rowNo;
	}
	public void setRowNo(int rowNo) {
		this.rowNo = rowNo;
	}

	

	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	
	public String getUserNickname() {
		return userNickname;
	}
	public void setUserNickname(String userNickname) {
		this.userNickname = userNickname;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getViews() {
		return views;
	}
	public void setViews(int views) {
		this.views = views;
	}
	public String getItemLink() {
		return itemLink;
	}
	public void setItemLink(String itemLink) {
		this.itemLink = itemLink;
	}
	public int getVoteCount() {
		return voteCount;
	}
	public void setVoteCount(int voteCount) {
		this.voteCount = voteCount;
	}
	public Date getCreateAt() {
		return createAt;
	}
	public void setCreateAt(Date createAt) {
		this.createAt = createAt;
	}
	public Date getVoteEndAt() {
		return voteEndAt;
	}
	public void setVoteEndAt(Date voteEndAt) {
		this.voteEndAt = voteEndAt;
	}


	
	private int start;
	private int end;
	private int page;

	public void setStartEnd(int page) {
		//page별로 start, end값만 구해주면 됨.
		start = 1 + (page - 1) * 10; 
		//무조건 1부터 시작
		//1page: 1 + 0 * 10 => start 1
		//2page: 1 + 1 * 10 => start 11  
		end = page * 10;
		//1page: 1 * 10 => end 10
		//2page: 2 * 10 => end 20
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	
	
	
	@Override
	public String toString() {
		return " BonBoardDTO [seq = "+ seq + ", userNickname = "  +userNickname+  ", title = " +title + ", content = "  +content
				+ ", views = " + views +  ", createAt=" + createAt + ", itemLink = "+ itemLink + " ] ";
	}

}
