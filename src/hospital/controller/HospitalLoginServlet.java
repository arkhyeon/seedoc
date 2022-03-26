package hospital.controller;

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
import hospital.model.service.HospitalService;
import hospital.model.vo.Hospital;

/**
 * Servlet implementation class HospitalLoginServlet
 */
@WebServlet("/hospital/login")
public class HospitalLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HospitalLoginServlet() {
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
		String hospId = request.getParameter("hospId");
		String hospPwd = Utils.getEncryptedPassword(request.getParameter("hospPwd"));
		String saveHospId = request.getParameter("saveHospId");
//		System.out.println("hospId@servlet = "+hospId);
//		System.out.println("hospPwd@servlet = "+hospPwd);
//		System.out.println("saveHospId@servlet = "+saveHospId); //on : check
		
		Enumeration<String> headerNames = request.getHeaderNames();
		while(headerNames.hasMoreElements()) {
			String key = headerNames.nextElement();
			String value = request.getHeader(key);
//			System.out.println(key+" = "+value);
		}
		
		Hospital h = new HospitalService().selectOne(hospId);
//		System.out.println("h@servlet="+h);
		//4.응답처리
		//아이디,비번이 모두 일치하는 경우
		if(h != null && hospId.equals(h.getHospId()) && hospPwd.equals(h.getHospPwd())) {
			//세션가지여부: create여부 true
			//세션객체가 없다면, 새로 생성 후 리턴
			//있으면 가져오기
			HttpSession session = request.getSession();
//					System.out.println("sessionId = "+session.getId());
			//세션유효시간설정 : 초
			//web.xml에 선언한 session-config > session-timeout보다 우선순위가 높다.
			session.setMaxInactiveInterval(30*60);
			
			//세션에 로그인한 사용자 정보 저장
			session.setAttribute("hospLoggedIn", h);
			//쿠키(saveId)처리
			Cookie c = new Cookie("saveHospId", hospId);
			c.setPath(request.getContextPath()); //쿠키유효 디렉토리 설정
			
			//saveId체크한 경우 : 쿠키생성
			if(saveHospId != null) {
				c.setMaxAge(7*24*60*60); //7일
			} 
			//saveId를 체크하지 않은 경우 : 쿠키삭제
			else {
				c.setMaxAge(0);
			}
			
			response.addCookie(c);
			//리다이렉트 처리
			//로그인 요청 페이지로 이동
//			String referer = request.getHeader("referer"); //로그인을 요청한 페이지
//			response.sendRedirect(referer);
			
			
//			request.setAttribute("msg", "로그인성공");
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
