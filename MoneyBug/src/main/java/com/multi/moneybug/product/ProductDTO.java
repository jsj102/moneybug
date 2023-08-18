package com.multi.moneybug.product;

import lombok.Data;

@Data
public class ProductDTO {
	private int product_id;
	private String product_type;
	private String product_name;
	private String product_img;
	private int product_oriprice;
	private int product_price;
	private String product_info;
}