<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/layout/header.jsp" %>
<%@ include file="/layout/TagBoardNav.jsp"%>
<style>

body {
	background: #F9F5E7;
}

a {
	text-decoration: none;
}


.totaltap {
	height: 100%;
	border: 2px solid #56CC9D; /* 테두리 색상과 두께 설정 */
	border-radius: 20px; /* 모서리 둥글게 만듦 */
 	margin : 10px 70px 55px 70px;  
 	background-color: white; 
}
.plmi {
    height: 100px;
    border: 2px solid #56CC9D;
    border-radius: 20px;
    margin: 10px 70px 30px 70px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center; /* 텍스트 가운데 정렬 */
    overflow: hidden; 
    background-color: white; 
    font-size: 18px;
}

.plmi table {
    margin: 0 auto; /* 내부 테이블을 수평 가운데 정렬 */
   width: 90%;
}

.maintitle {
    text-align: left; 
    margin-left : 40px;
}
.subtitle {
    font-size: 18px;
    margin-right : 40px;
    text-align: right; 
}

.maincontents {
    text-align: center; /* 가운데 정렬 */
    font-size: 25px;
    overflow: hidden; 
}

 
.replycontainer {
   	height: 100%;
	background-color: #F9F5E7; /* 테두리 색상과 두께 설정 */
	border-radius: 20px; /* 모서리 둥글게 만듦 */
 	margin : 50px 80px 55px 80px;  
 	padding-bottom: 35px; 
 	overflow: hidden; 
}

.tagreply-container{
	margin : 0 80px 20px 80px;
	background-color: #ffffff;
    border-radius: 20px;
    height: 600px; 
    overflow: auto;
    padding-top: 10px;
    }
.replyinsert {
	display: flex; /* 텍스트를 수직 및 수평으로 가운데 정렬하기 위해 flexbox 사용 */
    justify-content: center; /* 수직 가운데 정렬 */
    align-items: center; /* 수평 가운데 정렬 */
    font-size: 18px;
    background-color: #ffffff;
    border-radius: 20px; /* 테두리 스타일 및 색상 설정 */
    padding: 10px; /* 테두리와 내용 사이의 간격 설정 */
    margin : 0 150px 0 150px;
    overflow: hidden; 
}
#replycontent {
    border: none; /* 기본 테두리 제거 */
    border-bottom: 2px solid #F3969A; /* 밑줄 스타일 적용 */
    outline: none; /* 포커스시 테두리 제거 */
    padding: 15px; /* 내부 여백 추가 */
    width: 650px;
    background-color: #ffffff; /* 배경색 설정 */
    text-align: left; /* 가운데 정렬을 위한 속성 */
    overflow: hidden; 
}

/* textarea의 스타일 수정 */
textarea {
    border: none; /* 기본 테두리 제거 */
    border-radius: 5px; /* 모서리 둥글게 만듦 */
    outline: none; /* 포커스시 테두리 제거 */
    padding: 5px; /* 내부 여백 추가 */
    width: 450px; /* 너비를 부모 요소에 맞게 설정 */
    background-color: #fffdf5; /* 밝은 배경색 설정 */
}






/* 입력 폼과 버튼 간격 조절 */
br + #searchButton {
    margin-left: 100px;
}
</style>
<div class="totaltap">
<div class="container">
	<br><br>


	<div class="maintitle"><h3>[${tagBoardDTO.boardType}] ${tagBoardDTO.title}</h3></div>
	<div class="subtitle">
	조회수 : <span style="color:#F3969A;">${tagBoardDTO.views}</span> <br>
	<fmt:formatDate pattern="yyyy-MM-dd HH:mm"
		value="${tagBoardDTO.createAt}" />&nbsp <span style="color:#F3969A; font-size: 22px; font-weight: 600;">${tagBoardDTO.writerId}</span>
		</div>
		<hr style="color: #C4D7B2;">

<div class = "maincontents">
<br>
	${tagBoardDTO.content} 
	</div>
	<br><br><br><br><br>
	<div class="mainbuttons" style="overflow: hidden;">
	<div class="row">
	<c:choose>
		<c:when test="${sessionScope.userNickname eq tagBoardDTO.writerId }">
		<div class="btn-group" role="group">
        <div class="col-md-0.5" style="margin:0 10px 0 120px;">
        <form action="TagBoard_update.jsp" method="post">
            <input type="hidden" name="seq" value="${tagBoardDTO.seq}">
            <input type="hidden" name="title" value="${tagBoardDTO.title}">
            <input type="hidden" name="content" value="${tagBoardDTO.content}">
            <input type="hidden" name="boardType" value="${tagBoardDTO.boardType}">
            <input type="hidden" name="writerId" value="${tagBoardDTO.writerId}">
            <button type="submit" id="tagboardupdate" class="btn btn-warning btn-block">수정</button>
        </form>
        </div>
        <div class="col-md-0.5" style="margin-right: 10px;" >
        <button id="tagboarddelete" class="btn btn-danger btn-block">삭제</button>
        </div>
		<div class="col-md-0.5">
        <a href="TagBoard_list?Page=1">
            <button class="btn btn-secondary btn-block">목록</button>
        </a>
        </div>
		</div>
			<br>
		</c:when>
		<c:otherwise>
		<div class="col-md-0.5" style="margin:0 10px 0 120px;">
			<a href="TagBoard_list?Page=1"><button
					class="btn btn-secondary">목록</button></a>
					</div>
		</c:otherwise>
	</c:choose>
</div>
</div>
	

	<div class="replycontainer">
	<br>
	<h3 style="margin: 10px 0 15px 40px;"> 댓글</h3>
		<div class="replyinsert" ><input id="replycontent" placeholder="댓글을 입력하세요. . ."">&nbsp&nbsp
		<button id="tagreplyinsert" class="btn btn-secondary" style="margin-left: 10px;">입력</button></div>
		<br><br>
		


		<div class="tagreply-container">

			<c:forEach items="${tagreplylist}" var="tagReplyDTO">
				<c:if test="${tagReplyDTO.replyLevel eq 0}">
					<div class="tagreply original-reply" style="margin-left: 60px;">
						<br> <span style="font-weight: 600; color:#56CC9D;">${tagReplyDTO.writerId}</span> <br> <span style="font-size:18px;">${tagReplyDTO.content}</span>

						<br>
						<p style="font-size: 12px;">
							<fmt:formatDate value="${tagReplyDTO.createAt}"
								pattern="yyyy-MM-dd HH:mm" />
						</p>

						<%-- 로그인된 아이디와 댓글의 작성자가 같으면 --%>
						<c:choose>
							<c:when
								test="${sessionScope.userNickname eq tagReplyDTO.writerId and not empty tagReplyDTO.writerId}">
								<button class="re-tagreply btn btn-success" selected_id="${tagReplyDTO.seq}"
									>답글</button>
								<button class="tagreplyupdate btn btn-warning" selected_id="${tagReplyDTO.seq}"
									>수정</button>
								<button class="tagreplydelete btn btn-danger" selected_id="${tagReplyDTO.seq}"
									>삭제</button>
							</c:when>
							<c:when
								test="${not empty sessionScope.userNickname and !sessionScope.userNickname.equals(tagReplyDTO.writerId) and not empty tagReplyDTO.createAt}">
								<button class="re-tagreply btn btn-success" selected_id="${tagReplyDTO.seq}"
									>답글</button>
							</c:when>

						</c:choose>


						<form name="form" class="tagreply-update-form"
							selected_id="${tagReplyDTO.seq}">
							<textarea id="updatecontent${tagReplyDTO.seq}">${tagReplyDTO.content}</textarea>
							<button type="submit" class="btn btn-secondary">수정</button>
						</form>



						<form name="form" class="re-tagreply-form"
							selected_id="${tagReplyDTO.seq}">
							<textarea id="reinsertcontent${tagReplyDTO.seq}"></textarea>
							<input type="hidden" id="originWriter${tagReplyDTO.seq}"
								value="${tagReplyDTO.writerId}" />
							<button type="submit" class="btn btn-secondary">등록</button>
						</form>
						<br>
					</div>
					<hr style="margin: 15px 30px -12px 30px;">

					<!-- 대댓글 표시 -->
					<div>
						<c:forEach items="${tagreplylist}" var="reply">
							<c:if
								test="${reply.replyLevel eq 1 and reply.groupSeq eq tagReplyDTO.groupSeq}">
								<div class="tagreply indented-reply" style="margin-left: 105px;">
									<br><span style="font-weight: 600; color:#56CC9D;"> ${reply.writerId}</span> <br> <span style="font-size:18px;"><c:if
											test="${not empty reply.originWriter}"><span style="font-weight: 600; font-size: 17px;">@${reply.originWriter}</span></c:if>
									&nbsp${reply.content} </span><br>
									<p style="font-size: 12px;">
										<fmt:formatDate value="${reply.createAt}"
											pattern="yyyy-MM-dd HH:mm" />
									</p>

									<%-- 로그인된 아이디와 댓글의 작성자가 같으면 --%>
									<c:choose>
										<c:when test="${sessionScope.userNickname eq reply.writerId }">
											<button class="re-tagreply btn btn-success" selected_id="${reply.seq}"
												>답글</button>
											<button class="tagreplyupdate btn btn-warning" selected_id="${reply.seq}"
												>수정</button>
											<button class="retagreplydelete btn btn-danger" selected_id="${reply.seq}"
												>삭제</button>
										</c:when>
										<c:when
											test="${not empty sessionScope.userNickname and !sessionScope.userNickname.equals(reply.writerId)}">
											<button class="re-tagreply btn btn-success" selected_id="${reply.seq}"
												>답글</button>
										</c:when>
									</c:choose>

									<form name="form" class="tagreply-update-form"
										selected_id="${reply.seq}">
										<textarea id="updatecontent${reply.seq}">${reply.content}</textarea>
										<button type="submit" class="btn btn-secondary">수정</button>
									</form>



									<form name="form" class="re-tagreply-form"
										selected_id="${reply.seq}">
										<textarea id="reinsertcontent${reply.seq}"></textarea>
										<input type="hidden" id="originWriter${reply.seq}"
											value="${reply.writerId}" />
										<button type="submit" class="btn btn-secondary">등록</button>
									</form>

									<br>

								</div>
								<hr style="margin: 15px 30px -12px 30px;">


							</c:if>
						</c:forEach>
					</div>





				</c:if>
			</c:forEach>
			<br><br><br><br>
		</div>
</div>
</div>


	</div>

	<div class="plmi" style="text-align: center;">
    <table >
			<tbody>
				<c:forEach items="${plmilist}" var="tagBoardDTO">
					<tr style="border-bottom: 3px solid white;">
						<td style="width: 100px;"><c:if test="${tagBoardDTO.seq > param.seq}">
					ᐱ 
					</c:if> <c:if test="${tagBoardDTO.seq < param.seq}">
					ᐯ 
					</c:if></td>
						<td style="width: 500px;">[${tagBoardDTO.boardType}]&nbsp&nbsp<a
							href="TagBoard_one?seq=${tagBoardDTO.seq}">${tagBoardDTO.title}</a></td>
						<td style="width: 200px;">${tagBoardDTO.writerId}</td>
						<td style="width: 200px;"><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
								value="${tagBoardDTO.createAt}" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>


	</div>
	<div style="text-align: center;">
    <a href="TagBoard_list?Page=1">
        <button class="btn btn-outline-secondary">글 전체 목록</button>
    </a>
</div>
<br><br>


<%@ include file="/layout/footer.jsp"%>




<script type="text/javascript">
$(document).ready(function() {
    // 페이지 로드 시 한 번만 실행됩니다.
    
    // 게시글 조회 페이지 로드 시, 서버로 조회수 증가 요청 보내기
    $.ajax({
        url: "TagBoard_updateViews",  // 조회수 증가를 처리하는 서버 측 URL
        method: "POST",
        data: {
            seq: ${tagBoardDTO.seq}  // 게시글 식별자를 서버로 전달
        },
        success: function(response) {
            // 조회수 증가 후의 값을 받아서 화면에 표시
            $('#viewsCount').text(response.views);
        },
        error: function(error) {
            console.error("조회수 업데이트에 실패했습니다.");
        }
    });




			$('#tagboarddelete').click(function() {
				var confirmDelete = window.confirm("게시글을 삭제하시겠습니까?");
			    
			    if (confirmDelete) {
				$.ajax({
					url : "TagBoard_delete",
					data : {
						seq : "${param.seq}"
					},
					success : function() {
						location.href = "TagBoard_list?Page=1";
					},
					error : function() {
						alert("실패!");
					} //error
				})
			    }
			}) //tagboarddelete - 게시글 지우기 

			$('#tagreplyinsert').click(function() {
				
				var replyContent = $('#replycontent').val();

			    // 댓글 내용이 null 또는 빈 문자열인 경우 입력을 막음
			    if (!replyContent) {
			        alert("댓글 내용을 입력해주세요.");
			        return false; // 댓글 내용이 없으므로 함수 종료
			    }
			    
				 $.ajax({
			            url: "../checkLogin",
			            method: "GET",
			            success: function (response) {
			                let loginStatus = parseInt(response);
			                if (loginStatus !== 1) {
			                   alert("댓글 작성은 로그인을 해야 합니다!")
			                    location.href = "/moneybug/login.jsp"; // 실제 로그인 페이지 URL로 변경
			                } else {
				$.ajax({
					url : "../tagReply/TagReply_insert",
					data : {
						boardSeq : '${param.seq}',
						content : replyContent,
						writerId: '${sessionScope.userNickname}'

					},
					success : function() {
						location.reload();
					},
					error : function() {
						alert("실패!")
					} //error
				})
			                }},
			                error: function (error) {
			                    location.href = "/moneybug/login.jsp"; // 에러 발생 시 로그인 페이지로 리다이렉션
			                }
			})
			})//tagreplyinsert - 댓글 추가 

			$(document).ready(
					function() {
						$('.re-tagreply-form').hide(); // 페이지 로딩 시 폼을 숨김

						$('.re-tagreply').click(
								function() {
									var correspondingForm = $(this).closest(
											'.tagreply').find(
											'.re-tagreply-form');
									correspondingForm.slideToggle();

								})
					});

			//re-tagreply - 대댓글 

			$('.re-tagreply-form').on("submit", function() {
				var seq_value = $(this).attr("selected_id");
				var reInsertContent = $('#reinsertcontent' + seq_value).val();
				var originWriter = $('#originWriter' + seq_value).val();

			    // 댓글 내용이 null 또는 빈 문자열인 경우 입력을 막음
			    if (!reInsertContent) {
			        alert("댓글 내용을 입력해주세요.");
			        return false;
			    }

				$.ajax({
					url : "../tagReply/TagReply_reinsert",
					data : {
						boardSeq : '${param.seq}',
						originSeq : seq_value,
						content : reInsertContent,
						writerId: '${sessionScope.userNickname}',
						originWriter : originWriter

					},
					success : function() {
						location.reload();
					}, //success
					error : function() {
						alert("실패!")
					} //error
				})
				return false;
			})

			$(document).ready(
					function() {
						$('.tagreply-update-form').hide(); // 페이지 로딩 시 폼을 숨김

						$('.tagreplyupdate').click(
								function() {
									var correspondingForm = $(this).closest(
											'.tagreply').find(
											'.tagreply-update-form');
									correspondingForm.slideToggle();

								})
					});
			//tagreplyupdate - 댓글 수정 

			$('.tagreply-update-form').on("submit", function() {
				var seq_value = $(this).attr("selected_id");
				var UpdateContent = $('#updatecontent' + seq_value).val()
				
				 if (!UpdateContent) {
				        alert("댓글 내용을 입력해주세요.");
				        return false; // 댓글 내용이 없으므로 함수 종료
				    }
				$.ajax({
					url : "../tagReply/TagReply_update",
					data : {
						seq : seq_value,
						content : UpdateContent

					},
					success : function() {
						location.reload();
					}, // success
					error : function() {
						alert("실패!");
					} //error
				})
				//폼 제출 막기 
				return false;
			})

			$('.tagreplydelete').click(function() {
    var seq_value = $(this).attr("selected_id");
    var content_value = "삭제된 댓글입니다";
    
    
    // 사용자에게 삭제 여부를 확인하는 프롬프트 표시
    var confirmDelete = window.confirm("댓글을 삭제하시겠습니까?");
    
    if (confirmDelete) {
        $.ajax({
            url: "../tagReply/TagReply_delupdate",
            data: {
                seq: seq_value,
                content : content_value
              
            },
            success: function() {
                location.reload();
            },
            error: function() {
            	location.reload();
            } //error
        });
    }
});
//tagreplydelete -댓글 삭제 

			$('.retagreplydelete').click(function() {
    var seq_value = $(this).attr("selected_id");
    
    // 사용자에게 삭제 여부를 확인하는 프롬프트 표시
    var confirmDelete = window.confirm("댓글을 삭제하시겠습니까?");
    
    if (confirmDelete) {
        $.ajax({
            url: "../tagReply/TagReply_delete",
            data: {
                seq: seq_value
            },
            success: function() {
                location.reload();
            },
            error: function() {
                alert("실패!");
            } //error
        });
    }
});
//tagreplydelete -대댓글 삭제 
			
			
		});//$
	</script>