package com.multi.moneybug.product;

import lombok.Data;

@Data
public class ProductPageDTO {

	private int start;
	private int end;
	private int page;
	
	public void setStartEnd(int page) {
		start = 1 + (page-1) * 6;
		end = page * 6;
	}

}
