<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../../../resources/layout/header.jsp"%>

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

<body>
  <div class="basket-container">
    <div class="user-container d-flex flex-column align-items-center">
      <c:if test="${not empty userNickname}">
        <h2>${userNickname}님의 장바구니</h2>
        <c:choose>
          <c:when test="${basketIsEmpty}">
            <div style="margin-top: 20px;">
              <a href="${pageContext.request.contextPath}/product/shoplist?page=1"
                class="btn btn-primary ml-2 center">상품 담으러 가기</a>
            </div>
          </c:when>
        </c:choose>
      </c:if>
      <c:if test="${empty userNickname}">
        <p>사용자 정보가 없습니다.</p>
        <button class="btn btn-dark" id="login" onclick="location.href='login.jsp'">로그인 페이지로 이동</button>
      </c:if>
    </div>

    <div class="order-container">
      <form action="orderlist" method="post">
        <c:choose>
          <c:when test="${basketIsEmpty}">
            <p>장바구니에 담긴 상품이 없습니다.</p>
          </c:when>
          <c:otherwise>
            <table class="table table-light table-hover table-striped text-center">
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
                        <td><img src="${product.productImg}" alt="Product Image" width="150px" height="150px" /></td>
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
            <div class="orderSum">
				총 주문 금액: <span id="totalAmount">${totalAmount}원</span>
				  </div>
           <div class="d-flex justify-content-center mt-3">
					<input type="hidden" id="totalAmount2" name="totalAmount"
						value="${totalAmount}"> <input type="hidden"
						id="selectedId_" name="selectedId" value="${productId}" /> <input
						type="hidden" id="seletedSeq_" name="seletedSeq"
						value="${basket.seq}" />
					<button type="submit" class="btn btn-lg btn-secondary">주문하기</button>
			</div>
          </c:otherwise>
        </c:choose>
      </form>
    </div>
  </div>



  <%@ include file="../../../resources/layout/footer.jsp"%>
</body>
</html>
