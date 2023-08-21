<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../../../resources/layout/header.jsp"%>
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
	<br> <a
		href="TagBoard_update.jsp?seq=${tagBoardDTO.seq}&title=${tagBoardDTO.title}&content=${tagBoardDTO.content}">
		<button id="tagboardupdate" style="background: grey; color: white;">수정</button>
	</a>
	<button id="tagboarddelete" style="background: grey; color: white;">삭제</button>
	<a href="TagBoard_list?Page=1"><button
			style="background: grey; color: white;">목록</button></a> <br>
	<hr color="lavender">

	<div class="container">
		댓글 작성 : <input id="replycontent">
		<button id="tagreplyinsert">입력</button>
		<hr color="pink">


		<div class="tagreply-container" style="height: 450px; overflow: auto;">
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
							<c:when test="${id eq tagReplyDTO.writerId }">
								<button class="re-tagreply" selected_id="${tagReplyDTO.seq}"
									style="background: grey; color: white;">답글</button>
								<button class="tagreplyupdate" selected_id="${tagReplyDTO.seq}"
									style="background: grey; color: white;">수정</button>
								<button class="tagreplydelete" selected_id="${tagReplyDTO.seq}"
									style="background: grey; color: white;">삭제</button>
							</c:when>
							<c:otherwise>
								<button class="re-tagreply" selected_id="${tagReplyDTO.seq}"
									style="background: grey; color: white;">답글</button>
								<a href="javascript:">신고</a>
							</c:otherwise>
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
										<c:when test="${id eq tagReplyDTO.writerId }">
											<button class="re-tagreply" selected_id="${reply.seq}"
												style="background: grey; color: white;">답글</button>
											<button class="tagreplyupdate" selected_id="${reply.seq}"
												style="background: grey; color: white;">수정</button>
											<button class="tagreplydelete" selected_id="${reply.seq}"
												style="background: grey; color: white;">삭제</button>
										</c:when>
										<c:otherwise>
											<button class="re-tagreply" selected_id="${reply.seq}"
												style="background: grey; color: white;">답글</button>
											<a href="javascript:">신고</a>
										</c:otherwise>
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

		<hr color='red'>
		<br>

		<div class="result2"></div>
		<%
			int pages = (int) request.getAttribute("pages");
		for (int p = 1; p <= pages; p++) {
		%>
		<button style="background: lime; color: red; width: 50px;"
			class="pages"><%=p%></button>
		<!--id는 첫번째만 적용되기에 class=으로 설정한다.  -->
		<%
			}
		%>
	</div>
	<hr color="pink">
	<br> <a href="TagBoard_list?Page=1">글 전체 목록</a> <br>
</div>
<%@ include file="../../../resources/layout/footer.jsp"%>




<script type="text/javascript">

//페이지 로딩 시 이벤트 핸들러 등록
function registerEventHandlers() {
	$(document).ready(
			function() {
				$('.re-tagreply-form').hide(); // 페이지 로딩 시 폼을 숨김
				$('.tagreply-update-form').hide();
			});

	//re-tagreply - 대댓글 

	$('.re-tagreply-form').on("submit", function() {
		var seq_value = $(this).attr("selected_id");

		$.ajax({
			url : "../tagReply/TagReply_reinsert",
			data : {
				boardSeq : '${param.seq}',
				originSeq : seq_value,
				content : $('#reinsertcontent' + seq_value).val()

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
	}) //답글 
	
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
			}) // 댓글수정 

    // 삭제 버튼 클릭 시
    $('.tagreplydelete').click(function() {
        var seq_value = $(this).attr("selected_id");
        $.ajax({
            url: "../tagReply/TagReply_delete",
            data: {
                seq: seq_value
            },
            success: function() {
                alert("댓글이 삭제 되었습니다!");
                location.reload();
            },
            error: function() {
                alert("실패!");
            }
        });
    });
} // 댓글 페이징 ajax 처리 후 수정 답글 삭제 기능 




		$(function() {
			$('.pages').click(function() {
				$.ajax({
					url : "../tagReply/TagReply_list",
					data : {
						page : $(this).text(), 
						seq :${tagBoardDTO.seq}
					},
					success : function(result) { 
						console.log(result)
						$('.tagreply-container').html(result)
						$(document).ready(
								function() {
									registerEventHandlers();
									$('.re-tagreply-form').hide(); // 페이지 로딩 시 폼을 숨김

									$('.re-tagreply').click(
											function() {
												var correspondingForm = $(this).closest(
														'.tagreply').find(
														'.re-tagreply-form');
												correspondingForm.slideToggle();

											})
									$('.tagreply-update-form').hide(); // 페이지 로딩 시 폼을 숨김

									$('.tagreplyupdate').click(
											function() {
												var correspondingForm = $(this).closest(
														'.tagreply').find(
														'.tagreply-update-form');
												correspondingForm.slideToggle();

											})
											
								});
						
				        
				        
					},
					error : function() {
						alert('실패.@@@')
					}
				}) //ajax
		})
		//댓글 페이지네이션.

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
						content : $('#reinsertcontent' + seq_value).val()

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
			}) //tagreplydelete - 댓글 삭제 
		})//$
	</script>