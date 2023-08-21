<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table class="table table-hover">
	<thead>
		<tr>
			<th>상품번호</th>
			<th>제품분류</th>
			<th>제품이름</th>
			<th>이미지파일URL</th>
			<th>정가</th>
			<th>판매가</th>
			<th>상세설명</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${productList}" var="product" varStatus="status">
			<tr>
				<td>${product.productId}</td>
				<td>${product.productType}</td>
				<td>${product.productName}</td>
				<td>${product.productImg}</td>
				<td>${product.productOriprice}</td>
				<td>${product.productPrice}</td>
				<td>${product.productInfo}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>