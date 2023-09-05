	package com.multi.moneybug.openApi;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.multi.moneybug.accountBook.AccountBudgetDAO;
import com.multi.moneybug.accountBook.AccountBudgetDTO;
import com.multi.moneybug.accountBook.AccountDetailDAO;
import com.multi.moneybug.accountBook.AccountDetailDTO;
import com.multi.moneybug.accountBook.AccountExpensesDAO;
import com.multi.moneybug.accountBook.AccountExpensesDTO;

import io.github.bucket4j.Bandwidth;
import io.github.bucket4j.Bucket;
import io.github.bucket4j.Refill;
import lombok.extern.slf4j.Slf4j;

//최근 데이터부터 반환
@Service
@Slf4j
public class OpenApiService {
	// JSON만들기
	Gson gson = new Gson();
	// 선언부
	private final OpenApiDAO openApiDAO;
	private final AccountDetailDAO accountDetailDAO;
	private final AccountBudgetDAO accountBudgetDAO;
	private final AccountExpensesDAO accountExpensesDAO;

	@Autowired
	public OpenApiService(OpenApiDAO openApiDAO, AccountDetailDAO accountDetailDAO, AccountBudgetDAO accountBudgetDAO,
			AccountExpensesDAO accountExpensesDAO) {
		this.openApiDAO = openApiDAO;
		this.accountBudgetDAO = accountBudgetDAO;
		this.accountDetailDAO = accountDetailDAO;
		this.accountExpensesDAO = accountExpensesDAO;
	}

	public boolean ischeckTokenAvailability(Bucket bucket) {
		if (bucket.tryConsume(1)) {
			return true;
		} else {
			return false;
		}
	}

	public JSONObject detailJsonParsing(int accountBookId, int searchMonth, int searchYear) {
		List<AccountDetailDTO> detail = openApiDAO.readListDetail(accountBookId);
		JSONObject outerjson = new JSONObject();

		for (int i = 0; i < detail.size(); i++) {
			AccountDetailDTO data = detail.get(i);
			JSONObject detailjson = new JSONObject();
			LocalDate date = data.getUsedAt().toLocalDate();
			if (date.getYear() == searchYear && date.getMonthValue() == searchMonth) {
				detailjson.put("category", data.getAccountCategory());
				detailjson.put("price", data.getPrice() + "원");
				detailjson.put("dis", data.getDescription());
				detailjson.put("지출/수입", data.getAccountType());
				detailjson.put("사용날짜", data.getUsedAt());
				outerjson.append(searchYear + "년 " + searchMonth + "월 지출 내역", detailjson);
			} else if (detail.isEmpty()) {
				JSONObject errorMessage = new JSONObject();
				errorMessage.put("error", "해당 년/월의 예산 데이터가 없습니다.");
				outerjson.put("message", errorMessage);
			}
		}
		return outerjson;
	}

	public JSONObject budgetJsonParsing(int accountBookId, int searchMonth, int searchYear) {
		AccountBudgetDTO accountBudgetDTO = new AccountBudgetDTO();
		accountBudgetDTO.setAccountBookId(accountBookId);
		accountBudgetDTO.setCurrentMonth(searchMonth);
		accountBudgetDTO.setCurrentYear(searchYear);
		List<AccountBudgetDTO> budget = openApiDAO.readListBudget(accountBudgetDTO);
		JSONObject outerjson = new JSONObject();
		if (!budget.isEmpty()) {
			for (int i = 0; i < budget.size(); i++) {
				AccountBudgetDTO data = budget.get(i);
				try {
					JSONObject detailjson = new JSONObject();
					detailjson.put("카테고리", data.getFixedCategory());
					detailjson.put("가격", data.getPrice());
					outerjson.append(searchYear + "년 " + searchMonth + "월 예산", detailjson);
				} catch (NullPointerException e) {
					e.getMessage();
				}
			}
		} else {
			JSONObject errorMessage = new JSONObject();
			errorMessage.put("error", "해당 년/월의 예산 데이터가 없습니다.");
			outerjson.put("message", errorMessage);
		}
		return outerjson;
	}

	public JSONObject expensesJsonParsing(int accountBookId) {
		List<AccountExpensesDTO> expenses = openApiDAO.readListExpenses(accountBookId);
		JSONObject outerjson = new JSONObject();
		if (!expenses.isEmpty()) {
			for (int i = 0; i < expenses.size(); i++) {
				AccountExpensesDTO data = expenses.get(i);
				JSONObject detailjson = new JSONObject();
				detailjson.put("카테고리", data.getFixedCategory());
				detailjson.put("가격", data.getPrice());
				outerjson.append("고정 지출", detailjson);
			}
		} else {
			JSONObject errorMessage = new JSONObject();
			errorMessage.put("error", "고정지출 데이터가 없습니다.");
			outerjson.put("message", errorMessage);
		}
		return outerjson;
	}

	public void detailJsonPaser(AccountDetailDTO detailData, int accountBookId) {
		// 데이터 파싱
		JSONObject data = new JSONObject(detailData);
		String category = data.getString("accountCategory");
		String accountType = data.getString("accountType");
		String discription = data.getString("description");
		int price = data.getInt("price");

		String dateString = data.getString("usedAt");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date utilDate = null;
		try {
			utilDate = dateFormat.parse(dateString);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		Date usedAt = new Date(utilDate.getTime());
		// 객체에 데이터 넣기
		AccountDetailDTO accountDetailDTO = new AccountDetailDTO();
		accountDetailDTO.setAccountBookId(accountBookId);
		accountDetailDTO.setAccountCategory(category);
		accountDetailDTO.setAccountType(accountType);
		accountDetailDTO.setDescription(discription);
		accountDetailDTO.setUsedAt(usedAt);
		accountDetailDTO.setPrice(price);
		// 삽입
		accountDetailDAO.insert(accountDetailDTO);
	}

	public void budgetJsonPaser(AccountBudgetDTO budgetData, int accountBookId) {
		JSONObject data = new JSONObject(budgetData);
		String category = data.getString("category");
		int price = data.getInt("price");
		String dateString = data.getString("usedAt");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date utilDate = null;
		try {
			utilDate = dateFormat.parse(dateString);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		Date usedAt = new Date(utilDate.getTime());
		AccountBudgetDTO accountBudgetDTO = new AccountBudgetDTO();
		accountBudgetDTO.setAccountBookId(accountBookId);
		accountBudgetDTO.setFixedCategory(category);
		accountBudgetDTO.setPrice(price);
		accountBudgetDTO.setUsedAt(usedAt);
		//
		accountBudgetDAO.insertDate(accountBudgetDTO);
	}

	public void expensesJsonPaser(AccountExpensesDTO expensesData, int accountBookId) {
		JSONObject data = new JSONObject(expensesData);
		String category = data.getString("category");
		int price = data.getInt("price");
		AccountExpensesDTO accountExpensesDTO = new AccountExpensesDTO();
		accountExpensesDTO.setAccountBookId(accountBookId);
		accountExpensesDTO.setFixedCategory(category);
		accountExpensesDTO.setPrice(price);

		accountExpensesDAO.insert(accountExpensesDTO);
	}

	public HashMap<String, String> userApiGenerator() {
		String apiKey = UUID.randomUUID().toString();
		String secretKey = UUID.randomUUID().toString();
		HashMap<String, String> key = new HashMap<String, String>();
		key.put("apiKey", apiKey);
		key.put("secretKey", secretKey);
		return key;
	}

	public void insert(String apiKey, String secretKey, int accountBookId) {
		// 발급날짜 -> 일주일 후 API키 폐기
		LocalDate expireDate = LocalDate.now();
		expireDate = expireDate.plusDays(7);
		Date date = java.sql.Date.valueOf(expireDate);
		OpenApiDTO openApiDTO = new OpenApiDTO();
		openApiDTO.setApiKey(apiKey);
		openApiDTO.setSecretKey(secretKey);
		openApiDTO.setExpireDate(date);
		openApiDTO.setAccountBookId(accountBookId);
		openApiDAO.insert(openApiDTO);
	}

	public OpenApiDTO readOne(int accountBookId) {
		return openApiDAO.readOne(accountBookId);
	}

	public int delete(Date expireDate) {
		return openApiDAO.delete(expireDate);
	}

	public OpenApiDTO readOneKey(OpenApiDTO openApiDTO) {
		return openApiDAO.readOneKey(openApiDTO);
	}

	public List<OpenApiDTO> readList(OpenApiDTO openApiDTO) {
		return openApiDAO.readList(openApiDTO);
	}

	public void deleteId(int accountBookId) {
		openApiDAO.deleteId(accountBookId);
	}

	public void insertToken(OpenApiTokenDTO openApiTokenDTO) {
		openApiDAO.insertToken(openApiTokenDTO);
	}
	
	public void updateToken(OpenApiTokenDTO apiTokenDTO) {
		openApiDAO.updateToken(apiTokenDTO);
	}

	public Bucket readToken(String secretKey) {
		OpenApiTokenDTO token = openApiDAO.readToken(secretKey);
		Refill refill = Refill.intervally(token.getRefillCount(), Duration.ofSeconds(token.getRefillTime()));
		Bandwidth limit = Bandwidth.classic(token.getGivenToken(), refill);
		Bucket bucket = Bucket.builder().addLimit(limit).build();
		return bucket;
	}
	
}