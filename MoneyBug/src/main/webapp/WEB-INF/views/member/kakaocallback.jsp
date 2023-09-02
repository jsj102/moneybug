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
                'userName': "${memberDTO.userName}",
                'userNickname' : "카카오"+"${memberDTO.userName}"
            },
            success : function(member) {	
				if(member === 'old') {
					console.log('old');
					sendPostRequest('../main.do');
				} else if (member == 'new') {
					console.log('new');
					sendPostRequest('${pageContext.request.contextPath}/member/signUp.do');
				} else {
					console.log('ajax return error');
				}				
			},
			error: function() {
				alert("ajax error");
			}
        });
    });
	
	function sendPostRequest(url) {
	    var form = document.createElement('form');
	    form.method = 'POST';
	    form.action = url;
	    document.body.appendChild(form);
	    form.submit();
	}
</script>

</body>
</html>