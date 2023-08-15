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
    // 폼 제출 시 필수 입력 필드 검사 및 경고창 띄우기
    function validateForm() {
        var title = document.getElementById("title").value;
        var content = document.getElementById("content").value;
        var selectedValue = document.getElementById("boardType").value;

        if (!title) {
            alert("제목을 입력하세요.");
            return false; // 폼 제출 막기
        }

        if (!content) {
            alert("내용을 입력하세요.");
            return false; // 폼 제출 막기
        }

        if (selectedValue === "") {
            alert("말머리를 선택하세요.");
            return false; // 폼 제출 막기
        }

        return true; // 폼 제출 허용
    }
</script>



</head>
<body>
	<h3>커뮤니티 글쓰기</h3>
	<br>

	<form action="TagBoard_insert" id="form" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
		<table>

			<tr>
				<td>제목</td>
				<td>
				
						<select id="boardType" name="boardType">
							<option value="">말머리</option>
							<option value="#교통">교통</option>
							<option value="#식비">식비</option>
							<option value="#공과금">공과금</option>
						</select>
					<input name="title" type="text" placeholder=" 제목을 입력하세요.."
					style="width: 507px; height: 25px; font-size: 15px;">
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td><input name="content" type="text" placeholder=" 내용을 입력하세요.."
					style="width: 620px; height: 200px; font-size: 15px;"></td>
			</tr>
			<tr>
				<td>첨부 이미지</td>
				<td><input name="img" 
					placeholder="  20Mb 이하 jpg, jpeg, png 파일만 업로드하세요"
					style="width: 500px; height: 25px; font-size: 15px;">
					<input type="file" name="file"></td>
			</tr>
			<tr>
				<td colspan="2">
					<button id="b2">글 쓰기</button>
					<a href = "TagBoard_list"><button id="b2">취소</button></a>
				</td>
			</tr>
		</table>
		<!-- 입력한 값들이 서버(톰킷)으로 전달될때는 form태그 안에 있어야 함. -->
		<!-- 보충내용: <input name="data"> -->
	</form>






</body>
</html>