<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>계정 수정</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f5f5f5;
}

.section1 {
	background-color: white;
	padding: 20px;
	margin: 20px auto;
	max-width: 400px;
}

label {
	font-weight: bold;
	margin-right: 10px;
}

.update{
	width: 100%;
	padding: 10px;
	margin-bottom: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
	font-size: 14px;
}

button.update{
	background-color: #007bff;
	color: white;
	padding: 10px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

</style>
</head>
<body>
	<div class="section1" id="test">
		<h4>가계부 수정</h4>
		<div>
			<label for="accountCategory">계정: </label> 
			<select id="accountUpdate" name="accountCategory" class="update">
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
			</select>
		</div>
		<div>
			<label for="description">설명</label>
			<textarea class="update" id="description" name="description">${account.description}</textarea>
		</div>
		<div>
			<label for="price" class="">가격</label> <input type="number" class="update"
				id="price" name="price" value="${account.price}">
		</div>
		<div>
			<label for="accountType" class="form-label">지출</label> <select
				id="accountType" name="accountType" class="update">
				<option value="수입">수입</option>
				<option value="지출">지출</option>
			</select>
		</div>
		<div>
			<label for="usedAt" class="">사용날짜</label> <input type="date" class="update"
				id="usedAt" name="usedAt" value="${account.usedAt}">
		</div>
		<input type="hidden" name="seq" id="seq" value="${account.seq}">
		<button type="button" class="update" id="editData">수정 완료</button>
	</div>
	<script type="text/javascript">
	$(document).ready(function() {
		$("#editData").click(function() {
			$.ajax({
				url : "/moneybug/update.accountDeatil",
				type : "POST",
				data : {
					price : $("#price").val(),
					description : $("#description").val(),
					accountType : $("#accountType").val(),
					accountCategory : $("#accountUpdate").val(),
					usedAt : $("#usedAt").val(),
					seq : $("#seq").val()
				},
				success : function(response) {
					alert("수정 완료!");
					location.href = "/moneybug/accountBook/accountDetail_List.jsp";
				},
				error : function(xhr, status, error) {
					console.error("AJAX 요청 실패:", status, error);
					alert("수정 실패!");
				}
			})
		})
	})
	$(document).ready(function() {
		var selectedAccountType = "${account.accountCategory}";
		$("#accountUpdate option").each(function() {
			if ($(this).val() === selectedAccountType) {
				$(this).prop("selected", true);
			}
		});
	});
</script>
</body>
</html>