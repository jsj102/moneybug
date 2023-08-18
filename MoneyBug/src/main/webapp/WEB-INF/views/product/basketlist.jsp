<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- head 부분 생략 -->
</head>
<body>
    <h1>장바구니</h1>
    
    <table border="1">
        <thead>
            <tr>
                <th>제품명</th>
                <th>가격</th>
                <th>수량</th>
                <th>합계</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${basketList}" var="basket">
                <tr>
                    <td>${basket.userId}</td>
                    <td>${basket.productId}</td>
                    <td>${basket.productCount}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <!-- Bootstrap core JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
