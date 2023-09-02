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
}

.sidebutton {
height: 65px;
text-decoration: none; 
color: white; 
display: flex; 
justify-content: center; 
align-items: center; 
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
  <div id="sidebar" class="d-grid gap-2">
    <a href="/moneybug/accountBook/accountDetail_List.jsp" class="sidebutton btn btn-lg btn-info" style="text-decoration: none; color: white;">
      가계부 작성
    </a>
    <a href="/moneybug/accountBook/monthlyReport.jsp" class="sidebutton btn btn-lg btn-info" style="text-decoration: none; color: white;">
      월간 가계부
    </a>
    <a href="/moneybug/accountBook/budget.jsp" class="sidebutton btn btn-lg btn-info" style="text-decoration: none; color: white;">
      예산 설정
    </a>
    <a href="/moneybug/accountBook/fixedexpenditure.jsp" class="sidebutton btn btn-lg btn-info" style="text-decoration: none; color: white;">
      고정 지출
    </a>
  </div>
</div>


