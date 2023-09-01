<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@page import="com.multi.moneybug.bonBoard.BonBoardDAO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

    <div class= "container">
    	<div class= "row">
    		<form method="post" action="BonBoard_update">
    		<input type="hidden" name="seq" value="${param.seq}">
    			<table class= "table table-stripped" style= "text-align: center; boarder: 1px solid #dddddd">
	    	    	<thead>
		    	    	<tr>
		    	    		<th colspan= "2" style= "background-color: #eeeeee; text-align: center;">게시판 글 수정 양식</th>
		    	    	</tr>
	    	    	</thead>
			    	<tbody>
			    		<tr>
			    			<td><input type="text" class="form-control" placeholder="글 제목"  name="title" maxlength="50" value="${param.title}"></td>
			    		</tr>
			    		<tr>
			    			<td><textarea class="form-control" placeholder="글 내용"  name="content" maxlength="2048" style= "height:350px">
			    				${param.content}
			    			</textarea></td>
			    		</tr>
			    	</tbody>
    	    	</table>
    	    	<input type="submit" class="btn btn-primary pull-right" value="글수정">
    		</form>
    	    </div>
    </div>
</body>
</html>