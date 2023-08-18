<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Kakao Call</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
</head>
<body>
<script type="text/javascript">
    $(document).ready(function() {
        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/member/findMember.do',
            data: {
                'socialId': "${memberDTO.socialId}",
                'email': "${memberDTO.email}",
                'userName': "${memberDTO.userName}"
            },
            success : function(member) {	
				if(member === 'old') {
					window.location.href = '${pageContext.request.contextPath}/main.do';
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