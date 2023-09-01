package com.multi.moneybug.accountBook;

import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

@Service

public class AccountGPTService {

	@Value("#{key['open.ai']}")
	private String key;
	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	AccountDetailService accountDetailService;
	@Autowired
	AccountGPTDAO accountGPTDAO;
 
	public String sendRequest(String prompt) {
		String url = "https://api.openai.com/v1/completions";
		RestTemplate restTemplate = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
		headers.set("Authorization", key);

		HashMap<String, Object> requestBody = new HashMap<String, Object>();

		requestBody.put("prompt", prompt);
		requestBody.put("model", "text-davinci-003");
		requestBody.put("max_tokens", 3500);
		HttpEntity<HashMap<String, Object>> request = new HttpEntity<HashMap<String, Object>>(requestBody, headers);

		try {
			restTemplate.getMessageConverters().add(0, new StringHttpMessageConverter(StandardCharsets.UTF_8));
			ResponseEntity<String> response = restTemplate.postForEntity(url, request, String.class);
			System.out.println(response.getBody());
			return response.getBody();
		} catch (RestClientException e) {
			System.out.println(e.getMessage());
			return e.getMessage();
		}
	}

	public String jsonParsing(String gptResponse) {
		JSONObject gpt = new JSONObject(gptResponse);
		JSONArray choicesArray = gpt.getJSONArray("choices");
		JSONObject choice = choicesArray.getJSONObject(0);
		String textValue = choice.getString("text");	
		System.out.println(textValue);
		return textValue;
	}

	// 월별 데이터 소비,수입으로 나눠서 가져오기
	public HashMap<String, List<AccountDetailDTO>> accountSort(AccountDetailDTO accountDetailDTO) {
		List<AccountDetailDTO> list = accountDetailService.readListMonth(accountDetailDTO);
		List<AccountDetailDTO> income = new ArrayList<AccountDetailDTO>();
		List<AccountDetailDTO> consumption = new ArrayList<AccountDetailDTO>();
		HashMap<String, List<AccountDetailDTO>> result = new HashMap<String, List<AccountDetailDTO>>();
		for (AccountDetailDTO test : list) {
			String accountType = test.getAccountType();
			if (accountType.equals("수입")) {
				income.add(test);
			} else if (accountType.equals("지출")) {
				consumption.add(test);
			}
		}
		result.put("income", income);
		result.put("consumption", consumption);
		return result;
	}

	// 소비의 경우 카테고리별로 분류
	public HashMap<String, Integer> cosumptionSort(List<AccountDetailDTO> consumption) {
		HashMap<String, Integer> data = accountDetailService.sumCategory(consumption);
		return data;
	}

	public String prompt(HashMap<String, Integer> data) {
		StringBuilder prompt = new StringBuilder("너는 이제 내 자산관리사야\n");
		prompt.append("이제 이번달 사용량인데 보고 지출내역에 대해서 어떤식으로 절약해야되는지 조언해줘\n");
		for (Map.Entry<String, Integer> result : data.entrySet()) {
			String key = result.getKey();
			Integer val = result.getValue();
			prompt.append(key + "을(를) " + val + "원,\n");
		}
		
		return prompt.toString();
	}
	
	public int insert(AccountGPTDTO accountGPTDTO) {
		return accountGPTDAO.insert(accountGPTDTO);
	} 
	
	public AccountGPTDTO readOne(AccountGPTDTO accountGPTDTO) {
		return accountGPTDAO.readOne(accountGPTDTO);
	}

	public void deleteAll() {
		accountGPTDAO.deleteAll();
		log.info("데이터 전체삭제 완료");
	}

}