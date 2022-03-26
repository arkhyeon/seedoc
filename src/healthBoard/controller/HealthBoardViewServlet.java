package healthBoard.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.util.Utils;
import healthBoard.model.service.HealthBoardService;
import healthBoard.model.vo.HealthBoard;
import healthBoard.model.vo.HealthBoardComment;

/**
 * Servlet implementation class healthBoardViewServlet
 */
@WebServlet("/healthBoard/healthBoardView")
public class HealthBoardViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HealthBoardViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int boardNo = Integer.parseInt(request.getParameter("healthBoardNo"));
		
		Cookie[] cookies = request.getCookies();
		String HboardCookieVal = "";
		boolean hasRead = false;
		
		if(cookies != null) {
			for(Cookie c : cookies) {
				String name = c.getName();
				String value = c.getValue();
				
				if("HboardCookie".equals(name)) {
					HboardCookieVal = value;
					
					if(value.contains("["+boardNo+"]")) {
						hasRead = true;
					}
				}
			}
		}
		
		if(!hasRead) {
			Cookie HboardCookie = new Cookie("HboardCookie",HboardCookieVal+"["+boardNo+"]");
			HboardCookie.setPath(request.getContextPath()+"/healthBoard");
			HboardCookie.setMaxAge(365*24*60*60);
			response.addCookie(HboardCookie);
		}
		
		HealthBoard hb = new HealthBoardService().selectOne(boardNo, hasRead);
//			개행문자처리
				String boardContentWithBr = hb.getBoardContent().replaceAll("\\n", "<br/>");
				hb.setBoardContent(boardContentWithBr);

		int numPerPage =10;
		int cPage=1;
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		}catch(NumberFormatException e) {
//			예외가 던져진 경우, cPage = 1로 유지
		}
//		댓글 목록조회
		List<HealthBoardComment> commentList = new HealthBoardService().selectCommentList(boardNo, cPage,numPerPage);
		String url = request.getRequestURI() + "?healthBoardNo=" +boardNo+"&";
		int totalContents = new HealthBoardService().selectTotalContents2(boardNo);
		
		String pageBar = Utils.getPageBarHtml2(cPage, numPerPage, totalContents, url);
//		3.view단 처리
		request.setAttribute("hb", hb);
		request.setAttribute("commentList", commentList);
		request.setAttribute("pageBar", pageBar);
		request.getRequestDispatcher("/WEB-INF/views/healthBoard/health_boardView.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
