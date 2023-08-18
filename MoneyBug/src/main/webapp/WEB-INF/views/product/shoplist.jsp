<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>돈벌레 Shop</title>
    <!-- 부트스트랩 링크 추가 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Bootstrap icons-->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
	<style>
	body {
		background: #E4D5FF;
	}
	
	.banner-container {
		height: 320px;
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
	
	.badge {
		top: 10px;
		left: 10px;
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
	</style>
</head>
<body>
    <!-- 광고 배너 영역 -->
    <div class="banner-container">

        <!-- 광고 배너 문구 -->
        <div class="banner-text">
            <h1>MoneyBug Shop</h1>
            <p>돈벌레 사이트에서만 제공하는 다양한 이벤트와 굿즈</p>

            <!-- 광고 배너 버튼 -->
            <a href="#!" class="btn btn-outline-light">오늘의 특가</a>
        </div>
    </div>

    <!-- 쇼핑 영역 -->
	<section>
	    <div class="products-list">
	        <c:forEach items="${productList}" var="product">
	            <div class="product-container">
	                    <!-- Product image-->
	                    <div class="product-thumbnail">
						    <a href="<c:url value='/product/shopDetail?product_id=${product.product_id}' />">
						        <img src="${product.product_img}" alt="Product Image" />
						    </a>
	                    	<h4><span class="badge bg-light badge-lg">${product.product_type}</span></h4>
	                        <!-- Shopping cart-->
	                        <button type="button" class="btn btn-dark bi bi-cart-plus" onclick="location.href='basketlist'"></button>
						</div>
	                    <!-- Product details-->
	                        <div class="product-text">
	                            <!-- Product name-->
	                            <span class="nametext">${product.product_name}</span>
	                            <!-- Product price-->
	                            <div class="pricetext">
	                            <c:if test="${product.product_oriprice != 0}">
						        <del class="red-strike"><span style="color: red;"><fmt:formatNumber type="number" value="${product.product_oriprice}" pattern="#,###"/></span></del>
						        </c:if>
	                            <fmt:formatNumber type="number" value="${product.product_price}" pattern="#,###"/>원
	                            </div>
	                        </div>
	            </div>
	        </c:forEach>
	    </div>
	</section>
    
    
    <!-- Bootstrap core JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>