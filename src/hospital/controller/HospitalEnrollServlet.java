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
import common.util.Utils;
import hospital.model.service.HospitalService;
import hospital.model.vo.HospFile;
import hospital.model.vo.HospTime;
import hospital.model.vo.Hospital;

/**
 * Servlet implementation class HospitalEnrollServlet
 */
@WebServlet("/hospital/hospitalEnroll")
public class HospitalEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HospitalEnrollServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(!ServletFileUpload.isMultipartContent(request))
			System.out.println("파일업로드 enctype 속성 미적용! : " + request.getRequestURI());
		String saveDirectory = getServletContext().getRealPath("/")+"/upload/hospital"; //업로드할파일 저장경로
		int maxPostSize = 1024 * 1024 * 10; //업로드할파일크키제한 10MB
		FileRenamePolicy policy = new HospitalFileRenamePolicy(); //중복인 경우, numbering
		
		MultipartRequest multipartRequest = new MultipartRequest(request, saveDirectory, maxPostSize, "utf-8", policy);
		
		String hospId = multipartRequest.getParameter("hospId");
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
		hospInfo = hospInfo.replaceAll("<", "&lt").replaceAll(">", "&gt;");
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
//		System.out.println("HEnrollServlet = "+ht);
		
		String boardOriginalFileName1 = multipartRequest.getOriginalFileName("upFile1"); //사용자가 업로드한 파일명
		String boardRenamedFileName1 = multipartRequest.getFilesystemName("upFile1");//저장되는 파일명
		String boardOriginalFileName2 = multipartRequest.getOriginalFileName("upFile2"); //사용자가 업로드한 파일명
		String boardRenamedFileName2 = multipartRequest.getFilesystemName("upFile2");//저장되는 파일명
		HospFile hf1 = new HospFile(hospId, null, boardOriginalFileName1, boardRenamedFileName1, "logo");
		HospFile hf2 = new HospFile(hospId, null, boardOriginalFileName2, boardRenamedFileName2, "thumbnail");
		System.out.println(hf1);
		System.out.println(hf2);
		//3. 업무로직 : DB에 insert
		int result = new HospitalService().insertHosp(h);
		int result2 = 0;
		int result3 = 0;
		int result4 = 0;
		if(result>0) {
			result2 = new HospitalService().insertHospTime(ht);
			if(result2>0) {
				result3 = new HospitalService().insertHospFile(hf1);
				if(result3>0) {
					result4 = new HospitalService().insertHospFile(hf2);
				}
			}
				
		}
//		System.out.println("result@HospitalEnrollServlet = "+ result);
		
		//4. 사용자 응답처리 : msg.jsp
		String msg = result+result2+result3+result4 == 4 ? "회원가입 성공!" : "회원가입 실패!";
		String loc = "/"; //index페이지로 돌아가기
		
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
	}

}
