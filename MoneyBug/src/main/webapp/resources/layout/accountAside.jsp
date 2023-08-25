<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
/* 공통 스타일 */
button {
	border: none;
	background: none;
	padding: 0;
	cursor: pointer;
	width: 100px;
	height: 100px;
}

/* chatbot 이미지 버튼 스타일 */
#chatbotButton img {
	width: 100%;
	height: 100%;
}

/* KakaoTalk 이미지 버튼 스타일 */
#kakaoButton img {
	width: 100%;
	height: 100%;
}

#chat-container {
    display: none;
}

</style>

</head>
<body>
	<div id="aside" align="center">
	
	<div id="aside-container">
		<table>
			<tr>
				<td>
					<button id="chatbotButton" onclick="showChatPopup();">
						<img src="../resources/img/chatbot.png" alt="Image Button">
					</button>
				</td>
			</tr>
			<tr>
				<td>
					<a href="http://pf.kakao.com/_xnCxfIG" target="_blank">
						<button id="kakaoButton">
							<img src="../resources/img/KakaoTalk.png" alt="Image Button">
						</button>
					</a>
				</td>
			</tr>
		</table>
	</div>

	</div>
<script>

  function showChatPopup() {
	  window.open("../chat/chatPopUp.jsp", "_blank", "width=500, height=800, left=1000, top=50");
  }
</script>
</body>
</html>

