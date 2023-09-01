<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 상세보기</title>
    <!-- 부트스트랩 CSS 연결 -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- 추가 스타일 -->
    <style>
        body {
            background-color: #f2f2f2; /* 연한 회색 배경 */
            font-family: Arial, sans-serif;
        }
        .container {
            background-color: #ffffff; /* 하얀 배경 */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
        }
        h1 {
            color: #ff6b6b; /* 분홍색 제목 */
        }
        .btn-primary {
            background-color: #ff6b6b; /* 분홍색 버튼 */
            border-color: #ff6b6b; /* 분홍색 테두리 */
        }
        .btn-primary:hover {
            background-color: #ff3e3e; /* 버튼 호버 시 색 변화 */
            border-color: #ff3e3e;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- 게시글 내용 -->
        <h1>게시글 상세보기</h1>
        <p><strong>작성자:</strong> ${bonBoardDTO.writerID}</p>
        <p><strong>제목:</strong> ${bonBoardDTO.title}</p>
        <p><strong>조회수:</strong> ${bonBoardDTO.views}</p>
      <p><strong>작성날짜:</strong> <fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${bonBoardDTO.createAt}" /></p>

        <p><strong>내용:</strong></p>
        <p>
           ${bonBoardDTO.content}
        </p>
        
        
         
        
        <!-- 목록 버튼 -->
        <a href="BonBoard_list.jsp" class="btn btn-primary">목록</a>
        
        <!--  수정 버튼 -->
          <a href="BonBoard_update.jsp?seq=${bonBoard.seq}&title=${bonBoardDTO.title}&content=${bonBoardDTO.content}" class="btn btn-primary">수정</a>
          <!-- 삭제 버튼 -->
          
    <button id="deleteButton" style="background: grey; color: white;">삭제</button>   
         
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
    <c:forEach var="reply" items="${bonReplyDTO.list}">
        <li>${bonReplyDTO.writerId}</li>
        <li>${bonReplyDTO.content}</li>
    </c:forEach>
</ul>
         
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
$(function() {

	$('#deleteButton').click(function() {
		$.ajax({
			url : "BonBoard_delete",
			data : {
				seq : "${param.seq}"
			},
			success : function() {
				alert("삭제완료");
				location.href = "bonBoard_list";
			},
			error : function() {
				alert("실패");
			} //error
		}); //에이작스 
	});

</script>
    
        

    </div>
</body>
</html>
