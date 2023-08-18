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
	
	.product-container {
		display: flex;
		padding: 20px;
		border: 1px solid #ccc;
		margin: 20px;
	}
	
	.product-image {
		flex: 1;
		margin-right: 20px;
	}
	
	.product-details {
		flex: 2;
	}
	
	.product-name {
		font-size: 24px;
		margin-bottom: 10px;
	}
	
	.product-info {
		font-size: 18px;
		margin-bottom: 10px;
	}
	
	.product-price {
		font-size: 24px;
		margin-bottom: 20px;
	}
	
	.purchase-count {
		font-size: 18px;
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
            <a href="#!" class="btn btn-outline-light">전체상품리스트</a>
        </div>
    </div>

    <!-- 쇼핑 영역 -->
	<div class="container">
        <div class="product-container">
            <div class="product-image">
                <img src="${product.product_img}" alt="Product Image" style="max-width: 100%;" />
            </div>
            <div class="product-details">
                <h2 class="product-name">${product.product_name}</h2>
                <p class="product-info">${product.product_description}</p>
                <p class="product-price"><fmt:formatNumber type="number" value="${product.product_price}" pattern="#,###"/>원</p>
                <p class="purchase-count">Purchases: ${product.purchase_count}</p>
            </div>
        </div>
    </div>
    
    
    <!-- Bootstrap core JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>