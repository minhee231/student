<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/css/egovframework/student_table.css">
<style>
		.dataTable { border-collapse: collapse; width:800px; }
		.dataTable th, td { border:1px solid #ccc; padding:0; margin:0; }
		.tac { text-align:center }
		.tal { text-align:left }
		.tar { text-align:right }
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
function fetchTableData() {
    const selectedYear = $("#year").val();
    const selectedSemester = $("#semester").val();
    const selectedDivion = $("#divion").val();
    const selectedGrade = $("#grade").val();
    const selectedstudentClass = $("#studentClass").val();

    console.log(selectedYear)

    var url = "score_rank.do?year=" + encodeURIComponent(selectedYear) +
          "&semester=" + encodeURIComponent(selectedSemester) +
          "&divion=" + encodeURIComponent(selectedDivion) +
          "&grade=" + encodeURIComponent(selectedGrade) +
          "&studentClass=" + encodeURIComponent(selectedstudentClass);

	console.log(url);
    /* var url = "/score/score_view.do?student_id=" + studentId + "&grade=" + selectedGrade;*/
    console.log(url);

    $.ajax({
        url: url,
        success: function(data) {
        	var tableHtml = $(data).find(".dataTable").html();
        	$("#student_rank").html(data);
        }
    });
}
</script>
<title>학생 석차</title>
</head>
<body>
<div id="student_rank">
	<h3>${scoresRanks[0].scoreYear}년도
		${scoresRanks[0].semester}학기
		${scoresRanks[0].studentGrade}학년
		<c:choose>
		<c:when test="${scoresRanks[0].scoreDivion == 'M'}">
		   	중간
		</c:when>
		<c:otherwise>
		    기말
		</c:otherwise>
		</c:choose>
		고사
	</h3>
		<form id="setGrade" name="setGrade" method="GET" class="selectBox">
		    <label for="year">년도</label>
		    <input type="text" name="year" size="3" id="year" value="${scoresRanks[0].scoreYear }" >
		    <label for="semester">학기</label>
		    <select id="semester" name="semester">
		        <option value="1" <c:if test="${scoresRanks[0].semester == '1'}">selected</c:if>>1학기</option>
		        <option value="2" <c:if test="${scoresRanks[0].semester == '2'}">selected</c:if>>2학기</option>
		    </select>
		    <label for="divion">중간/기말</label>
		    <select id="divion" name="divion">
		        <option value="M" <c:if test="${scoresRanks[0].scoreDivion == 'M'}">selected</c:if>>중간</option>
		        <option value="F" <c:if test="${scoresRanks[0].scoreDivion == 'F'}">selected</c:if>>기말</option>
		    </select>
		    <label for="grade">학년</label>
		    <select id="grade" name="grade">
		        <option value="1" <c:if test="${scoresRanks[0].studentGrade == '1'}">selected</c:if>>1학년</option>
		        <option value="2" <c:if test="${scoresRanks[0].studentGrade == '2'}">selected</c:if>>2학년</option>
		        <option value="3" <c:if test="${scoresRanks[0].studentGrade == '3'}">selected</c:if>>3학년</option>
		    </select>
		    <label for="studentClass">반</label>
		    <select id="studentClass" name="studentClass">
		        <option value="all">전체</option>
		        <option value="1" >1</option>
		        <option value="2" >2</option>
		        <option value="3" >3</option>
		        <option value="4" >4</option>
		        <option value="5" >5</option>
		        <option value="6" >6</option>
		        <option value="7" >7</option>
		        <option value="8" >8</option>
		        <option value="9" >9</option>
		    </select>
		    <button type="button" onclick="fetchTableData()">검색</button>
		</form>
	<table class="dataTable">
		<tr>
			<th>순위</th>
			<th>학년</th>
			<th>반</th>
			<th>번호</th>
			<th>이름</th>
			<th>총점</th>
			<th>평균</th>
		</tr>
		<tr>
		</tr>
		<c:forEach var="rank" items="${scoresRanks}" varStatus="rankStatus">
			<tr>
				<td><c:out value="${rankStatus.index + 1}"></c:out></td>
				<td><c:out value="${rank.studentGrade}"></c:out></td>
				<td><c:out value="${rank.studentClass}"></c:out></td>
				<td><c:out value="${rank.studentNumber}"></c:out></td>
				<td><c:out value="${rank.studentName}"></c:out></td>
				<td><c:out value="${rank.totalSum}"></c:out></td>
				<td><c:out value="${rank.avgScore}"></c:out></td>
			</tr>
		</c:forEach>
	</table>
</div>
</body>
</html>