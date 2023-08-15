<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
    <title>BonBoard_insert</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h1>게시글 작성</h1>

    <form id="writeForm">
        유저 이름: <input type="text" name="username" required><br>
        제목: <input type="text" name="title" required><br>
        내용: <textarea name="content" rows="4" cols="50" required></textarea><br>
        상품 링크: <input type="text" name="productLink" required><br> <!-- required 추가 -->
        <input type="submit" value="작성 완료">   
    </form>

    <div id="result"></div>

    <script>
        $(document).ready(function () {
            $("#writeForm").submit(function (event) {
                if (!event.target.checkValidity()) {
                    // 유효성 검사에 실패하면 브라우저에서 제공하는 기본 알림을 사용
                    return;
                }
            	 
                event.preventDefault(); // 폼 기본 제출 동작 막기

                // 폼 데이터 가져오기
                let formData = $(this).serialize();

                $.ajax({
                    type: "POST",
                    url: "BonBoard_insert",
                    data: formData,
                    success: function (response) {
                        // 서버 응답에서 생성된 게시물 정보를 추출
                        let createdBoard = response;

                        // 게시물 정보를 화면에 추가하거나 갱신하는 로직을 수행
                        let newPostElement = $("<div>").text(createdBoard.title);
                        $("#result").html("게시물이 성공적으로 작성되었습니다."); // 결과 출력

                        // 결과를 result 요소에 출력 (필요하다면)
                        let boardContainer = $("#boardContainer"); // 게시물 컨테이너 선택
                        let boardTitleElement = $("<h2>").text(createdBoard.title); // 제목 추가
                        let boardContentElement = $("<p>").text(createdBoard.content); // 내용 추가
                        let boardLinkElement = $("<a>").attr("href", createdBoard.productLink).text("링크"); // 링크 추가

                        // 추가된 게시물을 게시물 컨테이너에 삽입
                        boardContainer.append(boardTitleElement);
                        boardContainer.append(boardContentElement);
                        boardContainer.append(boardLinkElement);
                    },
                    error: function () {
                        alert("서버와 통신중 오류 발생");
                    }
                });
            });
        });
    </script>
</body>
</html>
