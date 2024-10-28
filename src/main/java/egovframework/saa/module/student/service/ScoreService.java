package egovframework.saa.module.student.service;

import java.sql.SQLException;
import java.util.List;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;

public interface ScoreService {

	String selectStudentGrade(String id) throws SQLException;

	List<EgovMap> selectStudentScoresList(EgovMap paramMap) throws SQLException;

	List<EgovMap> selectSubjectList(String grade) throws SQLException;

	String selectSubjectNameByScoreId(String scoresId) throws SQLException;

	List<String> selectSubjectNamesByGrade(EgovMap paramMap) throws SQLException;

	boolean updateScore(EgovMap paraMap) throws SQLException;

	boolean insertScore(EgovMap paraMap) throws SQLException;

	String getNowYear();

}
