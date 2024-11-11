package egovframework.saa.module.student.service.impl;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.saa.module.student.service.FileService;


@Service("fileService")
public class FileServiceImpl extends EgovAbstractServiceImpl implements FileService{

	@Resource(name = "fileMapper")
	private FileMapper fileMapper;

	public List<EgovMap> selectStudentFile(String id) throws DataAccessException, SQLException {
		return fileMapper.selectStudentFile(id);
	}

	public boolean insertStudentFile(EgovMap studentFile) throws SQLException {
		return fileMapper.insertStudentFile(studentFile);
	}

	public boolean deleteStudentFile(String id) throws SQLException {
		return fileMapper.deleteStudentFile(id);
	}

}
