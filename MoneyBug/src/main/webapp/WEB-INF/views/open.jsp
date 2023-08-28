<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 부트스트랩 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.5.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
body {
	height: 150vh;
	background: linear-gradient(to bottom, #96A0FF, #9669FF);
	display: flex;
	justify-content: center;
}

.page-container {
	margin-top: 100px;
	margin-bottom: 100px;
	width: 50%;
	align-items: center;
	flex-direction: column;
}

.info-container {
	padding: 40px;
	justify-content: center;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
	background-color: white;
	border-radius: 20px;
}

.card-body {
	padding-left: 50px;
	padding-right: 50px;
}

form {
	display: flex;
	flex-direction: column;
}

b {
	font-size: 30px;
	font-weight: 100;
	text-align: center;
	color: white;
}

.nick-container {
	padding: 50px;
	display: flex;
	flex-direction: column;
	align-items: center;
}

.btn-custom {
	margin-top: 30px;
	background-color: #764dff;
	color: white;
	width: 70%;
	align-self: center; /* Add this line */
}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
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
    });
</script>

</head>
<body class="container mt-4">
	<div id="showData" class="page-container">
		<b>한번 발급되면 조회가 불가하니 반드시 다른곳에 기록하시기 바랍니다.</b>

		<button id="issued" class="btn btn-custom btn-lg">api 발급</button>
		<button id="reissued" class="btn btn-custom btn-lg">api 재발급</button>
	</div>
	<div>
		<a href="/moneybug/main.jsp">뒤로 가기</a>
	</div>
</body>
</html>