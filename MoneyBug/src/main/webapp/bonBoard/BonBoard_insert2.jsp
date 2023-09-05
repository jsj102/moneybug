<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/layout/header.jsp"%>
<style>
.banner-text {
	margin-top: 35px;
	margin-bottom: 40px;
}

.banner-container {
	height: 250px;
	background-color: #6cc3d5;
	background-position: center;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

.banner-text h1 {
	color: white;
	font-size: 60px;
}

.banner-text {
	color: white;
	font-size: 22px;
	text-align: center;
}
body{
background: #F9F5E7;
}

.container1 {
	background-color: #A1C59E;
	color: #b5c59e;
	border-radius: 20px;
	box-shadow: 0px 0px 10px rgba(255, 255, 255, 0.524);
	margin: 50px;
	padding: auto;
	width: 40%;
}

h1 {
	text-align: center;
	font-size: 30px;
	color: white;
}

form {
	background-color: #E2EDC9;
	padding: 20px;
	border-radius: 20px;
	margin-top: 20px;
}

label {
	margin-bottom: 8px;
}

.form-control {
	padding: 15px;
	margin-bottom: 20px;
	border: 1px solid #ccc;
	border-radius: 4px;
	font-size: 18px;
}

.btn-purple {
	font-size: 20px;
	padding: 10px 8px;
	margin: 10px;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	transition: background-color 0.3s, color 0.3s;
	background-color: #C4D7B2;
	color: white;
}

.btn-purple:hover {
	background-color: #799c58; /* 버튼 마우스 호버 시 배경 색상 변경 */
	border-color: #C4D7B2;
}

.btn-pink {
	background-color: #FF77ED;
	color: #fff;
	padding: 0px 20px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 18px;
}

.btn-pink:hover {
	background-color: #F99EFF;
	color: #FFFFFF;
}

#result {
	text-align: center;
	margin-top: 20px;
	color: green;
}
/* 버튼을 오른쪽 상단에 배치하는 스타일 */
.btn-container1 {
	display: flex;
	justify-content: flex-end;
}

.vote-deadline {
	width: 40%;
	margin-left: auto;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		//이전 페이지로 돌아가기
		$('#cancel').click(function() {
			window.history.back();
		});

	});
</script>
</head>
<body>
	<div class="banner-container" align="center">
		<div class="banner-text">
			<br> <a class="nav-link"
				href="/moneybug/bonBoard/BonBoard_list?page=1"><h1>MoneyBug
					Buy or Not</h1></a>
			<p>살까? 말까? 지금 투표를 열고 있어요!</p>
		</div>
	</div>
	<br>
	<br>

	<div class="container">
		<br>
		<form id="writeForm" action="/moneybug/bonBoard/BonBoard_insert">
			<input type="hidden" name="userNickname"
				value="<%=session.getAttribute("userNickname")%>"> <label
				for="title" style="font-size:20px;">제목</label> <input type="text" class="form-control"
				name="title" required="required" /> <label for="content" style="font-size:20px;">내용</label>
			<textarea class="form-control" name="content" rows="8"
				required="required"></textarea>

			<label for="itemLink" style="font-size:20px;">상품 링크</label> <input type="text"
				class="form-control" name="itemLink" required="required" />

			<!-- 선택한 날짜 출력 칸 -->
			<label for="voteEndAt" style="font-size:20px;">투표 마감일</label>
			<div class="input-group">
				<input type="date" class="form-control" name="voteEndAt"
					required="required">
			</div>

			<div class="btn-container1">
				<button type="submit" class="btn btn-purple">작성 완료</button>

				<button id="cancel" class="btn btn-purple">작성취소</button>
			</div>
		</form>
		<div id="result" class="text-center mt-3 text-success"></div>
	</div>
	<script>
		
	</script>
</body>
</html>
<br><br><br>
<%@ include file="/layout/footer.jsp"%>