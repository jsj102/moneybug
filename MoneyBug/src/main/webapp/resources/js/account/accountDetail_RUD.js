$(document).ready(function() {
    $.ajax({
        url: "/moneybug/readAll.accountDetail",
        type: "POST",
        data:{accountBookId:1}, //나중에 세션값으로 잡아야됨
        success: function(response) {
            $("#accountList").html(response);
        },
        error: function(xhr, status, error) {
            console.error("AJAX 요청 실패:", status, error);
        }
    });
});
