<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
application.setAttribute("s3", "https://moneybugbucket.s3.ap-northeast-2.amazonaws.com");
%>
<%@ include file="layout/header.jsp" %>

<style>
html, body {
	height: 100%;
}

body {
	background: #F9F5E7;
	display: flex;
	flex-direction: column;
	flex: 1;
	margin: 0;
	
}


.container {
	margin-top: 30px;
	padding-bottom: 10px;
}
.row{
	display:flex;
	justify-content: center;
	}

.main-category {
	padding: 20px 0px;
	margin: 30px 20px 0px 20px;
	text-align: center;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	width:35%;
	border-radius :25px;
}

.main-img {
	width: 120px;
	height: auto;
	magin-bottom: 10px;
}

.main-category p {
	padding:0px 80px;
	text-align: center;
	
	
}

.featureimg {
  position: relative;
  width: 500px;
  height: 500px;
}

.img-crop {
  background-size: cover;
  background-position: center;
  width: 100%;
  height: 100%;
}
</style>


</head>
<body>


	<div id="myCarousel" class="carousel slide" data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
			<li data-target="#myCarousel" data-slide-to="1"></li>
			<li data-target="#myCarousel" data-slide-to="2"></li>
		</ol>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="${s3}/resources/img/main_1.png" class="bd-placeholder-img"
					width="100%" height="100%" preserveAspectRatio="xMidYMid slice"
					focusable="false" role="img">
			</div>
			<div class="carousel-item">
				<img src="${s3}/resources/img/main_2.png" class="bd-placeholder-img"
					width="100%" height="100%" preserveAspectRatio="xMidYMid slice"
					focusable="false" role="img">
			</div>
			<div class="carousel-item">
				<img src="${s3}/resources/img/main_3.png" class="bd-placeholder-img"
					width="100%" height="100%" preserveAspectRatio="xMidYMid slice"
					focusable="false" role="img">
			</div>
		</div>
		<a class="carousel-control-prev" href="#myCarousel" role="button"
			data-slide="prev"> <span class="carousel-control-prev-icon"
			aria-hidden="true"></span> <span class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#myCarousel" role="button"
			data-slide="next"> <span class="carousel-control-next-icon"
			aria-hidden="true"></span> <span class="sr-only">Next</span>
		</a>
	</div>



	<div class="container">
		<div class="row">
			<div class="main-category">
				<img class="main-img" src="${s3}/resources/img/accounts.png" alt="Image" width="140" height="140">
				<h2>Account Book</h2>
				<p>가계부 기능은 개인이 수입과 지출을 기록하고 관리하는 기능으로, 재무 상태 파악과 예산 설정에 도움을 주며
					재정을 효과적으로 관리할 수 있게 해줍니다.</p>
				<a type="button" class="btn btn-success" href="accountBook/accountDetail_List.jsp" role="button">가계부</a>
			</div>

			<div class="main-category col-lg-4 text-center-margin">
				<img class="main-img" src="${s3}/resources/img/comm.png" alt="Image">
				<h2>Community</h2>
				<p>지출인증 게시판은 사용자들의 소비내역을 공유하는 플랫폼으로, 예산 관리와 소비 패턴 파악에 도움을 주며 경제적인 선택을 도모합니다.</p>
				<a class="btn btn-success" href="tagBoard/TagBoard_list?page=1" role="button">커뮤니티</a>
			</div>

			<div class="main-category col-lg-4 text-center-margin">
				<img class="main-img" src="${s3}/resources/img/voting.png" alt="Image">
				<h2>Voting Board</h2>
				<p>살까말까 게시판은 사용자들이 구매를 망설이는 문제에 대해 서로의 의견을 듣고 투표할 수 있는 플랫폼으로, 현명한 구매 결정에 도움을 줍니다.</p>
				<a class="btn btn-success" href="bonBoard/BonBoard_list?page=1" role="button">살까?말까?</a>
			</div>
			
			<div class="main-category col-lg-4 text-center-margin">
				<img class="main-img" src="${s3}/resources/img/shop.png" alt="Image">
				<h2>Shop</h2>
				<p>돈벌레 샵은 다양한 주제와 캐릭터를 기반으로 한 제품들을 판매하는 온라인 상점으로,팬들에게 고유한 상품 구매와 컬렉션 기회를 제공합니다.</p>
				<a class="btn btn-success" href="product/shoplist?page=1" role="button">굿즈샵</a>
			</div>
			

		</div>
	</div>



		
<!-- footer.jsp를 포함시킴 -->
<%@ include file="/layout/accountAside.jsp"%>
<%@ include file="layout/footer.jsp" %>
