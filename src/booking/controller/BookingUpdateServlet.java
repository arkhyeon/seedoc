package booking.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import booking.model.service.BookingService;
import booking.model.vo.Booking;

/**
 * Servlet implementation class BookingUpdateServlet
 */
@WebServlet("/booking/bookingUpdate")
public class BookingUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookingUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String bookingNo = request.getParameter("bookingNo");
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
		
//		System.out.println("입력: "+bookingDate);
		Date bookingDate_=null;
		if(bookingDate != null && !"".equals(bookingDate)) {
			bookingDate_ = Date.valueOf(bookingDate);
		}
//		System.out.println("출럭: "+bookingDate_);
		Booking booking = new Booking(bookingNo, userId, hospId, doctorNo, userName, bookingDate_, bookingTime, sysptom, null, null);
		
		int result = new BookingService().bookingUpdate(booking);
		
		String msg = result > 0? "예약 변경 성공!" : "예약 변경 실패!";
		String loc = "/booking/bookinglist?userId="+userId;
		
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);

		
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
	}

}
