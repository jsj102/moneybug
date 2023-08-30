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
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public int getBoardSeq() {
		return boardSeq;
	}
	public void setBoardSeq(int boardSeq) {
		this.boardSeq = boardSeq;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriterId() {
		return writerId;
	}
	public void setWriterId(String writerId) {
		this.writerId = writerId;
	}
	public Date getCreateAt() {
		return createAt;
	}
	public void setCreateAt(Date createAt) {
		this.createAt = createAt;
	}
	@Override
	public String toString() {
		return "BonReplyDTO [seq=" + seq + ", boardSeq="+ boardSeq +", content="+ content + "writerId="+writerId + "createAt="+createAt;
				
	}


}
