package member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.service.MemberService;
import member.model.vo.User;

/**
 * Servlet implementation class SearchIdServlet
 */
@WebServlet("/searchId")
public class SearchIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchIdServlet() {
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
		//1.인코딩
		request.setCharacterEncoding("utf-8");
		//2.변수저장
		String userName = request.getParameter("userName");
		String userEmail = request.getParameter("userEmail");
		String userPhone = request.getParameter("userPhone");
		System.out.println(userName);
		System.out.println(userEmail);
		System.out.println(userPhone);
		//3.비지니스 로직
		MemberService service = new MemberService();
		User user = service.searchId(userName, userEmail, userPhone);
		System.out.println(user);
		//4.뷰 처리
		if(user != null) {
				RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/member/searchId2.jsp");
				request.setAttribute("user", user);
				rd.forward(request, response);
		}else {
				request.setAttribute("msg", "정확한 정보를 입력해 주세요!");
				request.setAttribute("loc", "/member/login");
				RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp");
				rd.forward(request, response);
					
		}
	}

}
