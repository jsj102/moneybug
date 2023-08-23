package com.multi.moneybug.product;

import lombok.Data;

@Data
public class ProductDTO {
	private int rowNum;
	private int productId;
	private String productType;
	private String productName;
	private String productImg;
	private int productOriprice;
	private int productPrice;
	private String productInfo;
	
}