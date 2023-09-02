
/* 자식창을 닫으면서 값을 넘겨줌 */

function closePopup() { // 자식창(팝업창) 닫기
    const priceInput = document.getElementById('price_input');
    const valueToSend = priceInput.value;
    const parentOrigin = "http://localhost:8181";
    window.opener.postMessage(valueToSend, parentOrigin);
    window.close(); // 팝업 창 닫기
}

/* ocr_button 자동 버튼 */

 $(document).ready(function() {
            $("#ocr_button").click(function() {
                let formData = new FormData($("#ocr_form")[0]);
                $.ajax({
                    url: "/moneybug/ocr",
                    type: "POST",
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function(result) {
                        $("#price_input").val(result); // 결과를 입력란에 채움
                    },
                    error: function(error) {
                        console.log(error);
                    }
                });
            });
        });
 
 
 
 /* processButton 수동 버튼 */

  const inputElement = document.getElementById("fileInput");  // 파일 업로드 인풋 요소
  const canvas = document.getElementById('canvas');  // 캔버스 요소
  const ctx = canvas.getContext('2d');  // 캔버스 컨텍스트
  const processButton = document.getElementById("processButton");  // 처리 버튼
  let img;  // 이미지 변수
  let pts = [];  // 클릭한 포인트 저장하는 배열
  let transformationMatrix = null;  // 변환 행렬 변수

  // OpenCV 준비가 되었을 때 실행되는 함수
  function onOpenCvReady() {
      inputElement.addEventListener("change", handleFileUpload, false);  // 파일
                                                                            // 업로드
                                                                            // 시 처리
                                                                            // 함수
                                                                            // 연결
      canvas.addEventListener("click", handleCanvasClick);  // 캔버스 클릭 시 처리 함수 연결
  }

  // 파일 업로드 처리 함수
  function handleFileUpload(e) {
      const file = e.target.files[0];  // 선택한 파일 가져오기
      if (file) {
          const reader = new FileReader();
          reader.onload = (event) => {
              img = new Image();
              img.src = event.target.result;
              img.onload = () => {
                  canvas.width = img.width;
                  canvas.height = img.height;
                  ctx.drawImage(img, 0, 0, img.width, img.height);  // 이미지를 캔버스에
                                                                    // 그리기
                  transformationMatrix = null;  // 변환 행렬 초기화
                  pts = [];  // 클릭한 포인트 배열 초기화
              };
          };
          reader.readAsDataURL(file);  // 파일을 Data URL로 읽기
      }
  }

  // 캔버스 클릭 처리 함수
  function handleCanvasClick(e) {
        if (pts.length < 4) {
          const rect = canvas.getBoundingClientRect(); // 캔버스 사각형 정보 가져오기
          const scaleX = img.width / rect.width;
          const scaleY = img.height / rect.height;
          const x = (e.clientX - rect.left) * scaleX;
          const y = (e.clientY - rect.top) * scaleY;
          
          pts.push({ x, y });

          ctx.beginPath();
          ctx.arc(x, y, 5, 0, Math.PI * 2);
          ctx.fillStyle = "red";
          ctx.fill();

          if (pts.length === 4) {
            processButton.disabled = false;
          }
        }
      }

  // 이미지 처리 및 전송 함수
  function performImageProcessingAndSend() {
      // 변환 행렬 계산
      const srcPoints = new cv.Mat(4, 1, cv.CV_32FC2);
      const dstPoints = new cv.Mat(4, 1, cv.CV_32FC2);

     

      // 클릭한 포인트를 srcPoints에 복사
      for (let i = 0; i < 4; i++) {
          srcPoints.data32F[i * 2] = pts[i].x;
          srcPoints.data32F[i * 2 + 1] = pts[i].y;
      }

      // 목표 지점 정의
      const canvasWidth = canvas.width;
      const canvasHeight = canvas.height;
      dstPoints.data32F[0] = 0;
      dstPoints.data32F[1] = 0;
      dstPoints.data32F[2] = canvasWidth;
      dstPoints.data32F[3] = 0;
      dstPoints.data32F[4] = canvasWidth;
      dstPoints.data32F[5] = canvasHeight;
      dstPoints.data32F[6] = 0;
 dstPoints.data32F[7] = canvasHeight;

      transformationMatrix = cv.getPerspectiveTransform(srcPoints, dstPoints);

      // 원근 변환 적용
      const src = cv.imread(canvas);
      const dst = new cv.Mat();
      cv.warpPerspective(src, dst, transformationMatrix, src.size());

      // 이미지 회전하여 텍스트를 읽기 쉽게 만듦
      const rotated = new cv.Mat();
      cv.rotate(dst, rotated, cv.ROTATE_90_COUNTERCLOCKWISE);

      // 이미지를 그레이스케일로 변환
      const gray = new cv.Mat();
      cv.cvtColor(rotated, gray, cv.COLOR_RGBA2GRAY);

      // 변환 및 처리된 이미지 표시
      cv.imshow(canvas, gray);

      // 처리된 이미지를 base64로 변환
      const imgData = canvas.toDataURL("image/png").split(',')[1];

      // base64 데이터로 Blob 생성
      const blob = b64toBlob(imgData, 'image/png');

      // 이미지 전송을 위한 FormData 객체 생성
      const formData = new FormData();
      formData.append('image', blob);

      // POST 요청 전송
      fetch('/moneybug/ocr', {
          method: 'POST',
          body: formData
          
      })
      .then(response => response.json())  // 서버 응답을 JSON으로 변환
      .then(result => {
          // 서버로부터 받은 결과(result) 처리
          $("#price_input").val(result);  // 결과를 입력란에 채움
          
      })
      .catch(error => {
          // 오류 처리
          console.error('Error sending POST request:', error);
      });
  }

  // base64 데이터를 Blob으로 변환하는 함수
  function b64toBlob(b64Data, contentType = '', sliceSize = 512) {
       const byteCharacters = atob(b64Data);
       const byteArrays = [];
       for (let offset = 0; offset < byteCharacters.length; offset += sliceSize) {
           const slice = byteCharacters.slice(offset, offset + sliceSize);
           const byteNumbers = new Array(slice.length);
           for (let i = 0; i < slice.length; i++) {
               byteNumbers[i] = slice.charCodeAt(i);
           }
           const byteArray = new Uint8Array(byteNumbers);
           byteArrays.push(byteArray);
       }
       const blob = new Blob(byteArrays, { type: contentType });
       return blob;
  }
