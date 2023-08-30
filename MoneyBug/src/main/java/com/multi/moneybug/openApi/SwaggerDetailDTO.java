package com.multi.moneybug.openApi;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import springfox.documentation.annotations.ApiIgnore;

@ApiIgnore
@Data
@ApiModel(description = "reqeust")
public class SwaggerDetailDTO {
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
