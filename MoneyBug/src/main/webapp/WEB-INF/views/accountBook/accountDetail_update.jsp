<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>계정 수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
    $("#editData").click(function() {
        $.ajax({
            url : "/moneybug/update.accountDeatil",
            type : "POST",
            data : {
                price : $("#price").val(),
                description : $("#description").val(),
                accountType : $("#accountType").val(),
                accountCategory : $("#accountCategory").val(),
                usedAt : $("#usedAt").val(),
                seq : $("#seq").val()
            },
            success : function(response) {
                // 서버에서 성공적으로 응답했을 때 처리
                console.log(response);
                alert("수정 완료!");
                location.href = "/moneybug/accountBook/accountDetail_List.jsp";
            },
            error : function(xhr, status, error) {
                console.error("AJAX 요청 실패:", status, error);
                alert("수정 실패!");
            }
        })
    })
</script>
<style type="text/css">
</style>
</head>
</head>
<body>
	<div class="section" id="test">
		<h2>계정 수정</h2>
		<div>
			<label for="accountCategory">계정: </label> <select id="accountCategory" name="accountCategory">
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
			<textarea class="form-control" id="description" name="description">${account.description}</textarea>
		</div>
		<div>
			<label for="price" class="">가격</label> <input type="number" class="" id="price" name="price" value="${account.price}">
		</div>
		<div>
			<label for="accountType" class="form-label">지출</label> <select id="accountType" name="accountType">
				<option value="수입">수입</option>
				<option value="지출">지출</option>
			</select>
		</div>
		<div>
			<label for="usedAt" class="">사용날짜</label> <input type="date" class="" id="usedAt" name="usedAt" value="${account.usedAt}">
		</div>
		<input type="hidden" name="seq" id="seq" value="${account.seq}">
		<button type="button" class="" id="editData">수정 완료</button>
	</div>
</body>
</html>