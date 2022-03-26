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
 * Servlet implementation class BookingListApprovalServlet
 */
@WebServlet("/booking/bookingListApproval")
public class BookingListApprovalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookingListApprovalServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 사용자 입력값 cPage
		int cPage = 1;
		int numPerPage = 2;
		
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		}catch(NumberFormatException e) {
			
		}
		
		String state = request.getParameter("state");
		String userId = request.getParameter("userId");
//		String userId = "honggd";
		
//		List<Booking> list = new BookingService().bookingUserList(userId);
//		List<BookingAdd> list = new BookingService().bookingAddUserList(userId);
		List<BookingAdd> list = new BookingService().bookingAddUserApprovalList(userId, state, cPage, numPerPage);
//		System.out.println("BookingList@servlet: " + list);
		BookingCount bc = new BookingService().bookingCount(userId);
		User user = new BookingService().userSelectOne(userId);
//		System.out.println("BookingCount@servlet: " + bc);
		
		String url = request.getRequestURI() + "?userId="+ userId + "&state="+ state +"&" ;
		int totalContents = "A".equals(state)==true?bc.getApproval():"F".equals(state)==true? bc.getFinish() : bc.getCancle();
		String pageBar = Utils.getPageBarHtml0(cPage, numPerPage, totalContents, url);
		
		request.setAttribute("list", list);
		request.setAttribute("bc", bc);
		request.setAttribute("user", user);
		request.setAttribute("pageBar", pageBar);
		
		request.getRequestDispatcher("/WEB-INF/views/booking/myBooking.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
