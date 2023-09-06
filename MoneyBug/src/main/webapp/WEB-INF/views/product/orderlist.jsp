<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% application.setAttribute("s3","https://moneybugbucket.s3.ap-northeast-2.amazonaws.com"); %>
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
	background: #FAFAFA;
	margin-top: 30px;
	flex-direction: column;
	align-items: center;
	padding: 30px;
	border-radius: 20px;
	box-shadow: 0 0 30px rgba(0, 0, 0, 0.1);
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


<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>
	let seqListSize =0;
	let seqList="";
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
	        var maxDiscount = parseInt($("#discountPrice").attr("max")) || 0; // 최대값 가져오기
	        var totalAmount = <%= request.getAttribute("totalAmount") %>;
	        
	        // discountPrice가 max보다 크면 max 값으로 설정
	        if (discountPrice > maxDiscount) {
	            discountPrice = maxDiscount;
	        }
	        
	        var totalPrice = totalAmount - discountPrice;

	        if (totalPrice < 0) {
	            totalPrice = 0;
	        }

	        $("#totalPrice").val(totalPrice); 
	    });
	});

	   
	   $(function() {
		    $('#payOrder').click(function() {
				seqListSize = $('#hiddenSeqCount').val();
        		seqList = $('#basketSeq1').val();
        		for(let i = 2; i<=seqListSize ; i ++){
        		    seqList = $('#basketSeq'+i).val() + "," + seqList;
        		}
		        var IMP = window.IMP; // 생략 가능
		        IMP.init('iamport'); // 'iamport' 대신 제공된 "제휴사 식별코드" 사용
		        IMP.request_pay({
		            pg: 'inicis', // 1.1.0 버전부터 지원됨
		            pay_method: 'card',
		            merchant_uid: 'merchant_' + new Date().getTime(),
		            name: '멀개미:결제테스트',
		            amount: 1,
		            buyer_email: 'test@naver.com',
		            buyer_name: $('#userName').val(),
		            buyer_tel: $('#tel').val(),
		            buyer_addr: $('#address').val(),
		            buyer_postcode: $('#zip-code').val(),
		        }, function(rsp) {
		            if (rsp.success) {
		        		
		                //[1] imp_uid를 서버 측에서 결제정보를 조회하기 위해 jQuery ajax로 전달
		                jQuery.ajax({
		                    url: "paySuccess.do",
		                    type: 'POST',
		                    dataType: 'text',
		                    data: {
		                        imp_uid: rsp.imp_uid,
		                        seqList: seqList,
		                        "userId": $('#userId').val(),
		                        "userName": $('#userName').val(),
		                        "address": $('#address-1').val() +" "+ $('#address-2').val(),
		                        "tel": $('#tel').val(),
		                        "price": $('#price').val(),
		                        "discountPrice": $('#discountPrice').val(),
		                        "totalPrice": rsp.paid_amount,
		                        "socialId": $('#socialId').val(),
		                        "email": $('#email').val(),
		                        "point": $('#point').val(),
		                        "productId" : $('#productId').val()
		                    }
		                }).done(function(data) {
		                	alert(data)
		                    //[2] 결제 정보가 확인되고 서버에서 정상적인 서비스 루틴을 사용하는 경우
		                    if (data == '1') {
		                        var msg = '결제가 완료되었습니다.';
		                       /*  msg += '\n고유 ID: ' + rsp.imp_uid;
		                        msg += '\n상점 거래 ID: ' + rsp.merchant_uid;
		                        msg += '\n결제 금액: ' + rsp.paid_amount;
		                        msg += '\n카드 승인번호: ' + rsp.apply_num; */
		                        
		                        alert(msg);
		                        location.href = '/moneybug/main.jsp';
		                    } else {
		                        //[3] 결제가 아직 제대로 이루어지지 않았습니다.
		                        //[4] 요청한 금액과 다른 금액으로 결제가 자동 취소되었습니다.
		                       alert("fail!"); 
		                    }
		                });
		            } else {
		                var msg = '결제에 실패했습니다.';
		                msg += '\n에러 상세 정보: ' + rsp.error_msg;
		                
		                alert(msg);
		                document.location.href = 'redirect:/main.jsp';
		            }
		        });
		    });
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
				onclick="location.href='/moneybug/login.jsp'">로그인 페이지로 이동</button>
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
										<td><img src="${s3}/resources/products/${product.productImg}"" alt="Product Image"
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

			<!-- <form action="paySuccess" method="post"> -->
		
				<div class="form-group row">
					<label for="basketSeq" class="col-sm-8 col-form-label"> 장바구니 번호</label>
					<div class="col-sm-4">
						<div class="input-group">
								<c:set var="stepnumber" value="1" />
								<c:set var="countnumber" value="0" />
						<c:forEach items="${orderlist}" var="order">
								<c:set var="countnumber" value="${countnumber+stepnumber}" />
							<input type="number" class="form-control" id="basketSeq<c:out value="${countnumber}"/>" name="basketSeq" value="${order.seq}" readonly>
							</c:forEach>
							<input type="hidden" id="hiddenSeqCount" value="<c:out value="${countnumber}"/>">
						</div>
					</div>
				</div>
				<div class="form-group row">
					<label for="productId" class="col-sm-8 col-form-label"> 상품 번호</label>
					<div class="col-sm-4">
						<div class="input-group">
						<c:forEach items="${orderlist}" var="order">
							<input type="number" class="form-control" id="productId" name="productId" value="${order.productId}" readonly>
						</c:forEach>
						</div>
					</div>
				</div>
				<div class="form-group row">
					<label for="userId" class="col-sm-8 col-form-label"> 회원 아이디</label>
					<div class="col-sm-4">
						<div class="input-group">
							<input type="text" class="form-control" id="userId" name="userId" value="${orderlist[0].userId}" readonly>
						</div>
					</div>
				</div>
				<div class="form-group row">
					<label for="userName" class="col-sm-8 col-form-label"> 회원 이름</label>
					<div class="col-sm-4">
						<div class="input-group">
							<input type="text" class="form-control" id="userName" name="userName" value="${member.userName}" readonly>
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
								name="discountPrice" max="${member.point}" min="0" step="5" value="0"/>
							<button type="button" class="btn btn-danger" id="applyPoint">적용</button>
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
					<button type="button" class="btn btn-danger" id="postSearch"
						onclick="execDaumPostcode(); return false;">우편번호 찾기</button>
					<input type="text" class="form-control" id="zip-code" name="zip-code"
						placeholder="우편번호">
				</div>
				<div class="mb-3">
					<input type="text" class="form-control" id="address-1" placeholder="도로명주소" name="address-1">

				</div>
				<div class="mb-3">
					<input type="text" class="form-control" id="address-2"
						placeholder="상세주소" name="address-2">
				</div>

				<div class="d-flex justify-content-end">
					<button type="submit" class="btn btn-lg btn-info" id="payOrder">결제하기</button>
				</div>

			</form>
		</div>
		<hr>
	</div>

<%@ include file="/layout/accountAside.jsp"%>
<jsp:include page="/layout/footer.jsp"/>