<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html >
<head>
	<title>Bootstrap Example</title>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BonBoard insert</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<style>
@font-face {
	font-family: 'HakgyoansimWoojuR';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2307-2@1.0/HakgyoansimWoojuR.woff2')
		format('woff2');
	font-weight: normal;
	font-style: normal;
}
body {
	font-family: 'HakgyoansimWoojuR';
  
	font-size: 18px;
	margin: 10px;
	padding: 10px;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	height: 100vh;
}
.container {
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
	 color:white;
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
.btn-container {
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
	<div class="container">
		<br>
		<h1 >살까말까 게시글 작성</h1>
		<form id="writeForm" action="BonBoard_insert">
    <input type="hidden" name="userNickname" value="<%=session.getAttribute("userNickname")%>">
    
    <label for="title">제목</label>
    <input type="text" class="form-control" name="title" required="required" />
    
    <label for="content">내용</label>
    <textarea class="form-control" name="content" rows="8" required="required"></textarea>
    
    <label for="itemLink">상품 링크</label>
    <input type="text" class="form-control" name="itemLink" required="required" />
    
    <!-- 선택한 날짜 출력 칸 -->
    <label for="voteEndAt">투표 마감일</label>
    <div class="input-group">
        <input type="date" class="form-control" name="voteEndAt" required="required">
    </div>
    
    <div class="btn-container">
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