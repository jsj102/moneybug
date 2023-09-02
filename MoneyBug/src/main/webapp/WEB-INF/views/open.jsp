<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/layout/header.jsp" />
<script type="text/javascript">
	$(document).ready(function() {
		$("#issued").click(function() {
			$.ajax({
				url : "/moneybug/api/key",
				type : "POST",
				data : {
					type : "발급"
				},
				success : function(data) {
					$("#showData").html("<b>" + data + "</b>");
				},
				error : function(xhr, status, error) {
					console.error("AJAX 요청 실패:", xhr, status, error);
					alert("api 생성실패");
				}
			});
		});

		$("#reissued").click(function() {
			$.ajax({
				url : "/moneybug/api/key",
				type : "POST",
				data : {
					type : "재발급"
				},
				success : function(data) {
					$("#showData").html("<b>" + data + "</b>");
				},
				error : function(xhr, status, error) {
					console.error("AJAX 요청 실패:", xhr, status, error);
					alert("api 생성실패");
				}
			});
		});
		$("#goBack").click(function() {
			window.location.href = "/moneybug/main.jsp"; // 원하는 페이지 경로로 변경
		});
		$("#viewApiDocs").click(function() {
			window.location.href = "/moneybug/swagger-ui.html"; // 원하는 페이지 경로로 변경
		});
	});
</script>
<style>
.centered-container {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.centered-container>div {
	margin-top: 10px;
	margin-bottom: 10px; /* 원하는 간격 값으로 설정 */
}

.openApiData {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 30%;
	width: 600px;
	font-size: 25px;
	border: 2px solid #DEB887; /* 테두리 스타일 및 색상 설정 */
	border-radius: 10px; /* 테두리 둥글게 설정 */
	padding: 10px; /* 테두리와 내용 사이의 간격 설정 */
	background: #F5DEB3;
}
</style>
</head>
<div style="text-align: right;">
	<button class="btn btn-info" id="goBack" style="">뒤로가기</button>
</div>
<body style="background: #FFE4C4;">
	<div class="centered-container">
		<div id="showData" class="openApiData">
			<b>한번 발급되면 조회가 불가하니 반드시 다른곳에 기록하시기 바랍니다.</b>
		</div>
		<section>
			<button id="issued" class="btn btn-light">api 발급</button>
			<button id="reissued" class="btn btn-light"">api 재발급</button>
		</section>
		<div>
			<button class="btn btn-info" id="viewApiDocs">API문서 보러가기</button>
		</div>
	</div>
</body>
<jsp:include page="/layout/footer.jsp" />