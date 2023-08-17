package com.multi.moneybug.accountBook;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.springframework.stereotype.Service;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Paths;


@Service
public class AccountFileDownloadService {
	public void downloadPDF(HttpServletRequest request, HttpServletResponse response, int accountBookId, int year, int month) {
		try {
// ... 데이터 가져오는 부분 ...

// PDF 문서 생성
			PDDocument accountBookPDF = createAccountBookPDF();

// 파일명 설정
			String fileName = "accountBook_" + accountBookId + "_" + year + "_" + month + ".pdf";

// 파일 경로 설정 (서버의 실제 경로를 가져와 사용)
			String filePath = request.getSession().getServletContext().getRealPath("/");
			filePath = Paths.get(filePath, fileName).toString();

// PDF 파일 저장
			accountBookPDF.save(filePath);

// 클라이언트에 응답으로 파일을 보내기
			response.setContentType("application/pdf");
			response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

			FileInputStream inputStream = new FileInputStream(new File(filePath));
			OutputStream outputStream = response.getOutputStream();

			byte[] buffer = new byte[4096];
			int bytesRead;
			while ((bytesRead = inputStream.read(buffer)) != -1) {
				outputStream.write(buffer, 0, bytesRead);
			}

			inputStream.close();
			outputStream.close();

// PDF 문서 닫기
			accountBookPDF.close();
		} catch (Exception e) {
			e.printStackTrace();
// 에러 처리 로직 추가
		}
	}

	private PDDocument createAccountBookPDF() {
		PDDocument accountBookPDF = new PDDocument();
		PDPage page = new PDPage();
		accountBookPDF.addPage(page);

		PDPageContentStream contentStream;
		try {
			contentStream = new PDPageContentStream(accountBookPDF, page);

			contentStream.setFont(PDType1Font.COURIER, 12);

			float newX = page.getMediaBox().getWidth();
			float newY = page.getMediaBox().getHeight() - 50;

			contentStream.beginText();
			contentStream.newLineAtOffset(newX, newY);
			contentStream.showText("Hello World");
			contentStream.endText();
			contentStream.close();

		} catch (IOException e) {
			e.printStackTrace();
		}
		return accountBookPDF;
	}
}
