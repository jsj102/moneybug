package com.multi.moneybug.openApi;


import java.util.List;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class SwaggerExpensesResponse {

    @ApiModelProperty(value = "고정지출 내역")
    private List<expensesData> _고정지출내역;

    @Data
    public static class expensesData {
        @ApiModelProperty(example = "식비")
        private String category;

        @ApiModelProperty(example = "10000")
        private String price;
    }
}

