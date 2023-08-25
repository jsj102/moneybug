package com.multi.moneybug.log;

import java.sql.Date;

import lombok.Data;

@Data
public class LogDTO{	
	private int seq;
	private LogType type;
	private LogLevel level;
	private String content;
	private Date date;
}
