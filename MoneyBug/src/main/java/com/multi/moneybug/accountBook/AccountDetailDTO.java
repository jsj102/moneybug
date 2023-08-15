package com.multi.moneybug.accountBook;

import java.sql.Date;

import lombok.Data;

@Data
public class AccountDetailDTO {
	private int seq;
	private String accountCategory;
	private int accountBookId;
	private int price;
	private String description;
	private String accountType;
	private Date usedAt;
	private int currentYear; //,RU용도
	private int currentMonth;//R,U용도
	private int offset; // 페이지네이션
}