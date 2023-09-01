<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!doctype html>
<html lang="ko">
<head>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.7.0.min.js"></script>
</head>
<body>
	<script type="text/javascript">


	<!-- 서영 네이버 키값 EZDnNCVQMTJNlWbDhjvv -->
	<!-- 지윤 네이버 키값 P6wa8kR9Cvd1_JJOtheu -->
	var naver_id_login = new naver_id_login("P6wa8kR9Cvd1_JJOtheu", "http://localhost:8181/moneybug/member/navercallback.jsp");
		<!-- var naver_id_login = new naver_id_login("P6wa8kR9Cvd1_JJOtheu", "http://localhost:9091/moneybug/navercallback.jsp"); -->
		<!-- var naver_id_login = new naver_id_login("P6wa8kR9Cvd1_JJOtheu", "http://localhost:8989/moneybug/navercallback.jsp"); -->
		<!-- var naver_id_login = new naver_id_login("P6wa8kR9Cvd1_JJOtheu", "http://localhost:8080/moneybug/navercallback.jsp"); -->

			//alert(naver_id_login.oauthParams.access_token);
			naver_id_login.get_naver_userprofile("naverSignInCallback()");
			console.log('콜백실행')  
		  
		  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
		 function naverSignInCallback() {

			id = naver_id_login.getProfileData('id');
			email = naver_id_login.getProfileData('email');
			name = naver_id_login.getProfileData('name');

			console.log('1');
			// 절대경로로 변경
			$.ajax({
				type: 'POST',
				url: '${pageContext.request.contextPath}/member/findMember.do', 
				data: {
					'socialId': id,
					'email': email,
					'userName': name,
					'userNickname' : "네이버"+ name
					},
					success : function(member) {	
						if(member === 'old') {
							console.log('old');
							sendPostRequest('../main.do');
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
			}) 
				
				
		  }
		  
			function sendPostRequest(url) {
			    var form = document.createElement('form');
			    form.method = 'POST';
			    form.action = url;
			    document.body.appendChild(form);
			    form.submit();
			}
	</script>
	
</body>
</html>