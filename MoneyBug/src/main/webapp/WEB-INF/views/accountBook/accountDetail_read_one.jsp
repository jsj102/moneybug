<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>계정 조회</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

</head>
<body>
	<div class="section" id="editFormArea">
		<h4>가계부 상세내역</h4>
		<table class="table table-striped">
			<tr>
				<th>계정</th>
				<th>설명</th>
				<th>가격</th>
				<th>지출/수입</th>
				<th>사용일</th>
			</tr>
			<c:choose>
				<c:when test="${account eq 'No data'}">
					<tr>
						<td colspan="5">데이터 없음</td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr>
						<td>${account.accountCategory}</td>
						<td>${account.description}</td>
						<td>${account.price}</td>
						<td>${account.accountType}</td>
						<td>${account.usedAt}</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
		<div>
			<button type="submit" id="editForm" class="btn btn-success">수정</button>
			<button type="submit" id="deleteForm" class="btn btn-success">삭제</button>
		</div>
	</div>
	<script type="text/javascript">
        $("#editForm").click(function() {
            $.ajax({
                url : "/moneybug/updateForm.accountDetail",
                type : "POST",
                data : {
                    seq : "${account.seq}",
                    accountCategory : "${account.accountCategory}",
                    accountBookId : "${account.accountBookId}",
                    price : "${account.price}",
                    description : "${account.description}",
                    usedAt : "${account.usedAt}"
                },
                success : function(response) {
                	$("#editFormArea").html(response);
                },
                error : function(xhr, status, error) {
                	
                    console.error("AJAX 요청 실패:", status, error);
                }
            });
        })

        $("#deleteForm").click(function() {
            $.ajax({
                url : "/moneybug/delete.accountDetail",
                type : "POST",
                data : {
                    seq : "${account.seq}"
                },
                success : function(res) {
                    alert("삭제 성공")
                    location.href = "/moneybug/accountBook/accountDetail_List.jsp";
                },
                error : function(xhr, status, error) {
                    console.error("AJAX 요청 실패:", status, error);
                }
            })
        })
    </script>
</body>
</html>