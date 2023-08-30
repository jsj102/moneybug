<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>돈벌레 친구들</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/main.css" rel="stylesheet">

<script>
$(document).ready(function() {
    $('.mypage').click(function(event) {
        event.preventDefault();

        const form = $('<form>', {
            method: 'POST',
            action: 'member/myPage.do',
            style: 'display:none;'
        });

        $('body').append(form);
        form.submit();
    });
});
</script>
<style>
.navbar-brand {
  display: flex;
  align-items: center;
  font-weight: bold;
}
</style>
</head>
<body>

	<nav class="navbar navbar-expand-xl navbar-light" style="background-color: #F9F5E7;">
		<div class="container-fluid">
		<a class="navbar-brand" href="#">
			<img src="/moneybug/resources/img/nav_icon.png" width="50" height="50" class="d-inline-block align-center" >
			<span>돈벌레친구들</span>
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
        data-target="#navbarNav" aria-controls="navbarNav"
        aria-expanded="true" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    	</button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
            <li class="nav-item active"><a class="nav-link" href="/moneybug/main.jsp">Home<span class="sr-only">(current)</span></a></li>
            <li class="nav-item active"><a class="nav-link" href="/moneybug/tagBoard/TagBoard_list?page=1">커뮤니티</a></li>
            <li class="nav-item active"><a class="nav-link" href="/moneybug/accountBook/accountbookFrom.jsp">가계부</a></li>
            <li class="nav-item active"><a class="nav-link" href="/moneybug/bonBoard/BonBoard_list?page=1">살까말까</a></li>
            <li class="nav-item active"><a class="nav-link" href="${pageContext.request.contextPath}/product/shoplist?page=1">상품Shop</a></li>
            <!-- <li class="nav-item active"><a class="nav-link" href="/Moneybug/event/list.brd">이벤트</a></li> -->
            <!-- <li class="nav-item active"><a class="nav-link" href="/Moneybug/CS/list.brd">고객센터</a></li> -->

			<c:choose>
				<c:when
					test="${sessionScope.userNickname != null && !sessionScope.userNickname.isEmpty()}">
					
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle"
						href="/moneybug/member/myPage.do" role="button"
						data-toggle="dropdown" aria-expanded="false"> ${sessionScope.userNickname}님 </a>
						<ul class="dropdown-menu">
								<li>
									<form action="member/myPage.do" method="POST">
										<button type="submit" class="dropdown-item mypage">나의정보수정</button>
									</form>
								</li>
								<li><a class="dropdown-item" href="/moneybug/logout.do">로그아웃</a></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/member/managerlogin.jsp">관리자 로그인</a></li>
							<li><a class="dropdown-item" href="/moneybug/api/showButton">API키 관리</a></li>
						</ul>
					</li>
				</c:when>
				
			<c:otherwise>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle"
						href="login.jsp" role="button"
						data-toggle="dropdown" aria-expanded="false">로그인해주세요</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="login.jsp">회원 로그인</a></li>
							<li><a class="dropdown-item" href="member/managerlogin.jsp">관리자 로그인</a></li>
						</ul>
					</li>
				</c:otherwise>
			</c:choose>

			</ul>
<!-- 			<form class="d-flex align-items-center ms-auto">
				<input class="form-control me-sm-2" type="search"
					placeholder="Search">
				<button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
			</form> -->
		</div>
		</div>
</nav>