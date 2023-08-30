<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<table class="expenses-table">
		<tr>
			<th>종류</th>
			<th>금액</th>
		</tr>
<c:forEach items="${expensesList}" var="expenses">
		<tr>
			<td>${expenses.fixedCategory} </td>
			<td><fmt:formatNumber value="${expenses.price}" type="currency" />원</td>
		</tr>
</c:forEach>
</table>
