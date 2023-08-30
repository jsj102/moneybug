<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.multi.moneybug.bonBoard.BonBoardDAO" %>
<%@ page import="com.multi.moneybug.bonBoard.BonBoardDTO" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>BonBoard Update</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Custom Styles -->
    <style>
        body {
            background-color: #f2f2f2;
            font-family: Arial, sans-serif;
        }
        .container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <%
            String userID = null;
            if (session.getAttribute("userID") != null) {
                userID = (String) session.getAttribute("userID");
            }
            if (userID == null) {
                out.println("<div class='alert alert-danger'>");
                out.println("<strong>로그인하세요.</strong>");
                out.println("<a href='login.jsp' class='alert-link'>로그인 페이지로 이동</a>");
                out.println("</div>");
            }
            int seq = 0;
            if (request.getParameter("seq") != null) {
                seq = Integer.parseInt(request.getParameter("seq"));
            }
            if (seq == 0) {
                out.println("<div class='alert alert-danger'>");
                out.println("<strong>유효하지 않은 글입니다.</strong>");
                out.println("<a href='BonBoard_list.jsp' class='alert-link'>게시판 목록으로 이동</a>");
                out.println("</div>");
       }
            BonBoardDTO bonBoardDTO = new BonBoardDAO().one(seq);
            if (!userID.equals(bonBoardDTO.getWriterId())) {
                out.println("<div class='alert alert-danger'>");
                out.println("<strong>권한이 없습니다.</strong>");
                out.println("<a href='bbs.jsp' class='alert-link'>게시판 목록으로 이동</a>");
                out.println("</div>");
            } else {
                if (request.getParameter("title") == null || request.getParameter("content") == null
                        || request.getParameter("title").equals("") || request.getParameter("content").equals("")) {
                    out.println("<div class='alert alert-danger'>");
                    out.println("<strong>모든 문항을 입력해주세요.</strong>");
                    out.println("<a href='javascript:history.back()' class='alert-link'>이전 페이지로 돌아가기</a>");
                    out.println("</div>");
                } else {
                    BonBoardDAO bonBoardDAO = new BonBoardDAO();
                    int result = bonBoardDAO.update(bonBoardDTO);
                    if (result == -1) {
                        out.println("<div class='alert alert-danger'>");
                        out.println("<strong>글 수정에 실패했습니다.</strong>");
                        out.println("<a href='javascript:history.back()' class='alert-link'>이전 페이지로 돌아가기</a>");
                        out.println("</div>");
                    } else {
                        out.println("<div class='alert alert-success'>");
                        out.println("<strong>글 수정 성공!</strong>");
                        out.println("<a href='BonBoard_list.jsp' class='alert-link'>게시판 목록으로 이동</a>");
                        out.println("</div>");
                    }
                }
            }
        %>
    </div>
</body>
</html>
