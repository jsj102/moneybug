<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>Moneybug Shop Manager</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />

<style>
    body {
    	background-color: #E4D5FF;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        margin: 0;
    }
    
    .btn-long {
        width: 200px;
        margin-bottom: 20px;
    }
</style>

</head>
<body>
    <div class="text-center">
    	<i class="bi bi-database-add"></i>
        <h1>판매상품 등록</h1><br>

	    <form action="/product/itemInsert" method="POST">
	        <label for="product_type">카테고리:</label>
	        <select class="form-control" id="product_type" name="product_type" required>
	            <option value="이벤트 제휴">이벤트 제휴</option>
	            <option value="굿즈">굿즈</option>
	            <option value="특가할인">특가할인</option>
	        </select><br><br>
	        
	        <label for="product_name">제품명:</label>
	        <input type="text" id="product_name" name="product_name" required><br><br>
	        
	        <label for="product_img">제품이미지(URL):</label>
	        <input type="text" id="product_img" name="product_img" required><br><br>
	        
	        <label for="product_oriprice">제품 정가:</label>
	        <input type="number" id="product_oriprice" name="product_oriprice" >원<br><br>
	        
	        <label for="product_price">제품 판매가:</label>
	        <input type="number" id="product_price" name="product_price" required>원<br><br>
	        
	        <label for="product_info">제품 설명:</label>
	        <input type="text" id="product_info" name="product_info" ><br><br>
	        
	        <input type="submit" value="상품 등록">
	    </form>
    </div>
    
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
