package com.multi.moneybug.accountBook;

import lombok.Data;

@Data
public class AccountDetailSearchDTO {
	private int accountBookId;
	private String accountCategory;
	private int offsetNumber;
	private int searchMonth; 
	private int searchYear; 
	private int limit;
}
