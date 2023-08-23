<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>돈벌레 Shop</title>
<!-- 부트스트랩 링크 추가 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
body {
	background: #E4D5FF;
}

.banner-container {
	height: 250px;
	background-color: #9669FF;
	background-position: center;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

.banner-text h1 {
	color: white;
	font-size: 80px;
}

.banner-text {
	font-size: 22px;
	text-align: center;
}

.detail-container {
	display: flex;
	justify-content: center;
	margin: 20px 100px;
}

.product-image>img {
	height: 500px;
}

.product-details {
	margin: 30px 0px 0px 30px;
}

.product-name {
	font-size: 1.5rem;
	font-weight: bold;
	margin-bottom: 10px;
}

.product-price {
	font-size: 1.2rem;
	margin-bottom: 10px;
}

.product-introduction {
	margin-bottom: 20px;
}

.buttons {
	display: flex;
	gap: 10px;
}

.cart-button, .buy-button {
	padding: 10px 20px;
	background-color: #9669FF;
	color: white;
	border: none;
	cursor: pointer;
	font-size: 1rem;
	border-radius: 5px;
}

.cart-button {
	background-color: #2AD2D3;
}

.red-strike {
	text-decoration: line-through;
	color: red;
}
</style>
	
<script>
	$(document).ready(function() {
	    // 수량 증가 버튼 클릭 시
	    $("#increase").click(function() {
	        var currentQuantity = parseInt($("#quantity").val());
	        $("#quantity").val(currentQuantity + 1);
	    });
	
	    // 수량 감소 버튼 클릭 시
	    $("#decrease").click(function() {
	        var currentQuantity = parseInt($("#quantity").val());
	        if (currentQuantity > 1) {
	            $("#quantity").val(currentQuantity - 1);
	        }
	    });
	
	    // 장바구니 버튼 클릭 시
	    $(".cart-button").click(function() {
	        var productId = ${productDTO.productId};
	        var userNickname = "<%= session.getAttribute("userNickname") %>";
	        var count = parseInt($("#quantity").val());
	        
	        if (userNickname != "null") {	
	            var count = 1; //메인에서는 하나만 가능
	            addToCart(productId, userNickname, count);
	        } else if (userNickname = "null") {
	            alert("로그인이 필요합니다."); // 로그인 안내 경고창 띄우기
	            location.href = "../login.jsp";
	        }
	    });
	});
	
	// 장바구니 추가 함수
	function addToCart(productId, userNickname, count) {
	    $.ajax({
	        type: 'GET',
	        url: '${pageContext.request.contextPath}/addToCart',
	        data: {
	            'productId': productId,
	            'userNickname': userNickname,
	            'count': count
	        },
	        success: function(message) {
	            if (message === 'successfully') {
	                var confirmed = confirm("상품이 장바구니에 추가되었습니다.\n 장바구니 페이지로 이동하시겠습니까?");
	                if (confirmed) {
	                    // 장바구니 페이지 URL로 이동
	                    window.location.href = '${pageContext.request.contextPath}/product/basketlist';
	                } else {
	                    // 여기에 다른 처리를 추가할 수 있습니다.
	                }
	            } else {
	                alert(message); // 추가 실패 시 메시지 출력
	            }
	        },
	        error: function() {
	            alert("AJAX error");
	        }
	    });
	}

</script>
</head>
<body>
	<!-- 광고 배너 영역 -->
	<div class="banner-container">
		<!-- 광고 배너 문구 -->
		<div class="banner-text">
			<h1>MoneyBug Shop</h1>
			<p>돈벌레 사이트에서만 제공하는 다양한 이벤트와 굿즈</p>
			<!-- 광고 배너 버튼 -->
			<a href="shoplist?page=1" class="btn btn-outline-light">전체상품리스트</a>
		</div>
	</div>

	<!-- 쇼핑 영역 -->
	<div class="detail-container">
		<div class="product-image">
			<img src="${productDTO.productImg}" alt="Product Image">
		</div>
		<div class="product-details">
			<div class="product-category badge bg-light">
				${productDTO.productType}
			</div>
			<div class="product-name">${productDTO.productName}</div>
			<hr>
			<div class="product-oriprice">
				<c:if test="${product.productOriprice != 0}">
					<del class="red-strike">
						<span style="color: red;"><fmt:formatNumber type="number"
								value="${productDTO.productOriprice}" pattern="#,###" /></span>
					</del>
				</c:if>
			</div>
			<div class="product-price">
				<fmt:formatNumber type="number" value="${productDTO.productPrice}"
					pattern="#,###" />
				원
			</div>
			<div class="product-introduction">${productDTO.productInfo}</div>

			<!-- 수량조절버튼 -->
		    <div class="input-group">
		      <div class="input-group-prepend">
		        <button class="btn btn-outline-secondary" id="decrease">-</button>
		      </div>
		      <input type="text" class="form-control text-center" id="quantity" value="1" readonly>
		      <div class="input-group-append">
		        <button class="btn btn-outline-secondary" id="increase">+</button>
		      </div>
		    </div>

			<hr>
			<div class="buttons">
			    <button class="cart-button">장바구니</button>
			    <button class="buy-button" onclick="location.href='#'">바로 주문하기</button>
			</div>

		</div>
	</div>

	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- Bootstrap core JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>