package com.multi.moneybug.bonBoard;

import lombok.Data;

@Data
public class BonVoteDTO { // table 명
	private int seq;
	private String userId;
	private boolean vote;
	private int boardSeq;
}
