package com.multi.moneybug.bonBoard;


import lombok.Data;

@Data

public class BonVoteDTO { // table 명
	
	private int seq;
	private String userNickname;
	private int vote; // DB의 vote컬럼과 매칭  1은 찬성  0은 반대 
	private int boardSeq;
	private int upCount;
	private int downcount;
	
	public int getDowncount() {
		return downcount;
	}
	public void setDowncount(int downcount) {
		this.downcount = downcount;
	}
	public void setUpCount(int upCount) {
		this.upCount=upCount;
	}
	public int getUpCount() {
		return upCount;
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
	public int getVote() {
		return vote;
	}
	public void setVote(int vote) {
		this.vote = vote;
	}
	public int getBoardSeq() {
		return boardSeq;
	}
	public void setBoardSeq(int boardSeq) {
		this.boardSeq = boardSeq;
	}
	
	 @Override
	    public String toString() {
	        return "BonVoteDTO {" +
	                "seq=" + seq +
	                ", userNickname=" + userNickname + '\'' +
	                ", vote=" + vote +
	                ", boardSeq=" + boardSeq +
	                '}';
	    }
}
