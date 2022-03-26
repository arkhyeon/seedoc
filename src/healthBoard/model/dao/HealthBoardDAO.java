package healthBoard.model.dao;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;


import static common.JDBCTemplate.*;
import healthBoard.model.vo.HealthBoard;
import healthBoard.model.vo.HealthBoardComment;

public class HealthBoardDAO {

	private Properties prop = new Properties();
	
	public HealthBoardDAO() {
		String fileName = HealthBoardDAO.class.getResource("/sql/healthBoard/healthBoard-query.properties").getPath();
		try {
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	public List<HealthBoard> selectAll(Connection conn, int cPage, int numPerPage) {
		PreparedStatement pstmt = null;
		List<HealthBoard> list = new ArrayList<HealthBoard>();
		ResultSet rset = null;
		String sql = prop.getProperty("selectAllPaging");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (cPage-1)*numPerPage+1);
			pstmt.setInt(2, cPage*numPerPage);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				HealthBoard hb = new HealthBoard();
				
				hb.setBoardNo(rset.getInt("board_no"));
				hb.setBoardTitle(rset.getString("board_title"));
				hb.setBoardWriter(rset.getString("hosp_id"));
				hb.setBoardContent(rset.getString("board_content"));
				hb.setBoardOriginalFileName(rset.getString("board_original_filename"));
				hb.setBoardRenamedFileName(rset.getString("board_renamed_filename"));
				hb.setBoardDate(rset.getDate("board_date"));
				hb.setBoardReadCount(rset.getInt("board_readcount"));
				
				list.add(hb);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rset);
		}
		return list;
	}

	public int selectTotalContents(Connection conn) {
		int totalContents = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectTotalContents");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			if (rset.next()) {
				totalContents = rset.getInt("TOTAL_CONTENTS");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rset);
		}
		return totalContents;
	}

	public HealthBoard selectOne(Connection conn, int boardNo) {
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("selectOne");
		HealthBoard hb = null;
		ResultSet rset = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				hb = new HealthBoard();
				hb.setBoardNo(rset.getInt("board_no"));
				hb.setBoardTitle(rset.getString("board_title"));
				hb.setBoardWriter(rset.getString("hosp_id"));
				hb.setBoardContent(rset.getString("board_content"));
				hb.setBoardOriginalFileName(rset.getString("board_original_filename"));
				hb.setBoardRenamedFileName(rset.getString("board_renamed_filename"));
				hb.setBoardDate(rset.getDate("board_date"));
				hb.setBoardReadCount(rset.getInt("board_readcount"));
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rset);
		}
		
		
		return hb;
	}

	public int insertBoard(Connection conn, HealthBoard nb) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertBoard");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, nb.getBoardTitle());
			pstmt.setString(2, nb.getBoardWriter());
			pstmt.setString(3, nb.getBoardContent());
			pstmt.setString(4, nb.getBoardOriginalFileName());
			pstmt.setString(5, nb.getBoardRenamedFileName());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}

	public int selectLastBoardNo(Connection conn) {
		int boardNo = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("selectLastBoardNo");
		ResultSet rset = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				boardNo = rset.getInt("board_no");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rset);
		}
		
		return boardNo;
	}

	public int viewsUpReadCount(Connection conn, int boardNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("viewsUpReadCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}

	public int updateBoard(Connection conn, HealthBoard uhb) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateHealthBoard");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uhb.getBoardTitle());
			pstmt.setString(2, uhb.getBoardContent());
			pstmt.setString(3, uhb.getBoardOriginalFileName());
			pstmt.setString(4, uhb.getBoardRenamedFileName());
			pstmt.setInt(5, uhb.getBoardNo());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}

	public int deleteBoard(Connection conn, int boardNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteBoard");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}

	public List<HealthBoard> searchBoard(Connection conn, String searchType, String searchKeyword, int cPage,int numPerPage) {
		PreparedStatement pstmt = null;
		List<HealthBoard> list = new ArrayList<HealthBoard>();
		String sql = prop.getProperty("searchBoardPaging");
		ResultSet rset = null;
		
		String columnName = "";
		switch (searchType) {
		case "boardTitle": columnName = "board_title"; break;
		case "boardWriter": columnName = "hosp_id"; break;
		case "boardDate": columnName = "board_date"; break;
		}
			try {
				if(searchType.contains("boardDate")) {
					sql = prop.getProperty("searchBoardDatePaging");
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, searchKeyword);
					pstmt.setInt(2, (cPage-1)*numPerPage+1);
					pstmt.setInt(3, cPage*numPerPage);
					rset = pstmt.executeQuery();
				}else {
					sql = sql.replace("#", columnName);
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, '%'+searchKeyword+'%');
					pstmt.setInt(2, (cPage-1)*numPerPage+1);
					pstmt.setInt(3, cPage*numPerPage);
					
					rset = pstmt.executeQuery();
				}
				while(rset.next()) {
					HealthBoard hb = new HealthBoard();
					
					hb.setBoardNo(rset.getInt("board_no"));
					hb.setBoardTitle(rset.getString("board_title"));
					hb.setBoardWriter(rset.getString("hosp_id"));
					hb.setBoardContent(rset.getString("board_content"));
					hb.setBoardOriginalFileName(rset.getString("board_original_filename"));
					hb.setBoardRenamedFileName(rset.getString("board_renamed_filename"));
					hb.setBoardDate(rset.getDate("board_date"));
					hb.setBoardReadCount(rset.getInt("board_readcount"));
					
					list.add(hb);
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
				close(pstmt);
				close(rset);
			}
			
			return list;
	}

	public int selectTotalContents(Connection conn, String searchType, String searchKeyword) {
		int totalContents = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectFinderTotalContents");
		
		String columnName = "";
		switch (searchType) {
		case "boardTitle": columnName = "board_title"; break;
		case "boardWriter": columnName = "hosp_id"; break;
		case "boardDate": columnName = "board_date"; break;
		}

			try {
				if(searchType.contains("boardDate")) {
					sql = prop.getProperty("selectFinderTotalContents2");
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, searchKeyword);
					rset = pstmt.executeQuery();
				}else {
					sql = sql.replace("#", columnName);
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1,'%'+searchKeyword+'%');
					rset = pstmt.executeQuery();
				}
				if (rset.next()) {
					totalContents = rset.getInt("TOTAL_CONTENTS");
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
				close(pstmt);
				close(rset);
			}
			
			return totalContents;
	}

	public int insertBoardComment(Connection conn, HealthBoardComment hbc) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertBoardComment");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, hbc.getHealthBoardCommentLevel());
			pstmt.setString(2, hbc.getHealthBoardCommentWriter());
			pstmt.setString(3, hbc.getHealthBoardCommentContent());
			pstmt.setInt(4, hbc.getHealthBoardRef());
			pstmt.setInt(5, hbc.getHealthBoardCommentRef());
			String boardCommentRef = hbc.getHealthBoardCommentRef() == 0?null:Integer.toString(hbc.getHealthBoardCommentRef());
			pstmt.setString(5, boardCommentRef);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}

	public List<HealthBoardComment> selectCommentList(Connection conn, int boardNo, int cPage, int numPerPage) {
		List<HealthBoardComment> commentList = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectCommentListPaging");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			pstmt.setInt(2, (cPage-1)*numPerPage+1);
			pstmt.setInt(3, cPage*numPerPage);
			
			rset = pstmt.executeQuery();
			
			commentList = new ArrayList<HealthBoardComment>();
			while(rset.next()) {
				int healthBoardCommentNo = rset.getInt("board_health_comment_no");
				int healthBoardCommentLevel = rset.getInt("board_health_comment_level");
				String healthBoardCommentWriter = rset.getString("board_health_comment_writer");
				String healthBoardCommentContent = rset.getString("board_health_comment_content");
				int healthBoardRef = rset.getInt("board_health_ref");
				int healthBoardCommentRef = rset.getInt("board_health_comment_ref");//null값은 0으로 치환
				Date healthBoardCommentDate = rset.getDate("board_health_comment_date");
				
				HealthBoardComment bc = new HealthBoardComment(healthBoardCommentNo, healthBoardCommentLevel, healthBoardCommentWriter, healthBoardCommentContent, healthBoardRef, healthBoardCommentRef, healthBoardCommentDate);
				commentList.add(bc);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rset);
		}
		
		return commentList;
	}

	public int deleteBoardComment(Connection conn, int boardCommentNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteBoardComment");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardCommentNo);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}

	public int selectTotalContents2(Connection conn, int boardNo) {
		int totalContents = 0;
		List<HealthBoardComment> commentList = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectTotalContents2");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			
			rset = pstmt.executeQuery();
			if (rset.next()) {
				totalContents = rset.getInt("TOTAL_CONTENTS");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rset);
		}
		
		return totalContents;
	}

}
