<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BonReply List</title>
    <!-- 필요한 스타일 시트 및 스크립트를 여기에 추가할 수 있습니다. -->
</head>
<body>
    <h1>의견 달기</h1>

  <!-- 댓글 작성 폼 -->
<form id="replyForm" action="BonReply_insert" method="post">
    <input type="hidden" name="boardSeq" value="${bonBoard.seq}">
    <label for="content">댓글 작성:</label>
    <input type="text" id="re" name="content" required>
    <button type="submit" id="btn" >댓글 등록</button>
</form>

<!-- 댓글 목록 -->
<ul id="replyList">
    <c:forEach var="reply" items="${list}">
        <li>${bonReplyDTO.writerId}</li>
        <li>${bonReplyDTO.content}</li>
    </c:forEach>
</ul>

<script src="https://code.jquery.com/jquery-3.6.0.min.js">

$(document).ready(function() {
     $("#writeForm").submit(function(event) {
$.ajax({
	type: "POST",
url:"BonReply_insert",
data : formData,
success: function(response){
	
	alert("댓글 작성이 완료되었습니다.");
	
},
error: function(){
	alert("오류가 발생했습니다. 다시 시도해주세요.")
   }
                });
            });
        });


</script>
</body>
</html>
