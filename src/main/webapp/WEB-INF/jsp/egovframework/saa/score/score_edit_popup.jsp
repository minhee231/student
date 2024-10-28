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

    // scores_id와 score 값을 각각의 배열에 추가
    formData.forEach((value, key) => {
        if (key === 'scores_id') {
            scoresIdArray.push(value);
        } else if (key === 'score') {
            scoreArray.push(value);
        }
    });

    // 두 배열을 묶어 JSON 배열로 변환
    var data = scoresIdArray.map((scores_id, index) => {
        return {
            [scores_id]: scoreArray[index]
        };
    });

    // 콘솔로 확인
    console.log(JSON.stringify(data));

    // AJAX로 전송
    $.ajax({
        url: 'score_edit_proc.do',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(data),
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
		<h3>학생 점수 수정</h3>
		<form name="scoreFrm" id="scoreFrm" method="post" action="student_edit_proc.do">
		<table class="dataTable">
			<c:forEach var="subjectName" items="${subjectNames}" varStatus="status">
				<tr>
					<th>
						<c:out value="${subjectName }"></c:out>
						<input type="hidden" name="scores_id" id="scores_id" value="${scoresIdList[status.index ]}" />
					</th>

					<td><input type="text" name="score" id="score" size="20" value="" /></td>
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