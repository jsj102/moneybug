package com.multi.moneybug.accountBook;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.RequestContext;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletRequestContext;
import org.apache.http.HttpEntity;
import org.apache.http.HttpHeaders;
import org.apache.http.HttpResponse;
import org.apache.http.ParseException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class AccountOCRService {

    // OCR 키 값
	@Value("#{key['api.ocr']}")
    private String key;

    // OCR API
    public String processOCR(HttpServletRequest request) {
        String apiURL = "https://2gynp8yln1.apigw.ntruss.com/custom/v1/24318/3f80d7f6c6c01256a43336e3c2f64477e0b999bb4d309021de87cf002387aa30/infer";
        String requestId = UUID.randomUUID().toString();
        long timestamp = System.currentTimeMillis();
        String result = "";

        try {
			MultipartEntityBuilder builder = createMultipartEntityBuilder(requestId, timestamp, request);

			HttpClient httpClient = HttpClients.createDefault();
			HttpPost httpPost = new HttpPost(apiURL);
			httpPost.setHeader(HttpHeaders.ACCEPT, ContentType.APPLICATION_JSON.getMimeType());
			httpPost.setHeader("X-OCR-SECRET", key);
			httpPost.setEntity(builder.build());

			HttpResponse httpResponse = httpClient.execute(httpPost);
			HttpEntity responseEntity = httpResponse.getEntity();

			if (responseEntity != null) {
			    String responseBody = EntityUtils.toString(responseEntity);
			    System.out.println("<h2>OCR API 결과:</h2>");
			    System.out.println("<pre>" + responseBody + "</pre>");
			    result = responseBody;
			}
		} catch (ClientProtocolException e) {
			System.out.println("HTTP 프로토콜 관련 예외 처리");
			e.printStackTrace();
		} catch (ParseException e) {
			System.out.println("파싱 관련 예외 처리");
			e.printStackTrace();
		} catch (IOException e) {
			System.out.println("IO 관련 예외 처리");
			e.printStackTrace();
		}
        return jsonParsing(result);
    }

    // JSON 파일 생성
    private String createRequestJSON(String requestId, long timestamp) {
        return String.format("{\"images\": [{\"format\": \"jpg\", \"name\": \"demo\"}], \"requestId\": \"%s\", \"version\": \"V2\", \"timestamp\": %d}", requestId, timestamp);
    }

    // JSON 파싱
    private String jsonParsing(String ocrResponse) {
        JSONObject jsonResponse = new JSONObject(ocrResponse);
        JSONArray imagesArray = jsonResponse.getJSONArray("images");
        String inferTextValue = "";
        for (int i = 0; i < imagesArray.length(); i++) {
            JSONObject imageObject = imagesArray.getJSONObject(i);
            if (imageObject.has("title")) {
                JSONObject titleObject = imageObject.getJSONObject("title");  // title -> subFields -> inferText의 값을 가져오는 형태
                if (titleObject.has("subFields")) {
                    JSONArray subFieldsArray = titleObject.getJSONArray("subFields");
                    boolean foundStartsWithChong = false;
                    for (int j = 0; j < subFieldsArray.length(); j++) {
                        JSONObject subFieldObject = subFieldsArray.getJSONObject(j);
                        String inferText = subFieldObject.getString("inferText");
                        inferTextValue = inferText;
                        if (foundStartsWithChong) {
                            try {
                                Double.parseDouble(inferText);
                                System.out.println("<p>Infer Text: " + inferText + "</p>");
                                break;
                            } catch (NumberFormatException e) {
                                System.out.println("<p>Infer Text: " + inferText + "</p>");
                            }
                        } else if (inferText.startsWith("합") || inferText.startsWith("총") || inferText.startsWith("판매") || inferText.startsWith("신용")) {
                            foundStartsWithChong = true;
                        }
                    }
                }
            }
        }
        String numericOnly = inferTextValue.replaceAll("[^0-9]", "");
        return numericOnly;
    }
    // 파일 업로드
    private MultipartEntityBuilder createMultipartEntityBuilder(String requestId, long timestamp, HttpServletRequest request) {
        MultipartEntityBuilder builder = MultipartEntityBuilder.create();

        builder.addTextBody("message", createRequestJSON(requestId, timestamp), ContentType.APPLICATION_JSON);

        FileItemFactory factory = new DiskFileItemFactory();
        FileUpload upload = new FileUpload(factory);
        RequestContext requestContext = new ServletRequestContext(request);
        List<FileItem> items;
        try {
            items = upload.parseRequest(requestContext);
            for (FileItem item : items) {
                if (!item.isFormField()) {
                    try {
						InputStream imageInputStream = item.getInputStream();
						ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
						byte[] buffer = new byte[1024];
						int bytesRead;
						while ((bytesRead = imageInputStream.read(buffer)) != -1) {
						    byteArrayOutputStream.write(buffer, 0, bytesRead);
						}
						byteArrayOutputStream.close();
						byte[] imageData = byteArrayOutputStream.toByteArray();
						builder.addBinaryBody("file", imageData, ContentType.APPLICATION_OCTET_STREAM, UUID.randomUUID().toString() + ".jpg");
					} catch (IOException e) {
						System.out.println("IO 관련 예외 처리");
						e.printStackTrace();
					}
                }
            }
        } catch (FileUploadException e) {
        	System.out.println("파일 업로드 관련 예외 처리");
            e.printStackTrace();
        }
        return builder;
    }

}
