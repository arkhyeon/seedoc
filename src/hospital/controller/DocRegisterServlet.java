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
import hospital.model.service.HospitalService;
import hospital.model.vo.HospDoctor;
import hospital.model.vo.HospFile;

/**
 * Servlet implementation class DocEnrollServlet
 */
@WebServlet("/hospital/doctorRegister")
public class DocRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DocRegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String hospId = request.getParameter("hospId");
//		System.out.println(hospId);
		
		request.setAttribute("hospId", hospId);
		request.getRequestDispatcher("/WEB-INF/views/hospital/doc-register.jsp").forward(request, response);
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(!ServletFileUpload.isMultipartContent(request))
			System.out.println("enctype 속성 미적용");
		String saveDirectory = getServletContext().getRealPath("/")+"/upload/hospital";//업로드할 파일 저장경로
		int maxPostSize = 1024 * 1024 * 10;//업로드할 파일 크기 ~10MB
		FileRenamePolicy policy = new HospitalFileRenamePolicy();
		
		MultipartRequest multipartRequest = new MultipartRequest(request, saveDirectory, maxPostSize, "utf-8", policy);
		
		String boardOriginalFileName = multipartRequest.getOriginalFileName("upFile"); //사용자가 업로드한 파일명
		String boardRenamedFileName = multipartRequest.getFilesystemName("upFile");//저장되는 파일명
		String hospId = multipartRequest.getParameter("hospId");
		String doctorNo = multipartRequest.getParameter("doctorNo");
		String doctorName = multipartRequest.getParameter("doctorName");
		String hospDept = multipartRequest.getParameter("hospDept");
		String doctorTreat = multipartRequest.getParameter("doctorTreat");
		String doctorSpec = multipartRequest.getParameter("doctorSpec");
		
		HospDoctor hd = new HospDoctor(doctorNo, hospId, doctorName, hospDept, doctorTreat, doctorSpec);
		HospFile hf = new HospFile(hospId, doctorNo, boardOriginalFileName, boardRenamedFileName);
//		System.out.println("hd@servlet = "+hd);
//		System.out.println("hf@servlet = "+hf);
		
		//hosp_doctor에 insert
		int result = new HospitalService().insertDoc(hd);
//		System.out.println("result@HospitalEnrollServlet = "+ result);
		//hopspital_file에 insert
		int result2 = new HospitalService().insertDocFile(hf);
		
		//4. 사용자 응답처리 : msg.jsp
		String msg = result+result2 > 1 ? "의사등록 성공!" : "의사등록 실패!";
		String loc = "/hospital/doctorList?hospId="+hospId;
		
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
	}

}
