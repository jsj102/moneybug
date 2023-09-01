<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
session.getAttribute("userNickname");

%>

<jsp:forward  page="BonBoard_list?page=1"></jsp:forward>