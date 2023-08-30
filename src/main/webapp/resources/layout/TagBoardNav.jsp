<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
    /* div 요소를 가로로 가운데 정렬하기 위한 스타일 */
    .tagrow {
        display: flex;
        justify-content: center;
    }

    /* 각 div 요소 간의 간격을 조절하려면 margin 값을 조절하세요 */
    .tagrow > div {
        margin: 0 10px; /* 원하는 간격으로 조절 가능 */
    }
</style>
<h3>커뮤니티</h3>
</head>
<body>
	<div id="nav" align="center">
    <br>
    <h6>태그</h6>
    <br>
    <div class="tagrow" align="center">
    <div>
        <!-- 네비게이션 버튼 클릭 시 boardType 값을 URL 매개변수로 전달 -->
        <a href="TagBoard_taglist?boardType=공과금&page=1">
           #공과금
        </a> 
    </div>
    <div>
        <!-- 네비게이션 버튼 클릭 시 boardType 값을 URL 매개변수로 전달 -->
        <a href="TagBoard_taglist?boardType=교통&page=1">
           #교통
        </a> 
    </div>
    <div>
        <!-- 네비게이션 버튼 클릭 시 boardType 값을 URL 매개변수로 전달 -->
        <a href="TagBoard_taglist?boardType=데이트&page=1">
           #데이트
        </a> 
    </div>
    <div>
        <!-- 네비게이션 버튼 클릭 시 boardType 값을 URL 매개변수로 전달 -->
        <a href="TagBoard_taglist?boardType=생활꿀팁&page=1">
           #생활꿀팁
        </a> 
    </div>
    <div>
        <!-- 네비게이션 버튼 클릭 시 boardType 값을 URL 매개변수로 전달 -->
        <a href="TagBoard_taglist?boardType=식비&page=1">
           #식비
        </a> 
    </div>
    <div>
        <!-- 네비게이션 버튼 클릭 시 boardType 값을 URL 매개변수로 전달 -->
        <a href="TagBoard_taglist?boardType=일상&page=1">
           #일상
        </a> 
    </div>
    <div>
        <!-- 네비게이션 버튼 클릭 시 boardType 값을 URL 매개변수로 전달 -->
        <a href="TagBoard_taglist?boardType=플렉스&page=1">
           #플렉스
        </a> 
    </div>
   </div>
  <br>
  <br>
   
</div>

</body>
</html>