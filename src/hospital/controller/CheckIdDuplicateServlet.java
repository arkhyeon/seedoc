package hospital.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import hospital.model.service.HospitalService;
import hospital.model.vo.Hospital;


/**
 * Servlet implementation class CheckIdDuplicate
 */
@WebServlet("/hospital/checkIdDuplicate")
public class CheckIdDuplicateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckIdDuplicateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.사용자 입력값 처리
		String hospId = request.getParameter("hospId");
//		System.out.println("hospId@servlet = "+hospId);
		
		//3.업무로직 요청
		Hospital h = new HospitalService().selectOne(hospId);
		boolean isIdUsable = h == null ? true : false;
		request.setAttribute("isIdUsable", isIdUsable);
		
		response.setContentType("application/json; charset=utf-8");
//		request.getRequestDispatcher("/WEB-INF/views/member/register.jsp").forward(request, response);
		new Gson().toJson(isIdUsable, response.getWriter());;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
