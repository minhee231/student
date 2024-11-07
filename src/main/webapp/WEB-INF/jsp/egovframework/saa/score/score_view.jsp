<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.Set" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>학생 성적 뷰</title>
	<link rel="stylesheet" type="text/css" href="/css/egovframework/student_table.css">
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>


	<style>
		.dataTable { border-collapse: collapse; width:1000px; }
		.dataTable th, td { border:1px solid #ccc; padding:0; margin:0; }
		.tac { text-align:center }
		.tal { text-align:left }
		.tar { text-align:right }
	</style>

	<script>
function openEditPopup(button) {
	var frm = button.closest("form");
    var formData = new FormData(frm);

    var data = {};
    formData.forEach((value, key) => {
        if (data[key]) {
            if (Array.isArray(data[key])) {
                data[key].push(value);
            } else {
                data[key] = [data[key], value];
            }
        } else {
            data[key] = value;
        }
    });

    var params = new URLSearchParams(data).toString();
    console.log(params);

    var popup = window.open('/score/score_edit_popup.do?' + params, 'scorePopup', 'width=600,height=800,scrollbars=yes,resizable=yes');
}

/* function requestTable() {

} */

/* function openInputPopup(semester, division) {
	var studentId =  ${studentId};
	var grade = ${subjectList[0].studentGrade};
	var popup = window.open(
	        '/score/score_input_popup.do?student_id=' + studentId + '&grade=' + grade +
	        '&semester=' + semester + '&division=' + division,
	        'scorePopup',
	        'width=600,height=800,scrollbars=yes,resizable=yes'
	    );
} */

function openInputPopup(button, semester, division) {
    var frm = button.closest("form");
    var formData = new FormData(frm);
    var grade = ${subjectList[0].studentGrade};
    var year = ${subjectList[0].subjectYear};

    console.log(formData);

    var data = {};
    formData.forEach((value, key) => {
        if (data[key]) {
            if (Array.isArray(data[key])) {
                data[key].push(value);
            } else {
                data[key] = [data[key], value];
            }
        } else {
            data[key] = value;
        }
    });

 	console.log(data);

    data['semester'] = semester;
    data['division'] = division;
    data['grade'] = grade;
    data['year'] = year;

    var params = new URLSearchParams(data).toString();
    console.log(params);

    var popup = window.open('/score/score_input_popup.do?' + params, 'scorePopup', 'width=600,height=800,scrollbars=yes,resizable=yes');
}


function fetchTableData() {
    const studentId = "${studentId}";
    const selectedGrade = document.getElementById("grade").value;

    var url = "/score/score_view.do?student_id=" + studentId + "&grade=" + selectedGrade;
    console.log(url);

    $.ajax({
        url: url,
        success: function(data) {
        	var tableHtml = $(data).find(".dataTable").html();
        	console.log(tableHtml);
        	$("#score").html(data);
        }
    });
}

</script>
<body>
	<div id="score">
		<h3>${subjectList[0].subjectYear}년도 학생 성적</h3>
		<form id="setGrade" name="setGrade" method="GET" class="selectBox">
		    <label for="grade">학년</label>
		    <select id="grade" name="grade">
		        <option value="1" <c:if test="${subjectList[0].studentGrade == 1}">selected</c:if>>1학년</option>
		        <option value="2" <c:if test="${subjectList[0].studentGrade == 2}">selected</c:if>>2학년</option>
		        <option value="3" <c:if test="${subjectList[0].studentGrade == 3}">selected</c:if>>3학년</option>
		    </select>
		    <button type="button" onclick="fetchTableData()">검색</button>
		</form>

	<table class="dataTable">
	    <tr>
	        <th>학기</th>
	        <th>구분</th>
	        <c:forEach var="subject" items="${subjectList}">
	            <th><c:out value="${subject.subjectName}" /></th>
	        </c:forEach>
	      	<th>총점</th>
	      	<th>평균</th>
	        <th>수정등록</th>
	    </tr>
	    <c:set var="tr_count" value='0' />
	    <c:forEach var="semester" begin="1" end="2" varStatus="semester_status">
	        <c:forEach var="division" items="${['M', 'F']}" varStatus="status">
	            <tr id="${tr_count + semester_status.index + status.index}">
	                <td><c:out value="${semester}" /></td>
	                <td><c:out value="${division}" /></td>

	                <c:forEach var="subject" items="${subjectList}">
	                    <td>
	                        <c:set var="scoreFound" value="false" />

	                        <c:forEach var="scores" items="${studentScoresList}">
	                            <c:if test="${scores.subjectId == subject.subjectId && scores.semester == semester && scores.scoreDivion == division}">
	                                <c:out value="${scores.scores}" />
	                                <c:set var="scoreFound" value="true" />
	                            </c:if>
	                        </c:forEach>
	                        <c:if test="${scoreFound == false}">
	                            -
	                        </c:if>
	                    </td>
	                </c:forEach>
	                <c:set var="scoreSum" value="" />
	                <td>
	                        <c:set var="scoreFound" value="false" />
	                        <c:forEach var="scores" items="${studentScoresList}">
	                            <c:if test="${scores.semester == semester && scores.scoreDivion == division && scoreSum != scores.totalSum}">
	                                <c:out value="${scores.totalSum}" />
	                                <c:set var="scoreFound" value="true" />
	                                <c:set var="scoreSum" value="${scores.totalSum}" />
	                            </c:if>
	                        </c:forEach>
	                        <c:if test="${scoreFound == false}">
	                            -
	                        </c:if>
	                </td>
	                <c:set var="scoreAvg" value="" />
	                <td>
	                        <c:set var="scoreFound" value="false" />
	                        <c:forEach var="scores" items="${studentScoresList}">
	                            <c:if test="${scores.semester == semester && scores.scoreDivion == division && scoreAvg != scores.avgScore}">
	                                <c:out value="${scores.avgScore}" />
	                                <c:set var="scoreFound" value="true" />
	                                <c:set var="scoreAvg" value="${scores.avgScore}" />
	                            </c:if>
	                        </c:forEach>
	                        <c:if test="${scoreFound == false}">
	                            -
	                        </c:if>
	                </td>
					<td>
					    <form name="frmScore" id="frmScore">
					        <input type="hidden" name="student_id" value="${studentId}">
				        	<c:if test="${scoreFound == false}">
				        		<c:forEach var="subject" items="${subjectList}">
									<input type="hidden" name="subjectId[]" value="${subject.subjectId}" />
								</c:forEach>
				        	</c:if>
					        <c:forEach var="score" items="${studentScoresList}">

					            <c:if test="${score.semester == semester && score.scoreDivion == division}">
					                <input type="hidden" name="scoresId[]" value="${score.scoresId}" />
					                <input type="hidden" name="scores[]" value="${score.scores}" />
					            </c:if>
					        </c:forEach>

					        <c:choose>
					            <c:when test="${scoreFound == false}">
					                <button type="button" onclick="openInputPopup(this,'${semester}', '${division}')">등록</button>
					            </c:when>
					            <c:otherwise>
					                <button type="button" onclick="openEditPopup(this)">수정</button>
					            </c:otherwise>
					        </c:choose>
					    </form>
					</td>
	            </tr>
	        </c:forEach>
	    </c:forEach>
	</table>
	</div>
</body>
</html>
