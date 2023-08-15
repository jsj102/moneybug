<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script></script>
<%@ include file="../resources/layout/header.jsp"%>

<div id="nav" class="dropdown">
	<h2>
		<메뉴>
	</h2>
	<a href="/moneybug/accountBook/accountDetail_List.jsp">내역 작성</a>

	<button class="dropbtn">보고서</button>
	<div class="dropdown-content">
		<a href="index.jsp">●월별보고서</a> <a href="index.jsp">●월별지출</a> <a
			href="index.jsp">●월별수입</a>
	</div>
	<br> <br>
	<button class="dropbtn">설정</button>
	<div class="dropdown-content">
		<a href="index.jsp">●목표설정</a><br>
	</div>
</div>

<div id="section">
	<form action="/moneybug/insert.accountDetail">
		<!-- ../insert.accountDetail -->
		<table>
			<tr>
				<td colspan="2" style="text-align: center">입력</td>
			</tr>
			<tr>
				<td><input name="accountBookId" type="text" value="1">가계부
					아이디</td>
			</tr>
			<tr>
				<td><input type='date' name="usedAt" id="usedAt" /></td>
			</tr>
			<tr>
				<td><select id="expenses" name="accountType">
						<option value="수입">수입</option>
						<option value="지출">지출</option>
				</select></td>
			</tr>
			<tr>
				<td>금액</td>
			</tr>
			<tr>
				<td><input name="price" type="text">원</td>
			</tr>
			<tr>
				<td>분류</td>
			</tr>
			<tr>
				<td><select id="expenses" name="accountCategory">
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
				</select></td>
			</tr>
			<tr>
				<td>내용</td>
			</tr>
			<tr>
				<td><textarea name="description" cols="30" rows="3"
						placeholder="영수증 사진을 통해서 기록하려면 오른쪽 OCR 버튼을 이용해주세요..."></textarea>
					 
				</td>
			</tr>
			<tr>
				<td>
					<button>저장</button>
				</td>
			</tr>
		</table>
	</form>

<h6>OCR 이미지 업로드</h6>
<form action="" method="post" enctype="multipart/form-data">
                업로드할 이미지 선택:<br><input type="file" name="file" id="file">
<input type="submit" value="OCR" name="submit">
</form>
</div>





<%@ include file="../resources/layout/footer.jsp"%>

<script type="text/javascript">
// 오늘 날짜를 가져옵니다.
const currentDate = new Date();
// 'YYYY-MM-DD' 형식의 날짜 문자열로 변환합니다.
const dateString = currentDate.toISOString().split('T')[0];
// input 요소의 value 속성에 날짜를 설정합니다.
document.getElementById('usedAt').value = dateString;
</script>
