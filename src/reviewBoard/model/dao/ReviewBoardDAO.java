package reviewBoard.model.dao;

import static common.JDBCTemplate.close;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import reviewBoard.model.vo.Review;
import reviewBoard.model.vo.ReviewForList;

public class ReviewBoardDAO {
	
	private Properties prop = new Properties();

	public ReviewBoardDAO() {
		try {
			//클래스객체 위치찾기 : 절대경로를 반환한다. 
			// "/" : 루트디렉토리를 절대경로로 URL객체로 반환한다.
			// "./" : 현재디렉토리를 절대경로로 URL객체로 반환한다.
			String fileName 
				= ReviewBoardDAO.class
						  .getResource("/sql/reviewBoard/reviewBoard-query.properties")
						  .getPath();
			prop.load(new FileReader(fileName));
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}	
	}
	public int writeReview(Connection conn, Review r) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("writeReview");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, r.getBookingNo());
			pstmt.setString(2, r.getReviewCon());
			pstmt.setInt(3, r.getReviewRank());
			pstmt.setInt(4, r.getReviewLevel());
			String ReviewRef = 
					r.getReviewRef() == 0 ? null 
						: String.valueOf(r.getReviewRef());
			pstmt.setString(5, ReviewRef);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		return result;
	}
	public List<Review> reviewList(Connection conn, String hospId) {
		List<Review> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = prop.getProperty("reviewList");
		try{
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, hospId);
			
			//쿼리문실행
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				ReviewForList r = new ReviewForList();

				r.setBookingNo(rset.getString("booking_no"));
				r.setReviewCon(rset.getString("review_con"));
				r.setReviewRank(rset.getInt("review_rank"));
				r.setReviewNo(rset.getInt("review_no"));
				r.setReviewLevel(rset.getInt("review_level"));
				r.setUserId(rset.getString("user_Id"));
				r.setReviewRef(rset.getInt("review_ref"));
				
				list.add(r);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return list;
	}
	public List<Review> selectCommentList(Connection conn, String hospId) {
		List<Review> commentList = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectCommentList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hospId);
			
			rset = pstmt.executeQuery();
			
			commentList = new ArrayList<>();
			while(rset.next()) {
				String bookingNo = rset.getString("bookingNo");
				String userId = rset.getString("userId");
				String reviewCon = rset.getString("reviewCon");
				int reviewRank = rset.getInt("reviewRank");
				int reviewNo = rset.getInt("reviewNo");
				int reviewLevel = rset.getInt("reviewLevel");//가져올때만(get) null값은 0(기본값으로 치환)
				int reviewRef = rset.getInt("reviewRef");
				
				Review r = new Review(bookingNo, userId, hospId, reviewCon, reviewRank, reviewNo, reviewLevel, reviewRef);
				commentList.add(r);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rset);
		}
		
		System.out.println("commentList@DAO"+commentList);
		return commentList;
	}
	public int deleteReivew(Connection conn, String reviewNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteReview");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, reviewNo);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		return result;
	}
	public Review reviewselectOne(Connection conn, String bookingNo) {
		Review rsel = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("reviewselectOne");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bookingNo);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				rsel = new Review();
				rsel.setReviewNo(rset.getInt("review_no"));
				rsel.setBookingNo(rset.getString("booking_no"));
				rsel.setReviewCon(rset.getString("review_con"));
				rsel.setReviewRank(rset.getInt("review_rank"));
				rsel.setReviewLevel(rset.getInt("review_level"));
				rsel.setReviewRef(rset.getInt("review_ref"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(conn);
		}
		return rsel;
	}

}
