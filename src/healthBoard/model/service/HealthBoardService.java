package healthBoard.model.service;

import java.sql.Connection;
import java.util.List;
import static common.JDBCTemplate.*;

import healthBoard.model.dao.HealthBoardDAO;
import healthBoard.model.vo.HealthBoard;
import healthBoard.model.vo.HealthBoardComment;

public class HealthBoardService {

	private HealthBoardDAO healthBoardDAO = new HealthBoardDAO();
	
	public List<HealthBoard> selectAll(int cPage, int numPerPage) {
		Connection conn = getConnection();
		List<HealthBoard> list = healthBoardDAO.selectAll(conn, cPage, numPerPage);
		
		close(conn);
		
		return list;
	}

	public int selectTotalContents() {
		Connection conn = getConnection();
		int totalContents = healthBoardDAO.selectTotalContents(conn);
		close(conn);
		return totalContents;
	}

	public HealthBoard selectOne(int boardNo, boolean hasRead) {
		Connection conn = getConnection();
		int result = 0;
		if(!hasRead) {
			result = healthBoardDAO.viewsUpReadCount(conn,boardNo);
		}
		HealthBoard hb = healthBoardDAO.selectOne(conn,boardNo);
		if(result>0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		
		return hb;
	}

	public int insertBoard(HealthBoard nhb) {
		Connection conn = getConnection();
		int result = healthBoardDAO.insertBoard(conn,nhb);
		if(result>0) {
			int boardNo = healthBoardDAO.selectLastBoardNo(conn);
			nhb.setBoardNo(boardNo);
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}

	public HealthBoard selectOne(int boardNo) {
		Connection conn = getConnection();
		HealthBoard hb = healthBoardDAO.selectOne(conn, boardNo);
		close(conn);
		
		return hb;
	}

	public int updateBoard(HealthBoard updateHealthBoard) {
		Connection conn = getConnection();
		int result = healthBoardDAO.updateBoard(conn,updateHealthBoard);
		if(result>0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}

	public int deleteBoard(int boardNo) {
		Connection conn = getConnection();
		int result = healthBoardDAO.deleteBoard(conn, boardNo);
		if(result>0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}

	public List<HealthBoard> searchBoard(String searchType, String searchKeyword, int cPage, int numPerPage) {
		Connection conn = getConnection();
		List<HealthBoard> list = healthBoardDAO.searchBoard(conn, searchType,searchKeyword,cPage,numPerPage);
		close(conn);
		return list;
	}

	public int selectTotalContents(String searchType, String searchKeyword) {
		Connection conn = getConnection();
		int totalContents = healthBoardDAO.selectTotalContents(conn,searchType,searchKeyword);
		close(conn);
		return totalContents;
	}

	public int insertBoardComment(HealthBoardComment hbc) {
		Connection conn = getConnection();
		int result = healthBoardDAO.insertBoardComment(conn,hbc);
		if(result>0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}

	public List<HealthBoardComment> selectCommentList(int boardNo, int cPage, int numPerPage) {
		Connection conn = getConnection();
		List<HealthBoardComment> commentList = healthBoardDAO.selectCommentList(conn, boardNo, cPage,numPerPage); 
		close(conn);
		
		return commentList;
	}

	public int deleteBoardComment(int boardCommentNo) {
		Connection conn = getConnection();
		int result = healthBoardDAO.deleteBoardComment(conn, boardCommentNo);
		
		if(result>0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}

	public int selectTotalContents2(int boardNo) {
		Connection conn = getConnection();
		int totalContents = healthBoardDAO.selectTotalContents2(conn,boardNo);
		close(conn);
		return totalContents;
	}

}
