package com.multi.moneybug.openApi;

import lombok.Data;

@Data
public class OpenApiTokenDTO {
	private int seq;
	private int refillCount;
	private int refillTime;
	private int givenToken;
	private String secretKey;
	private String oldSecretKey;
	private String newSecretKey;

}
