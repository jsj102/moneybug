<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/layout/header.jsp"%>
<%@ include file="/layout/accountNav.jsp"%>

<style>
html, body {
	height: 100%;
}

body {
	background: #F9F5E7;
	display:flex;
	flex-direction:column;
	height:100%;
	flex:1;
	margin: 0;
}

.container {
padding-left: 250px;
}

.addcontainer {
box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
padding: 50px;
background: white;
}

.addline {
	width: 350px;
}

.moneyinput {
	width: 250px;
}
</style>
<script type="text/javascript">
    $(function() {
	let countinput = 1;

	let accountBookId = -1;
	$.ajax({
	    url : "seq",
	    success : function(acountSeq) {
		accountBookId = acountSeq;
		$.ajax({
		    url : "budgetfirst",
		    method : "POST",
		    data : {
			accountBookId : accountBookId
		    },
		    success : function(result) {
			// 결과를 resultbudget 요소에 삽입
			$('#resultbudget').html(result);

		    }
		});//ajax
	    },
	    error : function() {

	    }
	}) //accountBookId
	//ajax로 resultbudget에 월간 입력값 조회
	$('#moneyinput1').on('input', function() {
	    this.value = this.value.replace(/[^\d]/g, ''); //정규식) ^-> 제외한 문자를 찾음. d-> 숫자 = 숫자를 제외한 문자를 찾음  / g->this.value의 전역에서 / ''로 replace
	});//인풋에 입력시 숫자외의 값 제거

	$('#addLine')
		.click(
			function() {
			    countinput = countinput + 1;
			    $('#budgetoption')
				    .append(
					    '<br>'
						    + '<select name="budget'+countinput+'" id="budget'+countinput+'">'
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
		+countinput+'" placeholder="금액 입력란" class="moneyinput" value="0">     ');

			    $('#moneyinput' + countinput).on(
				    'input',
				    function() {
					this.value = this.value.replace(
						/[^\d]/g, '');
				    });//인풋에 입력시 숫자외의 값 제거

			})//한줄추가

	$('#addBudget').click(function() {
	    let budgetList = [];
	    let moneyList = [];

	    for (let i = 1; i <= countinput; i++) {
		budgetList.push($('#budget' + i).val());
		moneyList.push($('#moneyinput' + i).val());
	    }

	    $.ajax({
		url : "budgetupdate",
		method : "POST",
		data : {
		    accountBookId : accountBookId,
		    budgetList : JSON.stringify(budgetList),
		    moneyList : JSON.stringify(moneyList),
		},
		success : function(result) {
		    $.ajax({
			url : "budgetfirst",
			method : "POST",
			data : {
			    accountBookId : accountBookId
			},
			success : function(result) {
			    // 결과를 resultbudget 요소에 삽입
			    $('#resultbudget').html(result);
			}
		    });//ajax
		}
	    });//ajax
	}) //입력 전송
    })
</script>
<div class="container" align="center">
	<br> <br>
	<div style="border-radius: 30px; width: 1000px;" class="addcontainer">

		<h1>월간 예산(List)</h1>

		<br> <br>

		<div id="budgetoption">
			<select name="budget1" id="budget1">
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
			</select> <input id="moneyinput1" placeholder="금액 입력란" class="moneyinput"
				value="0">
			<button id="addBudget" class="btn btn-success">완료</button>

		</div>
		<br>
		<button id="addLine" class="addline btn btn-dark">+한줄추가</button>


		<br> <br>
		<div id="resultbudget">총 예산 : ₩0원</div>
	</div>
</div>
<%@ include file="/layout/accountAside.jsp"%>
<%@ include file="/layout/footer.jsp"%>