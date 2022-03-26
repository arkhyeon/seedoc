package healthBoard.controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import healthBoard.model.service.HealthBoardService;

/**
 * Servlet implementation class HealthBoardDeleteServlet
 */
@WebServlet("/healthBoard/healthBoardDelete")
public class HealthBoardDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HealthBoardDeleteServlet() {
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
		
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		String fileName = request.getParameter("fileName");
		
		if(!"".equals(fileName)) {
			String saveDirectory = getServletContext().getRealPath("/upload/healthBoard");
			File delFile = new File(saveDirectory, fileName);
			boolean delOk = delFile.delete();
		}
		int result = new HealthBoardService().deleteBoard(boardNo);
		
		String msg = result >0 ? "게시물삭제 성공!": "게시물삭제 실패!";
		String loc = "/healthBoard/healthboardList";//DML요청후에는 반드시 페이지 이동처리를 해줘야한다.안그럼 에러가 생긴다.
		
//		4. view단 처리
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
		
		
		
		
	}

}
