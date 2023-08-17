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
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
 
    <script>
    document.addEventListener("DOMContentLoaded", function() {
        const chatContainer = document.getElementById("chat-container");
        const asideContainer = document.getElementById("aside-container");
        const chatbotButton = document.getElementById("chatbotButton");
        const closeButton = document.getElementById("close");

        closeButton.addEventListener("click", () => {
            chatContainer.style.display = "none";   // 채팅 컨테이너 숨기기
            asideContainer.style.display = "block"; // 사이드 컨테이너 보이기
            //aside.style.backgroundColor = "rgba(0, 0, 0, 0.5)"; // 배경색을 반투명으로 설정
        });

        chatbotButton.addEventListener("click", () => {
            chatContainer.style.display = "block";   // 채팅 컨테이너 보이기
            asideContainer.style.display = "none";    // 사이드 컨테이너 숨기기
            //aside.style.backgroundColor = "transparent"; // 배경색을 투명으로 설정
        });
    });
    </script>
</head>
<body>
	<div id="aside" align="center">
		<div id="chat-container" align="left" style="display: none;">
		<h1>실시간 채팅</h1>
        <div id="chat-messages"></div>
        <input type="text" id="name-input" placeholder="작성자 이름">
        <input type="text" id="message-input" placeholder="메시지를 입력하세요...">
        <br>
        <button id="send-button">전송</button>
        <button id="close">닫기</button>
    </div>
	
	
	<div id="aside-container">
		<table>
			<tr>
				<td>
					<button id="chatbotButton">
						<img src="../resources/img/chatbot.png" alt="Image Button">
					</button>
				</td>
			</tr>
			<tr>
				<td>
				<a href="http://pf.kakao.com/_xnCxfIG">
						<button id="kakaoButton">
							<img src="../resources/img/KakaoTalk.png" alt="Image Button">
						</button>
				</a>
				</td>
			</tr>
		</table>
	</div>

	</div>
	
</body>
</html>