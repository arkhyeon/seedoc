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
@WebServlet("/searchButton")
public class SearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String hospName = request.getParameter("hospName");
		String doctorName = request.getParameter("doctorName");
		String hospDept = request.getParameter("hospDept");
		List<Hospital> hospList = null;
		hospList = new HospitalService().searchHosp(hospName, doctorName, hospDept);
		
//		System.out.println("hospName@SearchS = "+hospName);
//		System.out.println("doctorName@SearchS = "+doctorName);
//		System.out.println("hospDeptName@SearchS = "+hospDept);
		
//		System.out.println(hospList);
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
//		System.out.println(jsonStr);
		
		response.setContentType("application/json; charset=utf-8"); //json형식임을 클라이언트에게 알려주기
		response.getWriter().print(jsonStr);
//		request.setAttribute("hospList", hospList);
//		request.getRequestDispatcher("/").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
