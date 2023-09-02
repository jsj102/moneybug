<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
    offsetNumber = parseInt(localStorage.getItem('offsetNumber')) || 0;
    maxOffset = 100;
    
    function updateOffset(newOffset) {
	offsetNumber = newOffset;
	localStorage.setItem('offsetNumber', offsetNumber);
	pagination();
    }
    
    $("#prevBtn").click(function() {
	if (offsetNumber >= 1) {
	    offsetNumber = offsetNumber - 10; 
	    updateOffset(offsetNumber);
	    pagination();
	} else {
	    alert("처음 페이지입니다.")
	}
    })
    
    $("#nextBtn").click(function() {
	if (offsetNumber + 10 < maxOffset) {
	    offsetNumber = offsetNumber + 10
	    updateOffset(offsetNumber);
	    pagination();
	} else {
	    alert("마지막 페이지입니다.")
	}
    })

    function pagination() {
	$.ajax({
	    url : "/moneybug/readListSearch.accountDetail",
	    method : "POST",
	    data : {
		offsetNumber : offsetNumber,
		accountCategory : "${data.accountCategory}",
		searchMonth : ${data.searchMonth},
		searchYear : ${data.searchYear}
	    },
	    success : function(data) {
		$("#accountDetail").html(data);
	    },
	    error : function(xhr, status, error) {
		var errorMessage = "오류 상태 코드: " + xhr.status + "\n"
			+ "오류 메시지: " + error + "\n" + "오류 타입: " + status;
		alert(errorMessage);
	    }
	})
    }
    
    $(document).ready(function() {
        $(".account-link").click(function() {
            var dataSeqValue = $(this).data("seq");
            console.log("data-seq 값:", dataSeqValue);
            load(dataSeqValue);
        });
    });
</script>
<style>
table {
	width: 500px;
	table-layout: fixed;
}
</style>
</head>
<body>
	<div class="section" id="accountDetail">
		<h3>검색결과</h3>
		<table class="table table-striped">
			<tr>
				<th>순서</th>
				<th>계정</th>
				<th>설명</th>
				<th>가격</th>
				<th>지출</th>
				<th>사용날짜</th>
			</tr>
			<c:forEach items="${list}" var="account" varStatus="status">
				<tr>
					<td>${status.index + 1 + data.offsetNumber}</td>
					<td><a href="#" class="account-link" data-seq="${account.seq}">${account.accountCategory}</a></td>
					<td>${account.description}</td>
					<td>${account.price}</td>
					<td>${account.accountType}</td>
					<td>${account.usedAt}</td>
				</tr>
			</c:forEach>
		</table>
		<div id="pagination">
			<button id="prevBtn" class="btn btn-success">이전</button>
			<button id="nextBtn" class="btn btn-success">다음</button>
		</div>
	</div>

</body>
</html>