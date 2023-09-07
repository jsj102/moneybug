package com.multi.moneybug.accountBook;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonIgnore;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;


@Data
public class AccountBudgetDTO {
	@JsonIgnore
	private int seq;
	@JsonIgnore
	private int accountBookId;
	@ApiModelProperty(example = "식비")
	private String fixedCategory;
	@ApiModelProperty(example = "10000")
	private int price;
	@ApiModelProperty(example = "2023-09-05")
	private Date usedAt;
	@JsonIgnore
	private int currentYear; //,RU용도
	@JsonIgnore
	private int currentMonth;//R,U용도
}
