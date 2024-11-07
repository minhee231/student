<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드</title>
<style type="text/css">
.center {
	text-align: center;
}
</style>
</head>
<body>
<div class="center">
<h3>학생 파일</h3>
	<!-- 여기에다 학생 관련 파일들 form으로 출력하기-->
	<form id="file_form" action="student_file_proc.do" method="post" enctype="multiPart/form-data">
		<input type="file" name="file">
		<input type="submit" name="submit" value="전송">

	</form>
</div>
</body>
</html>