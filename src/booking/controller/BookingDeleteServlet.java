package booking.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import booking.model.service.BookingService;

/**
 * Servlet implementation class BookingDeleteServlet
 */
@WebServlet("/booking/deleteBooking")
public class BookingDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookingDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String bookingNo = request.getParameter("bookingNo");
		String state = request.getParameter("state");
		String userId = request.getParameter("userId");
//		String state = "C";
		
		int result1 = new BookingService().updateStateBooking(bookingNo, state);
		int result2 = new BookingService().deleteBooking(bookingNo);
//		System.out.println("updateState" + result1);
//		System.out.println("deleteState" + result2);
		
		String msg = (result1 > 0 && result2 > 0) ? "예약 삭제 성공!" : "예약 삭제 실패!";
//		String msg = result1 > 0 ? "예약 삭제 성공!" : "예약 삭제 실패!";
		String loc = "/booking/bookinglist?userId="+userId;
		
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
		
	}

}
