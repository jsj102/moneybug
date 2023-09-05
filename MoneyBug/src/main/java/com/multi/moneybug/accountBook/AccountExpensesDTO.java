package com.multi.moneybug.accountBook;

import com.fasterxml.jackson.annotation.JsonIgnore;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class AccountExpensesDTO {
	@JsonIgnore
	private int seq;
	@JsonIgnore
	private int accountBookId;
	@ApiModelProperty(example = "식비")
	private String fixedCategory;
	@ApiModelProperty(example = "12000")
	private int price;
	
}
