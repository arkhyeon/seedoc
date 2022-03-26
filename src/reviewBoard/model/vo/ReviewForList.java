package reviewBoard.model.vo;

public class ReviewForList extends Review{
	private int commentCnt;

	public ReviewForList() {
		super();
		// TODO Auto-generated constructor stub
	}


	public ReviewForList(String bookingNo, String userId, String hospId, String reviewCon, int reviewRank, int reviewNo,
			int reviewLevel, int reviewRef, int commentCnt) {
		super(bookingNo, userId, hospId, reviewCon, reviewRank, reviewNo, reviewLevel, reviewRef);
		this.commentCnt = commentCnt;
	}


	public int getCommentCnt() {
		return commentCnt;
	}


	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}


	@Override
	public String toString() {
		return "ReviewForList [commentCnt=" + commentCnt + ", toString()=" + super.toString() + "]";
	}



	
}
