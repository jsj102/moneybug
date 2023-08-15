<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>TagBoard_One</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
					content : $('#replycontent').val()

				},
				success : function(views_result) {
					$('#result').append(views_result)
				},
				error : function() {
					alert("실패!")
				} //error
			})
		}) //tagreplyinsert - 댓글 추가 
		
		
				
		$('.tagreplyupdate').click(function() {
			$(this).find(".tagreply-update-form");
			
		}) //tagreplyupdate - 댓글 수정 
		
		
		
		$(".tagreply-update-form").on("submit", function(){
			var url=$(this).attr("action");
			var data=$(this).serialize();
			var $this=$(this);
			
			$.ajax({
				url:url,
				method:"post",
				data:data,
				success:function(responseData){
					if(responseData.isSuccess){
						//폼을 안보이게 한다 
						$this.slideUp(200);
						//폼에 입력한 내용 읽어오기
						var content=$this.find("textarea").val();
						//pre 요소에 수정 반영하기 
						$this.parent().find("pre").text(content);
					}
				}
			});
			//폼 제출 막기 
			return false;
		});
		
		

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

</head>
<body>
	<h3>커뮤니티</h3>


	[${tagBoardDTO.boardType}] ${tagBoardDTO.title}
	조회수:${tagBoardDTO.views}
	<br>
	<fmt:formatDate pattern="yyyy-MM-dd HH:mm"
		value="${tagBoardDTO.createAt}" />${tagBoardDTO.writerId}
	<hr color="lavender">

	<br> ${tagBoardDTO.content}
	<br>
	<br>
	<a
		href="TagBoard_update.jsp?seq=${tagBoardDTO.seq}&title=${tagBoardDTO.title}&content=${tagBoardDTO.content}">
		<button id="tagboardupdate" style="background: grey; color: white;">수정</button>
	</a>
	<button id="tagboarddelete" style="background: grey; color: white;">삭제</button>
	<a href="TagBoard_list"><button id="tagboarddelete" style="background: grey; color: white;">목록</button></a>
	<br>
	<hr color="lavender">

	댓글 작성 :
	<input id="replycontent">
	<button id="tagreplyinsert">입력</button>
	<hr color="pink">
	<div id="result"
		style="background: lightyellow; height: 700px; width: 1000px; overflow: auto;">
		<c:forEach items="${tagreplylist}" var="tagReplyDTO">
				<br>
				${tagReplyDTO.writerId}
				<br> 
				${tagReplyDTO.content} 
				
				<br> 
				<p style="font-size: 12px;">
					<fmt:formatDate value="${tagReplyDTO.createAt}"
					pattern="yyyy-MM-dd HH:mm" />
				</p>
				<button class= class="tagreplyupdate" 
				style="background: grey; color: white;">수정</button>
				<button class="tagreplydelete"  selected_id="${tagReplyDTO.seq}"
				style="background: grey; color: white;">삭제</button>
				
				<c:if test="${id eq tagReplyDTO.writerId }">
					<form class="tagreply-update-form" action="../tagReply/TagReply_update" method="post">
						<input type="hidden" name="seq" value="${tagReplyDTO.seq }" />
						<textarea name="content">${tagReplyDTO.content}</textarea>
						<button type="submit">수정</button>
					</form>
				</c:if>
				
				
			<br>
			</c:forEach>

	</div>
	<hr color="pink">
	<br>
	<a href="TagBoard_list">글 전체 목록</a>
	<br>
</body>
</html>