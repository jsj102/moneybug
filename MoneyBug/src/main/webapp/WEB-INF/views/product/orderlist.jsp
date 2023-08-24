<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background: #F9F5E7;
}

.order-container {
	margin: 200px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	display: flex;
}

.user-container {
	justify-content: center;
}

.pay-container {
	margin-top: 30px;
	flex-direction: column;
	align-items: center;
}

.table {
	border: 1px solid;
}

.td img {
	object-fit: scale-down;
	background-color: white;
}

.btn-custom {
	background-color: #764dff;
	color: white;
	width: 70%;
	align-self: center;
}

.btn-custom:hover {
	background-color: black;
	color: white;
}

#idconfirm, #logout {
	margin-right: 10px;
}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				document.getElementById('zip-code').value = data.zonecode;
				document.getElementById('address-1').value = data.address;
			}
		}).open();
	}
</script>
</head>
<body>
	<div class="order-container">
		<div class="user-container d-flex flex-column align-items-center">
			<%
				String userNickname = (String) session.getAttribute("userNickname");

				if (userNickname != null && !userNickname.isEmpty()) {
			%>
			<h2><%=userNickname%>님의 결제주문서
			</h2>
			<div class="d-flex justify-content-center mt-2">
				<button class="btn btn-outline-dark" id="idconfirm"
					onclick="location.href='/moneybug/member/myPage.do'">사용자
					정보 확인</button>
				<button class="btn btn-outline-dark" id="logout"
					onclick="location.href='/moneybug/logout.do'">로그아웃</button>
			</div>
			<%
				} else {
			%>
			<p>사용자 정보가 없습니다.</p>
			<button class="btn btn-dark" id="login"
				onclick="location.href='login.jsp'">로그인 페이지로 이동</button>
			<%
				}
			%>
		</div>
		<div class="pay-container">
			<form action="payOrder" method="post">
				<table
					class="table table-light table-hover table-striped text-center">
					<thead>
						<tr>
							<th>유형</th>
							<th>제품 사진</th>
							<th>제품명</th>
							<th>가격</th>
							<th>수량</th>
							<th>합계</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${orderlist}" var="order">
							<c:forEach items="${productlist}" var="product">
								<c:if test="${order.productId eq product.productId}">
									<tr>
										<td>${product.productType}</td>
										<td><img src="${product.productImg}" alt="Product Image"
											width="150px" height="150px" /></td>
										<td>${product.productName}</td>
										<td id="productPrice_${product.productId}">${product.productPrice}</td>
										<td id="productCount_${product.productId}">${order.productCount}</td>
										<td>${product.productPrice * order.productCount}</td>
										
									</tr>
								</c:if>
							</c:forEach>
						</c:forEach>
					</tbody>
				</table>


				<blockquote class="blockquote">
					<p id="paySum">
						<strong>결제하실 금액은 <%=request.getAttribute("totalAmount")%>
							원입니다.
						</strong>
					</p>



				</blockquote>
				<div class="mb-3">
					<label for="userName">주문자 성함:</label><br> <input type="text"
						class="form-control" id="userName" name="userName" readonly>
				</div>

				<div class="mb-3">
					<label for="userAddress">배송지 전화번호:</label><br> <input
						type="text" class="form-control" id="userAddress"
						name="userAddress" required>
				</div>

				<div class="mb-3">
					<button class="btn btn btn-custom" id="postSearch"
						onclick="execDaumPostcode()">우편번호 찾기</button>
					<input type="text" class="form-control" id="zip-code"
						placeholder="우편번호">
				</div>
				<div class="mb-3">
					<input type="text" class="form-control" id="address-1"
						placeholder="도로명주소">
				</div>
				<div class="mb-3">
					<input type="text" class="form-control" id="address-2"
						placeholder="상세주소">
				</div>

				<div class="d-flex justify-content-center mt-3">
					<button type="submit" class="btn btn-lg btn-custom">결제하기</button>
				</div>
			</form>
		</div>
		<hr>
	</div>

	<!-- Bootstrap JavaScript -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>