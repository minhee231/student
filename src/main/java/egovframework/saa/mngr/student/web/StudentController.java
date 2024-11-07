package egovframework.saa.mngr.student.web;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import egovframework.saa.module.student.service.StudentService;
import egovframework.saa.utils.UniqueId;

@Controller
public class StudentController {

	/** studentService */
	@Resource(name = "studentService")
	private StudentService studentService;

   @Value("${file.upload-dir}")
    private String uploadDir;

	private static final Logger LOGGER = LogManager.getLogger(StudentController.class);

	@RequestMapping(value = "/student/student_list.do")
	public String selectStudentList(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("학생 목록");

		String page = request.getParameter("page") == null ? "1" : request.getParameter("page");
		String schFld = request.getParameter("schFld") == null ? "" : request.getParameter("schFld");
		String schStr = request.getParameter("schStr") == null ? "" : request.getParameter("schStr");

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(Integer.parseInt(page));
		paginationInfo.setRecordCountPerPage(10);
		paginationInfo.setPageSize(10);

		EgovMap egovMap = new EgovMap();
		egovMap.put("firstIndex", paginationInfo.getFirstRecordIndex());
		egovMap.put("lastIndex", paginationInfo.getLastRecordIndex());
		egovMap.put("schFld", schFld);
		egovMap.put("schStr", schStr);
		LOGGER.info("egovMap ::: " + egovMap);

		List<EgovMap> studentList = studentService.selectStudentList(egovMap);
		model.addAttribute("studentList", studentList);
		LOGGER.info(studentList);

		int totCnt = ((Long) studentList.get(0).get("totcnt")).intValue();
		LOGGER.info(totCnt);
		paginationInfo.setTotalRecordCount(totCnt);
		// JSP 데이타 전달
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("paramMap", egovMap);

		return "saa/student/student_list";
	}

	/*
	 * VIEW=========================================================================
	 */

	@RequestMapping(value = "/student/student_view.do")
	public String viewStudent(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("학생 뷰");

		String studentId = request.getParameter("student_id");

		LOGGER.info(studentId);
		EgovMap studentView = studentService.selectStudentView(studentId);
		EgovMap studentInfoView = studentService.selectStudentInfoView(studentId);
		model.addAttribute("studentView", studentView);
		model.addAttribute("studentInfoView", studentInfoView);

		LOGGER.info(studentView);

		return "saa/student/student_view";

	}

	@RequestMapping(value = "/student/student_file.do")
	public String fileStudent(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("파일");

		String studentId = request.getParameter("student_id");
		model.addAttribute("studentId", studentId);
		List<EgovMap> studentFiles = studentService.selectStudentFile(studentId);
//
//		model.addAttribute("studentFiles", studentFiles);


		return "saa/student/student_file";
	}

	@RequestMapping(value = "/student/student_file_proc.do")
	public String fileStudentProc(MultipartFile file, ModelMap model, HttpServletRequest request)
	        throws DataAccessException, RuntimeException, IOException, SQLException {
	    LOGGER.info("파일 처리 시작");

	    String studentId = request.getParameter("student_id");
	    LOGGER.info("학생 아이디: " + studentId);
	    String originalFile = file.getOriginalFilename();
	    String fileId = UniqueId.generateUniqueId();
	    String storedName = UUID.randomUUID().toString() + "_" + originalFile;
	    String uploadAt = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
	    Long fileSize = file.getSize();

	    EgovMap egovMap = new EgovMap();
	    egovMap.put("fileId", fileId);
	    egovMap.put("studentId", studentId);
	    egovMap.put("originalName", originalFile);
	    egovMap.put("storedName", storedName);
	    egovMap.put("fileSize", fileSize);
	    egovMap.put("uploadAt", uploadAt);

	    LOGGER.info("파일 정보 DB에 저장: " + egovMap);
	    studentService.insertStudentFile(egovMap);

	    String filePath = uploadDir + storedName;
	    File destFile = new File(filePath);

	    try {
	        file.transferTo(destFile);
	        LOGGER.info("파일 업로드 성공: " + storedName);
	    } catch (IOException e) {
	        LOGGER.error("파일 업로드 실패: " + e.getMessage());
	        return "redirect:./student_list.do";
	    }

	    return "redirect:./student_list.do";
	}




	@RequestMapping(value = "/student/student_info_view.do")
	public String viewStudentInfo(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("학생 개인정보 뷰");

		String studentId = request.getParameter("student_id");

		LOGGER.info(studentId);
		EgovMap studentInfoView = studentService.selectStudentInfoView(studentId);
		model.addAttribute("studentInfoView", studentInfoView);

		LOGGER.info(studentInfoView);

		if (studentInfoView == null) {

			model.addAttribute("studentId", studentId);
			return "saa/student/student_info_view_error";
		}

		return "saa/student/student_info_view";

	}

	/*
	 * INPUT========================================================================
	 * ===
	 */

	@RequestMapping(value = "/student/student_input.do")
	public String inputStudent(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("학생 등록");

		return "saa/student/student_input";
	}

	@RequestMapping(value = "/student/student_input_proc.do")
	public String inputStudentProc(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("학생 등록 처리");

		String studentId = UniqueId.generateUniqueId();
		String studentName = request.getParameter("student_name");
		String state = request.getParameter("state");
		String entrance = request.getParameter("entrance");
		String graduation = request.getParameter("graduation");
		String leaveYear = request.getParameter("leave_year");
		String expelledYear = request.getParameter("expelled_year");
		String studentSex = request.getParameter("student_sex");
		String studentDepartment = request.getParameter("student_department");
		String studentGrade = request.getParameter("student_grade");
		String studentClass = request.getParameter("student_class");
		String studentNumber = request.getParameter("student_number");

		EgovMap egovMap = new EgovMap();
		egovMap.put("studentId", studentId);
		egovMap.put("studentName", studentName);
		egovMap.put("state", state);
		egovMap.put("entrance", entrance);
		egovMap.put("graduation", graduation);
		egovMap.put("leaveYear", leaveYear);
		egovMap.put("expelledYear", expelledYear);
		egovMap.put("studentSex", studentSex);
		egovMap.put("studentDepartment", studentDepartment);
		egovMap.put("studentGrade", studentGrade);
		egovMap.put("studentClass", studentClass);
		egovMap.put("studentNumber", studentNumber);

		LOGGER.info("egovMap ::: " + egovMap);

		studentService.insertStudent(egovMap);

		return "redirect:./student_list.do";
	}

	@RequestMapping(value = "/student/student_info_input.do")
	public String inputStudentInfo(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("학생 개인정보 등록");

		String studentId = request.getParameter("student_id");

		EgovMap egovMap = new EgovMap();
		LOGGER.info("egovMap ::: " + egovMap);

		EgovMap student = studentService.selectStudentView(studentId);

		model.addAttribute("student", student);

		return "saa/student/student_info_input";
	}

	@RequestMapping(value = "/student/student_info_input_proc.do")
	public String inputStudentInfoProc(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("학생 개인정보 등록 처리");

		String studentId = request.getParameter("student_id");
		String studentName = request.getParameter("student_name");
		String phoneNumber = request.getParameter("phone_number");
		String residentRegistrationNumber = request.getParameter("resident_registration_number");
		String address = request.getParameter("address");
		String birthDate = request.getParameter("birth_date");
		String emergencyPhoneNumber = request.getParameter("emergency_phone_number");

		EgovMap egovMap = new EgovMap();
		egovMap.put("studentId", studentId);
		egovMap.put("studentName", studentName);
		egovMap.put("phoneNumber", phoneNumber);
		egovMap.put("residentRegistrationNumber", residentRegistrationNumber);
		egovMap.put("address", address);
		egovMap.put("birthDate", birthDate);
		egovMap.put("emergencyPhoneNumber", emergencyPhoneNumber);

		LOGGER.info("egovMap ::: " + egovMap);

		studentService.insertStudentInfo(egovMap);

		return "redirect:./student_list.do";
	}

	/*
	 * @RequestMapping(value = "/scores/scores_input_popup.do") public String
	 * inputStudentScores(ModelMap model, @RequestBody EgovMap paramMap) throws
	 * DataAccessException, RuntimeException, IOException, SQLException {
	 * LOGGER.info("학생 점수 등록 팝업");
	 *
	 * String studentId = (String) paramMap.get("studentId"); List<String>
	 * scoresIdList = (List<String>) paramMap.get("scoresId[]");
	 *
	 * LOGGER.info(studentId); LOGGER.info(scoresIdList);
	 *
	 * model.addAttribute("studentId", studentId);
	 * model.addAttribute("scoresIdList", scoresIdList);
	 *
	 * return "saa/scores/score_input_popup"; }
	 */



	/*
	 * EDIT=========================================================================
	 * ==============
	 */
	@RequestMapping(value = "/student/student_edit.do")
	public String editStudent(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("학생 수정");

		String studentId = request.getParameter("student_id");

		LOGGER.info(studentId);
		EgovMap studentView = studentService.selectStudentView(studentId);
		model.addAttribute("studentView", studentView);

		LOGGER.info(studentView);

		return "saa/student/student_edit";
	}

	@RequestMapping(value = "/student/student_edit_proc.do")
	public String editStudentProc(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("학생 수정처리");

		String studentId = request.getParameter("student_id");
		String studentName = request.getParameter("student_name");
		String state = request.getParameter("state");
		String entrance = request.getParameter("entrance");
		String graduation = request.getParameter("graduation");
		String leaveYear = request.getParameter("leave_year");
		String expelledYear = request.getParameter("expelled_year");
		String studentSex = request.getParameter("student_sex");
		String studentDepartment = request.getParameter("student_department");
		String studentGrade = request.getParameter("student_grade");
		String studentClass = request.getParameter("student_class");
		String studentNumber = request.getParameter("student_number");

		EgovMap egovMap = new EgovMap();
		egovMap.put("studentId", studentId);
		egovMap.put("studentName", studentName);
		egovMap.put("state", state);
		egovMap.put("entrance", entrance);
		egovMap.put("graduation", graduation);
		egovMap.put("leaveYear", leaveYear);
		egovMap.put("expelledYear", expelledYear);
		egovMap.put("studentSex", studentSex);
		egovMap.put("studentDepartment", studentDepartment);
		egovMap.put("studentGrade", studentGrade);
		egovMap.put("studentClass", studentClass);
		egovMap.put("studentNumber", studentNumber);

		LOGGER.info("egovMap ::: " + egovMap);

		boolean success = studentService.updateStudent(egovMap);

		if (!success) {
			return "실패";
		}

		return "redirect:./student_view.do?student_id=" + studentId;
	}

	@RequestMapping(value = "/student/student_info_edit.do")
	public String editStudentInfo(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("학생 개인정보 수정");

		String studentId = request.getParameter("student_id");

		LOGGER.info(studentId);
		EgovMap studentInfoView = studentService.selectStudentInfoView(studentId);
		model.addAttribute("studentInfoView", studentInfoView);

		LOGGER.info(studentInfoView);

		return "saa/student/student_info_edit";
	}

	@RequestMapping(value = "/student/student_info_edit_proc.do")
	public String editStudentInfoProc(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("학생 개인정보 수정처리");

		String studentId = request.getParameter("student_id");
		String studentName = request.getParameter("student_name");
		String phoneNumber = request.getParameter("phone_number");
		String residentRegistrationNumber = request.getParameter("resident_registration_number");
		String address = request.getParameter("address");
		String birthDate = request.getParameter("birth_date");
		String emergencyPhoneNumber = request.getParameter("emergency_phone_number");

		EgovMap egovMap = new EgovMap();
		egovMap.put("studentId", studentId);
		egovMap.put("studentName", studentName);
		egovMap.put("phoneNumber", phoneNumber);
		egovMap.put("residentRegistrationNumber", residentRegistrationNumber);
		egovMap.put("address", address);
		egovMap.put("birthDate", birthDate);
		egovMap.put("emergencyPhoneNumber", emergencyPhoneNumber);

		LOGGER.info("egovMap ::: " + egovMap);

		boolean success = studentService.updateStudentInfo(egovMap);

		if (!success) {
			return "실패";
		}

		return "redirect:./student_view.do?student_id=" + studentId;
	}



	@RequestMapping(value = "/student/student_delete_proc.do")
	public String deleteStudent(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("학생 삭제");

		String studentId = request.getParameter("student_id");

		LOGGER.info(studentId);
		boolean student = studentService.deleteStudent(studentId);

		if (!student) {
			return "삭제 실패";
		}

		return "redirect:./student_list.do";
	}

	@RequestMapping(value = "/student/student_info_delete_proc.do")
	public String deleteStudentInfo(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("학생 개인정보 삭제");

		String studentId = request.getParameter("student_id");

		LOGGER.info(studentId);
		boolean student = studentService.deleteStudentInfo(studentId);

		if (!student) {
			return "삭제 실패";
		}

		return "redirect:./student_list.do";
	}
}
