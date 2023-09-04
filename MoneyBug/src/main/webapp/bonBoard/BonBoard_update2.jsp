<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/layout/header.jsp"%>
<style>
   .banner-text {
	margin-top: 35px;
	margin-bottom: 40px;
}

.banner-container {
	height: 250px;
	background-color: #6cc3d5;
	background-position: center;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

.banner-text h1 {
	color: white;
	font-size: 60px;
}

.banner-text {
	color: white;
	font-size: 22px;
	text-align: center;
}
body{
background: #F9F5E7;
}
        .main-container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
            margin: 20px auto; /* 페이지 중앙 정렬을 위해 수정 */
            max-width: 800px; /* 최대 폭 지정 */
        }
        h1 {
            color: #A1C59E;
        }
        .form-control {
            border: 1px solid #dddddd;
            width: 100%; /* 폼 요소 너비 100%로 수정 */
        }
        .table-striped th {
            background-color: #eeeeee;
            text-align: center;
        }
        .btn-primary {
            background-color: #BCD6BA;
            border-color: #BCD6BA;
        }
        .btn-primary:hover {
            background-color: #C4D7B2;
            border-color: #C4D7B2;
        }
    </style>
</head>
<body>
   <div class="banner-container" align="center">
		<div class="banner-text">
			<br> <a class="nav-link"
				href="/moneybug/bonBoard/BonBoard_list?page=1"><h1>MoneyBug
					Buy or Not</h1></a>
			<p>살까? 말까? 지금 투표를 수정하고 있어요!</p>
		</div>
	</div>
<div class="main-container">
    <div class="row">
        <form method="post" action="/moneybug/bonBoard/BonBoard_update">
            <input type="hidden" name="seq" value="${param.seq}">
            <table class="table table-striped">
                <tbody>
                    <tr>
                        <td><input type="text" class="form-control" placeholder="글 제목" name="title" maxlength="50" value="${param.title}"></td>
                    </tr>
                    <tr>
                        <td>
                            <textarea class="form-control" placeholder="글 내용" name="content" maxlength="2048" style="height: 350px;">${param.content}</textarea>
                        </td>
                    </tr>
                </tbody>
            </table>
            <input type="submit" class="btn btn-primary pull-right" value="글 수정">
        </form>
         <a href="javascript:history.back()">뒤로 가기</a>
        
    </div>
</div>
<br>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
<%@ include file="/layout/footer.jsp" %>