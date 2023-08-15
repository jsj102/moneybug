package com.multi.moneybug.accountBook;

import lombok.Data;

@Data
public class AccountExpensesDTO {
	private int seq;
	private int accountBookId;
	private String fixedCategory;
	private int price;
	
}
