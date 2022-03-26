package booking.model.vo;

import java.sql.Date;

public class Booking {
	
	private String bookingNo; //예약번호
	private String userId; //유저아이디
	private String hospId; //병원 아이디
	private String doctorNo; //의사번호
	private String userName; // 유저 이름
	private Date bookingDate; // 예약일
	private String bookingTime; // 예약시간
	private String sysmptom; // 증상
	private String bookingState; //예약 상태 (A, F, C) Approval, finish, CANCLE
	private String bookingCancel; // 취소 사유
	
	public Booking() {
		super();
	}

	public Booking(String bookingNo, String userId, String hospId, String doctorNo, String userName, Date bookingDate,
			String bookingTime, String sysmptom, String bookingState, String bookingCancel) {
		super();
		this.bookingNo = bookingNo;
		this.userId = userId;
		this.hospId = hospId;
		this.doctorNo = doctorNo;
		this.userName = userName;
		this.bookingDate = bookingDate;
		this.bookingTime = bookingTime;
		this.sysmptom = sysmptom;
		this.bookingState = bookingState;
		this.bookingCancel = bookingCancel;
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

	public String getDoctorNo() {
		return doctorNo;
	}

	public void setDoctorNo(String doctorNo) {
		this.doctorNo = doctorNo;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Date getBookingDate() {
		return bookingDate;
	}

	public void setBookingDate(Date bookingDate) {
		this.bookingDate = bookingDate;
	}

	public String getBookingTime() {
		return bookingTime;
	}

	public void setBookingTime(String bookingTime) {
		this.bookingTime = bookingTime;
	}

	public String getSysmptom() {
		return sysmptom;
	}

	public void setSysmptom(String sysmptom) {
		this.sysmptom = sysmptom;
	}

	public String getBookingState() {
		return bookingState;
	}

	public void setBookingState(String bookingState) {
		this.bookingState = bookingState;
	}

	public String getBookingCancel() {
		return bookingCancel;
	}

	public void setBookingCancel(String bookingCancel) {
		this.bookingCancel = bookingCancel;
	}

	@Override
	public String toString() {
		return "bookingNo=" + bookingNo + ", userId=" + userId + ", hospId=" + hospId + ", doctorNo="
				+ doctorNo + ", userName=" + userName + ", bookingDate=" + bookingDate + ", bookingTime=" + bookingTime
				+ ", sysmptom=" + sysmptom + ", bookingState=" + bookingState + ", bookingCancel=" + bookingCancel;
	}
	
}
