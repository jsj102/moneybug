package com.multi.moneybug.openApi;

import java.sql.Date;

import lombok.Data;

@Data
public class OpenApiDTO {
	private String apiKey;
	private String secretKey;
	private Date expireDate;
	private int AccountBookId;

}
