<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% application.setAttribute("s3","https://moneybugbucket.s3.ap-northeast-2.amazonaws.com"); %>
<jsp:include page="/layout/header.jsp" />

<style>
html, body {
	height: 100%;
}

body {
	background: #F9F5E7;
	display: flex;
	flex-direction: column;
	height: 100%;
	flex: 1;
	margin: 0;
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
	let countinput = 0;
	countinput = $('#hiddenNumber').val();
	for(let i = 1; i <= countinput ; i++){
		$('#product_total' +i).html($('#productPrice_' +i).html()*$('#product_count' +i).val());
	}
	
	
	
	
	$('.form-control').on('input', function() {
		countinput = $('#hiddenNumber').val();
		for(let i = 1; i <= countinput ; i++){
			$('#product_total' +i).html($('#productPrice_' +i).html()*$('#product_count' +i).val());
		}
	});//$('#productPrice_' +i) 부분만 해결하면 끝 
	

    $('.checkboxclass1').on('change', function() {
        countinput = $('#hiddenNumber').val();
        let totalPrice = parseInt(0);
        for(let i = 1 ; i <= countinput ; i ++){
            var checkbox = document.getElementById("checkbox"+i);
            var ischecked = checkbox.checked;
            // checkbox가 체크되어 있는지 확인
            if (ischecked) {
            	totalPrice = totalPrice + parseInt($('#product_total' +i).html());
            } else {
            }
        }
            $('#totalAmount').html(totalPrice);
    });//checkbox
    
	$('#order').click(function() {
		let productId;
		let seq;
		let newCount;
		let seqList = [];
		let idList = [];
		countinput = $('#hiddenNumber').val();
		for(let i = 1 ; i <=countinput ; i ++){
			newCount = $('#product_count' +i).val();
			productId =  $('#productId' +i).val();
			var checkbox = document.getElementById("checkbox"+i);
			var ischecked = checkbox.checked;
			if (ischecked) {
            	seqList.push($('#productSeq' +i).val());
            	idList.push($('#productId' +i).val());
            }
			console.log(idList)
			console.log(seqList)
			
		$.ajax({
			url : "${pageContext.request.contextPath}/updateQuantity",
			data : {
				productId : productId,
				newCount : newCount
				},
			method : "POST",
			success: function(seq){
				}
			})//ajax udate
		}//for
	    $('#totalAmount2').val($('#totalAmount').html());
	    $('#selectedId_').val(idList);
	    $('#seletedSeq_').val(seqList);
	})//order
	
    
});


function deleteProduct(userNickname, productId, seq) {
    if (confirm("정말로 상품을 삭제하시겠습니까?")) {
        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/deleteProduct',  // 삭제 요청을 처리할 백엔드 엔드포인트 URL
            data: {
                productId: productId,
                seq: seq
                
            },
            success: function(response) {
            	alert(response)
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
								<c:set var="stepnumber" value="1" />
								<c:set var="countnumber" value="0" />


								<c:forEach items="${basketList}" var="basket">
									<c:set var="countnumber" value="${countnumber+stepnumber}" />
									<c:forEach items="${productList}" var="product">
										<c:if test="${basket.productId eq product.productId}">
											<tr>
												<td>${product.productType}</td>
												<td><img
													src="${s3}/resources/products/${product.productImg}"
													" alt="Product Image" width="150px" height="150px" /></td>
												<td>${product.productName}</td>
												<td id="productPrice_<c:out value="${countnumber}"/>">${product.productPrice}</td>
												<td><input type="number"
													class="form-control text-center"
													id="product_count<c:out value="${countnumber}"/>"
													value="${basket.productCount}" min="" required></td>
												<td id="product_total<c:out value="${countnumber}"/>"
													class="productTotal" />
												</td>
												<!-- 결과를 출력할 공간 -->


												<td><input type="checkbox" name="selectedProducts"
													id="checkbox<c:out value="${countnumber}"/>"
													value="${basket.productId}, ${basket.seq}"
													class="checkboxclass1" /></td>
												<td><button type="button"
														class="delete-btn btn btn-info"
														onclick="deleteProduct('${userNickname}', ${basket.productId}, ${basket.seq})">삭제</button>
													<input type="hidden"
													id="productId<c:out value="${countnumber}"/>"
													value="${basket.productId}"> <input type="hidden"
													id="productSeq<c:out value="${countnumber}"/>"
													value="${basket.seq}"></td>
											</tr>
										</c:if>
									</c:forEach>
								</c:forEach>
							</tbody>
						</table>
						<div class="orderSum">
							총 주문 금액: <span id="totalAmount">${totalAmount}원</span>
						</div>
						<input id="hiddenNumber" value="<c:out value="${countnumber}"/>"
							type="hidden">
						<div class="d-flex justify-content-center mt-3">
							<input type="hidden" id="totalAmount2" name="totalAmount"
								value="${totalAmount}"> <input type="hidden"
								id="selectedId_" name="selectedId" value="${productId}" /> <input
								type="hidden" id="seletedSeq_" name="seletedSeq"
								value="${basket.seq}" />
							<button type="submit" class="btn btn-lg btn-secondary" id="order">주문하기</button>
					</c:otherwise>
				</c:choose>
		</div>
		</form>
	</div>
	</div>

	<%@ include file="/layout/accountAside.jsp"%>
	<jsp:include page="/layout/footer.jsp" />