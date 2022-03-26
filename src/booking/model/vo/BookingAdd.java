package booking.model.vo;

import java.sql.Date;

public class BookingAdd extends Booking{

	private String hospName;
	private String docName;
	private String hospDept;
	private String userBirth;
	private String userPhone;
	private String userEmail;
	
	public BookingAdd() {
		super();
	}

	public BookingAdd(String bookingNo, String userId, String hospId, String doctorNo, String userName,
			Date bookingDate, String bookingTime, String sysmptom, String bookingState, String bookingCancel,
			String hospName, String docName, String hospDept, String userBirth, String userPhone, String userEmail) {
		super(bookingNo, userId, hospId, doctorNo, userName, bookingDate, bookingTime, sysmptom, bookingState,
				bookingCancel);
		this.hospName = hospName;
		this.docName = docName;
		this.hospDept = hospDept;
		this.userBirth = userBirth;
		this.userPhone = userPhone;
		this.userEmail = userEmail;
	}

	public String getHospName() {
		return hospName;
	}

	public void setHospName(String hospName) {
		this.hospName = hospName;
	}

	public String getDocName() {
		return docName;
	}

	public void setDocName(String docName) {
		this.docName = docName;
	}

	public String getHospDept() {
		return hospDept;
	}

	public void setHospDept(String hospDept) {
		this.hospDept = hospDept;
	}

	public String getUserBirth() {
		return userBirth;
	}

	public void setUserBirth(String userBirth) {
		this.userBirth = userBirth;
	}

	public String getUserPhone() {
		return userPhone;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	@Override
	public String toString() {
		return super.toString()+"hospName=" + hospName + ", docName=" + docName + ", hospDept=" + hospDept + ", userBirth="
				+ userBirth + ", userPhone=" + userPhone + ", userEmail=" + userEmail;
	}
	
}
