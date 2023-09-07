<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="/layout/header.jsp"%>

<style>

body {
	background: #F9F5E7; /* 배경 색상 변경 */
}

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


.container {
	width:90%;
	padding: 20px;
	border-radius: 10px;
	margin-top: 20px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}


.gradient-text {
	background: white;
	-webkit-background-clip: text;
	font-size: 30px;
}

.mainlist {
	width:100%;
	border: 2px solid #C4D7B2; /* 테두리 색상과 두께 설정 */
	border-radius: 20px; /* 모서리 둥글게 만듦 */
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	text-align: center; /* 텍스트 가운데 정렬 */
	background-color: #fffdf5;

}

.table {
	background-color: #BCD6BA;
	color: rgb(255, 255, 255);
	width:95%;
}

.table td {
	background-color: #E2EDC9;
	color: #2E4B00;
}

.pagination {
	justify-content: center;
}

.table-bordered th, .table-bordered td {
	border: 0px solid #FFFFFF;
}

.btn-custom {
	border-radius: 15px;
	padding: 10px;
	background-color: #c5d7af;
}

.btn-primary {
	background-color: #BCD6BA; /* 버튼 배경 색상 변경 */
	border-color: #BCD6BA; /* 버튼 테두리 색상 변경 */
}

.btn-primary:hover {
	background-color: #C4D7B2; /* 버튼 마우스 호버 시 배경 색상 변경 */
	border-color: #C4D7B2;
}
</style>

<script type="text/javascript" src="../resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript">
	$(function() {
		$('#writeForm').click(function() {
			
			$.ajax({
				url : "BonBoard_list2", //views/bbsList2.jsp가 결과!
				data : {
					page : $(this).text()
				},
				success : function(result) { //결과가 담겨진 table부분코드
					$('#d1').html(result)
				},
				error : function() {
				
				}
			}) //ajax
		})
	})
</script>

<title>BonBoard_list</title>

</head>
<body>
<div class="banner-container" align="center">
	<div class="banner-text">
		<br> <a class="nav-link"
			href="/moneybug/bonBoard/BonBoard_list?page=1"><h1>MoneyBug
				Buy or Not</h1></a>
		<p>살까? 말까? 돈벌레 친구들과 같이 고민해요!</p>
	</div>
</div>
<br><br>

	<div class="container">
	<div class="mainlist">
	<br>
		<h1 class="text-center gradient-text"
			style="font-size: 30px;">살까? 말까!</h1>
			<br>
		<table class="table table-hover ">
			<thead >
				<tr >
					<th scope="col" style="background-color: #C4D7B2; width: 7%;"></th>
					<th scope="col" style="background-color: #C4D7B2; width: 10%;">닉네임</th>
					<th scope="col" style="background-color: #C4D7B2; width: 50%;">제목</th>
					<th scope="col" style="background-color: #C4D7B2; width: 15%;">작성일</th>
					<th scope="col" style="background-color: #C4D7B2; width: 10%;">조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="bonBoardDTO" items="${list}" varStatus="loop">

					<tr>
						<td>${bonBoardDTO.rowNo}</td>
						<td>${bonBoardDTO.userNickname}</td>
						<td><a href="BonBoard_one?seq=${bonBoardDTO.seq}">
								${bonBoardDTO.title} </a></td>
						<td><fmt:formatDate pattern="yy/MM/dd HH:mm"
								value="${bonBoardDTO.createAt}" /></td>
						<td>${bonBoardDTO.views}</td>
					</tr>

				</c:forEach>
			</tbody>
		</table>
		<br><br>

		<div class="text-right">
			<a href="BonBoard_insert2.jsp" class="btn btn-custom" id="writeForm"
				>작성하기</a>
		</div>
		<br><br>

		<nav aria-label="Page navigation">
			<ul class="pagination">
				<%
				int pages = Integer.parseInt(request.getAttribute("pages").toString());
				for (int i = 1; i <= pages; i++) {
				%>

				<li class="page-item"><a class="page-link"
					href="/moneybug/bonBoard/BonBoard_list?page=<%=i%>"><%=i%></a>
				</li>
				<%
				}
				%>
			</ul>
		</nav>

	</div>
	</div>
<br><br>

	<script>
		$(document).ready(function() {
			$(".page-link").click(function(e) {
				e.preventDefault();
				var pageToShow = $(this).data("page");
				$(".page-row").hide();
				$(".page-row").eq(pageToShow - 1).show();
			});
		});
	</script>
<%@ include file="/layout/accountAside.jsp"%>
<%@ include file="/layout/footer.jsp"%>