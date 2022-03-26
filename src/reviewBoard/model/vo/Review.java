package reviewBoard.model.vo;

import java.io.Serializable;

public class Review implements Serializable {

	private String bookingNo;
	private String userId;
	private String hospId;
	private String reviewCon;
	private int reviewRank;
	private int reviewNo;
	private int reviewLevel;
	private int reviewRef;
	public Review() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Review(String bookingNo, String userId, String hospId, String reviewCon, int reviewRank, int reviewNo,
			int reviewLevel, int reviewRef) {
		super();
		this.bookingNo = bookingNo;
		this.userId = userId;
		this.hospId = hospId;
		this.reviewCon = reviewCon;
		this.reviewRank = reviewRank;
		this.reviewNo = reviewNo;
		this.reviewLevel = reviewLevel;
		this.reviewRef = reviewRef;
	}
	@Override
	public String toString() {
		return "Review [bookingNo=" + bookingNo + ", userId=" + userId + ", hospId=" + hospId + ", reviewCon="
				+ reviewCon + ", reviewRank=" + reviewRank + ", reviewNo=" + reviewNo + ", reviewLevel=" + reviewLevel
				+ ", reviewRef=" + reviewRef + "]";
	}
	public String getBookingNo() {
		return bookingNo;
	}
	public void setBookingNo(String bookingNo) {
		this.bookingNo = bookingNo;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getHospId() {
		return hospId;
	}
	public void setHospId(String hospId) {
		this.hospId = hospId;
	}
	public String getReviewCon() {
		return reviewCon;
	}
	public void setReviewCon(String reviewCon) {
		this.reviewCon = reviewCon;
	}
	public int getReviewRank() {
		return reviewRank;
	}
	public void setReviewRank(int reviewRank) {
		this.reviewRank = reviewRank;
	}
	public int getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}
	public int getReviewLevel() {
		return reviewLevel;
	}
	public void setReviewLevel(int reviewLevel) {
		this.reviewLevel = reviewLevel;
	}
	public int getReviewRef() {
		return reviewRef;
	}
	public void setReviewRef(int reviewRef) {
		this.reviewRef = reviewRef;
	}
		
}
