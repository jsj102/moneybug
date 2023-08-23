package com.multi.moneybug.accountBook;

import java.io.IOException;
import java.io.OutputStream;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.DatatypeConverter;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.apache.pdfbox.pdmodel.font.PDType0Font;
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

@Service
public class AccountFileDownloadService {
	private static float PDFHeight = 792.0f;
	private static float PDFWidth = 612.0f;
	private ClassPathResource fontResource = new ClassPathResource("font/NanumGothic.ttf");
	private PDFont font = null;

	public void downloadExcel(HttpServletResponse response, List<AccountBudgetDTO> budgetList,
			List<AccountExpensesDTO> expensesList, List<AccountDetailDTO> detailList,
			LinkedHashMap<String, Integer> detailMap, int year, int month, String userNickname) throws Exception {
		System.out.println("service");
		// 파일 조회후 없으면 생성
		Workbook accountBookExcel = createAccountBookExcel(budgetList, expensesList, detailList, detailMap, year,
				month);

		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		response.setHeader("Content-Disposition", "attachment; filename=\"accountBook.xlsx\""); // JS에서 파일명설정함

		OutputStream outputStream = response.getOutputStream();
		accountBookExcel.write(outputStream); // PDF 파일을 클라이언트로 전송
		accountBookExcel.close();
		outputStream.flush();
		outputStream.close();
	}

	public Workbook createAccountBookExcel(List<AccountBudgetDTO> budgetList, List<AccountExpensesDTO> expensesList,
			List<AccountDetailDTO> detailList, LinkedHashMap<String, Integer> detailMap, int year, int month) {
		Workbook accountBookExcel = new XSSFWorkbook();
		XSSFCellStyle headerStyle = accountBookExcelHeaderSetting(accountBookExcel);
		XSSFCellStyle bodyStyle = accountBookExcelBodySetting(accountBookExcel);
		
		
		String[] headerData = null;
		String[][] bodyData = null;
		//
		Sheet sheet = accountBookExcel.createSheet(month + "월 예산");
		sheet.setDefaultColumnWidth(20); // 디폴트 너비 설정
		headerData = new String[] {"카테고리","금액"};
		bodyData = new String[budgetList.size()][headerData.length];
		for(int i = 0;i<budgetList.size();i++) {
			AccountBudgetDTO accountBudgetDTO = budgetList.get(i);
			bodyData[i] = new String[] {accountBudgetDTO.getFixedCategory(),Integer.toString(accountBudgetDTO.getPrice())};
		}
		createAccountBookExcelSheet(accountBookExcel,sheet, headerData, bodyData, headerStyle, bodyStyle);
		
		sheet = accountBookExcel.createSheet("고정 지출");
		sheet.setDefaultColumnWidth(30);
		headerData = new String[] {"카테고리","금액"};
		bodyData = new String[expensesList.size()][headerData.length];
		for(int i = 0;i<expensesList.size();i++) {
			AccountExpensesDTO accountExpensesDTO = expensesList.get(i);
			bodyData[i] = new String[] {accountExpensesDTO.getFixedCategory(),Integer.toString(accountExpensesDTO.getPrice())};
		}
		createAccountBookExcelSheet(accountBookExcel, sheet, headerData, bodyData, headerStyle, bodyStyle);
		
		sheet = accountBookExcel.createSheet(month+"월 전체 내역");
		sheet.setDefaultColumnWidth(30);
		headerData = new String[] {"카테고리","수입/지출","사용내역","금액"};
		bodyData = new String[detailList.size()][headerData.length];
		for(int i = 0;i<detailList.size();i++) {
			AccountDetailDTO accountDetailDTO = detailList.get(i);
			bodyData[i] = new String[] {accountDetailDTO.getAccountCategory(),accountDetailDTO.getAccountType(),accountDetailDTO.getDescription(),Integer.toString(accountDetailDTO.getPrice())};
		}
		createAccountBookExcelSheet(accountBookExcel, sheet, headerData, bodyData, headerStyle, bodyStyle);
		
		
		sheet = accountBookExcel.createSheet(month+"카테고리별 내역");
		sheet.setDefaultColumnWidth(30);
		headerData = new String[] {"카테고리","금액"};
		Set<String> keys = detailMap.keySet();
		bodyData = new String[detailMap.size()][headerData.length];
		int detailMapI = 0;
		for(String key : keys) {
			bodyData[detailMapI++] = new String[] {key,Integer.toString(detailMap.get(key))};
		}
		createAccountBookExcelSheet(accountBookExcel, sheet, headerData, bodyData, headerStyle, bodyStyle);
		
		return accountBookExcel;
	}
	
	public XSSFCellStyle accountBookExcelHeaderSetting(Workbook accountBookExcel) {
		XSSFCellStyle headerStyle = (XSSFCellStyle) accountBookExcel.createCellStyle();
		XSSFFont headerFont = (XSSFFont) accountBookExcel.createFont();
		headerFont.setColor(new XSSFColor(new byte[] { (byte) 255, (byte) 255, (byte) 255 }));

		headerStyle.setBorderLeft(BorderStyle.THIN);
		headerStyle.setBorderRight(BorderStyle.THIN);
		headerStyle.setBorderTop(BorderStyle.THIN);
		headerStyle.setBorderBottom(BorderStyle.THIN);

		headerStyle.setFillForegroundColor(new XSSFColor(new byte[] { (byte) 34, (byte) 37, (byte) 41 }));
		headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		headerStyle.setFont(headerFont);
		return headerStyle;

	}
	public XSSFCellStyle accountBookExcelBodySetting(Workbook accountBookExcel) {
		XSSFCellStyle bodyStyle = (XSSFCellStyle) accountBookExcel.createCellStyle();

		bodyStyle.setBorderLeft(BorderStyle.THIN);
		bodyStyle.setBorderRight(BorderStyle.THIN);
		bodyStyle.setBorderTop(BorderStyle.THIN);
		bodyStyle.setBorderBottom(BorderStyle.THIN);
		return bodyStyle;
	}
	
	public Sheet createAccountBookExcelSheet(Workbook accountBookExcel, Sheet sheet,
			String[] headerData, String[][] bodyData,XSSFCellStyle headerStyle, XSSFCellStyle bodyStyle) {

		int rowCount = 0;
		Row headerRow = null;
		Cell headerCell = null;

		headerRow = sheet.createRow(rowCount++);
		for (int i = 0; i < headerData.length; i++) {
			headerCell = headerRow.createCell(i);
			headerCell.setCellValue(headerData[i]);
			headerCell.setCellStyle(headerStyle);
		}


		Row bodyRow = null;
		Cell bodyCell = null;

		for (String[] bodyDatas : bodyData) {
			bodyRow = sheet.createRow(rowCount++);

			for (int i = 0; i < bodyDatas.length; i++) {
				bodyCell = bodyRow.createCell(i);
				bodyCell.setCellValue(bodyDatas[i]);
				bodyCell.setCellStyle(bodyStyle);
			}
		}
		return sheet;
	}

	public void downloadPDF(HttpServletResponse response, List<AccountBudgetDTO> budgetList,
			List<AccountExpensesDTO> expensesList, LinkedHashMap<String, Integer> budgetAndExpensesMap,
			List<AccountDetailDTO> detailList, LinkedHashMap<String, Integer> detailMap, int year, int month,
			String chartImage, String userNickname) {
		try {
			PDDocument accountBookPDF = createAccountBookPDF(budgetList, expensesList, budgetAndExpensesMap, detailList,
					detailMap, year, month, chartImage); // PDF 문서 생성
			response.setContentType("application/pdf");
			response.setHeader("Content-Disposition", "attachment; filename=\"accountBook.pdf\""); // JS에서 파일명설정함

			OutputStream outputStream = response.getOutputStream();
			accountBookPDF.save(outputStream); // PDF 파일을 클라이언트로 전송
			accountBookPDF.close();
			outputStream.flush();
			outputStream.close();

		} catch (Exception e) {
			System.out.println("PDF다운로드 에러");
		}
	}

	public boolean isPDFPageOverflow(String text, float x, float y) {
		float nx = x + text.length() * 15;
		float ny = y + 15;
		if ((nx >= PDFWidth) || (ny <= 30)) {
			System.out.println(nx + ">" + PDFWidth + ":" + ny + "<" + 30);
			return true;
		}
		return false;
	}

	public void createAccountBookPDFDetailText(PDPageContentStream contentStream, int fontSize, float x, float y,
			String text) {

		try {
			contentStream.setFont(font, fontSize);
			contentStream.beginText();
			contentStream.newLineAtOffset(x, y);
			contentStream.showText(text);
			contentStream.endText();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	public PDPageContentStream createPDFContentStreamInNewPage(PDDocument accountBookPDF,
			PDPageContentStream contentStream) {
		try {
			if (contentStream != null) {
				contentStream.close();
			}
		} catch (IOException e) {
			System.out.println("기존 페이지 닫는중 오류발생");
		}
		PDPage page = new PDPage();
		accountBookPDF.addPage(page);
		try {
			contentStream = new PDPageContentStream(accountBookPDF, page);
		} catch (IOException e) {
			System.out.println("새 PDF페이지 만드는중 오류발생");
		}
		return contentStream;
	}

	public PDDocument createAccountBookPDF(List<AccountBudgetDTO> budgetList, List<AccountExpensesDTO> expensesList,
			LinkedHashMap<String, Integer> budgetAndExpensesMap, List<AccountDetailDTO> detailList,
			LinkedHashMap<String, Integer> detailMap, int year, int month, String chartImage) { // PDF파일 생성함수
		PDDocument accountBookPDF = new PDDocument();
		try {
			PDType0Font fontType = PDType0Font.load(accountBookPDF, fontResource.getInputStream());// PDF글꼴설정
			font = fontType;
		} catch (IOException e1) {
			e1.printStackTrace();
			System.out.println("글꼴파일 에러");
		}

		float startX = 50;
		float startY = PDFHeight - 50;

		float stepX = 0;
		float stepY = 15; // 줄간격

		float newX = 250;
		float newY = 500;

		int fontSize = 20;

		PDPageContentStream contentStream = null;

		contentStream = createPDFContentStreamInNewPage(accountBookPDF, contentStream);
		String text = "돈벌레친구들";
		createAccountBookPDFDetailText(contentStream, fontSize, newX, newY, text);
		newX = 300;
		newY = 300;
		text = year + "년 " + month + "월 가계부";
		createAccountBookPDFDetailText(contentStream, fontSize, newX, newY, text);
		newY -= stepY; // 라인변경
		newY -= stepY; // 라인변경
		text = "to You";
		createAccountBookPDFDetailText(contentStream, fontSize, newX, newY, text);

		// 차트 이미지
		contentStream = createPDFContentStreamInNewPage(accountBookPDF, contentStream);
		byte[] imageBytes = DatatypeConverter.parseBase64Binary(chartImage.split(",")[1]); // data:image/png;base64,
																							// 이후부터(인코딩된값)
		PDImageXObject image = null; // extends PDXObject implements PDImage
		try {
			newX = 100;
			newY = 350;
			image = PDImageXObject.createFromByteArray(accountBookPDF, imageBytes, "image");
			contentStream.drawImage(image, newX, newY, 400, 400);

		} catch (IOException e1) {
			e1.printStackTrace();
		}

		// 월간 지출 내역 카테고리 Map
		newX = 50;
		newY = 350;
		text = "분류별 월간 지출 내역";
		fontSize = 15;
		createAccountBookPDFDetailText(contentStream, fontSize, newX, newY, text);
		newY -= stepY;
		newY -= stepY;
		fontSize = 12;
		Set<String> keySet = detailMap.keySet();
		for (String s : keySet) {
			text = s + " : " + detailMap.get(s) + "원" + "(예산 : " + budgetAndExpensesMap.get(s) + "원)";
			if (isPDFPageOverflow(text, newX, newY)) {
				contentStream = createPDFContentStreamInNewPage(accountBookPDF, contentStream);
				newX = startX;
				newY = startY;

			}
			createAccountBookPDFDetailText(contentStream, fontSize, newX, newY, text);
			newY -= stepY; // 라인변경
		}
		newX = startX;
		newY = startY;

		contentStream = createPDFContentStreamInNewPage(accountBookPDF, contentStream);
		// 월간예산
		text = "월간 예산";
		fontSize = 15;
		createAccountBookPDFDetailText(contentStream, fontSize, newX, newY, text);
		newY -= stepY; // 라인변경
		newY -= stepY; // 라인변경

		fontSize = 12;
		for (int i = 0; i < budgetList.size(); i++) {
			text = budgetList.get(i).getFixedCategory() + " : " + budgetList.get(i).getPrice() + "원";
			if (isPDFPageOverflow(text, newX, newY)) {
				contentStream = createPDFContentStreamInNewPage(accountBookPDF, contentStream);
				newX = startX;
				newY = startY;

			}
			createAccountBookPDFDetailText(contentStream, fontSize, newX, newY, text);
			newY -= stepY; // 라인변경
		}

		// 고정지출
		newX = 50;
		newY -= stepY;
		fontSize = 15;
		if (isPDFPageOverflow(text, newX, newY)) {
			contentStream = createPDFContentStreamInNewPage(accountBookPDF, contentStream);
			newX = startX;
			newY = startY;

		}
		text = "고정 지출";
		createAccountBookPDFDetailText(contentStream, fontSize, newX, newY, text);
		newY -= stepY; // 라인변경

		fontSize = 12;
		for (int i = 0; i < expensesList.size(); i++) {
			text = expensesList.get(i).getFixedCategory() + " : " + expensesList.get(i).getPrice() + "원";
			if (isPDFPageOverflow(text, newX, newY)) {
				contentStream = createPDFContentStreamInNewPage(accountBookPDF, contentStream);
				newX = startX;
				newY = startY;

			}
			createAccountBookPDFDetailText(contentStream, fontSize, newX, newY, text);
			newY -= stepY; // 라인변경
		}

		// 월간 지출 내역 List
		contentStream = createPDFContentStreamInNewPage(accountBookPDF, contentStream);// 새 페이지
		newX = 50;
		newY = startY;
		text = "월간 지출 전체 내역";
		fontSize = 15;
		createAccountBookPDFDetailText(contentStream, fontSize, newX, newY, text);

		newY -= stepY;
		fontSize = 12;
		for (int i = 0; i < detailList.size(); i++) {
			text = "[" + detailList.get(i).getAccountType() + "]" + detailList.get(i).getDescription() + "("
					+ detailList.get(i).getAccountCategory() + ") : " + detailList.get(i).getPrice() + "원";
			if (isPDFPageOverflow(text, newX, newY)) {
				contentStream = createPDFContentStreamInNewPage(accountBookPDF, contentStream);
				newX = startX;
				newY = startY;

			}
			createAccountBookPDFDetailText(contentStream, fontSize, newX, newY, text);
			newY -= stepY; // 라인변경
		}

		try {
			contentStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return accountBookPDF;
	}

}
