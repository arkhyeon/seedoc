package hospital.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import common.HospitalFileRenamePolicy;
import hospital.model.exception.HospException;
import hospital.model.service.HospitalService;
import hospital.model.vo.HospFile;

/**
 * Servlet implementation class HospitalUploadFileServlet
 */
@WebServlet("/hospital/hospitalUploadFile")
public class HospitalUploadFileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public HospitalUploadFileServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		if (!ServletFileUpload.isMultipartContent(request))
			throw new HospException("파일업로드 enctype 속성 미적용! : " + request.getRequestURI());
		
		String saveDirectory = getServletContext().getRealPath("/") + "/upload/board";

		int maxPostSize = 1024 * 1024 * 10; // 10MB
		
		FileRenamePolicy policy = new HospitalFileRenamePolicy();

		MultipartRequest multipartRequest = new MultipartRequest(request, saveDirectory, maxPostSize, "utf-8", policy);

		String hospId = multipartRequest.getParameter("hospId");
		String doctorNo = multipartRequest.getParameter("doctorNo");
		String boardOriginalFileName = multipartRequest.getOriginalFileName("upFile");
		String boardRenamedFileName = multipartRequest.getFilesystemName("upFile");
		HospFile file = new HospFile(hospId, doctorNo, boardOriginalFileName, boardRenamedFileName, null);
		
		HospFile checkFile = new HospitalService().checkFile(doctorNo);
		if(checkFile != null) {
			new HospitalService().deleteFile(doctorNo);
		}
		int result = new HospitalService().uploadFile(file);
		
		String view = "/WEB-INF/views/common/msg.jsp";
		String msg = result > 0 ? "이미지 등록 성공!" : "이미지 등록 실패!";
		String loc = "/hospital/hospital?hospId=" + hospId;

		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		request.getRequestDispatcher(view).forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
