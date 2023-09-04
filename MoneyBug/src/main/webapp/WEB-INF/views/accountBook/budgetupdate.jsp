<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<table class="table table-dark">
		<tr>
			<th>종류</th>
			<th>금액</th>
		</tr>
<c:forEach items="${budgetList}" var="budget">
		<tr>
			<td>${budget.fixedCategory} </td>
			<td><fmt:formatNumber value="${budget.price}" type="currency" />원</td>
		</tr>
</c:forEach>
</table>
