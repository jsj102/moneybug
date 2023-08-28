package com.multi.moneybug.member;

import lombok.Data;

// Member 테이블 컬럼은 총 9개입니다.

@Data
public class MemberDTO {
	private String userId;
	private String socialId;
	private String email;
	private String userName;
	private String userNickname;
	private String userLevel;
	private int xpPoint;
	private int point;
}
