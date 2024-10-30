package egovframework.saa.module.student.service.impl;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import egovframework.saa.module.student.service.ScoreService;

@Service("scoreService")
public class ScoreServiceImpl extends EgovAbstractServiceImpl implements ScoreService{

	@Resource(name = "scoreMapper")
	private ScoreMapper scoreMapper;

	public String selectStudentGrade(String id) throws SQLException {
		return scoreMapper.selectStudentGrade(id);
	}

	public List<EgovMap> selectStudentScoresList(EgovMap paramMap) throws DataAccessException, SQLException {
		return scoreMapper.selectStudentScoresList(paramMap);
	}

	public List<EgovMap> selectSubjectList(EgovMap paramMap) throws DataAccessException, SQLException {
		return scoreMapper.selectSubjectList(paramMap);
	}

	public String selectSubjectNameByScoreId(String scoresId) throws SQLException {
		return scoreMapper.selectSubjectNameByScoreId(scoresId);
	}

	public List<String> selectSubjectNamesByGrade(EgovMap paramMap) throws SQLException {
		return scoreMapper.selectSubjectNamesByGrade(paramMap);
	}

	public boolean updateScore(EgovMap paraMap) throws DataAccessException, SQLException {
		return scoreMapper.updateScore(paraMap);
	}

	public boolean insertScore(EgovMap paraMap) throws SQLException {
		return scoreMapper.insertScore(paraMap);
	}

	public String getNowYear() {
		String currentYear = new SimpleDateFormat("yyyy").format(new Date());

		return currentYear;
	}


}
