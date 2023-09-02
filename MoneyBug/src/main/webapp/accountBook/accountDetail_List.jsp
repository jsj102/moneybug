<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript"
	src="../resources/js/account/accountDetail_RUD.js"></script>
<%@ include file="/layout/header.jsp"%>
<%@ include file="/layout/accountNav.jsp"%>
<%@ include file="/layout/accountDetail_Search.jsp"%>


<style>
html, body{
	height: 100%;
	
}

body {
	background: #F9F5E7;
	display:flex;
	flex-direction:column;
	height:100%;
	flex:1;
	margin: 0;
}

.account_section {
	width: 80vw;
	text-align: center;
	padding: 100px 0 0 250px;
	margin: 0 auto;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	padding-left: 250px;
}

</style>

<div class="account_section">
	<h3>가계부 내역 페이지</h3>

	<br>

	<a href="/moneybug/accountBook/accountDetail_Insert.jsp">
		<button class="btn btn-info">작성</button>
	</a>
	<div id="accountList"></div>
</div>
<%@ include file="/layout/accountAside.jsp"%>
<%@ include file="/layout/footer.jsp"%>

