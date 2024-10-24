<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>학생 정보 수정</title>
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

		if (!$("#phone_number").val()) {
			alert("전화번호 입력하세요.");
			$("#phone_number").focus();
			return;
		}

		if (!$("#phone_number").val()) {
			alert("주소를 입력하세요.");
			$("#phone_number").focus();
			return;
		}

		if (!$("#phone_number").val()) {
			alert("비상 연락망을 입력하세요.");
			$("#phone_number").focus();
			return;
		}

		frm.submit();
	}
	</script>
</head>
<body>
	<div>
		<h3>학생 개인정보 수정</h3>
		<form name="studentFrm" id="studentFrm" method="post" action="student_info_edit_proc.do">
		<table class="dataTable">
			<tr>
				<th>학생번호</th>
				<td><input type="text" name="student_id" id="student_id" size="50" value="${studentInfoView.studentId}" readonly /></td>
			</tr>
			<tr>
				<th>학생이름</th>
				<td><input type="text" name="student_name" id="student_name" size="10" value="${studentInfoView.studentName}"/></td>
			</tr>
			<tr>
				<th>핸드폰</th>
				<td><input type="text" name="phone_number" id="phone_number" size="10" value="${studentInfoView.phoneNumber}"/></td>
			</tr>
			<tr>
				<th>주민등록번호</th>
				<td><input type="text" name="resident_registration_number" id="resident_registration_number" size="10" value="${studentInfoView.residentRegistrationNumber}" readonly/></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><input type="text" name="address" id="address" size="50" value="${studentInfoView.address}" /></td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td><input type="text" name="birth_date" id="birth_date" size="10" value="${studentInfoView.birthDate}" readonly/></td>
			</tr>
			<tr>
				<th>비상연락망</th>
				<td><input type="text" name="emergency_phone_number" id="emergency_phone_number" size="10" value="${studentInfoView.emergencyPhoneNumber}" /></td>
			</tr>
		</table>
		</form>
	</div>

	<div class="redirect">
		<a href="#" onclick="fn_saveStudent();">수정하기</a>
	</div>

</body>
</html>