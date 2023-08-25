<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../resources/layout/header.jsp"%>
<%@ include file="../resources/layout/accountNav.jsp"%>

<style>
body {
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
			<td>
				<button class="btn btn-success" >작성</button>
			</td>
			<td>
				<button class="btn btn-success" >내역</button>
			</td>
		</tr>
	</table>
</div>

<%@ include file="../resources/layout/accountAside.jsp"%>
<%@ include file="../resources/layout/footer.jsp"%>

