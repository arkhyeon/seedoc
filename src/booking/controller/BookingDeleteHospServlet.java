package booking.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import booking.model.service.BookingService;

/**
 * Servlet implementation class BookingDeleteHospServlet
 */
@WebServlet("/booking/deleteHospBooking")
public class BookingDeleteHospServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookingDeleteHospServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String bookingNo = request.getParameter("bookingNo");
		String state = request.getParameter("bookingState");
		String cancle = request.getParameter("bookingCancle");
		String hospId = request.getParameter("hospId");
//		String state = "C";
//		System.out.println("booDel@servlet"+bookingNo);
//		System.out.println("booDel@servlet"+state);
//		System.out.println("booDel@servlet"+cancle);
		
		int result1 = new BookingService().updateStateHospBooking(bookingNo, state, cancle);
		int result2 = new BookingService().deleteBooking(bookingNo);
//		System.out.println("updateState" + result1);
//		System.out.println("deleteState" + result2);
		
		String msg = (result1 > 0 && result2 > 0) ? "예약 삭제 성공!" : "예약 삭제 실패!";
		String loc = "/booking/bookingHopitalList?hospId="+hospId;
		
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
	}

}
