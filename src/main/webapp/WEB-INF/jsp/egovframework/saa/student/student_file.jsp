<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>파일 업로드</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    $(document).ready(function () {
        var studentId = ${studentId}
        $("#uploadBtn").click(function () {
            var fileInput = $("#fileInput")[0];
            var file = fileInput.files[0];

            if (file) {
                var formData = new FormData();
                formData.append("file", file);
                formData.append("student_id", studentId);

                $.ajax({
                    url: "student_file_proc.do",
                    type: "POST",
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function (response) {
                        alert("파일 업로드 성공");
                        console.log(response);
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert("파일 업로드 실패");
                        console.log(jqXHR, textStatus, errorThrown);
                    }
                });
            } else {
                alert("파일을 선택하세요");
            }
        });
    });
</script>
<style type="text/css">
.center {
	text-align: center;
}

</style>
</head>
<body>
    <h3>학생 파일 업로드</h3>
    <form class="center" id="fileForm">
        <!-- 파일 선택 -->
        <input type="file" id="fileInput" name="file">
        <!-- 파일을 업로드할 학생 ID -->
        <input type="hidden" id="studentId" value="${studentId}" /> <!-- 서버에서 studentId 전달 -->
        <button type="button" id="uploadBtn">파일 업로드</button>
    </form>


</body>
</html>
