package booking.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import booking.model.service.BookingService;
import booking.model.vo.BookingAdd;
import booking.model.vo.BookingCount;
import common.util.Utils;
import member.model.vo.User;

/**
 * Servlet implementation class BookingListMain
 */
@WebServlet("/booking/bookingListMain")
public class BookingListMain extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookingListMain() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//1. 사용자 입력값 cPage
		String state = request.getParameter("state");
		String userId = request.getParameter("userId");
//		String userId = "honggd";
		
//		List<Booking> list = new BookingService().bookingUserList(userId);
//		List<BookingAdd> list = new BookingService().bookingAddUserList(userId);
		List<BookingAdd> list = new BookingService().bookingListMain(userId, state);
//		System.out.println("BookingList@servlet: " + list);
		BookingCount bc = new BookingService().bookingCount(userId);
		User user = new BookingService().userSelectOne(userId);
//		System.out.println("BookingCount@servlet: " + bc);
		
		
		request.setAttribute("list", list);
		request.setAttribute("bc", bc);
		request.setAttribute("user", user);
		
		request.getRequestDispatcher("/WEB-INF/views/booking/myBookingMain.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
