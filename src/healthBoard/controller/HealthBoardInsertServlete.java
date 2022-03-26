package healthBoard.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import common.HospitalFileRenamePolicy;
import healthBoard.model.exception.HealthBoardException;
import healthBoard.model.service.HealthBoardService;
import healthBoard.model.vo.HealthBoard;

/**
 * Servlet implementation class healthBoardInsertServlete
 */
@WebServlet("/healthBoard/healthBoardInsert")
public class HealthBoardInsertServlete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HealthBoardInsertServlete() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(!ServletFileUpload.isMultipartContent(request)){
			throw new HealthBoardException("파일업로드 enctype 속성 미적용! : "+request.getRequestURI());
		}
		
		String saveDirectory = getServletContext().getRealPath("/")+"upload/healthBoard";
		
		int maxPostSize = 1024 * 1024 * 10;
		
		FileRenamePolicy policy = new HospitalFileRenamePolicy();
		
		MultipartRequest multipartRequest = new MultipartRequest(request, saveDirectory, maxPostSize, "utf-8", policy);
		
		String boardTitle = multipartRequest.getParameter("boardTitle");
		String boardWriter = multipartRequest.getParameter("boardWriter");
		String boardContent = multipartRequest.getParameter("boardContent");
//		xss공격대비 : script태그 무효화 처리
		boardContent = boardContent.replaceAll("<", "&lt;").replaceAll(">", "&gt");
		
		String boardOriginalFileName = multipartRequest.getOriginalFileName("upFile");
		String boardRenamedFileName = multipartRequest.getFilesystemName("upFile");
		
		HealthBoard nhb = new HealthBoard(0, boardTitle, boardWriter, boardContent, boardOriginalFileName, boardRenamedFileName, null, 0);
		int result = new HealthBoardService().insertBoard(nhb);
		String msg = result >0 ? "게시물게시 성공!": "게시물게시 실패!";
		String loc = "/healthBoard/healthBoardView?healthBoardNo="+nhb.getBoardNo();//DML요청후에는 반드시 페이지 이동처리를 해줘야한다.안그럼 에러가 생긴다.
		
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
