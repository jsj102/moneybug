<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<head>
    <meta charset="UTF-8">
    <style>


        /* chatbot 이미지 버튼 스타일 */
        .chatbotButton img {
            width: 100px;
            height: 100px;
        }

        /* KakaoTalk 이미지 버튼 스타일 */
        .kakaoButton img {
            width: 100px;
            height: 90px;
        }

        .overlay-container {
            position: fixed;
            top: 20%;
            right: 0;
            z-index: 1000; 
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: flex-end;
            width: 150px; 
            height: auto;
            padding: 0;
        }
    </style>
</head>
<body>
    <div class="overlay-container">
        <div id="aside-container">
            <table>
                <tr>
                    <td>
                        <button class="btn chatbotButton" onclick="showChatPopup();">
                            <img src="${s3}/resources/img/chatbot.png" alt="Image Button">
                        </button>
                    </td>
                </tr>
                <tr>
                    <td>
                        <a href="http://pf.kakao.com/_xnCxfIG" target="_blank">
                            <button class="btn kakaoButton">
                                <img src="${s3}/resources/img/KakaoTalk.png" alt="Image Button">
                            </button>
                        </a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
<script>

function showChatPopup() {
    // 첫 번째 URL 시도
    openChatPopup("checkLogin", function() {
        
        openChatPopup("../checkLogin");  // 첫 번째 시도가 실패한 경우 두 번째 URL 시도
    });
}

function openChatPopup(url, onError) {
    $.ajax({
        url: url,
        method: "GET",
        success: function(response) {
            let loginStatus = parseInt(response);
            if (loginStatus !== 1) {
                // ajax 요청이 성공했지만 로그인 상태가 아닌 경우
                window.location.href = "/moneybug/login.jsp";
            } else {
                window.open("/moneybug/chat/chatPopUp.jsp", "_blank", "width=500, height=680, left=1000, top=50");
            }
        },
        error: function(error) {
            
            if (onError) {
                onError();
            }
        }
    });
}

</script>


</body>

