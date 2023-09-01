<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BonBoard Update</title>
    
    <style>
        body {
           /* 페이지 배경색 변경 */
            font-family: 'HakgyoansimWoojuR'; /* 폰트 변경 */
            font-size: 18px;
            margin: 10px;
            padding: 10px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        .container {
            background-color: #E2EDC9;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
            margin: 20px auto;
            max-width: 800px;
        }
        h1 {
            color:   #A1C59E; ; /* 제목 색상 변경 */
            text-align: center;
            font-size: 30px;
        }
        .form-control {
            border: 1px solid #ccc;
            width: 100%;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
            font-size: 18px;
        }
        .table-striped th {
            background-color: #eeeeee;
            text-align: center;
        }
        .btn-primary {
            background-color: #BCD6BA; /* 버튼 배경색 변경 */
            border-color:#BCD6BA; ;
            color: #fff; /* 버튼 텍스트 색상 변경 */
            padding: 15px 20px;
            border-radius: 20px;
            font-size: 18px;
        }
        .btn-primary:hover {
            background-color: #C4D7B2; /* 버튼 호버 배경색 변경 */
        }
    </style>
</head>
<body>
   
<div class="container">
    <div class="row">
        <form method="post" action="BonBoard_update">
            <input type="hidden" name="seq" value="${param.seq}">
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
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
