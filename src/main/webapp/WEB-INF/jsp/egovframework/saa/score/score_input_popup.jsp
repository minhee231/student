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
    var subjectIdArray = [];
    var semester = formData.get("semester");
    var division = formData.get("division");
    var studentId = ${egovMap.studentId};
    var grade = ${egovMap.grade};
    /* var nowYear = ${egovMap.nowYear}; */

    formData.forEach((value, key) => {
        if (key === "subject_name") {
            scoresIdArray.push(value);
        } else if (key === 'score') {
            scoreArray.push(value);
        } else if (key === 'subject_id') {
        	subjectIdArray.push(value);
		}
    });

    var scoresData = scoresIdArray.map((scores_id, index) => {
        return {
            [scores_id]: scoreArray[index]
        };
    });

    var requestData = {
        	studentId: studentId,
        	grade: grade,
            semester: semester,
            division: division,
            scores: scoresData,
            subjectId: subjectIdArray
        };

    console.log(JSON.stringify(requestData));

    $.ajax({
        url: 'score_input_proc.do',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(requestData),
        success: function(response) {
            console.log('성공:', response);
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
		<h3>${year}년도 학생 점수 등록</h3>
		<form name="scoreFrm" id="scoreFrm" method="post" action="student_edit_proc.do">
		<table class="dataTable">
			<c:forEach var="subjectName" items="${subjectNames}" varStatus="status">
				<tr>
					<th>
						<c:out value="${subjectName }"></c:out>
						<input type="hidden" name="subject_name" id="subject_name" value="${subjectName}" />
						<input type="hidden" name="subject_id" id="subject_id" value="${subjectIdList[status.index]}" />
						<input type="hidden" name="semester" id="semester" value="${semester}" />
						<input type="hidden" name="division" id="division" value="${division}" />
					</th>

					<td><input type="text" name="score" id="score" size="20" value="" /></td>
				</tr>
				<tr>
			</c:forEach>
		</table>
		</form>
	</div>
	<div class="redirect">
		<a href="#" onclick="fn_saveScore();">등록하기</a>
	</div>
</body>
</html>
