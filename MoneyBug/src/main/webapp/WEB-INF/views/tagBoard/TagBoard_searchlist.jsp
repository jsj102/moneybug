<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../../../resources/layout/header.jsp"%>
<%@ include file="../../../resources/layout/TagBoardNav.jsp"%>
	<h3>커뮤니티</h3>
<div class="container">
	 
	<br>
	<input type="text" id="searchInput" placeholder="게시글 검색">
<button id="searchButton">검색</button>
	<br>

	<table class="table table-sm mx-auto">
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
					<td>${tagBoardDTO.rowNo}</td>
					<td>[${tagBoardDTO.boardType}] <a href="TagBoard_one?seq=${tagBoardDTO.seq}">${tagBoardDTO.title}</a></td>
					<td>${tagBoardDTO.writerId}</td>
					<td>${tagBoardDTO.views}</td>
					<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
							value="${tagBoardDTO.createAt}" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<button id='newinsert'>글 쓰기</button>
	
	<%
	int pages = (int)request.getAttribute("pages");
	for(int p = 1; p <= pages; p++){
%>
	<a href="TagBoard_searchlist?searchKeyword=${param.searchKeyword}&page=<%= p %>">
		<%= p %>
	</a>  
<%		
	}
%>

<script type="text/javascript">
    $('#newinsert').click(function () {
        // 서버로부터 로그인 상태 값을 확인하여 처리
        $.ajax({
            url: "../checkLogin",
            method: "GET",
            success: function (response) {
                let loginStatus = parseInt(response);
                if (loginStatus !== 1) {
                    // 로그인 상태가 아니라면 로그인 페이지로 리다이렉션
                    location.href = "/moneybug/login.jsp"; // 실제 로그인 페이지 URL로 변경
                } else {
                    // 로그인 상태라면 글 쓰기 페이지로 이동
                    location.href = "TagBoard_insert.jsp"; // 글 쓰기 페이지 URL로 변경
                }
            },
            error: function (error) {
                location.href = "/moneybug/login.jsp"; // 에러 발생 시 로그인 페이지로 리다이렉션
            }
        });
    });
    

    // 검색 버튼 클릭 이벤트 처리
   $('#searchButton').click(function () {
    // 검색어 가져오기
    var searchKeyword = $('#searchInput').val();
    var boardType = "";
    
    $.ajax({
        url: "TagBoard_searchlist", // 1. URL 경로 수정
        method: "GET",
        data: {
        	searchKeyword: "searchKeyword",
        	boardType : "boardType"
        },
        success: function () {
            location.href = 'TagBoard_searchlist?searchKeyword=' + searchKeyword+'&page=1';
        },
        error: function () {
            alert("오류가 발생했습니다."); // 3. 오류 메시지 표시
            location.href = "TagBoard_list?page=1";
        }
    });
});


        

</script>

	
	<%@ include file="../../../resources/layout/footer.jsp"%>