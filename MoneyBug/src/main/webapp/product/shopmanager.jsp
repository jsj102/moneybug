<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>Moneybug Shop Manager</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
    body {
    	background-color: #F9F5E7;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        margin: 0;
        flex-direction: column;
    }
    
    .btn-long {
        width: 200px;
        margin-bottom: 20px;
    }
    
    .result {
    	background: white;
    	width: 80%;
    	border: 1px;
    	margin-bottom: 50px;
    }
</style>
    <script type="text/javascript">
    	$(function() {
    		//alert(productList);
    		$.ajax({
    			url: "manageList",
    			success: function(manager) {
    				$('#result').html(manager)
    			},
    			error: function() {
    				console.log(productList);
    				alert('ajax 실패')
    			}
    		}) //a
    	}) //f
    </script>
</head>
<body>
    <div class="text-center">
    	<h1 class="bi bi-exclamation-triangle-fill"></h1>
        <h1>Moneybug 쇼핑 관리자페이지</h1><br>
        <button class="btn btn-dark btn-lg btn-long" onclick="location.href='../product/manageInsert'">상품 추가</button>
        <button class="btn btn-dark btn-lg btn-long" onclick="location.href='../product/manageOrder'">주문 관리</button>
    </div>
    <hr>
    <div class="result" id="result"></div>
    

</body>
</html>
