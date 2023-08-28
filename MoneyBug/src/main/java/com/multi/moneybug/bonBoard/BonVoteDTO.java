package com.multi.moneybug.bonBoard;


import lombok.Data;

@Data

public class BonVoteDTO { // table 명
	
	private int seq;
	private String userId;
	private int vote; // DB의 vote컬럼과 매칭  1은 찬성  0은 반대 
	private int boardSeq;
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
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
	                ", userId='" + userId + '\'' +
	                ", vote=" + vote +
	                ", boardSeq=" + boardSeq +
	                '}';
	    }
}
