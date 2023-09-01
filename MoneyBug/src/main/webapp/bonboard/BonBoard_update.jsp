<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BonBoard Update</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #E2EDC9;
            font-family: Arial, sans-serif;
        }
        .container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
            margin: 20px auto; /* 페이지 중앙 정렬을 위해 수정 */
            max-width: 800px; /* 최대 폭 지정 */
        }
        h1 {
            color: #A1C59E;
        }
        .form-control {
            border: 1px solid #dddddd;
            width: 100%; /* 폼 요소 너비 100%로 수정 */
        }
        .table-striped th {
            background-color: #eeeeee;
            text-align: center;
        }
        .btn-primary {
            background-color: #BCD6BA;
            border-color: #BCD6BA;
        }
        .btn-primary:hover {
            background-color: #C4D7B2;
            border-color: #C4D7B2;
        }
    </style>
</head>
<body>
   
<div class="container">
    <div class="row">
        <form method="post" action="BonBoard_update">
            <input name="seq" value="${param.seq}">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th colspan="2" class="text-center">게시판 글 수정 양식</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><input type="text" class="form-control" placeholder="글 제목" name="title" maxlength="50" value="${param.title}"></td>
                    </tr>
                    <tr>
                        <td>
                            <textarea class="form-control" placeholder="글 내용" name="content" maxlength="2048" style="height: 350px;">${param.content}</textarea>
                        </td>
                    </tr>
                </tbody>
            </table>
            <input type="submit" class="btn btn-primary pull-right" value="글 수정">
        </form>
         <a href="javascript:history.back()">뒤로 가기</a>
        
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
