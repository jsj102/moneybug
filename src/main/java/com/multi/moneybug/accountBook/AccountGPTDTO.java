package com.multi.moneybug.accountBook;
import java.util.Date;
import lombok.Data;
@Data
public class AccountGPTDTO {
	private int seq;
	private int accountBookId;
	private String content;
	private Date createAt;
	private Date startDate;
	private Date endDate;
	private int currentYear; 
	private int currentMonth;
}