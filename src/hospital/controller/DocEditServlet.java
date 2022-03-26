package hospital.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import common.HospitalFileRenamePolicy;
import common.util.Utils;
import hospital.model.service.HospitalService;
import hospital.model.vo.HospDoctor;
import hospital.model.vo.HospFile;
import hospital.model.vo.Hospital;

/**
 * Servlet implementation class DocEnrollServlet
 */
@WebServlet("/hospital/doctorEdit")
public class DocEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DocEditServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * 의사리스트페이지에서 수정하기 눌렀을때 edit-doc페이지로연결
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String hospId = request.getParameter("hospId");
//		System.out.println("hospId@DocEditServlet = "+hospId);
		String doctorNo = request.getParameter("doctorNo");
//		System.out.println("docNo@DocEditServlet = "+doctorNo);
		int numPerPage = 5;
		int cPage = 1;
		
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch(NumberFormatException e) {
		}
		
		//2.업무로직
		Hospital h = new HospitalService().selectOne(hospId);
//		System.out.println(h);
		List<HospDoctor> list = new HospitalService().selectAll(cPage, numPerPage, hospId);
//		System.out.println("list@servlet"+list);
		
		String url = request.getRequestURI()+"?";
		int totalContents = new HospitalService().selectTotalContents(hospId);
//		System.out.println(totalContents);
		
		String pageBar = Utils.getPageBarHtml0(cPage, numPerPage, totalContents, url);
		
		HospDoctor hd = new HospitalService().selectOneDoc(doctorNo);
//		System.out.println(hd);
		
		List<HospFile> hospFileList = new HospitalService().selectHospDocFile(hospId);
//		System.out.println("hospFileList@DocES = "+hospFileList);
		
		
		request.setAttribute("hospFileList", hospFileList);
		request.setAttribute("list", list);
		request.setAttribute("pageBar", pageBar);
		request.setAttribute("h", h);
		request.setAttribute("hd", hd);
		
		request.getRequestDispatcher("/WEB-INF/views/hospital/edit-doc.jsp").forward(request, response);
	}
	
	/**
	 * 수정정보 update
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(!ServletFileUpload.isMultipartContent(request)) {
			System.out.println("enctype오류!");
		}
		String saveDirectory = getServletContext().getRealPath("/upload/hospital");
		int maxPostSize = 1024*1024*10; //10MB
		String encoding = "utf-8";
		FileRenamePolicy policy = new HospitalFileRenamePolicy();
		
		MultipartRequest multipartRequest = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
		
		String hospId = multipartRequest.getParameter("hospId");
		String doctorNo = multipartRequest.getParameter("doctorNo");
		String doctorName = multipartRequest.getParameter("doctorName");
		String hospDept = multipartRequest.getParameter("hospDept");
		String doctorTreat = multipartRequest.getParameter("doctorTreat");
		String doctorSpec = multipartRequest.getParameter("doctorSpec");
		
		HospDoctor hd = new HospDoctor(doctorNo, hospId, doctorName, hospDept, doctorTreat, doctorSpec);
//		System.out.println("hd@servlet = "+hd);
		String boardOriginalFileName = multipartRequest.getOriginalFileName("upfile");
		String boardRenamedFileName = multipartRequest.getFilesystemName("upfile");
		String oldOriginalFileName = multipartRequest.getParameter("oldOriginalFileName");
		String oldRenamedFileName = multipartRequest.getParameter("oldRenamedFileName");		
		String delFile = multipartRequest.getParameter("delFile");
		
		HospFile hf = new HospFile(hospId, doctorNo, boardOriginalFileName, boardRenamedFileName);
		//기존 첨부파일이 있는 경우 처리
		if(!"".equals(oldOriginalFileName)) {
			if(boardOriginalFileName == null && delFile == null) { //새 첨부파일이 없는 경우
				hf.setBoardOriginalFileName(oldOriginalFileName);
				hf.setBoardRenamedFileName(oldRenamedFileName);
			} else { //새 첨부파일이 있는 경우
				//기존파일 삭제
				File f = new File(saveDirectory, oldRenamedFileName);
				f.delete();
				System.out.println("["+oldOriginalFileName+"] 파일 삭제");
			}
		}
		//3. 업무로직 : DB에 insert
		int result = new HospitalService().updateDoc(hd);
		int result2 = new HospitalService().updateDocFile(hf);
//		System.out.println("result@DocEditServlet = "+ result);
		
		//4. 사용자 응답처리 : msg.jsp
		String msg = result+result2 > 1 ? "의사정보변경 성공!" : "의사정보변경 실패!";
		String loc = "/hospital/doctorList?hospId="+hospId;
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
	}

}
