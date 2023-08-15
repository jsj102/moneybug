<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body background="lime">
이미지 업로드 성공!!<img src="resources/upload/${savedName}" width=300 height=300> <br> <br>
<hr color="red">
등록된 영화아이디는 ${movieVO.movie_id} <br>
등록된 영화타이틀은 ${movieVO.title} <br>
등록된 영화링크는 ${movieVO.link} <br>

<a href="movie_one?movie_id=${movieVO.movie_id}">등록한 영화 하나 확인</a>
</body>
</html>