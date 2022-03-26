package reviewBoard.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import reviewBoard.model.dao.ReviewBoardDAO;
import reviewBoard.model.vo.Review;


public class ReviewBoardService {

	private ReviewBoardDAO boardDAO = new ReviewBoardDAO();
	
	public int writeReivew(Review r) {
		Connection conn = getConnection();
		int result = boardDAO.writeReview(conn, r);
		if(result>0)
			commit(conn);
		else 
			rollback(conn);
		close(conn);
		return result;
	}

	public List<Review> reviewList(String hospId) {
		Connection conn = getConnection();
		List<Review> list= boardDAO.reviewList(conn, hospId);
		close(conn);
		return list;
	}

	public List<Review> selectCommentList(String hospId) {
		Connection conn = getConnection();
		List<Review> commentList = boardDAO.selectCommentList(conn,hospId);
		close(conn);
		return commentList;
	}

	public int deleteReivew(String reviewNo) {
		Connection conn = getConnection();
		int result = boardDAO.deleteReivew(conn, reviewNo);
		if(result>0)
			commit(conn);
		else 
			rollback(conn);
		close(conn);
		return result;
	}

	public Review reviewselectOne(String bookingNo) {
		Connection conn = getConnection();
		Review rsel = boardDAO.reviewselectOne(conn, bookingNo);
		close(conn);
		return rsel;
	}


}
