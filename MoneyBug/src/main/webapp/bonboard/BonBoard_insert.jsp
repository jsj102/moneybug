<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>BonBoard_insert</title>
<!-- 부트스트랩 CSS 추가 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- 부트스트랩 Datepicker CSS 추가 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 부트스트랩 Datepicker JavaScript 추가 -->
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
	background-color: #bd7eff;
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
	background-color: #ffffff52;
	color: white;
	border-radius: 20px;
	box-shadow: 0px 0px 10px rgba(255, 255, 255, 0.524);
	margin: 50px;
	padding: auto;
	width: 40%;
}

h1 {
	text-align: center;
	font-size: 30px;
}

form {
	display: flex;
	flex-direction: column;
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
	background-color: #ab77ff;
	color: #fff;
	margin: 12px;
	padding: 15px 20px;
	border: none;
	border-radius: 20px;
	cursor: pointer;
	font-size: 18px;
}

.btn-purple:hover {
	background-color: #bd9eff;
	color: #ffffff;
}

.btn-pink {
	background-color: #ff77ed;
	color: #fff;
	padding: 0px 20px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 18px;
}

.btn-pink:hover {
	background-color: #f99eff;
	color: #ffffff;
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
</head>
<body>
	<div class="container">
		<br>
		<h1>살까말까 게시글 작성</h1>
		<form id="writeForm" action="BonBoard_insert" method="post">
			<label for="userName">작성자</label> 
			
			<input type="text"
				class="form-control" name="writerId" value="세션_유저네임" required> 
				
				<labelfor="title">제목</label> 
				<input type="text" class="form-control" name="title" required> <label for="content">내용</label>
			<textarea class="form-control" name="content" rows="8" required></textarea>

			<label for="itemLink">상품 링크</label> 
			
			<input type="text"
				class="form-control" name="itemLink" required>

			<!-- 선택한 날짜 출력 칸 -->

			<label for="voteDeadline"
				style="display: block; text-align: center; margin-left: 32%">투표
				마감일</label>
			<div class="input-group date vote-deadline" data-provide="datepicker">
				<input type="date" class="form-control" name="voteEndAt"
					placeholder="작성일로부터 3일 후 ">
				<div class="input-group-append">
					<button class="btn btn-pink" type="button">
						<span class="d-none d-sm-inline">마감일 지정</span>
					</button>
				</div>
			</div>
			
		<!-- 	<fieldset>
			
			<input type= "file" name="upfile" multiple><br>
			
			</fieldset> -->

			<!-- 버튼을 오른쪽 에 배치 -->
			<div class="btn-container">
				<button type="submit" class="btn btn-purple">작성 완료</button>
			</div>
			<button id="cancel">취소하기</button>
		</form>

		<div id="result" class="text-center mt-3 text-success"></div>
	</div>

<script>
  $(document).ready(function() {
    /* $("#writeForm").submit(function(event) {
      event.preventDefault();

      // 폼 데이터를 직렬화
      let formData = $(this).serialize();

      $.ajax({
        type: "POST", // 또는 GET, 서버 측 코드에 따라 설정
        url: "BonBoard_insert", // 서버 측 코드가 위치한 URL로 설정
        data: formData,
        success: function(response) {
          // 서버에서 받은 응답을 처리
          // 예를 들어, 화면을 다시 로드하거나 메시지를 표시할 수 있음
          alert("게시글 작성이 완료되었습니다.");
          window.location.href = "BonBoard_one";
        },
        error: function() {
          alert("오류가 발생했습니다. 다시 시도해주세요.");
        }
      });
    });
 */
    // 부트스트랩 Datepicker 초기화
    $(".input-group.date").datepicker({
      format: "yyyy-mm-dd",
      autoclose: true,
      todayHighlight: true,
      startDate: new Date()
    });
 
							
						});
	</script>
</body>
</html>
