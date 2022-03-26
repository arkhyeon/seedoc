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
import hospital.model.vo.HospFile;
import hospital.model.vo.HospTime;
import hospital.model.vo.Hospital;


/**
 * Servlet implementation class HospitalEditInfoServlet
 */
@WebServlet("/hospital/edit-info")
public class HospitalEditInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HospitalEditInfoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String hospId = request.getParameter("hospId");
//		System.out.println(hospId);
		Hospital h = new HospitalService().selectOne(hospId);
		HospTime ht = new HospitalService().selectOneTime(hospId);
		List<HospFile> hospFileList = new HospitalService().selectHospFile(hospId);
//		System.out.println(h);
//		System.out.println(ht);
//		System.out.println(hospFileList);
		request.setAttribute("hospFileList", hospFileList);
		request.setAttribute("h", h);
		request.setAttribute("ht", ht);
		request.getRequestDispatcher("/WEB-INF/views/hospital/edit-info.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
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
		System.out.println(hospId);
		String hospPwd = Utils.getEncryptedPassword(multipartRequest.getParameter("hospPwd"));
		String hospName = multipartRequest.getParameter("hospName");
		String hospTel = multipartRequest.getParameter("hospTel");
		String hospAddr = multipartRequest.getParameter("hospAddr");
		String hospInfo = multipartRequest.getParameter("hospInfo");
		String[] hospConvs = multipartRequest.getParameterValues("HospConv");
//		System.out.println(hospId);
//		System.out.println(hospPwd);
//		System.out.println(hospId);
//		System.out.println(hospName);
//		System.out.println(hospTel);
//		System.out.println(hospAddr);
//		System.out.println(hospInfo);
		String hospConv = "";
		if(hospConvs != null)
			hospConv = String.join(",", hospConvs);
//		System.out.println("hospConv = " +hospConv);
		Hospital h = new Hospital(hospId, hospPwd, hospName, hospAddr,
				hospTel, hospInfo, hospConv, null);
//		System.out.println("h@servlet = "+h);
		
		String monOpen = multipartRequest.getParameter("mon-open");
		String monEnd = multipartRequest.getParameter("mon-close");
		String tueOpen = multipartRequest.getParameter("tue-open");
		String tueEnd = multipartRequest.getParameter("tue-close");
		String wedOpen = multipartRequest.getParameter("wed-open");
		String wedEnd = multipartRequest.getParameter("wed-close");
		String thuOpen = multipartRequest.getParameter("thu-open");
		String thuEnd = multipartRequest.getParameter("thu-close");
		String friOpen = multipartRequest.getParameter("fri-open");
		String friEnd = multipartRequest.getParameter("fri-close");
		String satOpen = multipartRequest.getParameter("sat-open");
		String satEnd = multipartRequest.getParameter("sat-close");
		String sunOpen = multipartRequest.getParameter("sun-open");
		String sunEnd = multipartRequest.getParameter("sun-close");
		String lunOpen = multipartRequest.getParameter("lunch-open");
		String lunEnd = multipartRequest.getParameter("lunch-close");
//		HospTime ht = new HospTime(hospId, hospPwd, hospName, hospAddr, hospTel, hospInfo, hospConv, null,
//				hospId, monOpen, monEnd, tueOpen, tueEnd, wedOpen, wedEnd, thuOpen, thuEnd, friOpen, friEnd,
//				satOpen, satEnd, sunOpen, sunEnd, lunOpen, lunEnd);
		HospTime ht = new HospTime(hospId, monOpen, monEnd, tueOpen, tueEnd, wedOpen, wedEnd, thuOpen, thuEnd,
				friOpen, friEnd, satOpen, satEnd, sunOpen, sunEnd, lunOpen, lunEnd);
		
		//로고이미지일때
		String boardOriginalFileName1 = multipartRequest.getOriginalFileName("upFile1");
		String boardRenamedFileName1 = multipartRequest.getFilesystemName("upFile1");
		String oldOriginalFileName1 = multipartRequest.getParameter("oldOriginalFileName1");
		String oldRenamedFileName1 = multipartRequest.getParameter("oldRenamedFileName1");
		String delFile1 = multipartRequest.getParameter("delFile1");
		//대표이미지일때
		String boardOriginalFileName2 = multipartRequest.getOriginalFileName("upFile2");
		String boardRenamedFileName2 = multipartRequest.getFilesystemName("upFile2");
		String oldOriginalFileName2 = multipartRequest.getParameter("oldOriginalFileName2");
		String oldRenamedFileName2 = multipartRequest.getParameter("oldRenamedFileName2");
		String delFile2 = multipartRequest.getParameter("delFile2");
		
//		System.out.println("boardOriginalFileName1 = "+boardOriginalFileName1);
//		System.out.println("boardRenamedFileName1 = "+boardRenamedFileName1);
//		System.out.println("boardOriginalFileName2 = "+boardOriginalFileName2);
//		System.out.println("boardRenamedFileName2 = "+boardRenamedFileName2);
//		System.out.println("delFile1 = "+delFile1);
//		System.out.println("delFile2 = "+delFile2);
//		System.out.println("oldOriginalFileName1 = "+ oldOriginalFileName1);
//		System.out.println("oldRenamedFileName1 = "+oldRenamedFileName1);
//		System.out.println("oldOriginalFileName2 = "+ oldOriginalFileName2);
//		System.out.println("oldRenamedFileName2 = "+oldRenamedFileName2);
		
		HospFile hf1 = new HospFile(hospId, null, boardOriginalFileName1, boardRenamedFileName1, "logo");
		HospFile hf2 = new HospFile(hospId, null, boardOriginalFileName2, boardRenamedFileName2, "thumbnail");
		
		//기존 첨부파일이 있는 경우 처리
		//
		if(!"".equals(oldOriginalFileName1) && !"".equals(oldRenamedFileName1)) {
			if(boardOriginalFileName1 == null && delFile1 == null) { //새 첨부파일이 없는 경우
				hf1.setBoardOriginalFileName(oldOriginalFileName1);
				hf1.setBoardRenamedFileName(oldRenamedFileName1);
			} else { //새 첨부파일이 있는 경우
				//기존파일 삭제
				File f = new File(saveDirectory, oldRenamedFileName1);
				f.delete();
				System.out.println("["+oldOriginalFileName1+"] 파일 삭제");
			}
		}
		if(!"".equals(oldOriginalFileName2)) {
			if(boardOriginalFileName2 == null && delFile2 == null) { //새 첨부파일이 없는 경우
				hf2.setBoardOriginalFileName(oldOriginalFileName2);
				hf2.setBoardRenamedFileName(oldRenamedFileName2);
			} else { //새 첨부파일이 있는 경우
				//기존파일 삭제
				File f = new File(saveDirectory, oldRenamedFileName2);
				f.delete();
				System.out.println("["+oldOriginalFileName2+"] 파일 삭제");
			}
		}
		
		//3. 업무로직 : DB에 insert
		int result = new HospitalService().updateHosp(h);
		int result2 = new HospitalService().updateHospTime(ht);
		int result3 = new HospitalService().updateHospFile(hf1);
		int result4 = new HospitalService().updateHospFile(hf2);
		//System.out.println("result@HospitalEditServlet = "+ result);
		System.out.println(result+" , "+result2+" , "+result3+" , "+result4);
		//4. 사용자 응답처리 : msg.jsp
		String msg = result+result2+result3+result4 >= 4 ? "정보수정 성공!" : "정보수정 실패!";
		String loc = "/hospital/edit-info?hospId="+h.getHospId(); 

		request.setAttribute("ht",ht);
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
	}

}
