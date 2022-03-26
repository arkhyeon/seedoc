package booking.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import booking.model.service.BookingService;
import booking.model.vo.Booking;
import member.model.vo.User;

/**
 * Servlet implementation class BookingInsertServlet
 */
@WebServlet("/booking/bookingInsert")
public class BookingInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookingInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String birth = request.getParameter("birth");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String userId = request.getParameter("userId");
		String hospId = request.getParameter("hospId");
		String doctorNo = request.getParameter("doctorNo");
		String doctorName = request.getParameter("doctorName");
		String userName = request.getParameter("userName");
		String bookingDate = request.getParameter("bookingDate");
		String bookingTime = request.getParameter("bookingTime");
		String sysptom = request.getParameter("sysptom");
		
		Date bookingDate_=null; //2020-07-16
		if(bookingDate != null && !"".equals(bookingDate)) {
			bookingDate_ = Date.valueOf(bookingDate);
		}
		Booking booking = new Booking(null, userId, hospId, doctorNo, userName, bookingDate_, bookingTime, sysptom, null, null);
		int result = new BookingService().bookingInsert(booking);
		
		String msg = result > 0? "병원 예약 성공!" : "병원 예약 실패";
		String loc = "/booking/bookinglist?userId="+userId;
		
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
	}

}
