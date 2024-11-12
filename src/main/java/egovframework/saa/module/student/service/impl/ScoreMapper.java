package egovframework.saa.module.student.service.impl;

import java.sql.SQLException;
import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;

@Mapper("scoreMapper")
public interface ScoreMapper {
	String selectStudentGrade(String id) throws SQLException;

	List<EgovMap> selectStudentScoresList(EgovMap paramMap) throws SQLException;

	List<EgovMap> selectSubjectList(EgovMap paramMap) throws SQLException;

	List<EgovMap> selectScoresRank(EgovMap paramMap) throws SQLException;

	String selectSubjectNameByScoreId(String scoresId) throws SQLException;

	List<String> selectSubjectNamesByGrade(EgovMap paramMap) throws SQLException;

	boolean updateScore(EgovMap paraMap) throws SQLException;

	boolean insertScore(EgovMap paraMap) throws SQLException;

}