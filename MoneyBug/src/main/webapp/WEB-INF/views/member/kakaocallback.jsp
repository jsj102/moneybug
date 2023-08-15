<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Kakao Call</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
</head>
<body>
    <h1>Kakao Call Page</h1>

    	<script type="text/javascript">
    $(document).ready(function() {
        $.ajax({
            type: 'POST',
            url: 'findMember',
            data: {
                'socialId': "${memberDTO.socialId}",
                'email': "${memberDTO.email}",
                'userName': "${memberDTO.username}"
            },
            success : function(member) {	
				alert("ajax success");
				if(member === 'old') {
					window.location.href = '${pageContext.request.contextPath}/main.jsp';
				} else if (member == 'new') {
					window.location.href = '${pageContext.request.contextPath}/member/myPage.do';
				} else {
					console.log('ajax return error');
				}				
			},
			error: function() {
				alert("ajax error");
			}

        });
    });
</script>
</body>
</html>