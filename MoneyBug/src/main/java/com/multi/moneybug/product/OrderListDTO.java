package com.multi.moneybug.product;

import java.sql.Date;

import lombok.Data;

@Data
public class OrderListDTO {
	private int orderNumber;
	private int basketSeq;
	private String userId;
	private Date orderAt;
	private String userName;
	private String address;
	private String tel;
	private int price;
	private int discountPrice;
	private int totalPrice;
	private String payTool;
	private String orderStatus;
}