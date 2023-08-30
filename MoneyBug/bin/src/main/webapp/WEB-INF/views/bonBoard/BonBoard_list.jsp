<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style>
    body {
        background-color: #E2EDC9; /* 배경 색상 변경 */
        font-family: Arial, sans-serif;
    }
    .container {
        background-color: #ffffff; /* 배경 색상 변경 */
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
        margin-top: 20px;
    }
    h1 {
        color: #A1C59E; /* 제목 색상 변경 */
    }
    .btn-primary {
        background-color: #BCD6BA; /* 버튼 배경 색상 변경 */
        border-color: #BCD6BA; /* 버튼 테두리 색상 변경 */
    }
    .btn-primary:hover {
        background-color: #C4D7B2; /* 버튼 마우스 호버 시 배경 색상 변경 */
        border-color: #C4D7B2;
    }
    /* Style for the reply list */
    #replyList {
        margin-top: 20px;
        list-style-type: none;
        padding: 0;
    }
    #replyList li {
        margin-bottom: 10px;
        border: 1px solid #ccc;
        padding: 10px;
        background-color: #f9f9f9;
        border-radius: 5px;
    }
</style>

<script type="text/javascript" src="../resources/js/jquery-3.6.1.js"></script>
<script type="text/javascript">
	$(function() {
		$('button').click(function() {
			alert($(this).text())
			$.ajax({
				url : "BonBoard_list2", //views/bbsList2.jsp가 결과!
				data : {
					page : $(this).text()
				},
				success : function(result) { //결과가 담겨진 table부분코드
					$('#d1').html(result)
				},
				error : function() {
					alert('실패.@@@')
				}
			}) //ajax
		})
	})
</script>
  
    <title>BonBoard_list</title>
    
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
     <style>
        @font-face {
            font-family: 'HakgyoansimWoojuR';
            src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2307-2@1.0/HakgyoansimWoojuR.woff2') format('woff2');
            font-weight: normal;
            font-style: normal;
        }
        .purple-border {
    border: 2px solid purple;
    padding: 10px;
    text-align: center;
    color: white;
    background-color: black;
  }
        body {
            background:white;
            font-family: 'HakgyoansimWoojuR';
        }
        .gradient-text {
    background: white;
    -webkit-background-clip: text;
    color: transparent;
    font-weight: bold;
    font-size: 30px;
  }
        .container {
            background-color: #A1C59E;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0px 0px 5px rgba(100, 103, 83, 0.507);
        }
        .table {
            background-color: #BCD6BA;
            color: rgb(255, 255, 255);
        }
        .table td {
            background-color:#E2EDC9;
            color:#2E4B00;
        }
        .pagination {
            justify-content: center;
        }
        .table-bordered th, .table-bordered td {
            border: 0px solid #FFFFFF;
        }
        .btn-custom {
            border-radius: 15px;
            padding:10px;
            background-color:#c5d7af;

        }
        </style>
        
        </head>
<body>
  

    <div class="container mt-5">
        <h1 class="text-center mb-4 mb-4 gradient-text" style="font-weight:bold; font-size:30px;">살까말까 게시판</h1>
        <table class="table table-hover table-bordered">
            <thead class="thead-dark">
                <tr>
                    <th scope="col" style="background-color:#C4D7B2; width: 7%;">글번호</th>
                    <th scope="col" style="background-color:#C4D7B2; width: 10%;">신청자</th>
                    <th scope="col" style="background-color:#C4D7B2; width: 50%;">제목</th>
                    <th scope="col" style="background-color:#C4D7B2; width: 10%;">투표참여수</th>
                    <th scope="col" style="background-color:#C4D7B2; width: 10%;">작성일</th>
                    <th scope="col" style="background-color:#C4D7B2; width: 10%;">조회수</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="bonBoardDTO" items="${list}" varStatus="loop">
                  
                        <tr>
                            <td>${bonBoardDTO.rowNo}</td>
                            <td>${bonBoardDTO.writerId}</td>
                            <td>
                            	<a href="BonBoard_one?seq=${bonBoardDTO.seq}">
                           			 ${bonBoardDTO.title}
                           		</a>
                           	</td>
                            <td>${bonBoardDTO.voteCount}</td>
                            <td>${bonBoardDTO.createAt}</td>
                            <td>${bonBoardDTO.views}</td>
                        </tr>
                  
                </c:forEach>
            </tbody>
        </table>
        
	<div class="text-right mt-3">
		<a href="BonBoard_insert.jsp" class="btn btn-custom"
			style="margin-right: 10%;">작성하기</a>
	</div>
        
        <nav aria-label="Page navigation">
            <ul class="pagination">
            <% 
            int pages = (int)request.getAttribute("pages");
            for(int i = 1; i <= pages; i++){
            %>
             
                    <li class="page-item">
                        <a class="page-link" href="BonBoard_list?page=<%= i %>" ><%= i %></a>
                    </li>
              <% } %>
            </ul>
        </nav>

    </div>


    <script>
        $(document).ready(function() {
            $(".page-link").click(function(e) {
                e.preventDefault();
                var pageToShow = $(this).data("page");
                $(".page-row").hide();
                $(".page-row").eq(pageToShow - 1).show();
            });
        });
    </script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>