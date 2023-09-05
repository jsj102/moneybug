package com.multi.moneybug.openApi;

import java.util.ArrayList;
import java.util.List;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.bind.annotation.RequestMethod;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiResponses;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.ParameterBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.builders.ResponseMessageBuilder;
import springfox.documentation.schema.ModelRef;
import springfox.documentation.schema.ModelReference;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Parameter;
import springfox.documentation.service.ResponseMessage;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@Configuration
@EnableSwagger2

public class SwaggerConfiguration {
	@Bean
	public Docket api() {
		List<ResponseMessage> responseMessages = new ArrayList<ResponseMessage>();
		responseMessages.add(new ResponseMessageBuilder().code(500).message("{\"error\": \"서버 오류\" ,\"statusCode\": 500}").build());
		responseMessages.add(new ResponseMessageBuilder().code(404).message("{\"error\": \"키값 오류\" ,\"statusCode\": 404}").build());
		responseMessages.add(new ResponseMessageBuilder().code(429).message("{\"success\": \"토큰 한도 초과\"	 ,\"statusCode\": 429}").build());
		responseMessages.add(new ResponseMessageBuilder().code(200).message("{\"success\": \"데이터 작성완료\" ,\"statusCode\": 200}").build());
		return new Docket(DocumentationType.SWAGGER_2).useDefaultResponseMessages(false) // Swagger 에서 제공해주는 기본 응답 코드를
				.host("moneybug.site")
				.apiInfo(apiInfo()).groupName("가계부 OpenAPI").select()
				.apis(RequestHandlerSelectors.basePackage("com.multi.moneybug.openApi")) // Controller가 들어있는 패키지. 이
																							// 경로의// 하위에 있는 api만 표시됨.
				.paths(PathSelectors.ant("/api/v1/**")) // 위 패키지 안의 api 중 지정된 path만 보여줌. (any()로 설정 시 모든 api가 보여짐)
				.build().globalOperationParameters(globalParameters())
				.globalResponseMessage(RequestMethod.GET, responseMessages)
				.globalResponseMessage(RequestMethod.POST, responseMessages);
	}
	
	public List<Parameter> globalParameters() {
		List<Parameter> parameters = new ArrayList<>();

		// 예시: Header 파라미터 추가
		parameters.add(new ParameterBuilder().name("apiKey") // 헤더 이름
				.description("API 접근을 위한 APIKEY") // 헤더 설명
				.modelRef(new ModelRef("string")) // 데이터 타입
				.parameterType("header") // 파라미터 타입 (header)
				.required(true) // 필수 여부
				.description("기존의 발급받은 키를 입력").build());
		parameters.add(new ParameterBuilder().name("secretKey") // 헤더 이름
				.description("API 접근을 위한 secretKey") // 헤더 설명
				.modelRef(new ModelRef("string")) // 데이터 타입
				.parameterType("header") // 파라미터 타입 (header)
				.required(true) // 필수 여부
				.description("기존의 발급받은 키를 입력").build());
		return parameters;
	}

	public ApiInfo apiInfo() {
		return new ApiInfoBuilder().title("가계부 Open API Documentation")
				.description("가계부를 OpenAPI를 활용해서 데이터를 출력,삽입을 해봅시다.<br>" + "입력 제한 초당 20회 이후 20초에 20회씩 가능").version("1")
				.build();
	}
}
