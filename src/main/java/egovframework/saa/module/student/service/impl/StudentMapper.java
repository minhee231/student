package egovframework.saa.module.student.service.impl;

import java.sql.SQLException;
import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;

@Mapper("studentMapper")
public interface StudentMapper {

	List<EgovMap> selectStudentList(EgovMap paramMap) throws SQLException;

	EgovMap selectStudentView(String id) throws SQLException;

	EgovMap selectStudentInfoView(String id) throws SQLException;

	List<EgovMap> selectStudentFile(String id) throws SQLException;

	String selectStudentGrade(String id) throws SQLException;

	boolean insertStudent(EgovMap student) throws SQLException;

	boolean insertStudentInfo(EgovMap student) throws SQLException;

	boolean updateStudent(EgovMap student) throws SQLException;

	boolean updateStudentInfo(EgovMap student) throws SQLException;

	boolean deleteStudent(String id) throws SQLException;

	boolean deleteStudentInfo(String id) throws SQLException;

	boolean insertStudentScores(EgovMap studentScores) throws SQLException;

	boolean insertStudentFile(EgovMap studentFile) throws SQLException;
}
