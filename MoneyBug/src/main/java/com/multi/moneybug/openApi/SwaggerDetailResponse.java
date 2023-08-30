package com.multi.moneybug.openApi;


import java.util.List;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import springfox.documentation.annotations.ApiIgnore;
@ApiIgnore
@Data
public class SwaggerDetailResponse {
	
	private List<DetailData> _2023년_8월_지출내역;
	@Data
	public static class DetailData {
		@ApiModelProperty(value = "카테고리", example = "식비")
		private String category;

		@ApiModelProperty(value = "지출/수입", example = "지출")
		private String accountType;

		@ApiModelProperty(value = "설명", example = "맛있는 저녁식사")
		private String description;

		@ApiModelProperty(value = "가격", example = "10000")
		private String price;

		@ApiModelProperty(value = "사용 일자", example = "2023-09-17")
		private String usedAt;
	}
}
