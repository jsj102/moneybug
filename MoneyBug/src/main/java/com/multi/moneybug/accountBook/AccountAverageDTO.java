package com.multi.moneybug.accountBook;

import java.sql.Date;

import lombok.Data;

@Data
public class AccountAverageDTO {
	private int seq;
	private String accountCategory;
	private int price;
	private Date usedAt;
	private int currentYear; //,RU용도
	private int currentMonth;//R,U용도
}
