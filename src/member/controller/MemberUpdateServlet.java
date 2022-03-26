package member.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.util.Utils;
import member.model.service.MemberService;
import member.model.vo.User;

/**
 * Servlet implementation class MemberEnrollServlet
 */
@WebServlet("/member/memberUpdate")
public class MemberUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberUpdateServlet() {
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
		
		String userId = request.getParameter("userId");//jsp의 name값으로 적어준다.
		String userPwd = Utils.getEncryptedPassword(request.getParameter("userPwd"));//jsp의 name값으로 적어준다.
		String userName = request.getParameter("userName");//jsp의 name값으로 적어준다.
		String userEmail = request.getParameter("userEmail");//jsp의 name값으로 적어준다.
		String userEmail2 = request.getParameter("userEmail2");//jsp의 name값으로 적어준다.
		String userEmail3 = userEmail+userEmail2;
		
		String userPhone = request.getParameter("userPhone");//jsp의 name값으로 적어준다.
		String userGender = request.getParameter("userGender");//jsp의 name값으로 적어준다.
		String userBirth = request.getParameter("userBirth");//jsp의 name값으로 적어준다.
		String userAddr = request.getParameter("userAddr");//jsp의 name값으로 적어준다.
		String userSymptom = request.getParameter("userSymptom");//jsp의 name값으로 적어준다.
		
		String birth = "";
		if (Integer.parseInt(userBirth.substring(0,4)) < 2000 && userGender.contains("M")) {
			birth = userBirth.substring(2).replace("-", "");
			birth += "-1";
		}else if(Integer.parseInt(userBirth.substring(0,4))>=2000 && userGender.contains("M")){
			birth = userBirth.substring(2).replace("-", "");
			birth += "-3";
		}else if(Integer.parseInt(userBirth.substring(0,4)) < 2000 && userGender.contains("F")) {
			birth = userBirth.substring(2).replace("-", "");
			birth += "-2";
		}else if(Integer.parseInt(userBirth.substring(0,4)) >= 2000 && userGender.contains("F")) {
			birth = userBirth.substring(2).replace("-", "");
			birth += "-4";
		}
		
		if(userSymptom == null) {
			userSymptom = "";
		}
		String emailDirect = "";
		User newUser = null;

		if(userEmail2.contains(Integer.toString(1))) {
			emailDirect = request.getParameter("emailDirect");
			String emailDirect2 = userEmail+emailDirect;
			newUser = new User(userId, userPwd, userName, emailDirect2, userPhone, userGender, birth, userAddr, userSymptom, null, null);
		}else {
			newUser = new User(userId, userPwd, userName, userEmail3, userPhone, userGender, birth, userAddr, userSymptom, null, null);
		}
		
		int result = new MemberService().updateMember(newUser);
		
		String msg = result >0 ? "회원정보수정성공!": "회원정보수정실패!";
		String loc = "/member/edit-info?userId="+newUser.getUserId(); //DML요청후에는 반드시 페이지 이동처리를 해줘야한다.안그럼 에러가 생긴다.
		
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
	}

}
