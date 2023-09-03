<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script type="text/javascript">
    //입력란 예외처리
function checkWrite() {
    const priceInput = document.getElementById("price_input");
    const descriptionInput = document.getElementById("description");

    if (priceInput.value === "") {
        alert("금액을 입력하십시오!");
    } else if (isNaN(priceInput.value) || parseFloat(priceInput.value) <= 0) {
        alert("금액에는 양수 숫자만 입력하십시오!");
    } else if (descriptionInput.value === "") {
        alert("내용을 입력하십시오!");
    } else {
        document.getElementById("writeForm").submit();
    }
}

</script>
<%@ include file="/layout/header.jsp"%>
<%@ include file="/layout/accountNav.jsp"%>

<style>
html, body {
	height: 100%;
}

body {
	background: #F9F5E7;
	display: flex;
	flex-direction: column;
	height: 100%;
	flex: 1;
	margin: 0;
}

.account_section table {
	width: 500px;
	height: 500px;
	background-color: #e0ead7;
	border-radius: 30px;
	border: 1px transparent solid;
	border-spacing: 0px;
}

.account_section td {
	font-size: 16px; /* 필요한대로 글꼴 크기 조정 */
	font-weight: bold; /* 텍스트를 굵게 표시 */
	padding: 10px;
}
</style>

<div class="account_section" align="center">

	<form action="/moneybug/insert.accountDetail" id="writeForm">

		<br> <br>
		<table style="width: 500px; height: 500px">
			<tr>
				<td colspan="2" style="text-align: center">입력</td>
			</tr>
			<tr>
				<td><input name="accountBookId" type="hidden"
					id="accountBookId" value=""></td>
			</tr>
			<tr>
				<td><input type='date' name="usedAt" id="usedAt" /></td>
			</tr>
			<tr>
				<td><select id="expenses" name="accountType">
						<option value="수입">수입</option>
						<option value="지출">지출</option>
				</select></td>
			</tr>
			<tr>
				<td>금액&nbsp;<input class="btn btn-info" type="button"
					value="영수증 OCR" onclick="showOCRPopup();" /></td>
			</tr>
			<tr>
				<td><input type="text" name="price" id="price_input" value="" />원</td>
			</tr>
			<tr>
				<td>분류</td>
			</tr>
			<tr>
				<td><select id="expenses" name="accountCategory">
						<option value="주거/통신">주거/통신</option>
						<option value="식비">식비</option>
						<option value="교통/차량">교통/차량</option>
						<option value="의료/건강">의료/건강</option>
						<option value="교육">교육</option>
						<option value="금융">금융</option>
						<option value="생활용품">생활용품</option>
						<option value="패션/미용">패션/미용</option>
						<option value="가족">가족</option>
						<option value="유흥">유흥</option>
						<option value="문화/여가">문화/여가</option>
						<option value="선물/경조사/회비">선물/경조사/회비</option>
						<option value="마트/편의점/쇼핑">마트/편의점/쇼핑</option>
						<option value="반려동물">반려동물</option>
						<option value="기타">기타</option>
				</select></td>
			</tr>
			<tr>
				<td>내용</td>
			</tr>
			<tr>
				<td><textarea name="description" cols="30" rows="3"
						placeholder="내용을 작성해주세요..." id="description" value=""></textarea>
				</td>
			</tr>
			<tr>
				<td><input class="btn btn-info" type="button" value="저장"
					onclick="javascript:checkWrite()"></td>
			</tr>
		</table>
	</form>
</div>
<%@ include file="/layout/accountAside.jsp"%>
<%@ include file="/layout/footer.jsp"%>


<script type="text/javascript">
    $(document).ready(function() {
        // 서버로부터 로그인 상태 값을 확인하여 처리
        $.ajax({
            url : "seq",
            method : "GET",
            success : function(result) {
                $("#accountBookId").val(result);

            }
        });
    });

</script>

<!--  Opencv, OCR 팝업창 -->
<script>
    function showOCRPopup() {
        window.open("opencvPopUp.jsp", "_blank", "width=500, height=800, left=100, top=50");
    }
</script>

<!-- 
<포함된 스크립트>
1. 현재 날짜를 기본값으로
2. 팝업창이 닫힐 때, POST 메세지로 자식창으로 부터 부모창에 결과값을 보여줌
 -->
<script src="/moneybug/resources/js/account/accountDetail_Insert.js"></script>