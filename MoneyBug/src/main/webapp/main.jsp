
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="layout/header.jsp" %>

<style>
.container-marketing {
	margin-top: 10px;
}

.main-category {
	display: flex;
	padding: 10px;
	margin-top: 30px;
	text-align: center;
	flex-direction: column;
	align-items: center;
	justify-content: center;
}

.main-img {
	width: 120px;
	height: auto;
	magin-bottom: 10px;
}

.main-category p {
	padding: 0 10px 0 10px;
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
				<img src="resources/img/main_1.png" class="bd-placeholder-img"
					width="100%" height="100%" preserveAspectRatio="xMidYMid slice"
					focusable="false" role="img">
			</div>
			<div class="carousel-item">
				<img src="resources/img/main_2.png" class="bd-placeholder-img"
					width="100%" height="100%" preserveAspectRatio="xMidYMid slice"
					focusable="false" role="img">
			</div>
			<div class="carousel-item">
				<img src="resources/img/main_3.png" class="bd-placeholder-img"
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



	<div class="container marketing">
		<div class="row">
			<div class="main-category col-lg-4 text-center-margin">
				<img class="main-img" src="resources/img/accounts.png" alt="Image" width="140" height="140">
				<h2>Account Book</h2>
				<p>가계부 기능은 개인이 수입과 지출을 기록하고 관리하는 기능으로, 재무 상태 파악과 예산 설정에 도움을 주며
					재정을 효과적으로 관리할 수 있게 해줍니다.</p>
				<a type="button" class="btn btn-success" href="#" role="button">가계부 작성하러 가기&raquo;</a>
			</div>

			<div class="main-category col-lg-4 text-center-margin">
				<img class="main-img" src="resources/img/comm.png" alt="Image">
				<h2>Community</h2>
				<p>지출인증 게시판은 사용자들의 소비내역을 공유하는 플랫폼으로, 예산 관리와 소비 패턴 파악에 도움을 주며 경제적인 선택을 도모합니다.</p>
				<a class="btn btn-success" href="#" role="button">인증 게시판 바로가기&raquo;</a>
			</div>

			<div class="main-category col-lg-4 text-center-margin">
				<img class="main-img" src="resources/img/voting.png" alt="Image">
				<h2>Voting Board</h2>
				<p>살까말까 게시판은 사용자들이 구매를 망설이는 문제에 대해 서로의 의견을 듣고 투표할 수 있는 플랫폼으로, 현명한 구매 결정에 도움을 줍니다.</p>
				<a class="btn btn-success" href="#" role="button">살까 말까 투표하러 가기	&raquo;</a>
			</div>
			
			<div class="main-category col-lg-4 text-center-margin">
				<img class="main-img" src="resources/img/shop.png" alt="Image">
				<h2>Shop</h2>
				<p>돈벌레 샵은 다양한 주제와 캐릭터를 기반으로 한 제품들을 판매하는 온라인 상점으로,팬들에게 고유한 상품 구매와 컬렉션 기회를 제공합니다.</p>
				<a class="btn btn-success" href="product/shoplist?page=1" role="button">굿즈 사러 가기	&raquo;</a>
			</div>
			
			<div class="main-category col-lg-4 text-center-margin">
				<img class="main-img" src="resources/img/service.png" alt="Image">
				<h2>Customer Service</h2>
				<p>고객센터는 사용자가 궁금한 사항이나 문제를 문의할 수 있는 공간으로, 신속하고 친절한 답변으로 사용자 만족 서비스를 제공합니다. </p>
				<a class="btn btn-success" href="#" role="button">고객센터 가기	&raquo;</a>
			</div>
			
			<div class="main-category col-lg-4 text-center-margin">
				<img class="main-img" src="resources/img/buggy.png" alt="Image">
				<h2>My Page</h2>
				<p>마이페이지에서 하나밖에 없는 자신의 벌레 캐릭터 닉네임을 정해보세요. 돈벌레의 다양한 서비스를 더욱 재밌게 즐길 수 있습니다. </p>
				<form action="member/myPage.do" method="post">
	            <button role="button" class="btn btn-success">마이페이지 &raquo;</button>
	        	</form>
			</div>
		</div>
		<!-- /.row -->


		<!-- START THE FEATURETTES -->

		<hr class="featurette-divider">

		<div class="row featurette">
			<div class="col-md-7">
				<h1 class="featurette-heading">
					돈벌레? 돈벌래! <span class="text-muted"><br>어떻게 더 절약하고 소비할까요?</span>
				</h1>
				<p class="lead">머니버그Ai가 알려주는 돈절약방법! <br> 내 가계부 등록하고 진단받으세요.</p>
			</div>
			<div class="col-md-5">
				<svg
					class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto"
					width="400" height="400" xmlns="http://www.w3.org/2000/svg"
					preserveAspectRatio="xMidYMid slice" focusable="false" role="img"
					aria-label="Placeholder: 500x500">
					<title>Placeholder</title><rect width="100%" height="100%"
						fill="#eee" />
					</svg>
			</div>
		</div>

		<hr class="featurette-divider">

		<div class="feature-container">
			<div class="row">
				<div class="featureimg col-md-5 order-md-1">
					<img src="https://i.postimg.cc/L8rTp5qT/ecobag.jpg"
						class="img-crop" alt="Eco Bag">
				</div>
				<div class="featuretext col-md-7 order-md-2">
					<h1 class="featurette-heading">
						드디어 출시! <span class="text-muted"> <br>돈벌레 공식 에코백 굿즈
						</span>
					</h1>
					<p class="lead">
						돈벌레 공식 에코백은 친환경 소재로 제작되어 환경에도 좋답니다.<br>출시기념 할인가로 지금 만나보세요.
					</p>
				</div>
			</div>
		</div>




		<hr class="featurette-divider">

		<div class="row featurette">
			<div class="col-md-7">
				<h1 class="featurette-heading">
					지금 돈벌레 최고 인기글! <span class="text-muted"><br>오늘은 뭐쓰셨어요? </span>
				</h1>
				<p class="lead">사람들에게 지출을 보여주긴 쉽지않죠. 하지만 그게 절약의 첫걸음이에요!</p>
			</div>
			<div class="col-md-5">
				<svg
					class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto"
					width="400" height="400" xmlns="http://www.w3.org/2000/svg"
					preserveAspectRatio="xMidYMid slice" focusable="false" role="img"
					aria-label="Placeholder: 500x500">
					<title>Placeholder</title><rect width="100%" height="100%"
						fill="#eee" /></svg>
			</div>
		</div>

		<hr class="featurette-divider">

	</div>
		
<!-- footer.jsp를 포함시킴 -->
<%@ include file="layout/footer.jsp" %>
