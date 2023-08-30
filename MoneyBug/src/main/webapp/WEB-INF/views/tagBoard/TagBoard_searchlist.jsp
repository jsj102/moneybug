<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/layout/header.jsp"%>
<%@ include file="/layout/TagBoardNav.jsp"%>

<style>
#searchInput {
    border: none; /* 기본 테두리 제거 */
    border-bottom: 2px solid #F3969A; /* 밑줄 스타일 적용 */
    outline: none; /* 포커스시 테두리 제거 */
    padding: 5px; /* 내부 여백 추가 */
    width: 600px;
    align: center;
}

#searchButton {
    background: none;
    border: none;
    padding: 0;
    cursor: pointer;
}

/* 입력 폼과 버튼 간격 조절 */
br + #searchButton {
    margin-top: 10px;
}

.searchform {
	display: flex; /* 텍스트를 수직 및 수평으로 가운데 정렬하기 위해 flexbox 사용 */
    justify-content: center; /* 수직 가운데 정렬 */
    align-items: center; /* 수평 가운데 정렬 */
}

#searchButton img {
    width: 50px; /* 원하는 너비로 조절 */
}

.pagination {
  margin: 50px 0 70px 0;
  justify-content: center;
  display: flex;
}

#newinsert{
 margin :0 0 20px 1180px;
 padding: 5px 15px;
	cursor: pointer;
}


a {
	text-decoration: none;
}


</style>

<div class="container">
	 
	<br>
	<div class="searchform"><input type="text" id="searchInput" placeholder="검색어를 입력하세요!">
	<button id="searchButton" ><img src="../resources/img/tagboard_search.png"></button>
	</div>
	<button id='newinsert' class="btn btn-info">글 쓰기</button>
	<br>

	<table class="table table-sm mx-auto">
		<thead>
			<tr>
				<th style="width: 80px;">No.</th>
				<th style="width: 780px;">제목</th>
				<th style="width: 150px;">작성자</th>
				<th>조회수</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="tagBoardDTO">
				<tr>
					<td>${tagBoardDTO.rowNo}</td>
					<td>[${tagBoardDTO.boardType}]&nbsp <a href="TagBoard_one?seq=${tagBoardDTO.seq}">${tagBoardDTO.title}</a></td>
					<td>${tagBoardDTO.writerId}</td>
					<td>${tagBoardDTO.views}</td>
					<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
							value="${tagBoardDTO.createAt}" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<c:set var="currentPage" value="${param.page}" />
<div>
   <ul class="pagination">
    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
      <a class="page-link" href="TagBoard_searchlist?searchKeyword=${param.searchKeyword}&page=${currentPage - 1}" ${currentPage == 1 ? 'aria-disabled="true"' : ''}>«</a>
    </li>
	<c:forEach begin="1" end="${pages}" varStatus="status">
      <li class="page-item">
        <a class="page-link" href="TagBoard_searchlist?searchKeyword=${param.searchKeyword}&page=${status.index}">${status.index}</a>
      </li>
    </c:forEach>
	<li class="page-item ${currentPage == pages ? 'disabled' : ''}">
      <a class="page-link" href="TagBoard_searchlist?searchKeyword=${param.searchKeyword}&page=${currentPage + 1}" ${currentPage == pages ? 'aria-disabled="true"' : ''}>»</a>
    </li>
  </ul>
</div>
	

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
    
    if (!searchKeyword) {
        alert("검색어를 입력해주세요.");
        return false; // 댓글 내용이 없으므로 함수 종료
    }
    
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

	
	<%@ include file="/layout/footer.jsp"%>