package hospital.model.vo;

import java.sql.Date;

public class Hospital {

	private String hospId;
	private String hospPwd;
	private String hospName;
	private String hospAddr;
	private String hospTel;
	private String hospInfo;
	private String hospConv;
	private Date hospEnrollDate;
	
	public Hospital() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Hospital(String hospId, String hospPwd, String hospName, String hospAddr, String hospTel, String hospInfo,
			String hospConv, Date hospEnrollDate) {
		super();
		this.hospId = hospId;
		this.hospPwd = hospPwd;
		this.hospName = hospName;
		this.hospAddr = hospAddr;
		this.hospTel = hospTel;
		this.hospInfo = hospInfo;
		this.hospConv = hospConv;
		this.hospEnrollDate = hospEnrollDate;
	}
	
	public String getHospId() {
		return hospId;
	}
	public void setHospId(String hospId) {
		this.hospId = hospId;
	}
	public String getHospPwd() {
		return hospPwd;
	}
	public void setHospPwd(String hospPwd) {
		this.hospPwd = hospPwd;
	}
	public String getHospName() {
		return hospName;
	}
	public void setHospName(String hospName) {
		this.hospName = hospName;
	}
	public String getHospAddr() {
		return hospAddr;
	}
	public void setHospAddr(String hospAddr) {
		this.hospAddr = hospAddr;
	}
	public String getHospTel() {
		return hospTel;
	}
	public void setHospTel(String hospTel) {
		this.hospTel = hospTel;
	}
	public String getHospInfo() {
		return hospInfo;
	}
	public void setHospInfo(String hospInfo) {
		this.hospInfo = hospInfo;
	}
	public String getHospConv() {
		return hospConv;
	}
	public void setHospConv(String hospConv) {
		this.hospConv = hospConv;
	}
	public Date getHospEnrollDate() {
		return hospEnrollDate;
	}
	public void setHospEnrollDate(Date hospEnrollDate) {
		this.hospEnrollDate = hospEnrollDate;
	}
	
	@Override
	public String toString() {
		return "Hospital [hospId=" + hospId + ", hospPwd=" + hospPwd + ", hospName=" + hospName + ", hospAddr="
				+ hospAddr + ", hospTel=" + hospTel + ", hospInfo=" + hospInfo + ", hospConv=" + hospConv
				+ ", hospEnrollDate=" + hospEnrollDate + "]";
	}
}
