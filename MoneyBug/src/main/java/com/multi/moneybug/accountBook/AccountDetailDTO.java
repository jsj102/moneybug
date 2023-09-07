package com.multi.moneybug.accountBook;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonIgnore;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class AccountDetailDTO {
	@JsonIgnore
	private int seq;
	@ApiModelProperty(example = "식비")
	private String accountCategory;
	@JsonIgnore
	private int accountBookId;
	@ApiModelProperty(example = "10000")
	private int price;
	@ApiModelProperty(example = "설명작성")
	private String description;
	@ApiModelProperty(example = "지출")
	private String accountType;
	@ApiModelProperty(example = "2023-12-12")
	private Date usedAt;
	@JsonIgnore
	private int currentYear; //,RU용도
	@JsonIgnore
	private int currentMonth;//R,U용도
	@JsonIgnore
	private int offset; // 페이지네이션
}