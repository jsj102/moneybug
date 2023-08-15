<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../../../resources/layout/header.jsp"%>
<div class="container">
	 
	<h3>커뮤니티</h3>
	<br>

	<table class="table table-sm"
		style="margin-left: auto; margin-right: auto;">
		<thead>
			<tr>
				<th>No.</th>
				<th>제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="tagBoardDTO">
				<tr>
					<td>${tagBoardDTO.seq}</td>
					<td>[${tagBoardDTO.boardType}] <a href="TagBoard_one?seq=${tagBoardDTO.seq}">${tagBoardDTO.title}</a></td>
					<td>${tagBoardDTO.writerId}</td>
					<td>${tagBoardDTO.views}</td>
					<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
							value="${tagBoardDTO.createAt}" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<a href="TagBoard_insert.jsp"><button>글 쓰기</button></a>
	
	<%@ include file="../../../resources/layout/footer.jsp"%>