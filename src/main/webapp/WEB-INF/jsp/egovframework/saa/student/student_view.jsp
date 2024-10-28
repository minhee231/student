<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>학생 정보</title>
	<link rel="stylesheet" type="text/css" href="/css/egovframework/student_table.css">
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
	<style>
		.dataTable { border-collapse: collapse; width:800px; }
		.dataTable th, td { border:1px solid #ccc; padding:0; margin:0; }
		.tac { text-align:center }
		.tal { text-align:left }
		.tar { text-align:right }
	</style>
</head>
<body>
	<div>
		<h3>학생 정보</h3>
		<form name="studentFrm" id="studentFrm">
		<table class="dataTable">
			<tr>
				<th>학생번호</th>
				<td><input type="text" name="student_id" id="student_id" size="50" value="${studentView.studentId}" readonly/></td>
			</tr>
			<tr>
				<th>학생이름</th>
				<td><input type="text" name="student_name" id="student_name" size="10" value="${studentView.studentName}" readonly/></td>
			</tr>
			<tr>
				<th>재적상태</th>
				    <td>
				        <input type="radio" name="state" id="state_o" value="O"
				               onclick="return false;"
				               <c:if test="${studentView.state == 'O'}">checked</c:if> />O
				        <input type="radio" name="state" id="state_x" value="X"
				               onclick="return false;"
				               <c:if test="${studentView.state == 'X'}">checked</c:if> />X
				    </td>
			</tr>
			<tr>
				<th>입학/전입 날짜</th>
				<td><input type="text" name="entrance" id="entrance" size="10" value="${studentView.entrance}" readonly/></td>
			</tr>
			<tr>
				<th>졸업/전출 날짜</th>
				<td><input type="text" name="graduation" id="graduation" size="10" value="${studentView.graduation}" readonly/></td>
			</tr>
			<tr>
				<th>휴학년도</th>
				<td><input type="text" name="leave_year" id="leave_year" size="5" value="${studentView.leaveYear}" readonly/></td>
			</tr>
			<tr>
				<th>퇴학년도</th>
				<td><input type="text" name="expelled_year" id="expelled_year" size="5" value="${studentView.expelledYear}" readonly/></td>
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
				               onclick="return false;"
				               <c:if test="${studentView.studentGrade == '1'}">checked</c:if> />1학년
				         <input type="radio" name="student_grade" id="student_grade_2" value="2"
				               onclick="return false;"
				               <c:if test="${studentView.studentGrade == '2'}">checked</c:if> />2학년
						<input type="radio" name="student_grade" id="student_grade_3" value="3"
				               onclick="return false;"
				               <c:if test="${studentView.studentGrade == '3'}">checked</c:if> />3학년

				    </td>
			</tr>
			<tr>
				<th>반</th>
				<td><input type="text" name="student_class" id="student_class" size="3" value="${studentView.studentClass}" readonly/></td>
			</tr>
			<tr>
				<th>번호</th>
				<td><input type="text" name="student_number" id="student_number" size="3" value="${studentView.studentNumber}" readonly/></td>
			</tr>
		</table>
		</form>
	</div>

	<div class="redirect">
		<a href="student_list.do">목록</a>
		<a href="student_info_view.do?student_id=${studentView.studentId}">개인정보</a>
		<a href="student_edit.do?student_id=${studentView.studentId}">수정</a>
		<a href="student_delete_proc.do?student_id=${studentView.studentId}">삭제</a>
		<a href="/score/score_view.do?student_id=${studentView.studentId}">성적</a>
	</div>

</body>
</html>