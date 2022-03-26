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

/**
 * Servlet implementation class BookingHospFinderServlet
 */
@WebServlet("/booking/bookingFinder")
public class BookingHospFinderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public BookingHospFinderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String searchType = request.getParameter("searchType");
		String searchKeyword = request.getParameter("searchKeyword");
		int cPage = 1;
		int numPerPage = 10;
		
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		}catch(NumberFormatException e) {
			
		}
		
		String hospId = request.getParameter("hospId");
		String state = request.getParameter("state");
		state = state != null ? state: "_";
//		String hospId = "hospital1";
//		String state = "A";
		
		
		List<BookingAdd> list = new BookingService().bookingAddHospFinderList(hospId, state,searchType, searchKeyword, cPage, numPerPage);
		BookingCount bc = new BookingService().bookingHospFinderCount(hospId, searchType, searchKeyword);
//		System.out.println("BookingHospList@servlet: " + list);
//		System.out.println("BookingHospCount@servlet: " + bc);
		
		String url = request.getRequestURI()+"?state="+state+"&";
		int totalContents = "A".equals(state)==true?bc.getApproval():"F".equals(state)==true? bc.getFinish() : "C".equals(state)==true? bc.getCancle():bc.getTotal();
		String pageBar = Utils.getPageBarHtml0(cPage, numPerPage, totalContents, url);
		
		request.setAttribute("list", list);
		request.setAttribute("bc", bc);
		request.setAttribute("pageBar", pageBar);

		request.getRequestDispatcher("/WEB-INF/views/booking/hospital-booking.jsp").forward(request, response);
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
