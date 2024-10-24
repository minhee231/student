<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학생 개인정보 에러</title>
</head>
<body>
<script>

	function errorConfirm() {
		if (confirm('해당하는 학생의 개인정보를 찾을 수 없습니다. 추가하시겠습니까?')) {
			window.location.href = `student_info_input.do?student_id=${studentId}`;
		} else {
			window.location.href = 'student_list.do';
		}
	}

	window.onload = function() {
		errorConfirm();
	};
</script>

</body>
</html>