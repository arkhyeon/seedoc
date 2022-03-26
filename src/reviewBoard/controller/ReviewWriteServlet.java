package reviewBoard.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import reviewBoard.model.service.ReviewBoardService;
import reviewBoard.model.vo.Review;

/**
 * Servlet implementation class ReviewWriteServlet
 */
@WebServlet("/board/writeReview")
public class ReviewWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ReviewWriteServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/board/writeReview.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		// 1. 파라미터 핸들링
		String userId = request.getParameter("userId");
		String hospId = request.getParameter("hospId");
//		String reviewNo = request.getParameter("reviewNo");
		int reviewRank = Integer.parseInt(request.getParameter("reviewRank"));
		int reviewLevel = Integer.parseInt(request.getParameter("reviewLevel"));
//		String reviewWriter = request.getParameter("reviewWriter");
		String bookingNo = request.getParameter("bookingNo");
		String reviewCon = request.getParameter("reviewCon");
		
		reviewCon = reviewCon.replaceAll("<", "&lt;").replaceAll(">", "&gt");
		int reviewRef = Integer.parseInt(request.getParameter("reviewRef"));

		Review r = new Review(bookingNo, userId, hospId, reviewCon, reviewRank, 0, reviewLevel, reviewRef);
		Review rsel = new ReviewBoardService().reviewselectOne(bookingNo);
		System.out.println(r);
		
		String loc = "/booking/bookinglist?userId="+userId;
		if(userId == null) {
			loc = "/hospital/hospital?hospId="+hospId;
		}
		String msg = null;
		if(rsel == null || reviewLevel==2) {
			int result = new ReviewBoardService().writeReivew(r);
			msg = result > 0 ? "등록 성공!" : "등록 실패!";
		} else {
			msg = "이미 등록된 리뷰입니다.";
		}
		
		request.setAttribute("loc", loc);
		request.setAttribute("msg", msg);
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
	}

}
