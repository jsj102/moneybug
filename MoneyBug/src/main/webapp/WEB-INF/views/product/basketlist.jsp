<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/layout/header.jsp" />
<style>
body {
	background: #F9F5E7;
}

.basket-container {
	margin: 100px;
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
</style>

<script>
$(document).ready(function() {
	
	
    $('input[name="selectedProducts"]').on('change', function() {
        updateTotalAmount();
    });
    
    function updateTotalAmount(inputField) {
        var totalAmount = 0;
        var selectedProductIds = [];
        var selectedProductSeq = [];

        $('input[name="selectedProducts"]:checked').each(function() {
            var valueParts = $(this).val().split(',');
            selectedProductIds.push(parseInt(valueParts[0]));
            selectedProductSeq.push(parseInt(valueParts[1]));
        });

        selectedProductIds.forEach(function(prodId, index) {
            var s = selectedProductSeq[index];
            var productPrice = parseInt($('#productPrice_' + prodId).text());
            var productCount = 0;

            if (inputField) {
                var productId = inputField.data('product-id');
                var seq = inputField.data('product-count');
                if (productId === prodId && seq === s) {
                    productCount = parseInt(inputField.val());
                    $('#productTotal_' + productId + '_' + seq).text(productPrice * productCount + "원");
                }
            } else {
                productCount = parseInt($('#productCount_' + prodId).val());
                $('#productTotal_' + prodId + '_' + s).text(productPrice * productCount + "원");
            }

            totalAmount += productPrice * productCount;
        });

        $('#totalAmount').text(totalAmount + "원");
        $('#totalAmount2').val(totalAmount);
        $('#selectedId_').val(selectedProductIds);
        $('#seletedSeq_').val(selectedProductSeq);
    }
});


$("#orderForm").submit(function(event) {
    event.preventDefault(); // 기본 form 제출 동작 막기
    
    var selectedProductIds = [];
    var selectedProductSeq = [];
    var newCounts = [];

    $('input[name="selectedProducts"]:checked').each(function() {
        var valueParts = $(this).val().split(',');
        selectedProductIds.push(parseInt(valueParts[0]));
        selectedProductSeq.push(parseInt(valueParts[1]));
        newCounts.push(parseInt($('#productCount_' + valueParts[0]).val()));
    });

    var requestData = {
        userNickname: "사용자의 닉네임", // 사용자의 닉네임 설정
        productId: selectedProductIds,
        seq: selectedProductSeq,
        newCount: newCounts
    };

    $.ajax({
        type: 'POST',
        url: '/updateQuantity',
        data: requestData,
        success: function(response) {
            console.log('수량 업데이트 성공:', response);
            // 성공 후 처리할 동작 추가
        },
        error: function(error) {
            console.error('수량 업데이트 실패:', error);
            // 실패 후 처리할 동작 추가
        }
    });
});

function deleteProduct(userNickname, productId, seq) {
    if (confirm("정말로 상품을 삭제하시겠습니까?")) {
        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/deleteProduct',  // 삭제 요청을 처리할 백엔드 엔드포인트 URL
            data: {
                userNickname: userNickname,
                productId: productId,
                seq: seq
                
            },
            success: function(response) {
                alert("상품 삭제 성공");
                window.location.href = '${pageContext.request.contextPath}/product/basketlist';
            },
            error: function(error) {
                alert("상품 삭제 실패" + error);
                window.location.href = '${pageContext.request.contextPath}/product/basketlist';
            }
        });
    }
}
</script>



</head>
<body>
	<div class="basket-container">
		<div class="user-container d-flex flex-column align-items-center">
			<c:if test="${not empty userNickname}">
				<h2>${userNickname}님의장바구니</h2>
				<c:choose>
					<c:when test="${basketIsEmpty}">
						<div style="margin-top: 20px;">
							<a
								href="${pageContext.request.contextPath}/product/shoplist?page=1"
								class="btn btn-primary ml-2 center">상품 담으러 가기</a>
						</div>
					</c:when>
				</c:choose>
			</c:if>
			<c:if test="${empty userNickname}">
				<p>사용자 정보가 없습니다.</p>
				<button class="btn btn-dark" id="login"
					onclick="location.href='login.jsp'">로그인 페이지로 이동</button>
			</c:if>
		</div>
		<div class="order-container">
			<form action="orderlist" method="post">
				<c:choose>
					<c:when test="${basketIsEmpty}">
						<p>장바구니에 담긴 상품이 없습니다.</p>
					</c:when>
					<c:otherwise>
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
									<th>삭제</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${basketList}" var="basket">
									<c:forEach items="${productList}" var="product">
										<c:if test="${basket.productId eq product.productId}">
											<tr>
												<td>${product.productType}</td>
												<td><img src="${product.productImg}"
													alt="Product Image" width="150px" height="150px" /></td>
												<td>${product.productName}</td>
												<td id="productPrice_${product.productId}">${product.productPrice}</td>
												<td>
													<div class="input-group">
														<input type="number"
															class="form-control text-center quantity"
															id="productCount_${product.productId}"
															value="${basket.productCount}" min="1"
															onchange="updateTotalAmount(this, ${product.productId}, ${basket.seq})">
													</div>
												</td>
												<td id="productTotal_${product.productId}_${basket.seq}"
													class="productTotal">${product.productPrice * basket.productCount}원
												</td>

												<td><input type="checkbox" name="selectedProducts"
													value="${basket.productId}, ${basket.seq}" /></td>
												<td><button class="delete-btn"
														onclick="deleteProduct('${userNickname}', ${basket.productId}, ${basket.seq})">삭제</button></td>
											</tr>
										</c:if>
									</c:forEach>
								</c:forEach>
							</tbody>
						</table>
						<div class="orderSum">
							총 주문 금액: <span id="totalAmount">${totalAmount}원</span>
						</div>
						<div class="d-flex justify-content-center mt-3">
							
						</div>
					</c:otherwise>
				</c:choose>
			</form>
		</div>
	</div>

	<jsp:include page="/layout/footer.jsp" />