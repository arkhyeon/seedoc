package booking.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import booking.model.service.BookingService;
import booking.model.vo.Booking;
import hospital.model.vo.HospDoctor;
import hospital.model.vo.HospFile;
import hospital.model.vo.HospTime;
import hospital.model.vo.Hospital;
import member.model.vo.User;

/**
 * Servlet implementation class BookingUpdateServlet
 */
@WebServlet("/booking/updateBookingFrm")
public class BookingUpdateFrmServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookingUpdateFrmServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String bookingNo =(String)request.getParameter("bookingNo");
		String hospId =(String)request.getParameter("hospId");
		String userId =(String)request.getParameter("userId");
//		System.out.println("servlet@bookingNo: "+bookingNo);
		
		User user = new BookingService().userSelectOne(userId);
		Hospital hosp = new BookingService().bookingHospSelect(hospId);
		List<HospDoctor> doclist = new BookingService().bookingHospDoctorSelect(hospId);
		HospTime ht = new BookingService().hospitalTimeSelect(hospId);
		List<HospFile> hflist = new BookingService().hospitalFileSelect(hospId);
		Booking booking = new BookingService().bookingNoSelect(bookingNo);
		
//		System.out.println("servlet@user: " + user);
//		System.out.println("servlet@hosp: " + hosp);
//		System.out.println("servlet@doclist: " + doclist);
//		System.out.println("servlet@ht: " + ht);
//		System.out.println("servlet@booking: " + booking);
		
		request.setAttribute("user", user);
		request.setAttribute("hosp", hosp);
		request.setAttribute("doclist", doclist);
//		request.setAttribute("ht", ht);
		request.setAttribute("hflist", hflist);
		request.setAttribute("booking", booking);
		
		request.getRequestDispatcher("/WEB-INF/views/booking/booking-update.jsp").forward(request, response);
		
		
	}

}
