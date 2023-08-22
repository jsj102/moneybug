<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Moneybug Index</title>
  <link rel="stylesheet" type="text/css" media="all" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" />
  <link rel="stylesheet" type="text/css" href="/moneybug/resources/css/style.css">
  <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js"></script>

</head>
<body>

	<div id="header" align="center">
			<span><label align="left">돈벌레 친구들</label></span>
			 
			<a href="/moneybug/main.jsp"><button class="header-btn">홈</button></a> |
			<a href="/Moneybug/board/list.brd"><button class="header-btn">커뮤니티</button></a> |
			<a href="/moneybug/accountBook/accountbookFrom.jsp"><button class="header-btn">가계부</button></a> |
			<a href="/Moneybug/board2/list.brd"><button class="header-btn">살까말까</button></a> |
			<a href="/Moneybug/event/list.brd"><button class="header-btn">이벤트</button></a> |
			<a href="/Moneybug/CS/list.brd"><button class="header-btn">고객센터</button></a> |
			
			<c:choose>
				<c:when test="${userNickname != null && !userNickname.isEmpty()}">
					<a href="/moneybug/member/myPage.do"><button class="header-btn">마이페이지</button></a> | 
					<a href="/moneybug/logout.do"><button class="header-btn">로그아웃</button></a> | 
				</c:when>
				<c:otherwise>
					<a href="/moneybug/login.jsp"><button class="header-btn">로그인</button></a> | 
					<a href="/Moneybug/member/join.me"><button class="header-btn">회원가입</button></a>
				</c:otherwise>
			</c:choose>
		</div>

		
		