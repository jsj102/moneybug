<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/layout/header.jsp"/>
<%@ include file="/layout/accountNav.jsp"%>

<style>

html, body{
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


  .account_section {
    width: 80vw;
    text-align: center;
    padding: 100px 0;
    margin: 0 auto;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    padding-left: 250px; 
  }
  
</style>

<div class="account_section">

	<h3>가계부 메인 페이지</h3>
	<br>
	<table>
		<tr>
			<td><a href="/moneybug/accountBook/accountDetail_List.jsp">
				<button class="btn btn-success" >작성</button>
			</a></td>
			<td><a href="/moneybug/accountBook/monthlyReport.jsp">
				<button class="btn btn-success" >내역</button>
			</a></td>
		</tr>
	</table>
</div>

<%@ include file="/layout/accountAside.jsp"%>
<jsp:include page="/layout/footer.jsp"/>

