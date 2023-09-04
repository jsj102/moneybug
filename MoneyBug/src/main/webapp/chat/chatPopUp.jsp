<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- JSTL 라이브러리 추가 -->
<%@ include file="/layout/header.jsp"%>

<style>
.navbar, .footer {
	display: none;
}

#chat-container {
	display: flex;
	flex-direction: column;
	justify-content: flex-end; /* 수직 정렬을 하단에 맞춥니다 */
	align-items: flex-start; /* 왼쪽 정렬을 설정합니다 */
	width: 400px;
	height: 700px;
	overflow: auto;
}

#chat-messages {
	width: 400px;
	margin-top: auto; /* 하단으로 이동 */
	overflow: auto;
}

#chat-form {
	margin-top: 10px; /* 여백 추가 */
}

#name-input, #message-input {
	width: 150px; /* 원하는 너비로 조절하세요 */
}



body {
	background: #E1ECC8;
	min-height: 100vh;
}

.popup {
	display: flex;
	justify-content: center; /* 수평 가운데 정렬 */
	align-items: center; /* 수직 가운데 정렬 */
	width: 100%; /* 가로 너비 100%로 설정 */
	background-color: #C4D7B2;
	padding: 20px;
	border-radius: 30px;
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
	margin: 20px auto;
}

.popup table {
	border-radius: 30px;
	border: 1px transparent solid;
	border-spacing: 0px;
	font-size: 16px; /* 필요한대로 글꼴 크기 조정 */
	font-weight: bold; /* 텍스트를 굵게 표시 */
	padding: 10px;
}

.inputoutput {
	border-radius: 10px; /* 둥근 모서리 반경 설정 */
	padding: 15px; /* 내부 여백 설정 */
	background-color: rgba(255, 255, 255, 0.472); /* 배경 색상 설정 */
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2); /* 그림자 효과 추가 */
}
</style>

<div class="popup" align="center">

	<div class="inputoutput">
		<table>
			<tr>
				<td></td>
			</tr>
			<tr>
				<td>
					<div id="chat-container">
						<div id="chat-messages" align="left"></div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<form id="chat-form" action="<c:url value="/send" />" method="post">
						<input type="hidden" id="name-input" name="name" placeholder="작성자"
							value="${sessionScope.userNickname}"> <input type="text"
							id="message-input" name="text" placeholder="메세지를 입력...">
						<select id="channel-input" name="channel">
							<option value="chat1">채널1</option>
							<option value="chat2">채널2</option>
							<option value="chat3">채널3</option>
							<option value="chat4">채널4</option>
							<option value="chat5">채널5</option>
							<option value="${sessionScope.socialId}">나에게</option>
							<option value="chatbot@${sessionScope.socialId}">챗봇</option>
				       </select>	
							
						<button class="btn btn-info" type="submit">Send</button>
					</form>
				</td>
			</tr>
		</table>
	</div>

</div>
<%@ include file="/layout/footer.jsp"%>
<script src="/moneybug/resources/js/checkLogin/checkLogin.js"></script>

<script>
function setInputValueAndSubmit(value) {
    $("#message-input").val(value);
    $("#chat-form").submit();
}


$(document).ready(function() {
  $("#chat-form").submit(function(e) {
    e.preventDefault();
    let name = $("#name-input").val();
    let text = $("#message-input").val();
    let channel = $("#channel-input").val();

    if (text.trim() === "") {
        //alert("메시지를 입력하세요.");
        return;
      }
    
    $.ajax({
      url: "<c:url value="/send" />",
      method: "POST",
      data: {
        name: name,
        text: text,
        channel: channel
      },
      success: function(response) {

      },
      error: function(xhr, status, error) {
        console.error(error);
      }
    });

    $("#message-input").val("");
  });

  loadChatMessages();

  function loadChatMessages() {
      let selectedChannel = $("#channel-input").val();
      $.ajax({
        url: "<c:url value='/chat' />?channel=" + selectedChannel,
        method: "GET",
        dataType: "json",
        success: function(messages) {
          let chatMessages = $("#chat-messages");
          chatMessages.empty();

          messages.forEach(function(message) {
            let messageDiv = $("<div>").text(message.name + ": ");
            let textWithLinks = convertLinksToAnchors(message.text);
            messageDiv.append(textWithLinks);
            messageDiv.append(" (" + message.timestamp + ")");
            chatMessages.append(messageDiv);
          });
        },
        error: function(xhr, status, error) {
          console.error("로딩 에러", error);
        }
      });
    }

  function convertLinksToAnchors(text) {
    let urlPattern = /(http:\/\/|https:\/\/\S+)/g;
    return text.replace(urlPattern, function(url) {
      return "<a href='" + url + "' target='_blank' style='color: blue;''>" + url + "</a>";
    });
  }


  setInterval(loadChatMessages, 500);
});
</script>


