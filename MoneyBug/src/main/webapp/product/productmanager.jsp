<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>Moneybug Shop Manager</title>
<script type="text/javascript" src="resources/js/jquery-3.6.1.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

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
    	<h1 class="bi bi-exclamation-triangle-fill"></h1>
        <h1>Moneybug 쇼핑 관리자페이지</h1><br>
        <button class="btn btn-dark btn-lg btn-long" onclick="location.href='../product/manageInsert'">상품 추가</button>
        <button class="btn btn-dark btn-lg btn-long" onclick="location.href='../product/manageUpdate'">상품 수정</button>
        <button class="btn btn-dark btn-lg btn-long" onclick="location.href='../product/manageDelete'">상품 삭제</button>
        <button class="btn btn-dark btn-lg btn-long" onclick="location.href='../product/manageOrder'">주문 관리</button>
    </div>
    <div id="result"></div>
    
    <script type="text/javascript">
    	$(function() {
    		$.ajax({
    			url: "product/manageList",
    			success: function(manager) {
    				$('#result').append(manager)
    			},
    			error: function() {
    				alert('ajax 실패')
    			}
    		}) //a
    	}) //f
    </script>
</body>
</html>
