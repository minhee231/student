<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>학생목록</title>
	<link rel="stylesheet" type="text/css" href="/css/egovframework/student_table.css">
	<style>
		.dataTable { border-collapse: collapse; width:1000px; }
		.dataTable th, td { border:1px solid #ccc; padding:0; margin:0; }
		.tac { text-align:center }
		.tal { text-align:left }
		.tar { text-align:right }
	</style>

	<script>
	function fn_egov_link_page(page) {
	    const url = new URL(window.location.href);

	    url.searchParams.set('page', page);

	    window.location.href = url.toString();
	}
	</script>
</head>
<body>
	<div>
		<h3>학생 목록</h3>

		<form method="GET" action="student_list.do">
			<label for="schFld">검색 필드:</label>
			<select id="schFld" name="schFld">
				<option value="all">학생번호</option>
				<option value="name">학생이름</option>
				<option value="dept">학과</option>
			</select>
			<label for="schStr">검색어:</label>
			<input type="text" id="schStr" name="schStr" />
			<button type="submit">검색</button>
		</form>

		<table class="dataTable">
			<thead>
				<tr>
					<th>학생번호</th>
					<th>학생이름</th>
					<th>재적상태</th>
					<th>입학/전학일자</th>
					<th>성별</th>
					<th>학과</th>
					<th>학년</th>
					<th>반</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="list" items="${studentList}" varStatus="status">
				<tr>
					<td class="tac">
						<a href="/student/student_view.do?student_id=${list.studentId}">
        					<c:out value="${list.studentId}" />
        				</a>
       				</td>
					<td class="tac">
        					<c:out value="${list.studentName}" />
       				</td>
					<td class="tac"><c:out value="${list.state}" /></td>
					<td class="tac"><c:out value="${list.entrance}" /></td>
					<td class="tac"><c:out value="${list.studentSex}" /></td>
					<td class="tac"><c:out value="${list.studentDepartment}" /></td>
					<td class="tac"><c:out value="${list.studentGrade}" /></td>
					<td class="tac"><c:out value="${list.studentClass}" /></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>

   <div class="sectionDiv">
      <div id="paging" class="redirect">
         <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
      </div>
      <div class="redirect">
         <a href="student_input.do" class="btn btnFn">등록</a>
      </div>
   </div>

</body>
</html>
