<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>파일 업로드</title>
    <link rel="stylesheet" type="text/css" href="/css/egovframework/student_table.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    $(document).ready(function () {
        var studentId = ${studentId};
        $("#uploadBtn").click(function () {
            var fileInput = $("#fileInput")[0];
            var file = fileInput.files[0];

            if (file) {
                var formData = new FormData();
                formData.append("file", file);
                formData.append("student_id", studentId);

                $.ajax({
                    url: "/file/student_file_proc.do",
                    type: "POST",
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function (response) {
                        alert("파일 업로드 성공");
                        console.log(response);
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(jqXHR, textStatus, errorThrown);
                    }
                });
            } else {
                alert("파일을 선택하세요");
            }
        });
    });

	    function fileDownload(button) {
	        const originalName = $(button).data("original-name");
	        const storedName = $(button).data("stored-name");

	        $.ajax({
	            url: '/file/file_download_proc.do',
	            type: 'GET',
	            data: {
	                originalName: originalName,
	                storedName: storedName
	            },
	            xhrFields: {
	                responseType: 'blob'
	            },
	            success: function(data, status, xhr) {
	                const blob = new Blob([data]);
	                const downloadUrl = URL.createObjectURL(blob);

	                const a = document.createElement('a');
	                a.href = downloadUrl;
	                a.download = originalName;
	                document.body.appendChild(a);
	                a.click();
	                document.body.removeChild(a);

	                URL.revokeObjectURL(downloadUrl);
	            },
	            error: function(xhr, status, error) {
	                alert("파일 다운로드에 실패했습니다.");
	            }
	        });
	    }

    function fileDelete(button) {
        const fileId = $(button).data('file-id');
        const storedName = $(button).data("stored-name");
        const studentId = ${studentId};

        $.ajax({
            url: '/file/file_delete_proc.do',
            type: 'POST',
            data: { fileId: fileId,
            		storedName: storedName
            	},
            success: function(response) {
                alert('파일이 성공적으로 삭제되었습니다.');
                window.location.href = "/student/student_view.do?student_id=" + studentId;
            },
            error: function(xhr, status, error) {
                alert('파일 삭제에 실패하였습니다.');
                console.error('Error:', error);
            }
        });
    }



</script>
<style type="text/css">
.center {
	text-align: center;
}

</style>
</head>
<body>
    <h3>학생 파일 업로드</h3>
    <form class="center" id="fileForm" class="selectBox">
    <table class="dataTable">
    	<tr>
    		<th></th>
    		<th>파일명</th>
    		<th>작업</th>
    	</tr>
    	<c:forEach var="files" items="${studentFiles}">
    		<tr>
    			<td><button
           		data-file-id="${files.fileId}"
           		data-stored-name="${files.storedName}"
           		onClick="fileDelete(this)"
           	>삭제</button></td>
    			<td	><c:out value="${files.originalName }"></c:out>
    			<td><button type="button" id="downloadBtn"
                    data-original-name="${files.originalName}"
                    data-stored-name="${files.storedName}"
                    onClick="fileDownload(this)">
                파일 다운로드
            </button></td>

    		</tr>
    	</c:forEach>
    	<tr>
        	<td><input type="hidden" id="studentId" value="${studentId}"/></td>
        	<td><input type="file" id="fileInput" name="file"></td>
        	<td><button type="button" id="uploadBtn">파일 업로드</button></td>
        </tr>
    </table>
    	<input type="hidden" id="studentId" value="${studentId}"/>
    </form>


</body>
</html>
