<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.multi.moneybug.tagBoard.TagBoardDAO"%>
<%@ include file="../../../resources/layout/header.jsp"%>
<%@ include file="../../../resources/layout/TagBoardNav.jsp"%>
<div class="container">
	<h3>커뮤니티</h3>


	[${tagBoardDTO.boardType}] ${tagBoardDTO.title}
	조회수:${tagBoardDTO.views} <br>
	<fmt:formatDate pattern="yyyy-MM-dd HH:mm"
		value="${tagBoardDTO.createAt}" />${tagBoardDTO.writerId}
	<hr color="lavender">

	<br> ${tagBoardDTO.content} <br>
	<c:if test="${tagBoardDTO.image ne null}">
		<img src="../resources/upload/${tagBoardDTO.image}" width="300">
	</c:if>
	<br>
	<c:choose>
		<c:when test="${sessionScope.userNickname eq tagBoardDTO.writerId }">
			<a
				href="TagBoard_update.jsp?seq=${tagBoardDTO.seq}&title=${tagBoardDTO.title}&content=${tagBoardDTO.content}&boardType=${tagBoardDTO.boardType}">
				<button id="tagboardupdate" style="background: grey; color: white;">수정</button>
			</a>
			<button id="tagboarddelete" style="background: grey; color: white;">삭제</button>
			<a href="TagBoard_list?Page=1"><button
					style="background: grey; color: white;">목록</button></a>
			<br>
		</c:when>
		<c:otherwise>
			<a href="TagBoard_list?Page=1"><button
					style="background: grey; color: white;">목록</button></a>
			<br>
		</c:otherwise>
	</c:choose>

	<hr color="lavender">

	<div class="container">
		댓글 작성 : <input id="replycontent">
		<button id="tagreplyinsert">입력</button>
		<hr color="pink">


		<div class="tagreply-container" style="height: 800px; overflow: auto;">
			<c:forEach items="${tagreplylist}" var="tagReplyDTO">
				<c:if test="${tagReplyDTO.replyLevel eq 0}">
					<div class="tagreply original-reply">
						<br> ${tagReplyDTO.writerId} <br> ${tagReplyDTO.content}

						<br>
						<p style="font-size: 12px;">
							<fmt:formatDate value="${tagReplyDTO.createAt}"
								pattern="yyyy-MM-dd HH:mm" />
						</p>

						<%-- 로그인된 아이디와 댓글의 작성자가 같으면 --%>
						<c:choose>
							<c:when
								test="${sessionScope.userNickname eq tagReplyDTO.writerId }">
								<button class="re-tagreply" selected_id="${tagReplyDTO.seq}"
									style="background: grey; color: white;">답글</button>
								<button class="tagreplyupdate" selected_id="${tagReplyDTO.seq}"
									style="background: grey; color: white;">수정</button>
								<button class="tagreplydelete" selected_id="${tagReplyDTO.seq}"
									style="background: grey; color: white;">삭제</button>
							</c:when>
							<c:when
								test="${not empty sessionScope.userNickname and !sessionScope.userNickname.equals(tagReplyDTO.writerId)}">
								<button class="re-tagreply" selected_id="${tagReplyDTO.seq}"
									style="background: grey; color: white;">답글</button>
							</c:when>

						</c:choose>


						<form name="form" class="tagreply-update-form"
							selected_id="${tagReplyDTO.seq}">
							<textarea id="updatecontent${tagReplyDTO.seq}">${tagReplyDTO.content}</textarea>
							<button type="submit" style="background: grey; color: white;">수정</button>
						</form>



						<form name="form" class="re-tagreply-form"
							selected_id="${tagReplyDTO.seq}">
							<textarea id="reinsertcontent${tagReplyDTO.seq}"></textarea>
							<button type="submit" style="background: grey; color: white;">등록</button>
						</form>
						<br>
					</div>

					<!-- 대댓글 표시 -->
					<div>
						<c:forEach items="${tagreplylist}" var="reply">
							<c:if
								test="${reply.replyLevel eq 1 and reply.groupSeq eq tagReplyDTO.groupSeq}">
								<div class="tagreply indented-reply" style="margin-left: 20px;">
									<br> ${reply.writerId} <br> ${reply.content} <br>
									<p style="font-size: 12px;">
										<fmt:formatDate value="${reply.createAt}"
											pattern="yyyy-MM-dd HH:mm" />
									</p>

									<%-- 로그인된 아이디와 댓글의 작성자가 같으면 --%>
									<c:choose>
										<c:when test="${sessionScope.userNickname eq reply.writerId }">
											<button class="re-tagreply" selected_id="${reply.seq}"
												style="background: grey; color: white;">답글</button>
											<button class="tagreplyupdate" selected_id="${reply.seq}"
												style="background: grey; color: white;">수정</button>
											<button class="tagreplydelete" selected_id="${reply.seq}"
												style="background: grey; color: white;">삭제</button>
										</c:when>
										<c:when
											test="${not empty sessionScope.userNickname and !sessionScope.userNickname.equals(reply.writerId)}">
											<button class="re-tagreply" selected_id="${reply.seq}"
												style="background: grey; color: white;">답글</button>
										</c:when>
									</c:choose>

									<form name="form" class="tagreply-update-form"
										selected_id="${reply.seq}">
										<textarea id="updatecontent${reply.seq}">${reply.content}</textarea>
										<button type="submit" style="background: grey; color: white;">수정</button>
									</form>



									<form name="form" class="re-tagreply-form"
										selected_id="${reply.seq}">
										<textarea id="reinsertcontent${reply.seq}"></textarea>
										<button type="submit" style="background: grey; color: white;">등록</button>
									</form>
									<br>

								</div>



							</c:if>
						</c:forEach>
					</div>





				</c:if>
			</c:forEach>
		</div>




	</div>
	<hr color="pink">
	
	<div class="plmi">
	<table class="table table-sm mx-auto">
		<thead>
			<tr>
				<th>순서</th>
				<th>제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${plmilist}" var="tagBoardDTO">
				<tr>
					<td>
					<c:if test="${tagBoardDTO.seq > param.seq}">
					다음 글 
					</c:if>
					<c:if test="${tagBoardDTO.seq < param.seq}">
					이전 글 
					</c:if>
					</td>
					<td>[${tagBoardDTO.boardType}] <a href="TagBoard_one?seq=${tagBoardDTO.seq}">${tagBoardDTO.title}</a></td>
					<td>${tagBoardDTO.writerId}</td>
					<td>${tagBoardDTO.views}</td>
					<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
							value="${tagBoardDTO.createAt}" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	
	</div>
	<hr color="pink">
	<br> <a href="TagBoard_list?Page=1">글 전체 목록</a> <br>
</div>
<%@ include file="../../../resources/layout/footer.jsp"%>




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
				$.ajax({
					url : "TagBoard_delete",
					data : {
						seq : "${param.seq}"
					},
					success : function() {
						alert("게시글이 삭제 되었습니다!");
						location.href = "TagBoard_list?Page=1";
					},
					error : function() {
						alert("실패!");
					} //error
				})
			}) //tagboarddelete - 게시글 지우기 

			$('#tagreplyinsert').click(function() {
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
						content : $('#replycontent').val(),
						 writerId: '${sessionScope.userNickname}'

					},
					success : function() {
						alert("댓글을 등록했습니다.")
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

				$.ajax({
					url : "../tagReply/TagReply_reinsert",
					data : {
						boardSeq : '${param.seq}',
						originSeq : seq_value,
						content : $('#reinsertcontent' + seq_value).val(),
						 writerId: '${sessionScope.userNickname}'

					},
					success : function() {
						alert("댓글을 등록했습니다.")
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
				$.ajax({
					url : "../tagReply/TagReply_update",
					data : {
						seq : seq_value,
						content : $('#updatecontent' + seq_value).val()

					},
					success : function() {
						alert('댓글이 수정되었습니다.');
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

				$.ajax({
					url : "../tagReply/TagReply_delete",
					data : {
						seq : seq_value
					},
					success : function() {
						alert("댓글이 삭제 되었습니다!");
						location.reload();
					},
					error : function() {
						alert("실패!");
					} //error
				})
			})//tagreplydelete - 댓글 삭제 
			
			
		});//$
	</script>