<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/layout/header.jsp"%>
<%@ include file="/layout/TagBoardNav.jsp"%>

<style>
.mainlist {
	height: 100%;
	border: 2px solid #F3969A; /* 테두리 색상과 두께 설정 */
	border-radius: 10px; /* 모서리 둥글게 만듦 */
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
    overflow: hidden;
    background-color: #fffdf5;  
    padding: 18px 0 18px 0; 

}

html, body{
	height: 100%;
	background: #F9F5E7;
}

th, td {
	padding: 3px;
    }
    

#searchInput {
    border: none; /* 기본 테두리 제거 */
    border-bottom: 2px solid #F3969A; /* 밑줄 스타일 적용 */
    outline: none; /* 포커스시 테두리 제거 */
    padding: 5px; /* 내부 여백 추가 */
    width: 600px;
    align: center;
    overflow: hidden; 
     background-color: #F9F5E7;
     font-size: 18px;
}

#searchButton {
    background: none;
    border: none;
    padding: 0;
    cursor: pointer;
    overflow: hidden; 
}

/* 입력 폼과 버튼 간격 조절 */
br + #searchButton {
    margin-top: 10px;
}

.searchform {
	display: flex; /* 텍스트를 수직 및 수평으로 가운데 정렬하기 위해 flexbox 사용 */
    justify-content: center; /* 수직 가운데 정렬 */
    align-items: center; /* 수평 가운데 정렬 */
    overflow: hidden; 
}

#searchButton img {
    width: 50px; /* 원하는 너비로 조절 */
}

.pagination {
  margin: 50px 0 70px 0;
  justify-content: center;
  display: flex;
  overflow: hidden; 
}

#newinsert {
    float: right; /* 오른쪽으로 이동 */
    margin-right: 40px; /* 오른쪽 여백 추가 */
}


a {
	text-decoration: none;
}

.page-item.active .page-link {
    background-color: #F3969A; 
    border-color: #F3969A; 
}

</style>

<div class="container">
	 
	<br>
	<div class="searchform"><input type="text" id="searchInput" placeholder="검색어를 입력하세요!">
	<button id="searchButton" ><img src="${s3}/resources/img/tagboard_search.png"></button>
	</div>
	<button id='newinsert' class="btn btn-info">글 쓰기</button>
	<br>
	<br>
<div class="mainlist">
	<table>
		<thead>
			<tr style=" font-size: 18px;">
				<th style="width: 90px;">No.</th>
				<th style="width: 700px;">제목</th>
				<th style="width: 150px;">작성자</th>
				<th style="width: 90px;">조회수</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="tagBoardDTO">
				<tr style=" font-size: 20px;">
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
	</div>
	<br>
	
	<c:set var="currentPage" value="${param.page}" />
<div>
   <ul class="pagination">
    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
      <a class="page-link" href="TagBoard_searchlist?searchKeyword=${param.searchKeyword}&boardType=${param.boardType}&page=1" ${currentPage == 1 ? 'aria-disabled="true"' : ''}><<</a>
    </li>
    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
      <a class="page-link" href="TagBoard_searchlist?searchKeyword=${param.searchKeyword}&boardType=${param.boardType}&page=${currentPage - 1}" ${currentPage == 1 ? 'aria-disabled="true"' : ''}><</a>
    </li>
	<c:set var="startPage" value="${currentPage - (currentPage % 5 == 0 ? 4 : (currentPage % 5) - 1)}" />
<c:choose>
    <c:when test="${startPage < 1}">
        <c:set var="startPage" value="1" />
    </c:when>
</c:choose>

	<c:set var="endPage" value="${startPage + 4}" />
	<c:choose>
    <c:when test="${endPage > pages}">
        <c:set var="endPage" value="${pages}" />
    </c:when>
</c:choose>
	<c:forEach begin="${startPage}" end="${endPage}" varStatus="status">
      <li class="page-item ${currentPage == status.index ? 'active' : ''}">
        <a class="page-link" href="TagBoard_searchlist?searchKeyword=${param.searchKeyword}&boardType=${param.boardType}&page=${status.index}">${status.index}</a>
      </li>
    </c:forEach>
	<li class="page-item ${currentPage == pages ? 'disabled' : ''}">
      <a class="page-link" href="TagBoard_searchlist?searchKeyword=${param.searchKeyword}&boardType=${param.boardType}&page=${currentPage + 1}" ${currentPage == pages ? 'aria-disabled="true"' : ''}>></a>
    </li>
	<li class="page-item ${currentPage == pages ? 'disabled' : ''}">
      <a class="page-link" href="TagBoard_searchlist?searchKeyword=${param.searchKeyword}&boardType=${param.boardType}&page=${pages}" ${currentPage == pages ? 'aria-disabled="true"' : ''}>>></a>
    </li>
  </ul>
</div>


<br>	
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

    <%@ include file="/layout/accountAside.jsp"%>
	<%@ include file="/layout/footer.jsp"%>