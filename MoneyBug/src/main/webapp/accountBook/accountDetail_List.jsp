<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="../resources/js/account/accountDetail_RUD.js"></script>
<%@ include file="../resources/layout/header.jsp"%>
<%@ include file="../resources/layout/accountNav.jsp"%>
<%@ include file="../resources/layout/accountDetail_Search.jsp"%>

<div id="section" align="center">

	<h3>가계부 내역 페이지</h3>
	<br>

	<a href="/moneybug/accountBook/accountDetail_Insert.jsp">
		<button>작성</button>
	</a>
	<div id="accountList"></div>
</div>
<%@ include file="../resources/layout/accountAside.jsp"%>
<%@ include file="../resources/layout/footer.jsp"%>
