package egovframework.saa.module.student.service;

import java.sql.SQLException;
import java.util.List;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;

public interface StudentService {


	List<EgovMap> selectStudentList(EgovMap paramMap) throws SQLException;

	EgovMap selectStudentView(String id) throws SQLException;

	EgovMap selectStudentInfoView(String id) throws SQLException;

	List<EgovMap> selectStudentScoresList(EgovMap paramMap) throws SQLException;

	List<EgovMap> selectSubjectList(String grade) throws SQLException;

	String selectStudentGrade(String id) throws SQLException;

	boolean insertStudent(EgovMap student) throws SQLException;

	boolean insertStudentInfo(EgovMap student) throws SQLException;

	boolean updateStudent(EgovMap student) throws SQLException;

	boolean updateStudentInfo(EgovMap student) throws SQLException;

	boolean deleteStudent(String id) throws SQLException;

	String generateUniqueId();

	boolean insertStudentScores(EgovMap studentScores) throws SQLException;

}
