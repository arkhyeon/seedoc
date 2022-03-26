package common.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import hospital.model.vo.Hospital;
import member.model.service.MemberService;
import member.model.vo.User;

/**
 * Servlet Filter implementation class HospitalFilter
 */
@WebFilter(urlPatterns = {"/hospital/edit-info", "/hospital/doctorList", "/hospital/doctorRegister", "/hospital/doctorEdit", "/hospital/doctorDelete", "/hospital/deleteHospital", "/hospital/hospitalUploadFile"
			,"/booking/bookingHopitalList", "/booking/bookingFinder", "/booking/deleteHospBooking", "/booking/completeBooking"})
public class HospitalFilter implements Filter {
	
    /**
     * Default constructor. 
     */
    public HospitalFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpReq = (HttpServletRequest)request;
		HttpSession session = httpReq.getSession();
		Hospital hospLoggedIn = (Hospital)session.getAttribute("hospLoggedIn");
		System.out.println(hospLoggedIn);
		User userLoggedIn = (User)session.getAttribute("userLoggedIn");
		if(hospLoggedIn==null) {
			if(!userLoggedIn.getUserRole().equals("A")) {
				request.setAttribute("msg", "잘못된 접근입니다.");
				request.setAttribute("loc", "/");
				request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
				return;//이하 코드가 처리되지 않도록함
			}else {
				chain.doFilter(request, response);
			}
		}
		else {
			chain.doFilter(request, response);
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
