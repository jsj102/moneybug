package com.multi.moneybug.accountBook;

import java.sql.Date;

import lombok.Data;

@Data
public class AccountBookDTO {
	private int seq;
	private String socialId; 
	private Date createAt;
}
