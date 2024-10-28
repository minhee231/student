<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>학생 성적 등록</title>
	<link rel="stylesheet" type="text/css" href="/css/egovframework/student_table.css">
	<style>
		.dataTable { border-collapse: collapse; width:1000px; }
		.dataTable th, td { border:1px solid #ccc; padding:0; margin:0; }
		.tac { text-align:center }
		.tal { text-align:left }
		.tar { text-align:right }
	</style>

	<script>
		function fn_saveStudent() {
			var frm = document.studentFrm;
			/* var checkText ="";

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
			} */

			frm.submit();
		}
	</script>

</head>
<body>
	<div>
		<h3 style="text-align: center;">학생 성적 등록</h3>
		<form name="studentFrm" id="studentFrm" method="post" action="student_scores_input_proc.do?student_id=${studentId}">
		<table class="dataTable" id="scoresTable">
			<tr>
				<th>년도</th>
				<th>학기</th>
				<th>구분</th>
				<th>과목</th>
				<th>점수</th>
			</tr>
			<tr>
				<td class="tac"><input type="text" name="year" id="year" placeholder="년도" /></td>
		        <td class="tac">
		        <select id="semester" name="semester">
					<option value="1">1학기</option>
					<option value="2">2학기</option>
				</select></td>
				<td class="tac">
		        <select id="score_divion" name="score_divion">
					<option value="M">중간</option>
					<option value="F">기말</option>
				</select></td>
				<td class="tac">
		        <select id="subject_id" name="subject_id">
					<option value="0" selected>국어 </option>
					<option value="1">영어</option>
					<option value="3">수학</option>
					<option value="2">과학</option>
				</select></td>

		        <td class="tac"><input type="number" name="score" placeholder="점수" value=""/></td>
			</tr>

			</tbody>
		</table>
		</form>
	</div>
	<div class="redirect">
		<a href="#" onclick="fn_saveStudent();">등록</a>
	</div>
</body>
</html>

