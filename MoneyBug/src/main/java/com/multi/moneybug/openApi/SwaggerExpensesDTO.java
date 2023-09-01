package com.multi.moneybug.openApi;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import springfox.documentation.annotations.ApiIgnore;

@Data
@ApiModel(description = "고정지출")
public class SwaggerExpensesDTO {
	@ApiModelProperty(value = "카테고리", example = "식비")
	private String category;

	@ApiModelProperty(value = "가격", example = "10000")
	private String price;
}
