<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>학생 등록</title>
	<link rel="stylesheet" type="text/css" href="/css/egovframework/student_table.css">
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
	<style>
		.dataTable { border-collapse: collapse; width:800px; }
		.dataTable th, td { border:1px solid #ccc; padding:0; margin:0; }
		.tac { text-align:center }
		.tal { text-align:left }
		.tar { text-align:right }
	</style>
	<script>
	function fn_saveStudent() {
		var frm = document.studentFrm;
		var checkText ="";

		if (!$("#student_id").val()) {
			alert("학생번호를 입력하세요.");
			$("#student_id").focus();
			return;
		}

		if (!$("#student_name").val()) {
			alert("학생이름을 입력하세요.");
			$("#student_name").focus();
			return;
		}

		if (!$("input[name='state']:checked").val()) {
            alert("재적상태를 선택해주세요.");
			return;
		}

		if (!$("input[name='student_sex']:checked").val()) {
            alert("성별을 선택해주세요.");
			return;
		}

		if (!$("input[name='student_department']:checked").val()) {
            alert("학과를 선택해주세요.");
			return;
		}

		if (!$("input[name='student_grade']:checked").val()) {
            alert("학년를 선택해주세요.");
			return;
		}

		if (!$("#student_class").val()) {
			alert("번호를 입력하세요.");
			$("#student_class").focus();
			return;
		}

		if (!$("#student_number").val()) {
			alert("번호를 입력하세요.");
			$("#student_number").focus();
			return;
		}

		frm.submit();
	}
	</script>
</head>

<body>
	<div>
		<h3>학생 수정</h3>
		<form name="studentFrm" id="studentFrm" method="post" action="student_edit_proc.do">
		<table class="dataTable">
			<tr>
				<th>학생번호</th>
				<td><input type="text" name="student_id" id="student_id" size="50" value="${studentView.studentId}" readonly/></td>
			</tr>
			<tr>
				<th>학생이름</th>
				<td><input type="text" name="student_name" id="student_name" size="10" value="${studentView.studentName}"/></td>
			</tr>
			<tr>
				<th>재적상태</th>
				    <td>
				        <input type="radio" name="state" id="state_o" value="O"
				               <c:if test="${studentView.state == 'O'}">checked</c:if> />O
				        <input type="radio" name="state" id="state_x" value="X"
				               <c:if test="${studentView.state == 'X'}">checked</c:if> />X
				    </td>
			</tr>
			<tr>
				<th>입학/전입 날짜</th>
				<td><input type="text" name="entrance" id="entrance" size="10" value="${studentView.entrance}" readonly/></td>
			</tr>
			<tr>
				<th>졸업/전출 날짜</th>
				<td><input type="text" name="graduation" id="graduation" size="10" value="${studentView.graduation}"/></td>
			</tr>
			<tr>
				<th>휴학년도</th>
				<td><input type="text" name="leave_year" id="leave_year" size="5" value="${studentView.leaveYear}"/></td>
			</tr>
			<tr>
				<th>퇴학년도</th>
				<td><input type="text" name="expelled_year" id="expelled_year" size="5" value="${studentView.expelledYear}"/></td>
			</tr>
			<tr>
				<th>성별</th>
				    <td>
				        <input type="radio" name="student_sex" id="student_sex_f" value="F"
				               onclick="return false;"
				               <c:if test="${studentView.studentSex == 'F'}">checked</c:if> />F
				        <input type="radio" name="student_sex" id="student_sex_m" value="M"
				               onclick="return false;"
				               <c:if test="${studentView.studentSex == 'M'}">checked</c:if> />M
				    </td>
			</tr>
			<tr>
				<th>학과</th>
				    <td>
				        <input type="radio" name="student_department" id="department_security" value="보안"
				               onclick="return false;"
				               <c:if test="${studentView.studentDepartment == '보안'}">checked</c:if> />보안
				        <input type="radio" name="student_department" id="department_device" value="디바"
				               onclick="return false;"
				               <c:if test="${studentView.studentDepartment == '디바'}">checked</c:if> />디바
						<input type="radio" name="student_department" id="department_ai" value="인공"
				               onclick="return false;"
				               <c:if test="${studentView.studentDepartment == '인공'}">checked</c:if> />인공
				        <input type="radio" name="student_department" id="department_game" value="게임"
				               onclick="return false;"
				               <c:if test="${studentView.studentDepartment == '게임'}">checked</c:if> />게임
				    </td>
			</tr>
			<tr>
				<th>학년</th>
				    <td>
				        <input type="radio" name="student_grade" id="student_grade_1" value="1"
				               <c:if test="${studentView.studentGrade == '1'}">checked</c:if> />1학년
				         <input type="radio" name="student_grade" id="student_grade_2" value="2"
				               <c:if test="${studentView.studentGrade == '2'}">checked</c:if> />2학년
						<input type="radio" name="student_grade" id="student_grade_3" value="3"
				               <c:if test="${studentView.studentGrade == '3'}">checked</c:if> />3학년

				    </td>
			</tr>
			<tr>
				<th>반</th>
				<td><input type="text" name="student_class" id="student_class" size="3" value="${studentView.studentClass}"/></td>
			</tr>
			<tr>
				<th>번호</th>
				<td><input type="text" name="student_number" id="student_number" size="3" value="${studentView.studentNumber}"/></td>
			</tr>
		</table>
		</form>
	</div>

	<div>
		<a href="#" onclick="fn_saveStudent();">수정하기</a>
	</div>

</body>
</html>