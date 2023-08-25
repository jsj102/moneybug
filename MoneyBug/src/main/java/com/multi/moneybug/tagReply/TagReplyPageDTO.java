package com.multi.moneybug.tagReply;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class TagReplyPageDTO {
	
	private int seq; //boardSeq
	private int start;
	private int end;
	private int page;

	public void setStartEnd(int page) {
		//page별로 start, end값만 구해주면 됨.
		start = 1 + (page - 1) * 3; 
		
		end = page * 3;
		
	}
	
	
}