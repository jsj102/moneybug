<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>상품 수정 폼</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
</head>
<body>
    <div class="container">
        <h1>상품 수정 폼</h1>
        <form action="../product/updateProducts?productId=${product.productId}" method="POST">
            <div class="form-group">
                <label for="productType">카테고리:</label>
                <select class="form-control" id="productType" name="productType" required>
                    <option value="이벤트 제휴">이벤트 제휴</option>
                    <option value="굿즈">굿즈</option>
                    <option value="특가할인">특가할인</option>
                </select>
            </div>

            <div class="form-group">
                <label for="productName">제품명:</label>
                <input type="text" class="form-control" id="productName" name="productName" required value="${product.productName}">
            </div>
            <div class="form-group">
                <label for="productImg">제품 이미지(URL):</label>
                <input type="text" class="form-control" id="productImg" name="productImg" required value="${product.productImg}">
            </div>
            <div class="form-group">
                <label for="productOriprice">제품 정가(원):</label>
                <input type="number" class="form-control" id="productOriprice" name="productOriprice" value="${product.productOriprice}">
            </div>
            <div class="form-group">
                <label for="productPrice">제품 판매가(원):</label>
                <input type="number" class="form-control" id="productPrice" name="productPrice" required value="${product.productPrice}">
            </div>
            <div class="form-group">
                <label for="productInfo">제품 설명:</label>
                <textarea class="form-control" id="productInfo" name="productInfo" rows="3">${product.productInfo}</textarea>
            </div>
            <button type="submit" class="btn btn-block btn-dark">수정</button>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>