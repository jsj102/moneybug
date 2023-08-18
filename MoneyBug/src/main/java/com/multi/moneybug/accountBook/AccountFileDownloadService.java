package com.multi.moneybug.accountBook;

import java.io.IOException;
import java.io.OutputStream;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.apache.pdfbox.pdmodel.font.PDType0Font;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;


@Service
public class AccountFileDownloadService {
	
    public void downloadPDF(HttpServletResponse response, 
    		List<AccountBudgetDTO> budgetList,
    		List<AccountExpensesDTO> expensesList,
    		LinkedHashMap<String,Integer> budgetAndExpensesMap,
    		List<AccountDetailDTO> detailList,
    		LinkedHashMap<String,Integer> detailMap
    		) {
        try {
            PDDocument accountBookPDF = createAccountBookPDF(response,budgetList,expensesList,budgetAndExpensesMap,detailList,detailMap); // PDF 문서 생성
            response.setContentType("application/pdf"); 
            response.setHeader("Content-Disposition", "attachment; filename=\"accountBook.pdf\""); //JS에서 파일명설정함
            
            OutputStream outputStream = response.getOutputStream();
            accountBookPDF.save(outputStream); // PDF 파일을 클라이언트로 전송
            accountBookPDF.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public PDDocument createAccountBookPDF(HttpServletResponse response, 
    		List<AccountBudgetDTO> budgetList,
    		List<AccountExpensesDTO> expensesList,
    		LinkedHashMap<String,Integer> budgetAndExpensesMap,
    		List<AccountDetailDTO> detailList,
    		LinkedHashMap<String,Integer> detailMap
    		) { //PDF파일 생성함수

        PDDocument accountBookPDF = new PDDocument();
        PDFont font = null;
        
        PDPage page = new PDPage();
        accountBookPDF.addPage(page);
        try {
			PDType0Font fontType = PDType0Font.load(accountBookPDF, getClass().getResourceAsStream("/NanumGothic.ttf"));//PDF글꼴설정
			font =  fontType;
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			System.out.println("글꼴파일 에러");
		}
        
        PDPageContentStream contentStream;
        try {
            contentStream = new PDPageContentStream(accountBookPDF, page);
            contentStream.setFont(font, 12);
            
            float startX = 50;
            float startY = page.getMediaBox().getHeight() - 50;
            float stepX = 0;
            float stepY = 15; //줄간격
            
            float newX = startX;
            float newY = startY;

        	contentStream.beginText();
        	contentStream.newLineAtOffset(newX, newY);
        	contentStream.showText("월간 예산");
        	contentStream.endText();
        	newY-=stepY; //라인변경
            for(int i = 0 ; i < 5; i++) {
            
            	contentStream.beginText();
            	contentStream.newLineAtOffset(newX, newY);
            	contentStream.showText(budgetList.get(i).getFixedCategory());
            	contentStream.endText();
            	newY-=stepY; //라인변경
            }
            
            newX = 50;
            newY-=stepY;

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
