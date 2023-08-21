<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script></script>
<%@ include file="../resources/layout/header.jsp"%>
<%@ include file="../resources/layout/accountNav.jsp"%>
<script type="text/javascript">
	$(function() {
		let countinput = 1;
		$('#moneyinput1').on('input', function() {
            this.value = this.value.replace(/[^\d]/g, '');
   		});//인풋에 입력시 숫자외의 값 제거
		
		//ajax로 resultexpenses에 고정지출값 조회

		$.ajax({
			url : "expensesfirst",
			method : "POST",
			success : function(result) {
				$('#resultexpenses').html(result);
			}
		});//ajax

		$('#addLine')
				.click(
						function() {
							countinput = countinput + 1;
							console.log(countinput);
							$('#expensestoption')
									.append(
											'<br>'
													+ '<select name="expenses'+countinput+'" id="expenses'+countinput+'">'
													+ '<option value="주거/통신">주거/통신</option>'
													+ '<option value="식비">식비</option>'
													+ '<option value="교통/차량">교통/차량</option>'
													+ '<option value="의료/건강">의료/건강</option>'
													+ '<option value="교육">교육</option>'
													+ '<option value="금융">금융</option>'
													+ '<option value="생활용품">생활용품</option>'
													+ '<option value="패션/미용">패션/미용</option>'
													+ '<option value="가족">가족</option>'
													+ '<option value="유흥">유흥</option>'
													+ '<option value="문화/여가">문화/여가</option>'
													+ '<option value="선물/경조사/회비">선물/경조사/회비</option>'
													+ '<option value="마트/편의점/쇼핑">마트/편의점/쇼핑</option>'
													+ '<option value="반려동물">반려동물</option>'
													+ '<option value="기타">기타</option>'
													+ '</select> '
													+ '<input id="moneyinput'
													+countinput+'" placeholder="금액 입력란" class="moneyinput" value="0">');
							
					        $('#moneyinput' + countinput).on('input', function() {
					            this.value = this.value.replace(/[^\d]/g, '');
					        });//인풋에 입력시 숫자외의 값 제거
						})//한줄추가

		$('#addexpenses').click(function() {
			let expensesList = [];
			let moneyList = [];

			for (let i = 1; i <= countinput; i++) {
				expensesList.push($('#expenses' + i).val());
				moneyList.push($('#moneyinput' + i).val());
			}

			$.ajax({
				url : "expensesupdate",
				method : "POST",
				data : {
					expensesList : JSON.stringify(expensesList),
					moneyList : JSON.stringify(moneyList),
				},
				success : function(result) {
					$.ajax({
						url : "expensesfirst",
						method : "POST",
						success : function(result) {
							$('#resultexpenses').html(result);
						}
					});//ajax
				}
			});//ajax
		}) //입력 전송
	})
</script>
<div id="section" align="center">
	<br>
	<br>	<br>
	<br>	<br>
	<br>	<br>
	<br>
	<div style="background-color: rgba(255, 255, 255, 0.295); border-radius: 30px; width: 500px;">
	<h1>고정지출(List)</h1>

	<br> <br>

		<div id="expensestoption">
			<select name="expenses1" id="expenses1">
				<option value="주거/통신">주거/통신</option>
				<option value="식비">식비</option>
				<option value="교통/차량">교통/차량</option>
				<option value="의료/건강">의료/건강</option>
				<option value="교육">교육</option>
				<option value="금융">금융</option>
				<option value="생활용품">생활용품</option>
				<option value="패션/미용">패션/미용</option>
				<option value="가족">가족</option>
				<option value="유흥">유흥</option>
				<option value="문화/여가">문화/여가</option>
				<option value="선물/경조사/회비">선물/경조사/회비</option>
				<option value="마트/편의점/쇼핑">마트/편의점/쇼핑</option>
				<option value="반려동물">반려동물</option>
				<option value="기타">기타</option>
			</select> <input id="moneyinput1" placeholder="금액 입력란" class="moneyinput" value="0">
			<button id="addexpenses">완료</button>

		</div>
		<br>
		<button id="addLine" class="addline">+한줄추가</button>


		<br> <br>
		<div id="resultexpenses">총 고정지출 : 0원</div>
	</div>
</div>
<%@ include file="../resources/layout/footer.jsp"%>