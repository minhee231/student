<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/css/egovframework/student_table.css">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<meta charset="UTF-8">
<title>score</title>
<script>
function fn_saveScore() {
    var form = document.querySelector("#scoreFrm");
    var formData = new FormData(form);

    var scoresIdArray = [];
    var scoreArray = [];

    formData.forEach((value, key) => {
        if (key === 'scores_id') {
            scoresIdArray.push(value);
        } else if (key === 'score') {
            scoreArray.push(value);
        }
    });


    var data = scoresIdArray.map((scores_id, index) => {
        return {
            [scores_id]: scoreArray[index]
        };
    });

    console.log(JSON.stringify(data));

    $.ajax({
        url: 'score_edit_proc.do',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(data),
        success: function(response) {
            console.log('성공:', response);
            window.opener.fetchTableData();
            window.close()
        },
        error: function(xhr, status, error) {
            console.error('에러:', error);
        }
    });
}


</script>
</head>
<body>
	<div>
		<h3>학생 점수 수정</h3>
		<form name="scoreFrm" id="scoreFrm" method="post" action="student_edit_proc.do">
		<table class="dataTable">
			<c:forEach var="subjectName" items="${subjectNames}" varStatus="status">
				<tr>
					<th>
						<c:out value="${subjectName }"></c:out>
						<input type="hidden" name="scores_id" id="scores_id" value="${scoresIdList[status.index ]}" />
					</th>

					<td><input type="text" name="score" id="score" size="20" value="${ scoresList[status.index ]}" /></td>
				</tr>
				<tr>
			</c:forEach>
		</table>
		</form>
	</div>
	<div class="redirect">
		<a href="#" onclick="fn_saveScore();">수정하기</a>
	</div>
</body>
</html>