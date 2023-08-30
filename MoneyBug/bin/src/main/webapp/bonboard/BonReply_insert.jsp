<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
// 댓글 내용 가져오기
String content = request.getParameter("content");

// 실제로는 여기에서 댓글을 DB에 저장하거나 필요한 작업을 수행합니다.
// 이 예제에서는 댓글 내용을 그대로 사용합니다.
%>

<!-- 댓글 처리 결과를 JSON 형태로 반환 -->
<%
String result = "{\"success\": true, \"message\": \"댓글이 성공적으로 등록되었습니다.\"}";
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");
response.getWriter().write(result);
%>
