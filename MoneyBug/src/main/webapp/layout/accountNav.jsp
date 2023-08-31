<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<style>

#viewport {
  padding-left: 250px;
}

#sidebar {
  z-index: 500;
  position: fixed;
  left: 250px;
  width: 250px;
  margin-top: 50px;
  margin-left: -250px;
  overflow-y: auto;
  transition: all 0.5s ease;
}

.account-side {
	height: 50px;
}


</style>
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
                                url : "/moneybug/duplicateCheck",
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


<div id="viewport">
	<div id="sidebar">
		<ul class="nav nav-pills flex-column">
			<li class="nav-item account-side"><a class="nav-link active" href="/moneybug/accountBook/accountDetail_List.jsp">가계부 작성</a></li>
			<li class="nav-item account-side"><a class="nav-link active" href="/moneybug/accountBook/monthlyReport.jsp">월간 가계부</a></li>
			<li class="nav-item account-side"><a class="nav-link active" href="/moneybug/accountBook/budget.jsp">예산 설정</a></li>
			<li class="nav-item account-side"><a class="nav-link active" href="/moneybug/accountBook/fixedexpenditure.jsp">고정지출</a></li>
		</ul>
	</div>
</div>

