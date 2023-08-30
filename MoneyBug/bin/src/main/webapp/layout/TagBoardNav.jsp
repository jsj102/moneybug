<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
a {
	text-decoration: none;
}

.banner-text {
margin-top: 35px;
margin-bottom: 40px;
}

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

</head>
<body>
	<div class="banner-container" align="center">
	<div class="banner-text">
    <br>
    <a class="nav-link" href = "/moneybug/tagBoard/TagBoard_list?page=1"><h1>MoneyBug Community</h1></a>
	<p>나만의 이야기를 돈벌레 친구들과 같이 나눠요!</p>
	</div>
    <div class="tagrow" align="center">
    <div>
       <button type="button" class="btn btn-outline-primary">
        <a class="nav-link active" href="TagBoard_taglist?boardType=공과금&page=1">
           #공과금
        </a>
        </button> 
    </div>
    <div>
      <button type="button" class="btn btn-outline-primary">
        <a class="nav-link active" href="TagBoard_taglist?boardType=교통&page=1">
           #교통
        </a> 
        </button>
    </div>
    <div>
        <button type="button" class="btn btn-outline-primary">
        <a class="nav-link active" href="TagBoard_taglist?boardType=데이트&page=1">
           #데이트
        </a> 
        </button>
    </div>
    <div>
       <button type="button" class="btn btn-outline-primary">
        <a class="nav-link active" href="TagBoard_taglist?boardType=생활꿀팁&page=1">
           #생활꿀팁
        </a>
        </button> 
    </div>
    <div>
       <button type="button" class="btn btn-outline-primary">
        <a class="nav-link active" href="TagBoard_taglist?boardType=식비&page=1">
           #식비
        </a> 
        </button>
    </div>
    <div>
        <button type="button" class="btn btn-outline-primary">
        <a class="nav-link active" href="TagBoard_taglist?boardType=일상&page=1">
           #일상
        </a> 
        </button>
    </div>
    <div>
       <button type="button" class="btn btn-outline-primary">
        <a class="nav-link active" href="TagBoard_taglist?boardType=플렉스&page=1">
           #플렉스
        </a> 
        </button>
    </div>
   </div>
  
  <br>
  <br>
   
</div>

</body>
</html>