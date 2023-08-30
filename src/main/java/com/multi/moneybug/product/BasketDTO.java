package com.multi.moneybug.product;

import lombok.Data;

@Data
public class BasketDTO {
	private int seq;
	private String userId;
	private int productId;
	private int productCount;
}
