<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.Date"%>
<%@ include file="/layout/header.jsp"%>

<style>
.comment-section {
	background-color: #eff4e1;
	padding: 20px;
	border-radius: 20px;
	margin-top: 20px;
}

.btn-container1 {
	display: flex;
	justify-content: flex-end;
}

.post-section {
	background-color: #E2EDC9;
	padding: 20px;
	border-radius: 20px;
	margin-top: 20px;
}

.container1 {
	background-color: #A1C59E; /* 배경 색상 변경 */
	padding: 20px;
	border-radius: 10px;
	margin-top: 20px;
}

h1 {
	color: rgb(252, 255, 249);
}

h2 {
	color: #b5c59e;
}

h3 {
	color: #b5c59e;
}

/* Style for the reply list */
#replyList {
	margin-top: 20px;
	list-style-type: none;
	padding: 0;
}

#replyList li {
	margin-bottom: 10px;
	padding: 10px;
	border-radius: 5px;
}

.go:hover {
	background-color: #799c58; /* 버튼 마우스 호버 시 배경 색상 변경 */
	border-color: #C4D7B2;
}

.go {
	font-size: 20px;
	padding: 10px 8px;
	margin: 10px;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	transition: background-color 0.3s, color 0.3s;
	background-color: #C4D7B2;
	color: white;
	width: 120px;
	height: 50px;
	text-align: center;
}

.ss {
	display: flex;
	align-items: center;
	/* 원하는 다른 스타일을 추가하세요 */
}

.vote {
	font-size: 30px;
	padding: 0px 30px;
	padding-top: 20px;
	margin: 10px;
	border: none;
	border-radius: 15px;
	cursor: pointer;
	transition: background-color 0.3s, color 0.3s;
	margin-right: 10px;
}

.vote[data-vote="1"] {
	background-color: #61c8ff;
	color: white;
}

.vote[data-vote="0"] {
	background-color: #ff4589;
	color: white;
}

.vote:hover {
	background-color: #A1C59E; /* 호버 시 밝은 색상으로 변경 */
	color: white;
}

.text-center {
	display: flex;
	justify-content: center;
	align-items: center;
	flex-wrap: wrap;
}

#voteResult {
	/* 'voteResult' 태그에 스타일 추가 */
	margin-right: 10px; /* '산다' 버튼과 'voteResult' 태그 사이의 간격 조정 */
}
</style>


<script type="text/javascript">
       
       
       $(document).ready(function() {
           
           var boardSeq = ${bonBoardDTO.seq};
			
           // AJAX 요청을 보냅니다.
           $.ajax({
               url: "BonVote_upList", // 데이터를 가져올 URL
               data: {
                   boardSeq: boardSeq
               },
               success: function(data) {
                   // 성공 시 서버에서 받은 데이터를 표시합니다.
                   	
                   console.log(data)
                 
                   $('#voteResult').text( data+"표");
               },
               error: function(xhr, status, error) {
                   // 오류 처리
                   alert("투표수 확인")
                   console.error('오류 발생: ' + error);
                   console.error('오류 발생2: ' + xhr);
               }
           });
     
           // AJAX 요청을 보냅니다.
           $.ajax({
               url: "BonVote_downList", // 데이터를 가져올 URL
               data: {
                   boardSeq: boardSeq
               },
               success: function(data) {
                   // 성공 시 서버에서 받은 데이터를 표시합니다.
                   	
                   console.log(data)
                 
                   $('#voteResult2').text( data+"표");
               },
               error: function(xhr, status, error) {
                   // 오류 처리
                   alert("투표수 확인")
                   console.error('오류 발생: ' + error);
                   console.error('오류 발생2: ' + xhr);
               }
           });
           
           
           
           
   	    $('.vote').click(function() {
            let vote = $(this).attr('data-vote')
			let userNickname = "<%=session.getAttribute("userNickname")%>"
     	        
     	        $.ajax({
     	            type: 'GET',
     	            url: 'BonVote_insert',
     	            data: {
     	                boardSeq: ${bonBoardDTO.seq}, 
     	                vote: vote,
     	                userNickname : userNickname
     	     
     	            },
     	            success: function(response) {
     	                if (response ==1 && vote ==1) {
     	                   location.reload();
     	                    alert('찬성투표가 완료되었습니다.');
     	                } else if (response == 1 && vote ==0){
     	                	location.reload();
     	                	alert('반대투표가 완료되었습니다.');
     	                }
     	                else {
             		
     	                    alert('이미 투표한 게시글입니다.');
     	          
     	                }
     	            },
     	            error: function() {
     	                alert('오류 발생');
     	            }
     	        })
     	        
   	    })
     	        
     	        
     
    
        		$('#deleteButton').click(function() {
        			$.ajax({
        				url : "BonBoard_delete",
        				data : {
        					seq : "${param.seq}"
        				},
        				success : function(result) {
        					if(result == 1){
        						alert("삭제완료");
        						location.href = "BonBoard_list?page=1";
        					}else{
        						alert("실패");
        					}
        				},
        				error : function() {
        					alert("실패");
        				} //error
        			}); //에이작스 
        		});
        	
       })
        		
        		
   </script>




<script type="text/javascript">

$(document).ready(function() {
    // bonBoardDTO.createAt 값을 가져와서 JavaScript 변수에 저장

<%Date date = new Date();%>
/* 	const year = date.getFullYear();
	const month = ('0' + (date.getMonth() + 1)).slice(-2);
	const day = ('0' + date.getDate()).slice(-2);
	const dateStr = year + '-' + month + '-' + day; */
    var dateString = "<%=date%>";

 // 문자열을 공백으로 분리하여 배열로 만듭니다.
 var parts = dateString.split(' ');

 // 월, 일, 연도 부분을 추출합니다.
 var dayOfWeek = parts[0]; // "Fri"
 var month = parts[1];     // "Sep"
 var day = parts[2];       // "01"
 var time = parts[3];      // "00:00:00"
 var timeZone = parts[4];  // "KST"
 var year = parts[5];      // "2023"
 var date1 = new Date(year+ "-" + month + "-" + day);
	var dateString2 = "${bonBoardDTO.voteEndAt}";
	
	 var parts2 = dateString2.split(' ');

	 // 월, 일, 연도 부분을 추출합니다.
	 var dayOfWeek2 = parts2[0]; // "Fri"
	 var month2 = parts2[1];     // "Sep"
	 var day2 = parts2[2];       // "01"
	 var time2 = parts2[3];      // "00:00:00"
	 var timeZone2 = parts2[4];  // "KST"
	 var year2 = parts2[5];      // "2023"
	 var date2 = new Date(year2+ "-" + month2 + "-" + day2);
	
   /*  alert("date1 = "+date1)
    alert("date2 = "+date2) */

    if (date1 < date2) {
    	/* alert("마감날짜를 지나지 않았습니다"); */
    	  console.log('date1 is earlier than date2');
    	} else if (date1 > date2) {
    /* 	alert("마감날짜를 지났습니다"); */
    	 $('#upButton').hide();
         $('#downButton').hide();
         $('#voteResult').text("투표가 마감되었습니다");
    	  console.log('date1 is later than date2');
    	} else {
    /* 	alert("오늘이 마감일입니다"); */
    	  console.log('date1 is equal to date2');
    	}
  
});

</script>

<script type="text/javascript">
    $(document).ready(function() {
        // 댓글 수정 버튼 클릭 시
        $(document).on('click', '#replyEdit', function() {
            // 현재 클릭한 수정 버튼에 대한 댓글 내용을 가져오기
            var replyContent = $(this).closest('li').find('div:first p:first').text().trim();

            // 댓글 수정을 위한 폼 생성 및 팝업
            var editForm = '<form id="editReplyForm">';
            editForm += '<input type="hidden" name="seq" value="' + $(this).data('seq') + '">';
            editForm += '<textarea name="content" class="form-control" rows="3" required>' + replyContent + '</textarea>';
            editForm += '<button type="button" id="btnEdit" class="btn btn-primary">댓글 수정</button>';
            editForm += '</form>';

            // 팝업으로 댓글 수정 폼 띄우기
            $(this).closest('li').append(editForm);

            // 댓글 수정 버튼 비활성화 및 댓글 삭제 버튼 숨기기
            $(this).prop('disabled', true);
            $(this).closest('div.text-right').find('form').hide();
        });

        // 댓글 수정 폼에서 수정 버튼 클릭 시
        $(document).on('click', '#btnEdit', function() {
            // 수정된 내용 가져오기
            var editedContent = $(this).prev('textarea').val();
            var seq = $(this).closest('form').find('input[name="seq"]').val();

            $.ajax({
                type: 'POST', 
                url: 'BonReply_update', // 수정 요청을 처리할 서버의 URL
                data: {
                    seq: seq,
                    content: editedContent
                },
                success: function(response) {
                    // 수정 성공 시 댓글 내용 갱신 및 폼 제거
                    var listItem = $('#replyList li').find('input[name="seq"][value="' + seq + '"]').closest('li');
                    listItem.find('div:first p:first').text(editedContent);
                    listItem.find('#btnEdit').prop('disabled', false);
                    listItem.find('form').remove();
                },
                error: function() {
                    alert('오류 발생');
                }
            });
        });
    });
</script>


<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body	>
	<div class="container1" >
		<div class="text-center">
			<h1>살까? 말까?</h1>


		</div>
		<div class="post-section"  style="font-family: Arial, sans-serif; font-size: 24px;">
			<p>
				<strong>작성자:</strong> ${bonBoardDTO.userNickname}
			</p>
			<p>
				<strong>제목:</strong> ${bonBoardDTO.title}
			</p>
			<p>
				<strong>조회수:</strong> ${bonBoardDTO.views}
			</p>
			<p>
				<strong>작성날짜:</strong>
				<fmt:formatDate pattern="yyyy/MM/dd HH:mm"
					value="${bonBoardDTO.createAt}" />
			</p>
			<div class="post-content">
				<p>
					<strong>구매링크:</strong> <a href="${bonBoardDTO.itemLink}">상품 보기</a>
				</p>
				<p>
					<strong>내용:</strong>
				</p>
				<p>${bonBoardDTO.content}</p>
			</div>

			<br> <br> <br>



			<div class="text-center ss">
				<h2>내가 고민을 올린 벌레라면?</h2>
			</div>

			<div class="text-center">

				<!-- 현재 날짜가 투표 마감일보다 이른 경우에만 버튼을 표시 -->
				<button id="upButton" class="vote" data-vote="1">
					산다
					<p id="voteResult"></p>
				</button>
				<button id="downButton" class="vote" data-vote="0">
					만다
					<p id="voteResult2"></p>
				</button>

			</div>


			<div class="text-center">
				<strong>투표마감일:</strong>
				<fmt:formatDate pattern="yyyy-MM-dd"
					value="${bonBoardDTO.voteEndAt}" />
			</div>
			<div class="btn-container1">
				<!-- 목록 버튼 -->
				<a href="/moneybug/bonBoard/bonBoard_main" class="go">목록</a>

				<c:choose>
					<c:when
						test="${sessionScope.userNickname eq bonBoardDTO.userNickname}">
						<!-- 수정 버튼 -->
						<a
							href="/moneybug/bonBoard/BonBoard_update2.jsp?seq=${bonBoardDTO.seq}&title=${bonBoardDTO.title}&content=${bonBoardDTO.content}"
							class="go">수정</a>
						<!-- 삭제 버튼 -->
						<button id="deleteButton" class="go">삭제</button>
					</c:when>
				</c:choose>

			</div>
			<div class="container1">
				<div class="text-center">
					<h3 style="color: white;">벌레들의 의견</h3>
				</div>
				<div class="comment-section">
					<!-- 댓글 작성 폼 -->
					<form id="replyForm" action="BonReply_insert" method="post">
						<input type="hidden" name="boardSeq" value="${bonBoardDTO.seq}">
						<input type="hidden" name="userNickname"
							value="<%=session.getAttribute("userNickname")%>">
						<div class="form-group"></div>
						<div class="form-group">
							<label for="content">댓글내용</label>
							<textarea name="content" class="form-control" rows="3" required></textarea>
						</div>
						<button type="submit" id="btn" class="go">댓글 등록</button>
					</form>

				</div>

				<!-- 댓글 목록 -->
				<div class="comment-section">
					<ul id="replyList">
						<c:forEach var="bonReplyDTO" items="${list}">
							<li>
								<div>
									<strong>${bonReplyDTO.userNickname}</strong><br>
									${bonReplyDTO.content}
								</div>
								<div>
									<p>
										<fmt:formatDate pattern="yyyy/MM/dd HH:mm"
											value="${bonReplyDTO.createAt}" />
									</p>
								</div> <c:choose>
									<c:when
										test="${sessionScope.userNickname eq bonReplyDTO.userNickname}">


										<div class="btn-container1">
											<form method="get" action="BonReply_delete">
												<input type="hidden" name="seq" value="${bonReplyDTO.seq}">
												<input type="hidden" name="boardSeq"
													value="${bonBoardDTO.seq}">
												<button type="submit" class="go">댓글 삭제</button>
											</form>

										</div>
									</c:when>
								</c:choose>

							</li>
						</c:forEach>
					</ul>
				</div>

			</div>
		</div>
	</div>
	<%@ include file="/layout/footer.jsp"%>