package com.multi.moneybug.openApi;

import java.sql.Date;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.multi.moneybug.accountBook.AccountBookService;
import com.multi.moneybug.accountBook.AccountBudgetDTO;
import com.multi.moneybug.accountBook.AccountDetailDTO;
import com.multi.moneybug.accountBook.AccountExpensesDTO;

import io.github.bucket4j.Bucket;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;
import lombok.extern.java.Log;

@Controller
@RequestMapping("/api")
@Log
@EnableScheduling
@Api(tags = { "OpenAPI" })
public class OpenApiController {

	private final OpenApiService openApiService;
	private final AccountBookService accountBookService;
	private Map<String, Bucket> bucketMap = new HashMap<>();

	@Autowired
	public OpenApiController(OpenApiService openApiService, AccountBookService accountBookService) {
		this.accountBookService = accountBookService;
		this.openApiService = openApiService;
	}

	@RequestMapping("/key")
	@ResponseBody
	public String keyGenerator(HttpSession session, @RequestParam String type, Model model) {
		OpenApiDTO openApiDTO = new OpenApiDTO();
		OpenApiTokenDTO apiTokenDTO = new OpenApiTokenDTO();
		apiTokenDTO.setRefillCount(1);
		apiTokenDTO.setRefillTime(1);
		apiTokenDTO.setGivenToken(20);
		String convert = (String) session.getAttribute("socialId");
		String accountBookId = accountBookService.insertAccountDetailFindSeq(convert);
		int id = Integer.parseInt(accountBookId);
		openApiDTO = openApiService.readOne(id);
		// 값이 들어있으면 발급 X
		if (openApiDTO == null && type.equals("발급")) {
			HashMap<String, String> key = openApiService.userApiGenerator();
			String apiKey = key.get("apiKey");
			String sercetKey = key.get("secretKey");
			apiTokenDTO.setSecretKey(sercetKey);
			openApiService.insert(apiKey, sercetKey, id);
			openApiService.insertToken(apiTokenDTO);

			String result = "APIKEY : " + apiKey + "<br>SERCETKEY : " + sercetKey;
			log.info("키 발급 완료 / " + session.getAttribute("userNickname"));
			return result;

		} else if (openApiDTO != null && type.equals("발급")) {
			String result = "Exist Key";
			return result;
		} else if (openApiDTO != null && type.equals("재발급")) {
			OpenApiTokenDTO newApiTokenDTO = new OpenApiTokenDTO();
			HashMap<String, String> key = openApiService.userApiGenerator();
			String apiKey = key.get("apiKey");
			String sercetKey = key.get("secretKey");
			OpenApiDTO open = openApiService.readOne(id);
			newApiTokenDTO.setOldSecretKey(open.getSecretKey());
			newApiTokenDTO.setNewSecretKey(sercetKey);
			openApiService.updateToken(newApiTokenDTO);
			openApiService.deleteId(id);
			openApiService.insert(apiKey, sercetKey, id);
			String result = "APIKEY : " + apiKey + "<br>SERCETKEY : " + sercetKey;
			log.info("키 재발급 완료 / " + session.getAttribute("userNickname"));
			return result;
		} else {
			String result = "No Exist Key";
			return result;
		}
	}

	private ResponseEntity<String> createErrorResponse(int statusCode, String Message) {
		JSONObject result = new JSONObject();
		result.put("statusCode", statusCode);
		result.put("error", Message);
		return ResponseEntity.status(statusCode).body(result.toString());
	}

	private ResponseEntity<String> createSuccesResponse(int statusCode, String Message) {
		JSONObject result = new JSONObject();
		result.put("statusCode", statusCode);
		result.put("success", Message);
		return ResponseEntity.status(statusCode).body(result.toString());
	}

	// GET
	@GetMapping(value = "/v1/budget", produces = "application/json;charset=utf-8")
	@ApiOperation(value = "예산 조회", notes = "조회할 연월을 입력하면 조회가 가능합니다.")
	@ApiImplicitParams({
			@ApiImplicitParam(name = "searchMonth", value = "조회할 월", required = true, paramType = "header", dataType = "int"),
			@ApiImplicitParam(name = "searchYear", value = "조회할 연도", required = true, paramType = "header", dataType = "int") })
	@ApiResponses({ @ApiResponse(code = 200, message = "success", response = SwaggerBudgetResponse.class) })
	public ResponseEntity<String> budget(HttpServletRequest request) {
		String apiKey = request.getHeader("apiKey");
		String secretKey = request.getHeader("secretKey");
		int searchMonth = Integer.parseInt(request.getHeader("searchMonth"));
		int searchYear = Integer.parseInt(request.getHeader("searchYear"));
		OpenApiDTO openApiDTO = new OpenApiDTO();
		openApiDTO.setApiKey(apiKey);
		openApiDTO.setSecretKey(secretKey);
		// 버킷이 없으면 생성합니다.
		try {
			if (!bucketMap.containsKey(secretKey)) {
				bucketMap.put(secretKey, openApiService.readToken(secretKey));
			}
		} catch (NullPointerException e) {
			return createErrorResponse(400, "잘못된 키값");
		}
		// 값을 재할당
		openApiDTO = openApiService.readOneKey(openApiDTO);
		if (openApiService.ischeckTokenAvailability(bucketMap.get(secretKey))) {
			if (openApiDTO != null) {
				JSONObject result = openApiService.budgetJsonParsing(openApiDTO.getAccountBookId(), searchMonth,
						searchYear);
				String data = result.toString();
				log.info("예산 조회 / " + secretKey);
				return ResponseEntity.ok(data);
			} else {
				return createErrorResponse(400, "잘못된 키값");
			}
		} else {
			log.info("토큰 수 한도 초과");
			return createErrorResponse(429, "토큰 한도 초과");
		}
	}

	// GET
	@GetMapping(value = "/v1/expenses", produces = "application/json;charset=utf-8")
	@ApiOperation(value = "고정 지출 조회", notes = "고정 지출은 모든 데이터를 가져옵니다.")
	@ApiResponses({ @ApiResponse(code = 200, message = "success", response = SwaggerExpensesResponse.class) })
	public ResponseEntity<String> expenses(HttpServletRequest request) {
		String apiKey = request.getHeader("apiKey");
		String secretKey = request.getHeader("secretKey");

		OpenApiDTO openApiDTO = new OpenApiDTO();
		openApiDTO.setApiKey(apiKey);
		openApiDTO.setSecretKey(secretKey);
		openApiDTO = openApiService.readOneKey(openApiDTO);
		// 버킷이 없으면 생성합니다.
		try {
			if (!bucketMap.containsKey(secretKey)) {
				bucketMap.put(secretKey, openApiService.readToken(secretKey));
			}
		} catch (NullPointerException e) {
			return createErrorResponse(400, "잘못된 키값");
		}
		if (openApiService.ischeckTokenAvailability(bucketMap.get(secretKey))) {
			if (openApiDTO != null) {
				JSONObject result = openApiService.expensesJsonParsing(openApiDTO.getAccountBookId());
				log.info("고정 조회 / " + secretKey);
				return createErrorResponse(200, request.toString());
			} else {
				return createErrorResponse(400, "잘못된 키값");
			}
		} else {
			log.info("토큰 수 한도 초과");
			return createErrorResponse(429, "토큰 한도 초과");
		}
	}

	// GET
	@GetMapping(value = "/v1/detail", produces = "application/json;charset=utf-8")
	@ApiOperation(value = "지출 내역 조회", notes = "조회할 연월을 입력하면 조회가 가능합니다.")
	@ApiImplicitParams({
			@ApiImplicitParam(name = "searchMonth", value = "조회할 월", required = true, paramType = "header", dataType = "int"),
			@ApiImplicitParam(name = "searchYear", value = "조회할 연도", required = true, paramType = "header", dataType = "int") })
	@ApiResponses({ @ApiResponse(code = 200, message = "success", response = SwaggerDetailResponse.class) })
	public ResponseEntity<String> detail(HttpServletRequest request) {
		String apiKey = request.getHeader("apiKey");
		String secretKey = request.getHeader("secretKey");
		int searchMonth = Integer.parseInt(request.getHeader("searchMonth"));
		int searchYear = Integer.parseInt(request.getHeader("searchYear"));
		OpenApiDTO openApiDTO = new OpenApiDTO();
		openApiDTO.setApiKey(apiKey);
		openApiDTO.setSecretKey(secretKey);
		openApiDTO = openApiService.readOneKey(openApiDTO);
		try {
			if (!bucketMap.containsKey(secretKey)) {
				bucketMap.put(secretKey, openApiService.readToken(secretKey));
			}
		} catch (NullPointerException e) {
			return ResponseEntity.badRequest().body("잘못된 키값");
		}
		if (openApiService.ischeckTokenAvailability(bucketMap.get(secretKey))) {
			if (openApiDTO != null) {
				JSONObject result = openApiService.detailJsonParsing(openApiDTO.getAccountBookId(), searchMonth,
						searchYear);
				log.info("지출 조회 / " + secretKey);
				return createSuccesResponse(200, result.toString());	
			} else {
				return createErrorResponse(400, "잘못된 키값");
			}
		} else {
			log.info("토큰 수 한도 초과");
			return createErrorResponse(429, "토큰 한도 초과");
		}
	}

	@PostMapping(value = "/v1/detail", produces = "application/json;charset=utf-8")
	@ApiOperation(value = "지출/수입에 대해서 입력이 가능합니다.", notes = "입력할 연월을 입력하고 데이터를 넣으면 입력됩니다.")
	@ApiResponses({ @ApiResponse(code = 200, message = "success") })
	public ResponseEntity<String> detailInsert(HttpServletRequest request, @RequestBody List<AccountDetailDTO> requestBody) {
		// 인증
		String apiKey = request.getHeader("apiKey");
		String secretKey = request.getHeader("secretKey");
		OpenApiDTO openApiDTO = new OpenApiDTO();
		openApiDTO.setApiKey(apiKey);
		openApiDTO.setSecretKey(secretKey);
		openApiDTO = openApiService.readOneKey(openApiDTO);
		// 버킷이 없으면 생성합니다.
		try {
			if (!bucketMap.containsKey(secretKey)) {
				bucketMap.put(secretKey, openApiService.readToken(secretKey));
			}
		} catch (NullPointerException e) {
			return createErrorResponse(400, "잘못된 키값");
		}
		// 데이터 삽입
		if (openApiService.ischeckTokenAvailability(bucketMap.get(secretKey))) {
			log.info("detail accountBookId : {}" + openApiDTO.getAccountBookId());
			openApiService.detailJsonParser(requestBody, openApiDTO.getAccountBookId());
			log.info("지출/수입 삽입 / " + secretKey);
			return createSuccesResponse(200, "데이터 작성완료");
		} else {
			log.info("토큰 수 한도 초과");
			return createErrorResponse(429, "토큰 한도 초과");
		}
	}

	@PostMapping(value = "/v1/budget", produces = "application/json;charset=utf-8")
	@ApiOperation(value = "예산 입력", notes = "입력할 연월을 입력하고 데이터를 넣으면 입력됩니다. 대신 카테고리가 반복되지않게 주의해주십시오.")
	public ResponseEntity<String> budgetInsert(HttpServletRequest request, @RequestBody List<AccountBudgetDTO> requestBody) {
		// 인증
		String apiKey = request.getHeader("apiKey");
		String secretKey = request.getHeader("secretKey");

		OpenApiDTO openApiDTO = new OpenApiDTO();
		openApiDTO.setApiKey(apiKey);
		openApiDTO.setSecretKey(secretKey);
		openApiDTO = openApiService.readOneKey(openApiDTO);
		// 버킷이 없으면 생성합니다.
		try {
			if (!bucketMap.containsKey(secretKey)) {
				bucketMap.put(secretKey, openApiService.readToken(secretKey));
			}
		} catch (NullPointerException e) {
			return createErrorResponse(400, "잘못된 키값");
		}
		if (openApiService.ischeckTokenAvailability(bucketMap.get(secretKey))) {
			openApiService.budgetJsonPaser(requestBody, openApiDTO.getAccountBookId());
			return createSuccesResponse(200, "데이터 작성완료");
		} else {
			log.info("토큰 수 한도 초과");
			return createErrorResponse(400, "잘못된 키값");
		}
	}

	@PostMapping(value = "/v1/expenses", produces = "application/json;charset=utf-8")
	@ApiOperation(value = "고정 지출 입력", notes = "데이터를 넣으면 입력됩니다. 대신 카테고리가 반복되지않게 주의해주십시오.")
	public ResponseEntity<String> expensesInsert(HttpServletRequest request,
			@RequestBody List<AccountExpensesDTO> requestBody) {
		String apiKey = request.getHeader("apiKey");
		String secretKey = request.getHeader("secretKey");

		OpenApiDTO openApiDTO = new OpenApiDTO();
		openApiDTO.setApiKey(apiKey);
		openApiDTO.setSecretKey(secretKey);
		openApiDTO = openApiService.readOneKey(openApiDTO);
		// 버킷이 없으면 생성합니다.
		try {
			if (!bucketMap.containsKey(secretKey)) {
				bucketMap.put(secretKey, openApiService.readToken(secretKey));
			}
		} catch (NullPointerException e) {
			return createErrorResponse(400, "잘못된 키값");
		}
		if (openApiService.ischeckTokenAvailability(bucketMap.get(secretKey))) {
			log.info("detail accountBookId : {}" + openApiDTO.getAccountBookId());
			openApiService.expensesJsonPaser(requestBody, openApiDTO.getAccountBookId());
			log.info("고정 지출 삽입 / " + secretKey);
			return createSuccesResponse(200, "데이터 작성 완료");
		} else {
			log.info("토큰 수 한도 초과");
			return createErrorResponse(429, "토큰 한도 초과");
		}
	}

	@Scheduled(cron = "0 0 0 * * *")
	public void expiredKey() {
		LocalDate today = LocalDate.now();
		Date date = java.sql.Date.valueOf(today);
		if (openApiService.delete(date) == 1) {
			log.info("만료키 삭제");
		} else {
			log.info("삭제될 만료키 없음");
		}
	}

	@GetMapping("/showButton")
	public String show() {
		return "open";
	}
}