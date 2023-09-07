<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>돈벌레 관리자 페이지</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
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

.manageInsert {
	background-color: white;
	padding: 20px;
	width: 80%;
	margin: 0;
	border-radius: 10px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.table-container {
	overflow-x: auto;
}

th, td {
	vertical-align: middle !important;
}
</style>
</head>
<body>
	<div class="text-center">
		<h1 class="bi bi-exclamation-triangle-fill"></h1>
		<h1>Moneybug 쇼핑 주문관리 페이지</h1>
		<br>
	</div>
	<hr>
	<div class="result" id="result"></div>
	<div class="container manageInsert">
		<div class="table-container">
			<table class="table table-hover">
				<thead>
					<tr>
						<th>주문번호</th>
						<th>주문 날짜</th>
						<th>주문자 이름</th>
						<th>주소</th>
						<th>전화번호</th>
						<th>최종금액</th>
						<th>결제수단</th>
						<th>주문상태</th>
						<th>주문변경</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${orderList}" var="order">
						<tr>
							<td>${order.orderNumber}</td>
							<td>${order.orderAt}</td>
							<td>${order.userName}</td>
							<td>${order.address}</td>
							<td>${order.tel}</td>
							<td>${order.totalPrice}</td>
							<td>${order.payTool}</td>
							<td>${order.orderStatus}</td>
							<td>
								<form id="statusForm${order.orderNumber}" method="post"
									action="updateOrderStatus">
									<input type="hidden" name="orderNumber"
										value="${order.orderNumber}" /> <select name="newStatus">
										<option value="배송준비"
											${order.orderStatus == '배송준비' ? 'selected' : ''}>배송준비</option>
										<option value="배송중"
											${order.orderStatus == '배송중' ? 'selected' : ''}>배송 중</option>
										<option value="배송완료"
											${order.orderStatus == '배송완료' ? 'selected' : ''}>완료</option>
									</select>
									<button type="submit" class="btn btn-sm btn-primary">변경</button>
								</form>

							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<script>
		function submitStatusForm(orderNumber) {
			var form = document.getElementById(`statusForm${orderNumber}`);
			form.submit();
		}

		function updateAllOrderStatus(orderNumber) {
			var forms = document.querySelectorAll('form');
			forms.forEach(function(form) {
				submitStatusForm(orderNumber);
			});
		}
	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
