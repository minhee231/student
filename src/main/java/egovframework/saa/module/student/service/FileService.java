package egovframework.saa.module.student.service;

import java.sql.SQLException;
import java.util.List;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;

public interface FileService {
	List<EgovMap> selectStudentFile(String id) throws SQLException;

	boolean insertStudentFile(EgovMap studentFile) throws SQLException;

	boolean deleteStudentFile(String id) throws SQLException;
}
