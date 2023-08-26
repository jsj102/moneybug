<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<div id="nav" align="center">
    <br>
    <h6>태그</h6>
    <br>
    <div>
        <!-- 네비게이션 버튼 클릭 시 boardType 값을 URL 매개변수로 전달 -->
        <a href="TagBoard_taglist?boardType=교통&page=1">
            <button class="dropbtn btn btn-dark">#교통</button>
        </a> 
    </div>
    <br>
    <div>
        <a href="TagBoard_taglist?boardType=식비&page=1">
            <button class="dropbtn btn btn-dark">#식비</button>
        </a> 
    </div>
    <br>
    <div>
        <a href="TagBoard_taglist?boardType=공과금&page=1">
            <button class="dropbtn btn btn-dark">#공과금</button>
        </a> 
    </div>
    <br>
</div>

</body>
</html>