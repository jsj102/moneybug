<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>



<title>bonBoard_list</title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
@font-face {
	font-family: 'HakgyoansimWoojuR';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2307-2@1.0/HakgyoansimWoojuR.woff2')
		format('woff2');
	font-weight: normal;
	font-style: normal;
}

.purple-border {
	border: 2px solid purple;
	padding: 10px;
	text-align: center;
	color: white;
	background-color: black;
}

body {
	background: linear-gradient(to bottom, #CA61FF, hsl(265, 100%, 72%),
		#945FFF);
	font-family: 'HakgyoansimWoojuR';
}

.gradient-text {
	background: linear-gradient(to right, #FF3EEC, #1499FF);
	-webkit-background-clip: text;
	color: transparent;
	font-weight: bold;
	font-size: 30px;
}

.container {
	background-color: rgb(217, 195, 255);
	border-radius: 15px;
	padding: 20px;
	box-shadow: 0px 0px 10px rgba(248, 176, 255, 0.507);
}

.table {
	background-color: rgba(255, 255, 255, 0.241);
	color: rgb(145, 55, 255);
}

.table th {
	background-color: #FFFFFF;
}

.pagination {
	justify-content: center;
}

.table-bordered th, .table-bordered td {
	border: 0px solid #FFFFFF;
}

.btn-custom {
	background-color: #9582ff;
	color: white;
	transition: background-color 0.3s ease;
	box-shadow: 0px 0px 10px rgba(170, 146, 255, 0.556);
}

.btn-custom:hover {
	background-color: #c1adff; /* 호버 시 배경색 변경 */
	color: white;
}
</style>


</head>
<body>

	<div class="container mt-5">
		<h1 class="text-center mb-4 mb-4 gradient-text"); font-weight:bold; font-size:30px;">살까말까
			게시판</h1>
		<table class="table table-hover table-bordered">
			<thead class="thead-dark">
				<tr>
					<th scope="col"
						style="background-color: hsl(258, 100%, 75%); width: 7%;">글번호</th>
					<th scope="col"
						style="background-color: hsl(258, 100%, 75%); width: 10%;">신청자</th>
					<th scope="col"
						style="background-color: hsl(258, 100%, 75%); width: 50%;">제목</th>
					<th scope="col"
						style="background-color: hsl(258, 100%, 75%); width: 10%;">투표수</th>
					<th scope="col"
						style="background-color: hsl(258, 100%, 75%); width: 10%;">조회수</th>
					<th scope="col"
						style="background-color: hsl(258, 100%, 75%); width: 10%;">작성일자</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="bonBoardDTO" items="${posts}" varStatus="loop">

					<tr>
						<td>${bonBoardDTO.rowNo}</td>
						<td>${bonBoardDTO.writerId}</td>
						<td><a href="bonBoard_one?seq=${bonBoardDTO.seq}&page=1">${bonBoardDTO.title}</a></td>
						<td>${bonBoardDTO.voteCount}</td>
						<td>${bonBoardDTO.view}</td>
						<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
								value="${bonBoardDTO.createAt}" /></td>

					</tr>
				</c:forEach>
			</tbody>
		</table>

	</div>

	<div class="text-right mt-3">
		<a href="BonBoard_insert.jsp" class="btn btn-custom"
			style="margin-right: 10%;">작성하기</a>
	</div>






	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>