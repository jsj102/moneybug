package com.multi.moneybug.accountBook;

import java.util.Date;

import lombok.Data;

@Data
public class AccountGPTDTO {
	private int seq;
	private int accountBookId;
	private String content;
	private Date createAt;
}
