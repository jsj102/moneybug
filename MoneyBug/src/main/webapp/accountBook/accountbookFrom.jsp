<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<script></script>
<%@ include file="../resources/layout/header.jsp"%>

<div id="nav" class="dropdown">
	<h2><메뉴></h2>
	<a href="/moneybug/accountBook/accountDetail_List.jsp">내역 작성</a>
	<br>
	<br>
	<button class="dropbtn">보고서</button>
	<div class="dropdown-content">
		<a href="index.jsp">●월별보고서</a>
		<a href="index.jsp">●월별지출</a>
		<a href="index.jsp">●월별수입</a>
	</div>
	<br>
	<br>
	<button class="dropbtn">설정</button>
	<div class="dropdown-content">
		<a href="index.jsp">●목표설정</a><br>
	</div>
</div>


<div id="section">

	<h3>가계부 메인 페이지</h3>
	<br>


	<table>

		<tr>
			<td>
				<button id="b2">작성</button>

			</td>
			<td>
				<button id="b2">내역</button>
			</td>
		</tr>
	</table>
</div>
<%@ include file="../resources/layout/footer.jsp"%>

