package booking.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import booking.model.service.BookingService;
import booking.model.vo.Booking;
import hospital.model.vo.HospTime;

/**
 * Servlet implementation class BookingCalendarServlet
 */
@WebServlet("/booking/bookingCalendar")
public class BookingCalendarServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookingCalendarServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int week = Integer.parseInt(request.getParameter("week"));
		String year = request.getParameter("year");
		String mon = request.getParameter("mon");
		String day = request.getParameter("day");
		String hospId = request.getParameter("hospId");
		String doctorNo = request.getParameter("doctorNo");
//		System.out.println("week@sevelt: " + week);
//		System.out.println("hospId@sevelt: " + hospId);
//		System.out.println("doctorNo@sevelt: " + doctorNo);
//		System.out.println("date@sevelt: " + year);
//		System.out.println("date@sevelt: " + mon);
//		System.out.println("date@sevelt: " + day);

		
		HospTime ht = new BookingService().hospitalTimeSelect(hospId);
		List<Booking> list = new BookingService().bookingDocNoSelect(doctorNo);
//		System.out.println("ht@servlet: " + ht);
//		System.out.println(list);
		request.setAttribute("week", week);
		request.setAttribute("doctorNo", doctorNo);
		request.setAttribute("ht", ht);
		request.setAttribute("list", list);
		request.setAttribute("year", year);
		request.setAttribute("mon", mon);
		request.setAttribute("day", day);
		request.getRequestDispatcher("/WEB-INF/views/booking/booking-time.jsp").forward(request, response);
	}

}
