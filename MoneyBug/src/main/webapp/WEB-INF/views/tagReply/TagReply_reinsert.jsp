<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<br>
				${tagReplyDTO.writerId}
				<br> 
				${tagReplyDTO.content} 
				
				<br> 
				<p style="font-size: 12px;">
					<fmt:formatDate value="${tagReplyDTO.createAt}"
					pattern="yyyy-MM-dd HH:mm" />
				</p>
				<button class="tagreplyupdate"
				style="background: grey; color: white;">수정</button>
				<button class="tagreplydelete"
				style="background: grey; color: white;">삭제</button>
				
			<br>