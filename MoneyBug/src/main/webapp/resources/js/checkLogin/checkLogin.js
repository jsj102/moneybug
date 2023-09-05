// 로그인 상태 확인 함수
$(document).ready(function() {
    function checkLoginStatus() {
        $.ajax({
            url: "../checkLogin",
            method: "GET",
            success: function(response) {
                let loginStatus = parseInt(response);
                if (loginStatus !== 1) { 
                    window.location.href = "/moneybug/login.jsp";
                }
            },
            error: function(error) {
      
            }
        });
    }

  
    const interval = 60000; // 1분마다 확인 (밀리초 단위)
    setInterval(checkLoginStatus, interval);
   
    checkLoginStatus();
});