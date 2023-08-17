<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script></script>

<%@ include file="/resources/layout/header.jsp"%>

<style>
 body {
    background: linear-gradient(to bottom, #CA61FF, hsl(265, 100%, 72%), #945FFF);
    min-height: 100vh;
  }

#section {
  background-color: rgba(255, 255, 255, 0.472);
  padding: 20px;
  border-radius: 30px;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
  margin: 20px auto;
  max-width: 500px;
  margin-left: 50px; /* 왼쪽 여백 값 */
}

 #section table {
		border-radius: 30px;
		border: 1px transparent solid;
		border-spacing: 0px;
        font-size: 16px; /* 필요한대로 글꼴 크기 조정 */
        font-weight: bold; /* 텍스트를 굵게 표시 */
        padding: 10px;
    }

  #header, #footer {
    display: none;
  }

  #imageContainer {
    max-width: 100%; /* 이미지 컨테이너 너비 조정 */
    max-height: 100%; /* 이미지 컨테이너 높이 조정 */
    background-color: rgba(255, 255, 255, 0.472); /* 동일한 배경색 적용 */
    border-radius: 30px; /* 이미지 컨테이너 둥글게 처리 */
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2); /* 그림자 효과 추가 */
    margin-top: 20px; /* 위쪽 여백 추가 */
  }
  #canvas {
    max-width: 100%; /* 이미지 너비를 컨테이너에 맞게 조절 */
    max-height: 100%; /* 이미지 높이를 컨테이너에 맞게 조절 */
  }
  
   .inputoutput {
        border-radius: 10px; /* 둥근 모서리 반경 설정 */
        padding: 15px; /* 내부 여백 설정 */
        background-color: rgba(255, 255, 255, 0.472); /* 배경 색상 설정 */
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2); /* 그림자 효과 추가 */
    }
  
</style>
<div id="section" >

<form id="ocr_form" enctype="multipart/form-data">
		<div class="inputoutput">
			
			<table>
			<tr>
				<td><h6 align="center">영수증 OCR</h6></td>
			</tr>
			<tr>
				<td> 업로드할 이미지 선택:<input type="file" id="fileInput" name="file"accept="image/*" /><td>
			</tr>
			<tr>
				<td>
				 		<input type="button" value="자동" id="ocr_button">
						<input type="button" value="수동" id="processButton" onclick="performImageProcessingAndSend()">
				 		결과: <input name="price" type="text" id="price_input" value="">
						<button onclick="closePopup()">확인</button>
				</td>
			</tr>
			</table>
		</div>
	</form>
 <div id="imageContainer" align="center">
<canvas id="canvas"></canvas>
</div>
  
  

</div>
<%@ include file="/resources/layout/footer.jsp"%>

<script>
  const fileInput = document.getElementById('fileInput');
  const uploadedImage = document.getElementById('uploadedImage');

  fileInput.addEventListener('change', function() {
    const selectedFile = fileInput.files[0];

    if (selectedFile) {
      const reader = new FileReader();

      reader.onload = function(e) {
        uploadedImage.src = e.target.result;
      };

      reader.readAsDataURL(selectedFile);
    }
  });
</script>
  <script async src="https://docs.opencv.org/master/opencv.js" onload="onOpenCvReady();" type="text/javascript">
  </script>
  <script src="/moneybug/resources/js/account/opencv.js"></script>
  <script src="/moneybug/resources/js/account/ocrPost.js"></script>

<script>
function closePopup() { //자식창(팝업창) 닫기
	const priceInput = document.getElementById('price_input');
	const valueToSend = priceInput.value;
	const parentOrigin = "http://localhost:8181";
	window.opener.postMessage(valueToSend, parentOrigin);
    window.close(); // 팝업 창 닫기
}
</script>
