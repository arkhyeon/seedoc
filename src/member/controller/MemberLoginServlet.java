package member.controller;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.util.Utils;
import member.model.service.MemberService;
import member.model.vo.User;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/member/login")
public class MemberLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberLoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/member/login.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String userId = request.getParameter("userId");
		String userPwd = Utils.getEncryptedPassword(request.getParameter("userPwd"));
		String saveUserId = request.getParameter("saveUserId");
		Enumeration<String> headerNames = request.getHeaderNames();
		
		while(headerNames.hasMoreElements()) {
			String key = headerNames.nextElement();
			String value = request.getHeader(key);
		}
		
		User u = new MemberService().selectOne(userId);
		
		if(u != null && userId.equals(u.getUserId()) && userPwd.equals(u.getUserPwd())) {
			
			HttpSession session = request.getSession();
			
			session.setMaxInactiveInterval(30*60);
			
			session.setAttribute("userLoggedIn", u);
			
			Cookie c = new Cookie("saveUserId", userId);
			c.setPath(request.getContextPath()); //쿠키유효 디렉토리 설정
			
			if(saveUserId != null) {
				c.setMaxAge(7*24*60*60); //7일
			} 
			else {
				c.setMaxAge(0);
			}
			response.addCookie(c);
			
			request.setAttribute("msg", "로그인성공");
			request.setAttribute("loc", "/");//사용자 피드백 이후 이동할 페이지
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
			 
		}
		//아이디 또는 비번이 틀린 경우
		else {
			request.setAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
			request.setAttribute("loc", "/member/login");//사용자 피드백 이후 이동할 페이지
			
			RequestDispatcher reqDispatcher = request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp");
			reqDispatcher.forward(request, response);
		}
	}
		

}
