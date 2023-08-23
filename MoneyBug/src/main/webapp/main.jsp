<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시판 메인</title>
<!-- 부트스트랩 CSS -->
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.5.3/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
    crossorigin="anonymous">

<link rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script
    src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
    .navbar-dark .navbar-nav .nav-link {
        color: #000;
    }

    .main-content {
        background-color: #9669FF;
        padding: 20px;
        border-radius: 10px;
    }

    .btn-custom {
        background-color: #2AD2D3;
        color: #000;
    }

    .btn-custom:hover {
        background-color: #FFDF89;
        color: #000;
    }

    .btn-custom2 {
        background-color: #96A0FF;
        color: #000;
    }

    .btn-custom2:hover {
        background-color: #2AD2D3;
        color: #000;
    }

    .btn-custom3 {
        background-color: #D298FF;
        color: #000;
    }

    .btn-custom3:hover {
        background-color: #CEC2FF;
        color: #000;
    }
    
    .btn-custom4 {
        background-color: #FFDF89;
        color: #000;
    }

    .btn-custom4:hover {
        background-color: #2AD2D3;
        color: #000;
    }

    .btn-custom5 {
        background-color: #E4D5FF;
        color: #000;
    }

    .btn-custom5:hover {
        background-color: #2AD2D3;
        color: #000;
    }

    .btn-custom6 {
        background-color: #D298FF;
        color: #000;
    }

    .btn-custom6:hover {
        background-color: #CEC2FF;
        color: #000;
    }
    
    .text-right {
        text-align: right;
    }
</style>
</head>

<body style="background-color: #9669FF;">


    <!-- Main Content -->
    <div class="container mt-4">
        <h1>게시판 메인 페이지</h1>
        <div class="row">
            <div class="col-md-6 text-right">
                <a href="#" class="btn btn-custom btn-lg btn-block mb-3">커뮤니티</a>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 text-right">
                <a href="#" class="btn btn-custom2 btn-lg btn-block mb-3">가계부</a>
            </div>
            <div class="col-md-6 text-right">
                <a href="#" class="btn btn-custom3 btn-lg btn-block mb-3">살까말까</a>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 text-right">
                <a href="#" class="btn btn-custom4 btn-lg btn-block mb-3">미션</a>
            </div>
            <div class="col-md-6 text-right">
                <a href="#" class="btn btn-custom5 btn-lg btn-block mb-3">고객센터</a>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 text-right">
                <a href="#" class="btn btn-custom6 btn-lg btn-block mb-3">이벤트</a>
            </div>
            <div class="col-md-6 text-right">
                <a href="product/shoplist?page=1" class="btn btn-custom5 btn-lg btn-block mb-3">굿즈 판매</a>
            </div>
        </div>
    </div>
    
     <div class="main-content">
           <% 
        String userNickname = (String) session.getAttribute("userNickname");

        if (userNickname != null && !userNickname.isEmpty()) {
            %>
            <p>안녕하세요, <%= userNickname %>님. 사용자 정보를 확인하세요.</p>
            <a href="#" class="btn btn-custom btn-lg btn-block mb-3">사용자 정보 확인</a>
            <a href="/moneybug/logout.do" class="btn btn-custom btn-lg btn-block mb-3">로그아웃</a>
            <%
        } else {
            %>
            <p>사용자 정보가 없습니다.</p>
            <a href="login.jsp" class="btn btn-custom btn-lg btn-block mb-3">로그인 페이지로 이동</a>
            <%
        }
        %>
        </div>
        


</body>
</html>
