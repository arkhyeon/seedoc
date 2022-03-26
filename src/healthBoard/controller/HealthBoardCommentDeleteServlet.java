package healthBoard.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import healthBoard.model.service.HealthBoardService;


/**
 * Servlet implementation class HealthBoardCommentDeleteServlet
 */
@WebServlet("/healthBoard/healthBoardCommentDelete")
public class HealthBoardCommentDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HealthBoardCommentDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int boardCommentNo = Integer.parseInt(request.getParameter("boardCommentNo"));
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));

		int result = new HealthBoardService().deleteBoardComment(boardCommentNo);
		
		String msg = result >0 ? "댓글삭제 성공!": "댓글삭제 실패!";
		String loc = "/healthBoard/healthBoardView?healthBoardNo="+boardNo;//DML요청후에는 반드시 페이지 이동처리를 해줘야한다.안그럼 에러가 생긴다.
		
//		4. view단 처리
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
		
		
		
		
	}

}
