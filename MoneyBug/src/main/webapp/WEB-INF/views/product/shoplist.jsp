<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% application.setAttribute("s3","https://moneybugbucket.s3.ap-northeast-2.amazonaws.com"); %>
<jsp:include page="/layout/header.jsp"/>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<style>
body {
	background: #F9F5E7;
}

.banner-container {
	height: 320px;
	background-color: #6cc3d5;
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
	color: white;
	font-size: 22px;
	text-align: center;
}

.products-list {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
}

.product-container {
	margin: 15px;
}

.product-thumbnail {
	position: relative;
	z-index: 1;
}

.product-thumbnail img {
	width: 300px;
	height: 300px;
	object-fit: scale-down;
	background-color: white;
}

.numbadge {
	top: 10px;
	left: 10px;
	position: absolute;
	z-index: 2;
}

.typebadge {
	top: 10px;
	right: 10px;
	position: absolute;
	z-index: 2;
}

.bi-cart-plus {
	position: absolute;
	z-index: 2;
	bottom: 10px;
	right: 10px;
}

.product-text {
	display: inline-block;
	flex-direction: column;
}

.nametext {
	font-weight: bolder;
	font-size: 22px;
}

.pricetext {
	font-size: 20px;
}

.red-strike {
	text-decoration: line-through;
	color: red;
}

.pagination {
  margin: 30px 0 70px 0;
  justify-content: center;
  display: flex;
}

</style>
    <script>
    function DirectBasket() {
        // 세션에 userNickname 정보가 있는지 확인
        var userNickname = "<%= session.getAttribute("userNickname") %>";
        if (userNickname != "null") {
            location.href = "basketlist"; // 장바구니 페이지로 이동
        } else if (userNickname = "null") {
            alert("로그인이 필요합니다."); // 로그인 안내 경고창 띄우기
            location.href = "../login.jsp";
        }
    }
    
    
    function goToBasket(productId) {
        // 세션에 userNickname 정보가 있는지 확인
        var userNickname = "<%= session.getAttribute("userNickname") %>";
        
        if (userNickname != "null") {	
            var count = 1; //메인에서는 하나만 가능
            addToCart(productId, userNickname, count);
        } else if (userNickname = "null") {
            alert("로그인이 필요합니다."); // 로그인 안내 경고창 띄우기
            location.href = "../login.jsp";
        }
    }

        
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
    	                var confirmed = confirm("상품이 장바구니에 추가되었습니다. 장바구니 페이지로 이동하시겠습니까?");
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
			<a href="../product/shopDetail?productId=1"
				class="btn btn-light">오늘의 특가</a>
			<button class="btn btn-light" onclick="DirectBasket()">장바구니</button>
			
		</div>
	</div>


<!-- 쇼핑 영역 -->
<section>
    <div class="products-list">
        <table>
            <c:forEach items="${productList}" var="product" varStatus="status">
                <c:if test="${status.index % 3 == 0}">
                    <tr>
                </c:if>
                <td>
                    <div class="product-container">
                        <!-- Product image-->
                        <div class="product-thumbnail">
                            <a href="<c:url value='/product/shopDetail?productId=${product.productId}' />">
                                <img src="${s3}/resources/products/${product.productImg}" alt="Product Image" />
                            </a>
                            <h4><span class="badge typebadge bg-light badge-lg">${product.productType}</span></h4>
                            <!-- Shopping cart-->
                            <button type="button" class="btn btn-light bi bi-cart-plus" onclick="goToBasket(${product.productId})"></button>
                            <h4><span class="badge numbadge rounded-pill bg-light badge-lg">${product.rowNum}</span></h4>
                        </div>
                        <!-- Product details-->
                        <div class="product-text">
                            <!-- Product name-->
                            <span class="nametext">${product.productName}</span>
                            <!-- Product price-->
                            <div class="pricetext">
                                <c:if test="${product.productOriprice != 0}">
                                    <del class="red-strike"><span style="color: red;"><fmt:formatNumber type="number" value="${product.productOriprice}" pattern="#,###"/></span></del>
                                </c:if>
                                <fmt:formatNumber type="number" value="${product.productPrice}" pattern="#,###"/>원
                            </div>
                        </div>
                    </div>
                </td>
                <c:if test="${status.index % 3 == 2 || status.last}">
             		<tr>
                </c:if>
            </c:forEach>
        </table>
    </div>
</section>

<c:set var="currentPage" value="${param.page}" />

<div>
  <ul class="pagination pagination-lg">
    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
      <a class="page-link" href="shoplist?page=${currentPage - 1}" ${currentPage == 1 ? 'aria-disabled="true"' : ''}>«</a>
    </li>
    <c:forEach begin="1" end="${pages}" varStatus="status">
      <li class="page-item">
        <a class="page-link" href="shoplist?page=${status.index}">${status.index}</a>
      </li>
    </c:forEach>
    <li class="page-item ${currentPage == pages ? 'disabled' : ''}">
      <a class="page-link" href="shoplist?page=${currentPage + 1}" ${currentPage == pages ? 'aria-disabled="true"' : ''}>»</a>
    </li>
  </ul>
</div>
<%@ include file="/layout/accountAside.jsp"%>
<jsp:include page="/layout/footer.jsp"/>
