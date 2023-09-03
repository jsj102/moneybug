<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/layout/header.jsp"%>

<style>

 body {
    background: #E1ECC8;
    min-height: 100vh;
  }

.popup {
  background-color: #C4D7B2;
  padding: 20px;
  border-radius: 30px;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
  margin: 20px auto;
  max-width: 500px;
  display: flex;
  justify-content: center; /* 수평 가운데 정렬 */
  width: 100%; /* 가로 너비 100%로 설정 */
}

.popup table {
		border-radius: 30px;
		border: 1px transparent solid;
		border-spacing: 0px;
        font-size: 16px; /* 필요한대로 글꼴 크기 조정 */
        font-weight: bold; /* 텍스트를 굵게 표시 */
        padding: 10px;
    }

  .navbar, .footer {
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
<div class="popup" >

<form id="ocr_form" enctype="multipart/form-data">
		<div class="inputoutput">
			
			<table>
			<tr>
				<td><h6 align="center">영수증 OCR</h6></td>
			</tr>
			<tr>
				<td> 업로드할 이미지 선택:<input type="file" id="fileInput" name="file" accept="image/*" onchange="checkFileSelection()" /><td>
			</tr>
			<tr>
				<td>
				 		<input class="btn btn-info" type="button" value="자동" id="ocr_button" disabled>
						<input class="btn btn-info" type="button" value="수동" id="processButton" onclick="performImageProcessingAndSend()" disabled>
				 		결과: <input name="price" type="text" id="price_input" value="">
						<button class="btn btn-danger" onclick="closePopup()">확인</button>
				</td>
			</tr>
			<tr>
				<td>
					 <div id="imageContainer" align="center">
						<canvas id="canvas"></canvas>
					</div>
				</td>
			</tr>
			</table>
		</div>
	</form>

  
  

</div>
<%@ include file="/layout/footer.jsp"%>
<script src="/moneybug/resources/js/checkLogin/checkLogin.js"></script>

<script> //파일 업로드가 없을 때  자동,수동 버튼을 누를 수 없음. 파일업로드 되었을 때 이미지 파일인 경우에만 자동, 수동 버튼을 누를 수 있음.
function checkFileSelection() {
    const fileInput = document.getElementById('fileInput');
    const ocrButton = document.getElementById('ocr_button');
    const processButton = document.getElementById('processButton');

    if (fileInput.files.length > 0) {
        const selectedFile = fileInput.files[0];
        
        if (selectedFile.type.includes('image')) { // 이미지 파일인 경우
            ocrButton.disabled = false;
            processButton.disabled = false;
        } else { // 이미지 파일이 아닌 경우
            ocrButton.disabled = true;
            processButton.disabled = true;
        }
    } else { // 파일이 선택되지 않은 경우
        ocrButton.disabled = true;
        processButton.disabled = true;
    }
}
</script>

<!-- Opencv.js를 사용하기 위해서 -->
<script async src="https://docs.opencv.org/master/opencv.js" onload="onOpenCvReady();" type="text/javascript"></script>

<!-- 
<포함된 스크립트>
1. 자식창을 닫으면서 값을 넘겨줌
2. ocr_button 자동 버튼
3. processButton 수동 버튼
 -->
<script src="/moneybug/resources/js/account/opencvPopUp.js"></script>