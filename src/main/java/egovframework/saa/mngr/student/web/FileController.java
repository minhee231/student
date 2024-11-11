package egovframework.saa.mngr.student.web;


import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
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
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.dao.DataAccessException;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import egovframework.saa.module.student.service.FileService;
import egovframework.saa.utils.UniqueId;

@Controller
public class FileController {
	@Resource(name = "fileService")
	private FileService fileService;

	@Value("${file.upload-dir}")
    private String uploadDir;

	private static final Logger LOGGER = LogManager.getLogger(StudentController.class);

	@RequestMapping(value = "/file/student_file.do")
	public String fileStudent(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("파일");

		String studentId = request.getParameter("student_id");
		LOGGER.info(studentId);
		model.addAttribute("studentId", studentId);
		List<EgovMap> studentFiles = fileService.selectStudentFile(studentId);


		LOGGER.info(studentFiles);
		model.addAttribute("studentFiles", studentFiles);
		model.addAttribute("studentId", studentId);


		return "saa/student/student_file";
	}

	@RequestMapping(value = "/file/student_file_proc.do")
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
	    fileService.insertStudentFile(egovMap);

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

	@RequestMapping(value = "/file/file_download.do")
	public HttpEntity<FileSystemResource> downloadFile(
			@RequestParam("storedName") String storedName,
			@RequestParam("originalName") String originalName
			) {

		LOGGER.info("파일 다운로드");

	    String filePath = uploadDir + storedName;
	    LOGGER.info(filePath);

	    FileSystemResource resource = new FileSystemResource(filePath);

	    if (!resource.exists()) {
	        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
	    }

	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentDisposition(ContentDisposition.builder("attachment")
	            .filename(originalName, StandardCharsets.UTF_8)
	            .build());
	    headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);

	    return ResponseEntity.ok()
	            .headers(headers)
	            .body(resource);
	}

	@RequestMapping(value = "/file/file_delete.do")
	@ResponseBody
	public ResponseEntity<String> deleteFile(
			@RequestParam("fileId") String fileId,
			@RequestParam("storedName") String storedName
			) throws SQLException {

	        String filePath = uploadDir + storedName;
	        File file = new File(filePath);

	        if (file.exists() && file.delete()) {
	            fileService.deleteStudentFile(fileId);
	            return ResponseEntity.ok("파일 삭제 성공");
	        } else {
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("파일 삭제 실패");
	        }
	}

}
