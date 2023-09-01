<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 상세보기</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Custom Styles -->
    <style>
         body {
        background-color: #E2EDC9; /* 배경 색상 변경 */
        font-family: Arial, sans-serif;
        font-size : 24px;
    }
    .container {
        background-color: #ffffff; /* 배경 색상 변경 */
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
        margin-top: 20px;
    }
    h1 {
        color: #A1C59E; /* 제목 색상 변경 */
    }
    
       h3 {
        color: #A1C59E; /* 제목 색상 변경 */
    }
    .btn-primary {
     font-size : 24px
        background-color: #BCD6BA; /* 버튼 배경 색상 변경 */
        border-color: #BCD6BA; /* 버튼 테두리 색상 변경 */
    }
    .btn-primary:hover {
        background-color: #C4D7B2; /* 버튼 마우스 호버 시 배경 색상 변경 */
        border-color: #C4D7B2;
    }
    /* Style for the reply list */
    #replyList {
        margin-top: 20px;
        list-style-type: none;
        padding: 0;
    }
    #replyList li {
        margin-bottom: 10px;
        border: 1px solid #ccc;
        padding: 10px;
        background-color: #f9f9f9;
        border-radius: 5px;
    }
    
    
     .vote-button {
     
            font-size: 30px;
            padding: 20px 30px;
            margin: 10px;
            border: none;
            border-radius: 15px;
            cursor: pointer;
            transition: background-color 0.3s, color 0.3s;
        }

        .vote-button[data-vote="1"] {
            background-color: #61c8ff;
            color: white;
        }
        .vote-button[data-vote="0"] {
            background-color: #ff4589;
            color: white;
        }

        .vote-button:hover {
            background-color: #555;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- 게시글 내용 -->
        <h1>게시글 상세보기</h1>
        <p><strong>작성자:</strong> ${bonBoardDTO.writerId}</p>
        <p><strong>제목:</strong> ${bonBoardDTO.title}</p>
        <p><strong>조회수:</strong>${bonBoardDTO.views}</p>
        <p><strong>작성날짜:</strong><fmt:formatDate pattern="yyyy-MM-dd " value="${bonBoardDTO.createAt}" /></p>
        <p><strong>내용:</strong></p>
        <p>
        ${bonBoardDTO.content}
        </p>
        
        <br>
        <br>
        <br>
        
        
        <!-- 목록 버튼 -->
        <a href="BonBoard_list.jsp" class="btn btn-primary">목록</a>
        
        <!-- 수정 버튼 -->
        <a href="BonBoard_update.jsp?seq=${bonBoardDTO.seq}&title=${bonBoardDTO.title}&content=${bonBoardDTO.content}" class="btn btn-primary">수정</a>
        
        <!-- 삭제 버튼 -->
        
           
            <button id="deleteButton" class="btn btn-danger">게시글 삭제</button>
        
    </div>
    
    <div class="container">
    
    <%-- <form id="voteForm" action="BonVote_insert">
    
    <h3>내 의견을 투표해보자!</h3>
    <h6>내가 글쓴벌레라면?</h6>
    <input type="hidden" name="boardSeq" value="${bonBoardDTO.seq}" />
        <input type="hidden" name="userId" value="3126498" />
    
    
      <button type="button"  data-vote="1">찬성</button>
        <button type="button" data-vote="0">반대</button>
        <button type="submit"  > 투표완료 </button>
        <input type="hidden" name="vote" value="${vote}" />
    
      <div id="voteResults"></div>  
    </form> --%>
    
    
    <h1>투표</h1>
    <h3>내가 고민을 올린 벌레라면? </h3>
    <button id="upButton" class="vote-button" data-vote="1">살까</button>
    <button id="downButton" class="vote-button" data-vote="0">말까</button>
      <p><strong>투표마감일:</strong> <fmt:formatDate pattern="yyyy-MM-dd " value="${bonBoardDTO.voteEndAt}" /></p>
    </div>

    
    
    
    <div class="container">
        <h1>의견 달기</h1>
        
        <!-- 댓글 작성 폼 -->
        <form id="replyForm" action="BonReply_insert" method="post">
            <input type="hidden" name="boardSeq" value="${bonBoardDTO.seq}">
            <div class="form-group">
                <label for="writerId">닉네임</label>
                 <input type="text" name="writerId" minlength="1" maxlength="8" class="form-control" required> 
            </div>
            <div class="form-group">
                <label for="content">댓글내용</label>
                <textarea name="content"  class="form-control" rows="3" required></textarea>
            </div>
            <button type="submit" id="btn" class="btn btn-primary">댓글 등록</button>
        </form>
        
        
        
        <!-- 댓글 목록 -->
        <ul id="replyList">
            <c:forEach var="bonReplyDTO" items="${list}">
                <li>
                     <div>
                <strong>${bonReplyDTO.writerId}</strong><br>
                ${bonReplyDTO.content}
            </div>
            <div>
               <p>
                ${bonReplyDTO.createAt}
               <p>  
                 </div>
                   <button type="submit" id="btnEdit" class="btn btn-primary">댓글 수정</button>
                 
        <form method="get" action="BonReply_delete">
            <input type="hidden" name="seq" value="${bonReplyDTO.seq}">
            <button type="submit" class="btn btn-danger">댓글 삭제</button>
        </form>
           
                </li>
            </c:forEach>
        </ul>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
        // Delete button click handler using AJAX
        $('#deleteButton').click(function() {
            var seq = "${bonBoardDTO.seq}";
            
            $.ajax({
                type: 'GET',
                url: 'BonBoard_delete',
                data: {
                	seq : seq
                },
                success: function(response) {
                    if (response === '1') {
                        alert('게시글이 삭제되었습니다.');
                        // You can refresh the page or perform other actions here
                        window.location.href= 'BonBoard_one?seq='+seq
                    } else {
                        alert('게시글 삭제에 실패했습니다.');
                    }
                },
                error: function(xhr, status, error) {
                    alert('오류 발생: ' + error);
                }
            });
        
        });

     
        
        $(document).ready(function() {
            // "사자" 버튼 클릭 시 AJAX 요청
            $("#voteLion").click(function() {
                castVote(1); // 사자 투표는 1을 전달
            });

            // "말자" 버튼 클릭 시 AJAX 요청
            $("#voteHorse").click(function() {
                castVote(0); // 말자 투표는 0을 전달
            });
        });


        

        
        
        
        
        $('.edit-comment').click(function () {
            var listItem = $(this).closest('li');
            var commentContent = listItem.find('.comment-content').text();
            var boardSeq = listItem.find('input[name="boardSeq"]').val();
            var seq = listItem.find('input[name="seq"]').val();
            var writerId = listItem.find('strong').text();

            $('#editBoardSeq').val(boardSeq);
            $('#editSeq').val(seq);
            $('#editWriterId').val(writerId);
            $('#editContent').val(commentContent);

            $('#replyForm').hide();
            $('#editForm').show();
        });

       
    </script>
</body>
</html>
