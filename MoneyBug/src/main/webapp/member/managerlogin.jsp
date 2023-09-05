<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>관리자 로그인페이지</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/main.css" rel="stylesheet">
<style>
	body {
		margin: 0;
		background: #F9F5E7;
		display: flex;
	}
	
	.container {
		width: 100vw;
		height: 100vh;
		display: flex;
		align-items: center;
		justify-content: center;
	}
	
	.form-signin {
		width: 300px;
		margin: auto;
	}
</style>

<script>
  $(document).ready(function() {
    $("form").submit(function(event) {
      event.preventDefault();
      var password = $("#floatingPassword").val();
      if (password === "1234") {
        window.location.href = "../product/shopmanager.jsp";
      } else {
        alert("ERROR! 관리자가 아니라면 접근할 수 없습니다.")
      }
    });
  });
</script>

</head>
<body>

<div class="container">
<div class="form-signin">
  <form>
    <img class="mb-2" src="${s3}/resources/img/nav_icon.png" alt="nav_icon" width="70" height="70">
    <h1 class="h3 mb-3 fw-normal">Manager Login</h1>
    <p>관리자만 접속이 가능합니다.</p>

    <div class="form-floating">
      <input type="email" class="form-control" id="floatingInput" value="TEAM_moneybug" readonly>
    </div>
    <div class="form-floating">
      <input type="password" class="form-control" id="floatingPassword" placeholder="Password">
    </div>
	<hr>
    <button class="btn btn-outline-secondary w-100 py-2" type="submit">로그인</button>
  </form>
</div>
</div>	


</body>
</html>