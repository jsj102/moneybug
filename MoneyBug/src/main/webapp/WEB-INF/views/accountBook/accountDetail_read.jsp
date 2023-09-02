<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">

<title>Account Details</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	var offset = parseInt(localStorage.getItem('offset')) || 0; // offset 값을 숫자로 변환
	var maxOffset = 1000;
	var accountBookId = $("#accountBookId").val();
	window.addEventListener('beforeunload', function() {
		localStorage.setItem('offset', 0);
	});
	function updateOffset(newOffset) {
		offset = newOffset;
		localStorage.setItem('offset', offset);
		pagination();
	}

	$("#prevBtn").click(function() {
		if (offset >= 10) {
			offset = offset - 10;
			updateOffset(offset);
		} else {
			alert("첫 페이지입니다.");
		}
	});

	$("#nextBtn").click(function() {
		if (offset + 10 <= maxOffset) {
			offset = offset + 10;
			updateOffset(offset);
		} else {
			alert("마지막 페이지입니다.");
		}
	});

	function pagination() {
		$.ajax({
			url : "/moneybug/readListPage.accountDetail",
			method : "GET",
			data : {
				offset : offset,
				accountBookId : accountBookId
			},
			success : function(data) {
				$("#accountDetail").html(data); // 화면 업데이트를 AJAX 요청 응답 후에 수행
				console.log("Pagination success");
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
	function load(seq) {
		$.ajax({
			url : "/moneybug/readSeq.accountDetail",
			method : "GET",
			data : {
				seq : seq
			},
			success : function(data) {
				$("#accountDetail").html(data);
			},
			error : function(xhr, status, error) {
				var errorMessage = "오류 STATUS CODE: " + xhr.status + "\n"
						+ "오류 보고: " + error + "\n" + "오류 상태: " + status;
				alert(errorMessage);
			}
		});
	}
</script>
<style>
table {
	width: auto;
	table-layout: fixed;
}
</style>
</head>
<body>
	<input id="accountBookId" type="hidden" value="${accountBookId}">
	<div class="section" id="accountDetail">
		<table class="table table-striped" id="tableFixed">
			<c:choose>
				<c:when test="${list eq 'no-data'}">
					<tr>
						<td colspan="6">데이터 없음</td>
					</tr>
				</c:when>
				<c:otherwise>
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
							<td>${status.index + 1 + offset}</td>
							<td><a href="#" class="account-link"
								data-seq="${account.seq}">${account.accountCategory}</a></td>
							<td>${account.description}</td>
							<td>${account.price}</td>
							<td>${account.accountType}</td>
							<td>${account.usedAt}</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
		<div id="pagination">
			<button id="prevBtn" class="btn btn-success">이전</button>
			<button id="nextBtn" class="btn btn-success">다음</button>
		</div>
	</div>
</body>
</html>