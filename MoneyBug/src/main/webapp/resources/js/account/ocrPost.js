/**
 * 
 */

 $(document).ready(function() {
            $("#ocr_button").click(function() {
                var formData = new FormData($("#ocr_form")[0]);
                $.ajax({
                    url: "/moneybug/ocr",
                    type: "POST",
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function(result) {
                        $("#price_input").val(result); // 결과를 입력란에 채움
                    },
                    error: function(error) {
                        console.log(error);
                    }
                });
            });
        });