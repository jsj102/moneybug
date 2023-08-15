<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../../../resources/layout/header.jsp"%>
<div class="container">
	<h3>커뮤니티</h3>


	[${tagBoardDTO.boardType}] ${tagBoardDTO.title}
	조회수:${tagBoardDTO.views}
	<br>
	<fmt:formatDate pattern="yyyy-MM-dd HH:mm"
		value="${tagBoardDTO.createAt}" />${tagBoardDTO.writerId}
	<hr color="lavender">

	<br> ${tagBoardDTO.content}
	<br>
		<c:if test="${tagBoardDTO.image ne null}">
    <img src="../resources/upload/${tagBoardDTO.image}" width="300">
</c:if>
	<br>
	<a
		href="TagBoard_update.jsp?seq=${tagBoardDTO.seq}&title=${tagBoardDTO.title}&content=${tagBoardDTO.content}">
		<button id="tagboardupdate" style="background: grey; color: white;">수정</button>
	</a>
	<button id="tagboarddelete" style="background: grey; color: white;">삭제</button>
	<a href="TagBoard_list"><button id="tagboarddelete"
			style="background: grey; color: white;">목록</button></a>
	<br>
	<hr color="lavender">

<div class="container">
	댓글 작성 :
	<input id="replycontent">
	<button id="tagreplyinsert">입력</button>
	<hr color="pink">


	<div id="result"
		style=" height: 400px; overflow: auto;">
		<c:forEach items="${tagreplylist}" var="tagReplyDTO">
			<c:if test="${tagReplyDTO.replyLevel eq 0}">
				<br>
				${tagReplyDTO.writerId}
				<br> 
				${tagReplyDTO.content} 
				
				<br>
				<p style="font-size: 12px;">
					<fmt:formatDate value="${tagReplyDTO.createAt}"
						pattern="yyyy-MM-dd HH:mm" />
				</p>

				<%-- 로그인된 아이디와 댓글의 작성자가 같으면 --%>
				<c:choose>
					<c:when test="${id eq tagReplyDTO.writerId }">
						<button class="re-tagreply"
							style="background: grey; color: white;">답글</button>
						<button class="tagreplyupdate" selected_id="${tagReplyDTO.seq}"
							style="background: grey; color: white;">수정</button>
						<button class="tagreplydelete" selected_id="${tagReplyDTO.seq}"
							style="background: grey; color: white;">삭제</button>
					</c:when>
					<c:otherwise>
						<button class="re-tagreply"
							style="background: grey; color: white;">답글</button>
						<a href="javascript:">신고</a>
					</c:otherwise>
				</c:choose>

				<%-- 로그인된 아이디와 댓글의 작성자가 같으면 --%>
				<c:if test="${id eq tagReplyDTO.writerId }">
					<form  name = "form" class="tagreply-update-form" selected_id="${tagReplyDTO.seq}">
						<textarea id="updatecontent${tagReplyDTO.seq}">${tagReplyDTO.content}</textarea>
						<button type="submit" style="background: grey; color: white;">수정</button>
					</form>

				</c:if>

				<form class="re-tagreply-form">
					<input type="hidden" id="originSeq" value="${tagReplyDTO.seq}" />
					<textarea id="reinsertcontent"></textarea>
					<button type="submit" style="background: grey; color: white;">등록
					</button>
				</form>
				<br>


				<!-- 대댓글 표시 -->
				<div>
				<c:forEach items="${tagreplylist}" var="reply">
					<c:if
						test="${reply.replyLevel eq 1 and reply.originSeq eq tagReplyDTO.seq}">
						<br>
       				  ${reply.writerId}
        				<br> 
      				  ${reply.content} 
        
       				 <br>
						<p style="font-size: 12px;">
							<fmt:formatDate value="${reply.createAt}"
								pattern="yyyy-MM-dd HH:mm" />
						</p>

						<%-- 로그인된 아이디와 댓글의 작성자가 같으면 --%>
						<c:choose>
							<c:when test="${id eq reply.writerId }">

								<button class="tagreplyupdate"
									style="background: grey; color: white;">수정</button>
								<button class="tagreplydelete" selected_id="${reply.seq}"
									style="background: grey; color: white;">삭제</button>
							</c:when>
							<c:otherwise>

								<a href="javascript:">신고</a>
							</c:otherwise>
						</c:choose>

						<%-- 로그인된 아이디와 댓글의 작성자가 같으면 --%>
						<c:if test="${id eq reply.writerId }">
							<form class="tagreply-update-form">
								<input type="hidden" id="re-seq" value="${reply.seq}" />
								<textarea id="re-updatecontent">${reply.content}</textarea>
								<button type="submit" style="background: grey; color: white;">수정</button>
							</form>

						</c:if>


						<br>


					</c:if>
				</c:forEach>
				</div>





			</c:if>
		</c:forEach>
		</div>

	</div>
	<hr color="pink">
	<br>
	<a href="TagBoard_list">글 전체 목록</a>
	<br>

	<%@ include file="../../../resources/layout/footer.jsp"%>




<script type="text/javascript">
	$(function() {

		$('#tagboarddelete').click(function() {
			$.ajax({
				url : "TagBoard_delete",
				data : {
					seq : "${param.seq}"
				},
				success : function() {
					alert("게시글이 삭제 되었습니다!");
					location.href = "TagBoard_list";
				},
				error : function() {
					alert("실패!");
				} //error
			})
		}) //tagboarddelete - 게시글 지우기 

		$('#tagreplyinsert').click(function() {
			$.ajax({
				url : "../tagReply/TagReply_insert",
				data : {
					boardSeq : '${param.seq}',
					content : $('#replycontent').val(),

				},
				success : function() {
					alert("댓글을 등록했습니다.")
					location.reload();
				},
				error : function() {
					alert("실패!")
				} //error
			})
		}) //tagreplyinsert - 댓글 추가 

		$(document).ready(function() {
			$('.re-tagreply-form').hide(); // 페이지 로딩 시 폼을 숨김

			$('.re-tagreply').click(function() {
				$('.re-tagreply-form').slideToggle();

			})
		});

		//re-tagreply - 대댓글 

		$('.re-tagreply-form').on(
				"submit",
				function() {
					$.ajax({
						url : "../tagReply/TagReply_reinsert",
						data : {
							boardSeq : '${param.seq}',
							originSeq : $('#originSeq').val(),
							content : $('#reinsertcontent').val()
									|| $('#re-reinsertcontent').val()

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

		$(document).ready(function() {
			$('.tagreply-update-form').hide(); // 페이지 로딩 시 폼을 숨김

			$('.tagreplyupdate').click(function() {
				$('.tagreply-update-form').slideToggle();

			})
		});
		//tagreplyupdate - 댓글 수정 

		$('.tagreply-update-form').on(
				"submit",
				function() {
					var seq_value = $(this).attr("selected_id");
					alert(seq_value);
					$.ajax({
						url : "../tagReply/TagReply_update",
						data : {
							seq : seq_value ,
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
		}) //tagreplydelete - 댓글 삭제 
	})//$
</script>