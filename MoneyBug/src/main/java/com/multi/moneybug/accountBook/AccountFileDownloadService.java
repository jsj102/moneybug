package com.multi.moneybug.accountBook;

import java.io.IOException;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

@Service
public class AccountFileDownloadService {
	public void createAccountBookPDF() {
	    PDDocument accountBookPDF = new PDDocument();
	    PDPage page = new PDPage();
	    accountBookPDF.addPage(page);

	    PDPageContentStream contentStream;
	    try {
	        contentStream = new PDPageContentStream(accountBookPDF, page);

	        contentStream.setFont(PDType1Font.COURIER, 12);
	        
	        // 이동할 y 좌표 값을 설정
	        float newX = page.getMediaBox().getWidth() - 50;
	        float newY = page.getMediaBox().getHeight() - 50; // 예: 50 포인트 아래로 이동
	        
	        contentStream.beginText();
	        contentStream.newLineAtOffset(100, newY); // x 좌표는 그대로, y 좌표만 변경
	        contentStream.showText("Hello World");
	        contentStream.endText();
	        contentStream.close();

	        accountBookPDF.save("C:\\Users\\SUNBI\\eclipse-workspace\\Project\\newlife\\MoneyBug\\example.pdf");
	        accountBookPDF.close();
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	}


		    
		    
}
