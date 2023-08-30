<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/layout/header.jsp"/>


<style>
body {
	background: #F9F5E7;
}

.order-container {
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
	background-color: #F3969A;
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

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>
	function execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				document.getElementById('zip-code').value = data.zonecode;
				document.getElementById('address-1').value = data.address;
			}
		}).open();
	}

	   $(document).ready(function() {
	        $("#applyPoint").click(function(event) {
	            event.preventDefault(); 
	            var discountPrice = parseInt($("#discountPrice").val()) || 0;
	            var totalAmount = <%= request.getAttribute("totalAmount") %>;
	            var totalPrice = totalAmount - discountPrice;

	            if (totalPrice < 0) {
	                totalPrice = 0;
	            }

	            $("#totalPrice").val(totalPrice); 
	        });
	   });


	   $(function() {
           $('#payOrder').click(function() {
               var IMP = window.IMP; // 생략가능
               IMP.init('iamport'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
               IMP.request_pay({
                   pg : 'inicis', // version 1.1.0부터 지원.
                   pay_method : 'card',
                   merchant_uid : 'merchant_' + new Date().getTime(),
                   name : '주문명:결제테스트',
                   amount : 1000,
                   buyer_email : 'iamport@siot.do',
                   buyer_name : '구매자이름',
                   buyer_tel : '010-1234-5678',
                   buyer_addr : '서울특별시 강남구 삼성동',
                   buyer_postcode : '123-456',
                   m_redirect_url : 'www.yourdomain.com/payments/complete'
           }, function(rsp) {
               if ( rsp.success ) {
                   var msg = '결제가 완료되었습니다.';
                   msg += '고유ID : ' + rsp.imp_uid;
                   msg += '상점 거래ID : ' + rsp.merchant_uid;
                   msg += '결제 금액 : ' + rsp.paid_amount;
                   msg += '카드 승인번호 : ' + rsp.apply_num;
               } else {
                   var msg = '결제에 실패하였습니다.';
                   msg += '에러내용 : ' + rsp.error_msg;
               }
               alert(msg);
           });

           })
       })
       
       document.getElementById("applyPoint").addEventListener("click", function(event) {
        var discountPriceInput = document.getElementById("discountPrice");
        var maxPoint = parseInt(discountPriceInput.max);
        var enteredValue = parseInt(discountPriceInput.value);
        
        if (enteredValue > maxPoint) {
            alert("The entered value exceeds the maximum point value.");
            event.preventDefault();
        }
    });
       

</script>

</head>
<body>

	<div class="order-container">
		<div class="user-container d-flex flex-column align-items-center">
			<%
				String userNickname = (String) session.getAttribute("userNickname");

				if (userNickname != null && !userNickname.isEmpty()) {
			%>
			<h2><%=userNickname%>님의 주문서
			</h2>

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

			<!-- <form action="payOrder" method="post"> -->
		
				<div class="form-group row">
					<label for="basketSeq" class="col-sm-8 col-form-label"> 장바구니 번호</label>
					<div class="col-sm-4">
						<div class="input-group">
						<c:forEach items="${orderlist}" var="order">
							<input type="text" class="form-control" id="basketSeq" name="basketSeq" value="${order.seq}" readonly>
							</c:forEach>
						</div>
					</div>
				</div>
				<div class="form-group row">
					<label for="userId" class="col-sm-8 col-form-label"> 회원 아이디</label>
					<div class="col-sm-4">
						<div class="input-group">
							<input type="text" class="form-control" id="userId" name="userId" value="<%=request.getAttribute("userId")%>" readonly>
						</div>
					</div>
				</div>
				<div class="form-group row">
					<label for="userName" class="col-sm-8 col-form-label"> 회원 이름</label>
					<div class="col-sm-4">
						<div class="input-group">
							<input type="text" class="form-control" id="userName" name="userName" value="<%=request.getAttribute("userName")%>" readonly>
						</div>
					</div>
				</div>
				
				<div class="form-group row">
					<label for="price" class="col-sm-8 col-form-label"> 선택한 상품의 합계</label>
					<div class="col-sm-4">
						<div class="input-group">
							<input type="text" class="form-control" id="price" name="price" value="<%=request.getAttribute("totalAmount")%>" readonly>
							<div class="input-group-append">
								<span class="input-group-text">원</span>
							</div>
						</div>
					</div>
				</div>
				
				<div class="form-group row">
					<label for="point" class="col-sm-8 col-form-label"> 현재 나의 포인트</label>
					<div class="col-sm-4">
						<div class="input-group">
							<input type="text" class="form-control" id="point" value="${member.point }" readonly>
							<div class="input-group-append">
								<span class="input-group-text">P</span>
							</div>
						</div>
					</div>
				</div>

				<div class="form-group row">
					<label for="discountPrice" class="col-sm-8 col-form-label">
						사용하고 싶은 포인트 입력</label>
					<div class="col-sm-4">
						<div class="input-group">
							<input type="number" class="form-control" id="discountPrice"
								name="discountPrice" max="${member.point}" min="0" step="5"/>
							<button class="btn btn-danger" id="applyPoint">적용</button>
						</div>
					</div>
				</div>

				<div class="form-group row">
					<label for="totalPrice" class="col-sm-8 col-form-label"> 최종 결제금액</label>
					<div class="col-sm-4">
						<div class="input-group">
							<input type="text" class="form-control" id="totalPrice" name="totalPrice" value="<%=request.getAttribute("totalAmount")%>" readonly>
							<div class="input-group-append">
								<span class="input-group-text">원</span>
							</div>
						</div>
					</div>
				</div>
				
				<div class="form-group row">
					<label for="tel" class="col-sm-8 col-form-label"> 배송지 전화번호</label>
					<div class="col-sm-4">
						<div class="input-group">
							<input type="tel" class="form-control" id="tel" name="tel">
						</div>
					</div>
				</div>

				<div class="mb-3">
					<button class="btn btn-danger" id="postSearch"
						onclick="execDaumPostcode(); return false;">우편번호 찾기</button>
					<input type="text" class="form-control" id="zip-code"
						placeholder="우편번호">
				</div>
				<div class="mb-3">
					<input type="text" class="form-control" id="address-1"
						placeholder="도로명주소" name="address">
				</div>

				<div class="d-flex justify-content-end">
					<button type="submit" class="btn btn-lg btn-info" id="payOrder">결제하기</button>
				</div>

			</form>
		</div>
		<hr>
	</div>


<jsp:include page="/layout/footer.jsp"/>