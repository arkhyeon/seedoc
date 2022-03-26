package hospital.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import reviewBoard.model.service.ReviewBoardService;
import reviewBoard.model.vo.Review;
import hospital.model.service.HospitalService;
import hospital.model.vo.HospDoctor;
import hospital.model.vo.HospFile;
import hospital.model.vo.HospTime;
import hospital.model.vo.Hospital;

/**
 * Servlet implementation class HospitalServlet
 */
@WebServlet("/hospital/hospital")
public class HospitalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HospitalServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String hospId = request.getParameter("hospId");

		List<Review> list = new ReviewBoardService().reviewList(hospId);
		List<HospDoctor> doctor = new HospitalService().doctorList(hospId); 
		Hospital hosp = new HospitalService().hospitalInfo(hospId);
		HospTime time = new HospitalService().hospTime(hospId);
		List<HospFile> file = new HospitalService().hospFile(hospId);
		HospFile logo = new HospitalService().hosLogo(hospId);
		List<HospFile> thumbnail = new HospitalService().thumnail(hospId);

		request.setAttribute("list", list);
		request.setAttribute("doctor", doctor);
		request.setAttribute("hosp", hosp);
		request.setAttribute("time", time);
		request.setAttribute("file", file);
		request.setAttribute("logo", logo);
		request.setAttribute("thumbnail", thumbnail);
		request.getRequestDispatcher("/WEB-INF/views/hospital/hospital.jsp")
			   .forward(request, response);	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
