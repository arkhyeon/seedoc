package healthBoard.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import healthBoard.model.service.HealthBoardService;
import healthBoard.model.vo.HealthBoardComment;

/**
 * Servlet implementation class HealthBoardCommentInsertServlet
 */
@WebServlet("/healthBoard/healthBoardCommentInsert")
public class HealthBoardCommentInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HealthBoardCommentInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int healthBoardRef = Integer.parseInt(request.getParameter("healthBoardRef"));
		int healthBoardCommentLevel = Integer.parseInt(request.getParameter("healthBoardCommentLevel"));
		int healthBoardCommentRef = Integer.parseInt(request.getParameter("healthBoardCommentRef"));
		String healthBoardCommentWriter = request.getParameter("healthBoardCommentWriter");
		String healthBoardCommentContent = request.getParameter("healthBoardCommentContent");
		
		HealthBoardComment hbc = new HealthBoardComment(0, healthBoardCommentLevel, healthBoardCommentWriter, healthBoardCommentContent, healthBoardRef, healthBoardCommentRef, null);
		int result = new HealthBoardService().insertBoardComment(hbc);
		
		String msg = result>0? "댓글 등록성공!":"댓글 등록실패!";
		String loc = "/healthBoard/healthBoardView?healthBoardNo="+healthBoardRef;
		
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
	}

}
