package hospital.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import hospital.model.service.HospitalService;
import hospital.model.vo.HospDoctor;
import hospital.model.vo.HospFile;
import hospital.model.vo.Hospital;

/**
 * Servlet implementation class SearchServlet
 */
@WebServlet("/searchAddr")
public class SearchServlet2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchServlet2() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String addr1 = request.getParameter("addr1");
		String addr2 = request.getParameter("addr2");
		String addr3 = request.getParameter("addr3");
		String addr4 = request.getParameter("addr4");
		String addr5 = request.getParameter("addr5");
		List<Hospital> hospList = null;
		hospList = new HospitalService().searchHospAddr(addr1, addr2, addr3, addr4, addr5);
		
//		System.out.println("addr1@SearchS = "+addr1);
//		System.out.println("addr2@SearchS = "+addr2);
//		System.out.println("addr3@SearchS = "+addr3);
//			
		List<HospFile> hfList = null;
		String hfRenamedFileName = "";
		//hospList의 hospId값으로 첨부파일 조회
		for(Hospital h : hospList) {
			hfList = new HospitalService().selectHospFile(h.getHospId());
			//첨부파일이 있을 때
			if(!hfList.isEmpty()) {
				for(HospFile hf : hfList) {
					if("logo".equals(hf.getUse())) //첨부파일이 로고인지?
						h.setHospInfo(hf.getBoardRenamedFileName()); //upload/hospital에 있는 사진값 가져오기
//						hfRenamedFileName = hf.getBoardRenamedFileName(); //upload/hospital에 있는 사진값 가져오기
				}
			}
		}
		Gson gson = new Gson();
		String jsonStr = gson.toJson(hospList);
//		String jsonStr2 = gson.toJson(hfRenamedFileName);
//		System.out.println(jsonStr);
		
		response.setContentType("application/json; charset=utf-8"); //json형식임을 클라이언트에게 알려주기
//		new Gson().toJson(jsonStr, response.getWriter());;
		response.getWriter().print(jsonStr);
//		response.getWriter().print(jsonStr2);
//		request.setAttribute("hospList", hospList);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
