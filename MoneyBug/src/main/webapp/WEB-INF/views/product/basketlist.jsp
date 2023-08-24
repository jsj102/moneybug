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

.basket-container {
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

.order-container {
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
	background-color: #F3969A;
	color: white;
	width: 70%;
	align-self: center; /* Add this line */
}
</style>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    $('input[name="selectedProducts"]').on('change', function() {
        updateTotalAmount();
    });
    
    function updateTotalAmount() {
        var totalAmount = 0;
        var selectedProductIds = [];
        var selectedProductSeq = []; // 선택한 상품의 seq 값을 저장하는 배열

        $('input[name="selectedProducts"]:checked').each(function() {
            var valueParts = $(this).val().split(','); // value 값에서 productId와 seq 분리
            selectedProductIds.push(parseInt(valueParts[0])); // productId를 배열에 추가
            selectedProductSeq.push(parseInt(valueParts[1])); // seq를 배열에 추가 
        });

        selectedProductIds.forEach(function(productId, index) {
            var seq = selectedProductSeq[index]; // 현재 인덱스의 seq 값 가져오기
            var productPrice = parseInt($('#productPrice_' + productId).text());
            var productCount = parseInt($('#productCount_' + productId).text());
            totalAmount += productPrice * productCount;
        });

        $('#totalAmount').text(totalAmount + "원");
        $('#totalAmount2').val(totalAmount);
        $('#selectedId_').val(selectedProductIds);
        $('#seletedSeq_').val(selectedProductSeq);
    }
});
</script>



</head>
<body>
<%@ include file="../../../resources/layout/header.jsp" %>	

	<div class="basket-container">
		<div class="user-container d-flex flex-column align-items-center">
			<%
				String userNickname = (String) session.getAttribute("userNickname");

				if (userNickname != null && !userNickname.isEmpty()) {
			%>
			<h2><%=userNickname%>님의 장바구니
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

		<div class="order-container">
			<form action="orderlist" method="post">
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
							<th>선택</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${basketList}" var="basket">
							<c:forEach items="${productList}" var="product">
								<c:if test="${basket.productId eq product.productId}">
									<tr>
										<td>${product.productType}</td>
										<td><img src="${product.productImg}" alt="Product Image"
											width="150px" height="150px" /></td>
										<td>${product.productName}</td>
										<td id="productPrice_${product.productId}">${product.productPrice}</td>
										<td id="productCount_${product.productId}">${basket.productCount}</td>
										<td>${product.productPrice * basket.productCount}</td>
										<td><input type="checkbox" name="selectedProducts"
											value="${basket.productId}, ${basket.seq}" /></td>


									</tr>
								</c:if>
							</c:forEach>
						</c:forEach>
					</tbody>
				</table>
				<div class="d-flex justify-content-center mt-3">
					<input type="hidden" id="totalAmount2" name="totalAmount"
						value="${totalAmount}"> <input type="hidden"
						id="selectedId_" name="selectedId" value="${productId}" /> <input
						type="hidden" id="seletedSeq_" name="seletedSeq"
						value="${basket.seq}" />
					<button type="submit" class="btn btn-lg btn-custom">주문하기</button>
				</div>
			</form>
		</div>

		<hr>
		<div class="orderSum">
			총 주문 금액: <span id="totalAmount">${totalAmount}원</span>
		</div>
	</div>

	<!-- Bootstrap JavaScript -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<%@ include file="../../../resources/layout/footer.jsp" %>

</body>
</html>