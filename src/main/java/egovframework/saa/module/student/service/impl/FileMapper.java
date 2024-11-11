package egovframework.saa.module.student.service.impl;

import java.sql.SQLException;
import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;

@Mapper("fileMapper")
public interface FileMapper {
	List<EgovMap> selectStudentFile(String id) throws SQLException;

	boolean insertStudentFile(EgovMap studentFile) throws SQLException;
}
