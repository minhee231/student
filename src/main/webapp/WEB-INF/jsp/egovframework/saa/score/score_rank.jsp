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
<title>학생 석차</title>
</head>
<body>
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
</body>
</html>