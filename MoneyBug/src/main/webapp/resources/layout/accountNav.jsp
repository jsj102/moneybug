<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<script>
        $(document).ready(function() {
            // 서버로부터 로그인 상태 값을 확인하여 처리
            $.ajax({
                url : "../checkLogin",
                method : "GET",
                success : function(response) {
                    let loginStatus = parseInt(response);
                    if (loginStatus !== 1) {
                        // 로그인 상태가 아니라면 로그인 페이지로 리다이렉션
                        window.location.href = "/moneybug/login.jsp"; // 실제 로그인 페이지 URL로 변경
                    } else {
                        $(document).ready(function() {
                            // 서버로부터 로그인 상태 값을 확인하여 처리
                            $.ajax({
                                url : "../duplicateCheck",
                                method : "GET",
                                success : function(response) {
                                },
                                error : function(error) {
                                    window.location.href = "/moneybug/login.jsp";
                                }
                            });
                        });
                    }
                }
            });
        });
</script>
	<div id="nav" align="center">
		<br>
		<h6>가계부</h6>
		<div class="dropdown">
			<a href="/moneybug/accountBook/accountDetail_List.jsp">
				<button class="dropbtn">내역작성</button>
			</a>
		</div>
		<br>
		<br>
		<div class="dropdown">
			<button class="dropbtn">보고서</button>
			<div class="dropdown-content">
				<a href="index.jsp">▶월별보고서</a>
			</div>
		</div>
		<br>
		<br>
		<div class="dropdown">
			<button class="dropbtn">설정</button>
			<div class="dropdown-content">
				<a href="index.jsp">▶목표설정</a>
			</div>
		</div>
	</div>
</body>
</html>

