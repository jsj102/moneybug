<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix='form' uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
#b1 { /* #은 아이디 선택!, 특정한 것 한 개만 선택! */
	color: red;
}

#b2 {
	background-color: black;
	color: white;
}
</style>

<script>
    // 이전에 선택한 말머리 값을 가져와서 선택되도록 설정
    var selectedBoardType = "${tagBoardDTO.boardType}";
    if (selectedBoardType) {
        var selectElement = document.getElementById("boardType");
        for (var i = 0; i < selectElement.options.length; i++) {
            if (selectElement.options[i].text === selectedBoardType) {
                selectElement.options[i].selected = true;
                break;
            }
        }
    }

    // 폼 제출 시 말머리 선택 여부를 확인하고 경고창 띄우기
    function validateForm() {
        var selectedValue = document.getElementById("boardType").value;
        if (selectedValue === "") {
            alert("말머리를 선택하세요.");
            return false; // 폼 제출 막기
        }
        return true; // 폼 제출 허용
    }
</script>


</head>
<body>
	<h3>커뮤니티 글 수정</h3>
	<br>

	<form action="TagBoard_update" name="tagboardupdate" method="post"
		enctype="multipart/form-data" onsubmit="return validateForm();">
		<input name="seq" value="${param.seq}" type="hidden">
		<table>

			<tr>
			<tr>
				<td>제목</td>
				<td><select id="boardType" name="boardType">
						<option value="">말머리</option>
						<option value="#교통"
							${tagBoardDTO.boardType == '#교통' ? 'selected' : ''}>교통</option>
						<option value="#식비"
							${tagBoardDTO.boardType == '#식비' ? 'selected' : ''}>식비</option>
						<option value="#공과금"
							${tagBoardDTO.boardType == '#공과금' ? 'selected' : ''}>공과금</option>
				</select> <input name="title" type="text" value="${param.title}"
					style="width: 507px; height: 25px; font-size: 15px;"></td>
			</tr>

			<tr>
				<td>내용</td>
				<td><input name="content" type="text" value="${param.content}"
					style="width: 620px; height: 200px; font-size: 15px;"></td>
			</tr>
			<tr>
				<td>첨부 이미지</td>
				<td><input type="text" name="img"
					placeholder="20Mb 이하 jpg, jpeg, png 파일만 업로드하세요"
					style="width: 500px; height: 25px; font-size: 15px;"> <input
					type="file" name="file"> <!-- 파일 선택 입력란 --></td>
			</tr>
			<tr>
				<td colspan="2">
					<button id="b2" type="submit">수정</button>
				</td>
			</tr>
		</table>
	</form>
	<!-- 입력한 값들이 서버(톰킷)으로 전달될때는 form태그 안에 있어야 함. -->
	<!-- 보충내용: <input name="data"> -->






</body>
</html>