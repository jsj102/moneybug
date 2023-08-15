function id_remove(reply_id){
				alert("함수호출 성공 reply_id>> " + reply_id)
				$.ajax({
					url: "reply_delete",
					data: {
						id: reply_id
					},
					success: function(views_result) {
						alert("views호출 성공 !>> " + views_result)
						if(views_result != 0){
							$('#' + reply_id).parent().remove()
						}else{
							alert("댓글삭제 실패");
						}
					}, 
					error: function() {
						alert("실패!")
					}//error
				}) //ajax
}
//onclick="id_remove(${dto.id})"