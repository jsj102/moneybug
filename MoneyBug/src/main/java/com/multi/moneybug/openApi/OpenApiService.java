package com.multi.moneybug.openApi;

import java.sql.Date;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.multi.moneybug.accountBook.AccountBudgetDTO;
import com.multi.moneybug.accountBook.AccountDetailDTO;
import com.multi.moneybug.accountBook.AccountExpensesDTO;

//최근 데이터부터 반환
@Service
public class OpenApiService {

	@Autowired
	OpenApiDAO openApiDAO;

	public JSONObject detailJsonParsing(int accountBookId, int searchMonth, int searchYear) {
		List<AccountDetailDTO> detail = openApiDAO.readListDetail(accountBookId);
		JSONObject outerjson = new JSONObject();

		for (int i = 0; i < detail.size(); i++) {
			AccountDetailDTO data = detail.get(i);
			JSONObject detailjson = new JSONObject();
			LocalDate date = data.getUsedAt().toLocalDate();
			if (date.getYear() == searchYear && date.getMonthValue() == searchMonth) {
				detailjson.put("카테고리", data.getAccountCategory());
				detailjson.put("가격", data.getPrice() + "원");
				detailjson.put("설명", data.getDescription());
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
		if (expenses.isEmpty()) {
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

	public HashMap<String, String> userApiGenerator() {
		String apiKey = UUID.randomUUID().toString();
		String secretKey = UUID.randomUUID().toString();
		HashMap<String, String> key = new HashMap<String, String>();
		key.put("apiKey", apiKey);
		key.put("secretKey", secretKey);
		return key;
	}

	public void insert(OpenApiDTO openApiDTO) {
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
}
