package healthBoard.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class BoardFileDownloadServlet
 */
@WebServlet("/healthBoard/fileDownload")
public class HealthBoardFileDownloadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HealthBoardFileDownloadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		1.파라미터핸들링
		String oname = request.getParameter("oname");
		String rname = request.getParameter("rname");
		
//		2.파일입력 -> 응답출력
		String saveDirectory = getServletContext().getRealPath("/upload/healthBoard");
		FileInputStream fis = new FileInputStream(new File(saveDirectory,rname));//저장된파일을 읽어와야하기때문에 rname
		BufferedInputStream bis = new BufferedInputStream(fis);
		
		BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
		
//		3.응답헤더작성 : 파일명, 타입명시
//		IE 브라우져를 통한 요청여부 확인
		boolean isIE = request.getHeader("user-agent").indexOf("MSIE")>-1
					|| request.getHeader("user-agent").indexOf("Tride")>-1;
		if(isIE) {
//			공백을 의미하는 + 를 %20 으로 변환
			oname = URLEncoder.encode(oname,"utf-8").replace("\\+", "%20");
			
		}else {
//			ascii -> iso-8859-1(유럽어 포함된 최초의 인코딩)
			oname = new String(oname.getBytes("utf-8"),"iso-8859-1");
		}
		
		response.setContentType("application/octet-stream");//이진데이터 전송시 MIME타입
		response.setHeader("Content-Disposition", "attachment; filename="+oname);
		
//		4.응답쓰기 작업 & 자원반납
		int read = -1;
		while((read = bis.read())!=-1) {
			bos.write(read);
		}
		bos.close();
		bis.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
