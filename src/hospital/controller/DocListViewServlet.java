package hospital.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.util.Utils;
import hospital.model.service.HospitalService;
import hospital.model.vo.HospDoctor;
import hospital.model.vo.HospFile;
import hospital.model.vo.Hospital;

/**
 * Servlet implementation class DocView
 */
@WebServlet("/hospital/doctorList")
public class DocListViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DocListViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.사용자 입력값 cPage
		String hospId = request.getParameter("hospId");
//		System.out.println(hospId);
		int numPerPage = 5;
		int cPage = 1;
		
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch(NumberFormatException e) {
		}
		
		Hospital h = new HospitalService().selectOne(hospId);
//		System.out.println("h@DocListS = "+h);
		List<HospDoctor> list = new HospitalService().selectAll(cPage, numPerPage, hospId);
//		System.out.println("list@servlet"+list);
		List<HospFile> hospFileList = new HospitalService().selectHospDocFile(hospId);
//		System.out.println("hf@DocLS = "+hospFileList);
		
		String url = request.getRequestURI()+"?"+"hospId="+hospId+"&";
		int totalContents = new HospitalService().selectTotalContents(hospId);
//				System.out.println(totalContents);
		String pageBar = Utils.getPageBarHtml0(cPage, numPerPage, totalContents, url);
		
		//3.view단처리
		request.setAttribute("hospFileList", hospFileList);
		request.setAttribute("h", h);
		request.setAttribute("list", list);
		request.setAttribute("pageBar", pageBar);
		
		request.getRequestDispatcher("/WEB-INF/views/hospital/docList-View.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
