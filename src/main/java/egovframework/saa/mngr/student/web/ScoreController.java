package egovframework.saa.mngr.student.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.dao.DataAccessException;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.saa.module.student.service.ScoreService;
import egovframework.saa.utils.UniqueId;

@Controller
public class ScoreController {

	@Resource(name = "scoreService")
	private ScoreService scoreService;

	private static final Logger LOGGER = LogManager.getLogger(StudentController.class);

	@RequestMapping(value = "/score/score_view.do")
	public String viewStudentScores(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("학생 점수 뷰");

		String studentId = request.getParameter("student_id");
		String defaultGrade = scoreService.selectStudentGrade(studentId);
		String nowYear = scoreService.getNowYear();
		LOGGER.info(defaultGrade);
		String grade = request.getParameter("grade") == null ? defaultGrade : request.getParameter("grade");
		LOGGER.info("학년:::::" + grade);

		EgovMap egovMap = new EgovMap();
		egovMap.put("studentId", studentId);
		egovMap.put("grade", grade);
		egovMap.put("nowYear", nowYear);

		LOGGER.info(studentId);
		List<EgovMap> studentScoresList = scoreService.selectStudentScoresList(egovMap);
		LOGGER.info("점수 리스트 :::" + studentScoresList);
		List<EgovMap> subjectList = scoreService.selectSubjectList(egovMap);
		LOGGER.info("과목 리스트 :::" + subjectList);

		model.addAttribute("studentId", studentId);
		model.addAttribute("studentScoresList", studentScoresList);
		model.addAttribute("subjectList", subjectList);

		return "saa/score/score_view";

	}

	@RequestMapping(value = "/score/score_edit_popup.do")
	public String editStudentScores(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("학생 점수 수정 팝업");

		String studentId = request.getParameter("student_id");
		String[] scoresIdArray = request.getParameterValues("scoresId[]");
		String[] scoresArray = request.getParameterValues("scores[]");
		List<String> scoresIdList = Arrays.asList(scoresIdArray[0].split(","));
		List<String> scoresList = Arrays.asList(scoresArray[0].split(","));

	    List<String> subjectNames = new ArrayList<>();

		 for (String scoresId : scoresIdList) {
		     String subjectName = scoreService.selectSubjectNameByScoreId(scoresId);
		     subjectNames.add(subjectName);
		 }

		LOGGER.info(studentId);
		LOGGER.info(scoresIdList);
		LOGGER.info(subjectNames);
		LOGGER.info(scoresList);

		model.addAttribute("studentId", studentId);
		model.addAttribute("scoresIdList", scoresIdList);
		model.addAttribute("subjectNames", subjectNames);
		model.addAttribute("scoresList", scoresList);

		return "saa/score/score_edit_popup";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/score/score_edit_proc.do")
	public ResponseEntity<String> editStudentScoresProc(@RequestBody List<EgovMap> scoresData) {
	    LOGGER.info("점수 수정 요청 받음");

	    LOGGER.info("scoresData의 실제 타입: " + scoresData.getClass().getName());

        LOGGER.info("받은 데이터 크기: " + scoresData.size());
        LOGGER.info(scoresData);
        for (EgovMap scoreEntry : scoresData) {
            scoreEntry.forEach((key, value) -> {
            	EgovMap scoreInfo = new EgovMap();
        		scoreInfo.put("scoresId", key);
        		scoreInfo.put("scores", value);
            	try {
					boolean su = scoreService.updateScore(scoreInfo);
				} catch (SQLException e) {
					e.printStackTrace();
				}});
        }
	    return ResponseEntity.ok("success");
	}

	@RequestMapping(value = "/score/score_input_popup.do")
	public String inputStudentScores(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("학생 점수 등록 팝업");

		String studentId = request.getParameter("student_id");
		String grade = request.getParameter("grade");
		String semester = request.getParameter("semester");
		String division = request.getParameter("division");
		String year = request.getParameter("year");
		String nowYear = scoreService.getNowYear();
		String[] subejctIdArray = request.getParameterValues("subjectId[]");
		List<String> subjectIdList = Arrays.asList(subejctIdArray[0].split(","));

		LOGGER.info(subjectIdList);

		EgovMap egovMap = new EgovMap();
		egovMap.put("studentId", studentId);
		egovMap.put("grade", grade);
		egovMap.put("year", year);

		LOGGER.info("년도" +nowYear);
		LOGGER.info(egovMap);

		List<String> subjectNames = scoreService.selectSubjectNamesByGrade(egovMap);

		LOGGER.info(subjectNames);

		model.addAttribute("subjectNames", subjectNames);
		model.addAttribute("semester", semester);
		model.addAttribute("year", year);
		model.addAttribute("division", division);
		model.addAttribute("egovMap", egovMap);
		model.addAttribute("subjectIdList", subjectIdList);

		return "saa/score/score_input_popup";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/score/score_input_proc.do")
	public ResponseEntity<String> editStudentScoresProc(@RequestBody EgovMap requestData) {
	    LOGGER.info("점수 등록 요청처리");

	    LOGGER.info(requestData);

	    String nowYear = scoreService.getNowYear();
	    String studentId = String.valueOf(requestData.get("studentId"));
	    String grade = String.valueOf(requestData.get("grade"));
	    String semester = (String) requestData.get("semester");
	    String division = (String) requestData.get("division");
	    LOGGER.info(semester);

	    List<Map<String, Object>> scores = (List<Map<String, Object>>) requestData.get("scores");
	    List<String> subjectIdList = (List<String>) requestData.get("subjectId");
	    LOGGER.info("과목Id: " + subjectIdList);

	    Iterator<String> subjectIdIterator = subjectIdList.iterator();

	    for (Map<String, Object> scoreEntry : scores) {
	        scoreEntry.forEach((key, value) -> {
	        	String scoresId = UniqueId.generateUniqueId();
	            EgovMap scoreInfo = new EgovMap();
	            scoreInfo.put("scoresId", scoresId);
	            scoreInfo.put("subjectName", key);
	            scoreInfo.put("score", value);
	            scoreInfo.put("semester", semester);
	            scoreInfo.put("division", division);
	            scoreInfo.put("studentId", studentId);
				scoreInfo.put("grade", grade);
	            scoreInfo.put("nowYear", nowYear);
	            scoreInfo.put("subjectId", subjectIdIterator.next());
	            LOGGER.info(scoreInfo);
	            try {
					scoreService.insertScore(scoreInfo);
				} catch (SQLException e) {
					e.printStackTrace();
				} catch (Exception e) {
					e.printStackTrace();
				}
	            LOGGER.info("과목: " + key + ", 점수: " + value);
	            LOGGER.info(scoreInfo);


	        });
	    }
	    return ResponseEntity.ok("success");
	}
}

