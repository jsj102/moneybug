<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<title>돈벌레 닉네임 정하기</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
	body {
		height: 150vh;
		background: linear-gradient(to bottom, #96A0FF, #9669FF);
		display: flex;
		justify-content: center;
	}
	
	.page-container {
		margin-top: 100px;
		margin-bottom: 100px;
		width: 50%;
		align-items: center;
		flex-direction: column;
	}
	
	.info-container {
		padding: 40px;
		justify-content: center;
		box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
		background-color: white;
		border-radius: 20px;
	}
	
	.card-body {
		padding-left: 50px;
		padding-right: 50px;
	}
	
	form {
		display: flex;
		flex-direction: column;
	}
	
	h1 {
		font-size: 60px;
		font-weight: 100;
		text-align: center;
		color: white;
	}
	
	.nick-container {
		padding: 50px;
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	
	.btn-custom {
		margin-top: 30px;
		background-color: #764dff;
		color: white;
		width: 70%;
		align-self: center; /* Add this line */
	}
</style>
</head>
<body>
	<div class="page-container">
		<h1>MoneyBug MyPage</h1>

		<div class="info-container">
			<div class="card">
				<div class="card-header text-center">
					닉네임만 수정하실 수 있습니다.<br /> 닉네임은 최초 가입시 반드시 입력해야합니다.<br /> 글쓰기 및 돈벌레
					미션에 노출됩니다.
				</div>
				<div class="card-body">
					<div class="form-group">
						<label for="email">회원가입 이메일:</label> <input type="email"
							id="email" name="email" readonly class="form-control"
							value="${email}" />
					</div>
					<div class="form-group">
						<label for="userName">회원 이름:</label> <input type="text"
							id="userName" name="userName" readonly class="form-control"
							value="${userName}" />
					</div>
					<div class="form-group">
						<label for="userLevel">회원 등급:</label> <input type="text"
							id="userLevel" name="userLevel" readonly class="form-control"
							value="${userLevel}" />
					</div>
					<div class="form-group">
						<label for="xpPoint">총 경험치:</label> <input type="text"
							id="xpPoint" name="xpPoint" readonly class="form-control"
							value="${xpPoint}" />
					</div>

					<form action="myInfoUpdate.do" method="post">
						<label for="oldNickname">기존 닉네임: (신규일경우, 아래에 새로 등록해주세요.)</label> <input
							type="text" readonly class="form-control" value="${userNickname}" />
						<label for="newNickname">새로운 닉네임:</label> <input type="text"
							id="newNickname" name="userNickname" required class="form-control" />
						<button type="submit" class="btn btn-custom btn-lg">수정하기</button>
					</form>
					
				</div>

			</div>
		</div>
	</div>
</body>
</html>
