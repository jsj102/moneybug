package com.multi.moneybug.openApi;

import java.sql.Date;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.multi.moneybug.accountBook.AccountBookService;

import lombok.extern.java.Log;

@Controller
@RequestMapping("/api")
@Log
public class OpenApiController {

	Gson gson = new Gson();

	@Autowired
	OpenApiService openApiService;
	@Autowired
	private AccountBookService accountBookService;

	@RequestMapping("/key")
	@ResponseBody
	public String keyGenerator(HttpSession session, @RequestParam String type, Model model) {
		OpenApiDTO openApiDTO = new OpenApiDTO();
		String convert = (String) session.getAttribute("socialId");
		String accountBookId = accountBookService.insertAccountDetailFindSeq(convert);
		int id = Integer.parseInt(accountBookId);
		openApiDTO = openApiService.readOne(id);

		// 값이 들어있으면 발급 X
		if (openApiDTO == null && type.equals("발급")) {
			HashMap<String, String> key = openApiService.userApiGenerator();
			String apiKey = key.get("apiKey");
			String sercetKey = key.get("secretKey");
			openApiService.insert(apiKey, sercetKey, id);
			String result = "APIKEY : " + apiKey + "<br>SERCETKEY : " + sercetKey;
			return result;

		} else if (openApiDTO != null && type.equals("발급")) {
			String result = "Exist Key";
			return result;
		} else if (openApiDTO != null && type.equals("재발급")) {
			openApiService.deleteId(id);
			HashMap<String, String> key = openApiService.userApiGenerator();
			String apiKey = key.get("apiKey");
			String sercetKey = key.get("secretKey");
			openApiService.insert(apiKey, sercetKey, id);
			String result = "APIKEY : " + apiKey + "<br>SERCETKEY : " + sercetKey;
			return result;
		} else {
			String result = "No Exist Key";
			return result;
		}
	}

	@PostMapping(value = "/v1/budget", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String budget(HttpServletRequest request, @RequestBody Map<String, String> requestBody) {
		String apikey = request.getHeader("apiKey");
		String secretKey = request.getHeader("secretKey");
		int searchMonth = Integer.parseInt(requestBody.get("searchMonth"));
		int searchYear = Integer.parseInt(requestBody.get("searchYear"));

		OpenApiDTO openApiDTO = new OpenApiDTO();
		openApiDTO.setApiKey(apikey);
		openApiDTO.setSecretKey(secretKey);

		// 값을 재할당
		openApiDTO = openApiService.readOneKey(openApiDTO);
		if (openApiDTO != null) {
			JSONObject result = openApiService.budgetJsonParsing(openApiDTO.getAccountBookId(), searchMonth,
					searchYear);
			String data = result.toString();
			return data;
		} else {
			JSONObject errorObject = new JSONObject();
			errorObject.put("error", "키값이 잘못되었습니다.");
			String jsonStr = gson.toJson(errorObject);
			return jsonStr; // JSON 형식의 에러 메시지 반환
		}
	}

	// GET
	@GetMapping(value = "/v1/expenses", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String expenses(HttpServletRequest request) {
		String apikey = request.getHeader("apiKey");
		String secretKey = request.getHeader("secretKey");

		OpenApiDTO openApiDTO = new OpenApiDTO();
		openApiDTO.setApiKey(apikey);
		openApiDTO.setSecretKey(secretKey);

		openApiDTO = openApiService.readOneKey(openApiDTO);
		if (openApiDTO != null) {
			JSONObject result = openApiService.expensesJsonParsing(openApiDTO.getAccountBookId());
			String data = result.toString();
			return data;
		} else {
			JSONObject errorObject = new JSONObject();
			errorObject.put("error", "키값이 잘못되었습니다.");
			String jsonStr = gson.toJson(errorObject);
			return jsonStr; // JSON 형식의 에러 메시지 반환
		}
	}

	// POST
	@PostMapping(value = "/v1/detail", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String detail(HttpServletRequest request, @RequestBody Map<String, String> requestBody) {
		String apikey = request.getHeader("apiKey");
		String secretKey = request.getHeader("secretKey");
		int searchMonth = Integer.parseInt(requestBody.get("searchMonth"));
		int searchYear = Integer.parseInt(requestBody.get("searchYear"));

		OpenApiDTO openApiDTO = new OpenApiDTO();
		openApiDTO.setApiKey(apikey);
		openApiDTO.setSecretKey(secretKey);

		openApiDTO = openApiService.readOneKey(openApiDTO);
		if (openApiDTO != null) {
			JSONObject result = openApiService.detailJsonParsing(openApiDTO.getAccountBookId(), searchMonth,
					searchYear);
			String data = result.toString();
			return data;
		} else {
			JSONObject errorObject = new JSONObject();
			errorObject.put("error", "키값이 잘못되었습니다.");
			String jsonStr = gson.toJson(errorObject);
			return jsonStr; // JSON 형식의 에러 메시지 반환
		}
	}

	@DeleteMapping("/v1/delete")
	public void expiredKey() {
		LocalDate today = LocalDate.now();
		Date date = java.sql.Date.valueOf(today);
		if (openApiService.delete(date) == 1) {
			System.out.println("삭제완료");
		} else {
			System.out.println("만료일 apiKey없음");
		}
	}
	
	@GetMapping("/showButton")
	public String show() {
		return "open";
	}
}