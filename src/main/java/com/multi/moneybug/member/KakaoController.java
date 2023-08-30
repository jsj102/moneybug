package com.multi.moneybug.member;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;


@Controller
public class KakaoController {
	@GetMapping("member/kakaocallback")
	
	public MemberDTO kakaoCallback(Model model,@RequestParam("code")String code, MemberDTO memberDTO) {
		//POST방식으로 key=value 데이터를 요청(카카오쪽으로)

		RestTemplate rt = new RestTemplate();

		//HttpHeader 오브젝트 생성
		HttpHeaders headers = new HttpHeaders();
		//현재 http형식이 key-value형식임을 알림
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

		//HttpBody 오브젝트 생성
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type","authorization_code");
		params.add("client_id", "89d5de7971c30a083e735b6abc250f26");
		params.add("redirect_uri", "http://localhost:8181/moneybug/member/kakaocallback");
		params.add("code", code);


		//HttpHeader와 HttpBody를 하나의 오브젝트에 담기
		HttpEntity<MultiValueMap<String,String>> kakaoTokenRequest =
				new HttpEntity<>(params,headers);

		//Http 요청하기 - Post방식으로 - 그리고 response 변수의 응답 받음.
		ResponseEntity<String> response = rt.exchange(
				"https://kauth.kakao.com/oauth/token",
				HttpMethod.POST,
				kakaoTokenRequest,
				String.class
				);

		ObjectMapper objectMapper = new ObjectMapper();
		OAuthToken oauthToken = null;
		try {
			oauthToken = objectMapper.readValue(response.getBody(),OAuthToken.class);


		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}


		RestTemplate rt2 = new RestTemplate();

		//HttpHeader 오브젝트 생성
		HttpHeaders headers2 = new HttpHeaders();
		headers2.add("Authorization", "Bearer " + oauthToken.getAccess_token());
		//현재 http형식이 key-value형식임을 알림
		headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

		//HttpHeader와 HttpBody를 하나의 오브젝트에 담기
		HttpEntity<MultiValueMap<String,String>> kakaoPorfileRequest =
				new HttpEntity<>(headers2);

		//Http 요청하기 - Post방식으로 - 그리고 response 변수의 응답 받음.
		ResponseEntity<String> response2 = rt2.exchange(
				"https://kapi.kakao.com/v2/user/me",
				HttpMethod.POST,
				kakaoPorfileRequest,
				String.class
				);

		String codeResult = response2.getBody();
		model.addAttribute("code", codeResult);

		ObjectMapper objectMapper2 = new ObjectMapper();
		KakaoProfile kakaoProfile = null;
		try {
			kakaoProfile = objectMapper2.readValue(response2.getBody(),KakaoProfile.class);
			memberDTO.setEmail(kakaoProfile.getKakao_account().getEmail());
			memberDTO.setUserName(kakaoProfile.getProperties().getNickname());
			memberDTO.setSocialId(kakaoProfile.getId());


		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}

		model.addAttribute("memberDTO", memberDTO);
		return memberDTO; 

	}
	
	

}