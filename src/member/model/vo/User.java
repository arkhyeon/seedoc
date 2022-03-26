package member.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class User implements Serializable{
	
	private String userId;
	private String userPwd;
	private String userName;
	private String userEmail;
	private String userPhone;
	private String userGender;
	private String userBirth;
	private String userAddr;
	private String userSymptom;
	private String userRole;
	private Date userEndrollDate;
	
	public User() {
		super();
	}

	public User(String userId, String userPwd, String userName, String userEmail, String userPhone, String userGender,
			String userBirth, String userAddr, String userSymptom, String userRole, Date userEndrollDate) {
		super();
		this.userId = userId;
		this.userPwd = userPwd;
		this.userName = userName;
		this.userEmail = userEmail;
		this.userPhone = userPhone;
		this.userGender = userGender;
		this.userBirth = userBirth;
		this.userAddr = userAddr;
		this.userSymptom = userSymptom;
		this.userRole = userRole;
		this.userEndrollDate = userEndrollDate;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserPhone() {
		return userPhone;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	public String getUserGender() {
		return userGender;
	}

	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}

	public String getUserBirth() {
		return userBirth;
	}

	public void setUserBirth(String userBirth) {
		this.userBirth = userBirth;
	}

	public String getUserAddr() {
		return userAddr;
	}

	public void setUserAddr(String userAddr) {
		this.userAddr = userAddr;
	}

	public String getUserSymptom() {
		return userSymptom;
	}

	public void setUserSymptom(String userSymptom) {
		this.userSymptom = userSymptom;
	}

	public String getUserRole() {
		return userRole;
	}

	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}

	public Date getUserEndrollDate() {
		return userEndrollDate;
	}

	public void setUserEndrollDate(Date userEndrollDate) {
		this.userEndrollDate = userEndrollDate;
	}

	@Override
	public String toString() {
		return "User [userId=" + userId + ", userPwd=" + userPwd + ", userName=" + userName + ", userEmail=" + userEmail
				+ ", userPhone=" + userPhone + ", userGender=" + userGender + ", userBirth=" + userBirth + ", userAddr="
				+ userAddr + ", userSymptom=" + userSymptom + ", userRole=" + userRole + ", userEndrollDate="
				+ userEndrollDate + "]";
	}

	
	

}
