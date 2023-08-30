<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $("#searchButton").click(function() { // 수정된 부분: click 이벤트 핸들러 추가
            $.ajax({
                url : "/moneybug/readListSearch.accountDetail",
                type : "POST",
                data : {
                    searchYear : $("#searchYear").val(),
                    searchMonth : $("#searchMonth").val(), // 수정된 부분: "#" 추가
                    accountCategory : $("#accountCategory").val()
                },
                success : function(data) {
                    $("#accountList").html(data);
                },
                error : function(xhr, status, error) {
                    var errorMessage = "오류 상태 코드: " + xhr.status + "\n" + "오류 메시지: " + error + "\n" + "오류 타입: " + status;
                    alert(errorMessage);
                }
            });
        });
    });
</script>
<style>
.account_search {
	padding: 30px 0 0 280px;
}
</style>
</head>
<body>
	
	<div class="account_search">
	<select id="searchYear" name="searchYear" >
		<option value="2024">2024년</option>
		<option value="2023" selected="selected">2023년</option>
		<option value="2022">2022년</option>
		<option value="2021">2021년</option>
		<option value="2020">2020년</option>
	</select>
	<select id="searchMonth" name="searchMonth">
		<option value="1">01월</option>
		<option value="2">02월</option>
		<option value="3">03월</option>
		<option value="4">04월</option>
		<option value="5">05월</option>
		<option value="6">06월</option>
		<option value="7">07월</option>
		<option value="8">08월</option>
		<option value="9">09월</option>
		<option value="10">10월</option>
		<option value="11">11월</option>
		<option value="12">12월</option>
	</select>
	<select id="accountCategory" name="accountCategory">
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
	<button class="btn btn-secondary" type="submit" id="searchButton">검색</button>
	</div>
</body>
</html>