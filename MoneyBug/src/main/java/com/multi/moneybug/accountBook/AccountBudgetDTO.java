package com.multi.moneybug.accountBook;

import java.sql.Date;

import io.swagger.annotations.ApiModel;
import lombok.Data;


@Data
public class AccountBudgetDTO {
	private int seq;
	private int accountBookId;
	private String fixedCategory;
	private int price;
	private Date usedAt;
	private int currentYear; //,RU용도
	private int currentMonth;//R,U용도
}
