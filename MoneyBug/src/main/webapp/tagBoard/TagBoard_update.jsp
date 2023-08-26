<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix='form' uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../../resources/layout/header.jsp"%>


<h3>커뮤니티 글 수정</h3>
<br>

<form action="TagBoard_update" name="tagboardupdate" method="post"
	enctype="multipart/form-data" onsubmit="return validateForm();">
	<input name="seq" value="${param.seq}" type="hidden">
	<table>


		<tr>

			<td>제목</td>
			
			<td><select id="boardType" name="boardType">
					<option value="공과금"
						<c:if test="${param.boardType == '공과금'}">selected</c:if>>공과금</option>
					<option value="교통"
						<c:if test="${param.boardType == '교통'}">selected</c:if>>교통</option>
					<option value="데이트"
						<c:if test="${param.boardType == '데이트'}">selected</c:if>>공과금</option>
					<option value="생활꿀팁"
						<c:if test="${param.boardType == '생활꿀팁'}">selected</c:if>>공과금</option>
					<option value="식비"
						<c:if test="${param.boardType == '식비'}">selected</c:if>>식비</option>
					<option value="일상"
						<c:if test="${param.boardType == '일상'}">selected</c:if>>공과금</option>
					<option value="플렉스"
						<c:if test="${param.boardType == '플렉스'}">selected</c:if>>공과금</option>
			</select> <input id="title" name="title" type="text" value="${param.title}"
				style="width: 507px; height: 25px; font-size: 15px;"></td>


		</tr>

		<tr>
			<td>내용</td>
			<td><input id="content" name="content" type="text"
				value="${param.content}"
				style="width: 620px; height: 200px; font-size: 15px;"></td>
		</tr>
		<tr>
			<td>첨부파일
				<button type="button" id="add_file">추가</button>
			</td>
			<td class="file_area">
				<div class="uploadfileform">
					<input type="file" name="file">
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<button id="update">수정</button>
				<button id="cancel">취소</button>
			</td>
		</tr>
	</table>
</form>

<%@ include file="../../resources/layout/footer.jsp"%>

<script type="text/javascript">
	$(document).ready(function() {

		var selectedBoardType = "${tagBoardDTO.boardType}";

		$("#boardType option").each(function() {
			if ($(this).val() === selectedBoardType) {
				$(this).prop("selected", true);
			}
		});
	});

	$('#add_file')
			.click(
					function() {
						$('.file_area')
								.append(
										'<div class="uploadfileform">'
												+ '<input type="file" name="file">'
												+ ' <button type="button" class="delete_file">삭제</button>'
												+ '</div>');
					});

	$('.file_area').on('click', '.delete_file', function() {
		$(this).closest('div').remove();
	});

	$('#cancel').click(function() {
		location.href = "TagBoard_one?seq=${param.seq}";
		return false;
	});

	$('#update').click(function() {
		var selectedValue1 = document.getElementById("boardType").value;
		var selectedValue2 = document.getElementById("title").value;
		var selectedValue3 = document.getElementById("content").value;
		if (selectedValue1 === "") {
			alert("말머리를 선택하세요.");
			return false; // 폼 제출 막기
		}
		if (selectedValue2 === "") {
			alert("제목을 입력하세요.");
			return false; // 폼 제출 막기
		}
		if (selectedValue3 === "") {
			alert("내용을 입력하세요.");
			return false; // 폼 제출 막기
		}
		return true; // 폼 제출 허용
	});
</script>