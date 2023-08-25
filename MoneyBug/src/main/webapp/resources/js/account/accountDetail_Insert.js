
/* 현재 날짜를 기본값으로 */

//오늘 날짜를 가져옵니다.
let currentDate = new Date();
// 'YYYY-MM-DD' 형식의 날짜 문자열로 변환합니다.
let dateString = currentDate.toISOString().split('T')[0];
// input 요소의 value 속성에 날짜를 설정합니다.
document.getElementById('usedAt').value = dateString;

/* 팝업창이 닫힐 때, POST 메세지로 자식창으로 부터 부모창에 결과값을 보여줌 */

// 부모 창 코드 내부
let allowedOrigin = "http://localhost:8181"; // 허용된 출처로 대체

window.addEventListener("message", receiveMessage, false);

function receiveMessage(event) {
    if (event.origin !== allowedOrigin) {
        console.log("신뢰할 수 없는 출처에서 메시지를 받았습니다:", event.origin);
        return;
    }

    let receivedValue = event.data;
    console.log("팝업에서 받은 값:", receivedValue);

    // <input> 요소에 receivedValue 값을 넣어줍니다.
    let priceInput = document.getElementById('price_input');
    priceInput.value = receivedValue;
}
