<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% application.setAttribute("s3","https://moneybugbucket.s3.ap-northeast-2.amazonaws.com"); %>
<!DOCTYPE html>
<html>
<head>
<title>돈벌레 로그인</title>

<meta name="google-signin-client_id" content="35118497195-tvjc4c2qpdtq95148f8evc7o2ko3v72u.apps.googleusercontent.com">
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script src="https://accounts.google.com/gsi/client" async defer></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>


<style>
body {
	height: 100vh;

	background: #F9F5E7;

	display: flex;
	justify-content: center;
	align-items: center;
}


.login-container {
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
	padding: 30px;
	text-align: center;

}

.social-group {
	display: flex;
	flex-direction: column;
	align-items: center;
	margin-top: 30px;
}

.social-group>* {
	margin-bottom: 10px;
}


h1 {

	margin-bottom: 10px;
}

p {
	margin-bottom: 20px;
}
</style>

</head>

<body>


	<!-- 로그인 컨테이너 login  -->

	<div class="login-container">
		<h1 class="mb-2">Login</h1>
		<p>소셜로그인을 통해서만 서비스 이용이 가능합니다.</p>
		<hr>
		<div class="social-group">

			<!-- 네이버 로그인 버튼 노출 영역 -->
			<div id="naver_id_login"></div>

			<!-- 카카오 로그인 버튼 노출 영역 -->
			<a
				href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=89d5de7971c30a083e735b6abc250f26&redirect_uri=http://localhost:8181/moneybug/member/kakaocallback">
				<img width="231.250px" height="55"
				src="${s3}/resources/img/kakao_login_button.png" />
			</a>

			<!-- 구글 로그인 버튼 노출 영역 -->
			<div id="g_id_onload"
				data-client_id="35118497195-tvjc4c2qpdtq95148f8evc7o2ko3v72u.apps.googleusercontent.com"
				data-callback="handleCredentialResponse"></div>

			<div class="g_id_signin" data-type="standard"
				data-shape="rectangular" data-theme="filled_black"
				data-text="signin_with" data-size="large" data-locale="ko"
				data-logo_alignment="left" data-width="230"></div>

		</div>
		<hr>
		<a class="btn btn-sm btn-outline-secondary" role="button" href="member/managerlogin.jsp">관리자로 로그인</a>
	</div>

	<script type="text/javascript">


			/* 네이버 로그인 버튼 노출 스크립트 */
			/* 서영 네이버 키값 EZDnNCVQMTJNlWbDhjvv */
			/* 지윤 네이버 키값 P6wa8kR9Cvd1_JJOtheu */

			  	var naver_id_login = new naver_id_login("P6wa8kR9Cvd1_JJOtheu", "http://localhost:8181/moneybug/member/navercallback.jsp");
			  	var state = naver_id_login.getUniqState();
			  	naver_id_login.setButton("green", 3,50);
			  	naver_id_login.setDomain("http://localhost:8181");
			  	naver_id_login.setState(state);
			  	naver_id_login.init_naver_id_login();
			  
			/* 구글 로그인 버튼 스크립트  */
			function handleCredentialResponse(response) {
				const responsePayload = parseJwt(response.credential);
				console.log("google1")
				console.log("ID: " + responsePayload.sub);
			    console.log('Full Name: ' + responsePayload.name);
			    console.log("Email: " + responsePayload.email); 

			
			    console.log("google2")

			    $.ajax({
				type: 'POST',
				url: '${pageContext.request.contextPath}/member/findMember.do', 
				data: {
				    'socialId': responsePayload.sub,
				    'email': responsePayload.email,
				    'userName': responsePayload.name,
				    'userNickname' : "구글" + responsePayload.name
					},
					success : function(member) {	
						if(member === 'old') {
							console.log('old');
							sendPostRequest('${pageContext.request.contextPath}/main.do');
						} else if (member == 'new') {
							console.log('new');
							sendPostRequest('${pageContext.request.contextPath}/member/signUp.do');
						} else {
							console.log('ajax return error');
						}				
					},
					error: function() {
						alert("ajax error");
					}
			});
				
				  
				function sendPostRequest(url) {
				    var form = document.createElement('form');
				    form.method = 'POST';
				    form.action = url;
				    document.body.appendChild(form);
				    form.submit();
				}	
			    		
			
			function parseJwt (token) {
			    var base64Url = token.split('.')[1];
			    var base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
			    var jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
			        return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
			    }).join(''));

			    return JSON.parse(jsonPayload);
			}
        }

			
	
</script>

</body>
</html>