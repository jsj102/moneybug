<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>돈벌레 관리자 페이지</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />

	<style>
	body {
		display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        margin: 0;
	}
	
	.manageInsert {
		background-color: #F9F5E7;
		padding: 100px;
		width: 50%;
		margin: 0;
	}
	
	
	</style>

</head>
<body>
    <div class="manageInsert">
    	<i class="bi bi-database-add"></i>
        <h1>판매상품 등록</h1><br>

	    <form action="../product/productInsert" method="POST">
	    
	    	<div class="mb-3">
	        <label for="product_type">카테고리:</label>
	        <select class="form-control" id="productType" name="productType" required>
	            <option value="이벤트 제휴">이벤트 제휴</option>
	            <option value="굿즈">굿즈</option>
	            <option value="특가할인">특가할인</option>
	        </select>
	        </div>
	        
	        <div class="mb-3">
	        <label for="productName">제품명:</label><br>
	        <input type="text" class="form-control" id="productName" name="productName" required></div>
	        
	        <div class="mb-3">
	        <label for="productImg">제품이미지(URL):</label><br>
	        <input type="text" class="form-control"  id="productImg" name="productImg" required></div>
	        
	        <div class="mb-3">
	        <label for="productOriprice">제품 정가(원):</label><br>
	        <input type="number" class="form-control" id="productOriprice" name="productOriprice" ></div>
	        
	        <div class="mb-3">
	        <label for="productPrice">제품 판매가(원):</label><br>
	        <input type="number" class="form-control" id="productPrice" name="productPrice" required></div>
	        
	        <div class="mb-3">
	        <label for="productInfo">제품 설명:</label><br>
	        <textarea class="form-control" id="productInfo" name="productInfo" rows="3"></textarea></div>
	        
	        <button type="submit" class="btn btn-block btn-dark">상품등록</button>
	        
	    </form>
    </div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>