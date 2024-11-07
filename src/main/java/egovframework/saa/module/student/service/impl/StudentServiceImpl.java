package egovframework.saa.module.student.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Date;
import java.util.Random;
import java.text.SimpleDateFormat;

import javax.annotation.Resource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.stringtemplate.v4.compiler.CodeGenerator.region_return;

import egovframework.saa.mngr.student.web.StudentController;
import egovframework.saa.module.student.service.StudentService;

@Service("studentService")
public class StudentServiceImpl extends EgovAbstractServiceImpl implements StudentService {

	@Resource(name = "studentMapper")
	private StudentMapper studentMapper;

	private static final Logger LOGGER = LogManager.getLogger(StudentController.class);

	public List<EgovMap> selectStudentList(EgovMap paramMap) throws DataAccessException, SQLException {
		return studentMapper.selectStudentList(paramMap);
	}

	public EgovMap selectStudentView(String id) throws DataAccessException, SQLException {
		return studentMapper.selectStudentView(id);
	}

	public EgovMap selectStudentInfoView(String id) throws DataAccessException, SQLException {
		return studentMapper.selectStudentInfoView(id);
	}


	public boolean insertStudent(EgovMap student) throws SQLException {
		return studentMapper.insertStudent(student);
    }

	public boolean insertStudentInfo(EgovMap student) throws SQLException {
        return studentMapper.insertStudentInfo(student);
    }

	public boolean updateStudent(EgovMap student) throws SQLException {
		return studentMapper.updateStudent(student);
	}

	public boolean updateStudentInfo(EgovMap student) throws SQLException {
		return studentMapper.updateStudentInfo(student);
	}

	public boolean deleteStudent(String id) throws SQLException {
		return studentMapper.deleteStudent(id);
	}

	public boolean deleteStudentInfo(String id) throws SQLException {
		return studentMapper.deleteStudentInfo(id);
	}

	public boolean insertStudentFile(EgovMap studentFile) throws SQLException {
		return studentMapper.insertStudentFile(studentFile);
	}

}
