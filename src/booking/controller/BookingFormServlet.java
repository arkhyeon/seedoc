package booking.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import booking.model.service.BookingService;
import hospital.model.vo.HospDoctor;
import hospital.model.vo.HospFile;
import hospital.model.vo.HospTime;
import hospital.model.vo.Hospital;
import member.model.vo.User;

/**
 * Servlet implementation class BookingFormServlet
 */
@WebServlet("/booking/bookingfrm")
public class BookingFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookingFormServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String hospId=request.getParameter("hospId");
		String userId=request.getParameter("userId");
//		String hospId = "hospital1";
//		String userId = "honggd";
		
		User user = new BookingService().userSelectOne(userId);
		Hospital hosp = new BookingService().bookingHospSelect(hospId);
		List<HospDoctor> doclist=new BookingService().bookingHospDoctorSelect(hospId);
		HospTime ht = new BookingService().hospitalTimeSelect(hospId);
		List<HospFile> hflist = new BookingService().hospitalFileSelect(hospId);
		
//		System.out.println("servlet@user: " + user);
//		System.out.println("servlet@hosp: " + hosp);
//		System.out.println("servlet@doclist: " + doclist);
//		System.out.println("servlet@ht: " + ht);
		
		request.setAttribute("user", user);
		request.setAttribute("hosp", hosp);
		request.setAttribute("doclist", doclist);
//		request.setAttribute("ht", ht);
		request.setAttribute("hflist", hflist);
		request.getRequestDispatcher("/WEB-INF/views/booking/booking-hos.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
