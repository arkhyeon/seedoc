package hospital.model.vo;

import java.sql.Date;

public class HospTime extends Hospital {
	
	private String hospId;
	private String monOpen;
	private String monEnd;
	private String tueOpen;
	private String tueEnd;
	private String wedOpen;
	private String wedEnd;
	private String thuOpen;
	private String thuEnd;
	private String friOpen;
	private String friEnd;
	private String satOpen;
	private String satEnd;
	private String sunOpen;
	private String sunEnd;
	private String lunOpen;
	private String lunEnd;
	
	public HospTime() {
		super();
	}
	

	public HospTime(String hospId, String monOpen, String monEnd, String tueOpen, String tueEnd, String wedOpen,
			String wedEnd, String thuOpen, String thuEnd, String friOpen, String friEnd, String satOpen, String satEnd,
			String sunOpen, String sunEnd, String lunOpen, String lunEnd) {
		super();
		this.hospId = hospId;
		this.monOpen = monOpen;
		this.monEnd = monEnd;
		this.tueOpen = tueOpen;
		this.tueEnd = tueEnd;
		this.wedOpen = wedOpen;
		this.wedEnd = wedEnd;
		this.thuOpen = thuOpen;
		this.thuEnd = thuEnd;
		this.friOpen = friOpen;
		this.friEnd = friEnd;
		this.satOpen = satOpen;
		this.satEnd = satEnd;
		this.sunOpen = sunOpen;
		this.sunEnd = sunEnd;
		this.lunOpen = lunOpen;
		this.lunEnd = lunEnd;
	}

	public HospTime(String hospId, String hospPwd, String hospName, String hospAddr, String hospTel, String hospInfo,
			String hospConv, Date hospEnrollDate, String hospId2, String monOpen, String monEnd, String tueOpen,
			String tueEnd, String wedOpen, String wedEnd, String thuOpen, String thuEnd, String friOpen, String friEnd,
			String satOpen, String satEnd, String sunOpen, String sunEnd, String lunOpen, String lunEnd) {
		super(hospId, hospPwd, hospName, hospAddr, hospTel, hospInfo, hospConv, hospEnrollDate);
		hospId = hospId2;
		this.monOpen = monOpen;
		this.monEnd = monEnd;
		this.tueOpen = tueOpen;
		this.tueEnd = tueEnd;
		this.wedOpen = wedOpen;
		this.wedEnd = wedEnd;
		this.thuOpen = thuOpen;
		this.thuEnd = thuEnd;
		this.friOpen = friOpen;
		this.friEnd = friEnd;
		this.satOpen = satOpen;
		this.satEnd = satEnd;
		this.sunOpen = sunOpen;
		this.sunEnd = sunEnd;
		this.lunOpen = lunOpen;
		this.lunEnd = lunEnd;
	}

	public String getHospId() {
		return hospId;
	}

	public void setHospId(String hospId) {
		this.hospId = hospId;
	}

	public String getMonOpen() {
		return monOpen;
	}

	public void setMonOpen(String monOpen) {
		this.monOpen = monOpen;
	}

	public String getMonEnd() {
		return monEnd;
	}

	public void setMonEnd(String monEnd) {
		this.monEnd = monEnd;
	}

	public String getTueOpen() {
		return tueOpen;
	}

	public void setTueOpen(String tueOpen) {
		this.tueOpen = tueOpen;
	}

	public String getTueEnd() {
		return tueEnd;
	}

	public void setTueEnd(String tueEnd) {
		this.tueEnd = tueEnd;
	}

	public String getWedOpen() {
		return wedOpen;
	}

	public void setWedOpen(String wedOpen) {
		this.wedOpen = wedOpen;
	}

	public String getWedEnd() {
		return wedEnd;
	}

	public void setWedEnd(String wedEnd) {
		this.wedEnd = wedEnd;
	}

	public String getThuOpen() {
		return thuOpen;
	}

	public void setThuOpen(String thuOpen) {
		this.thuOpen = thuOpen;
	}

	public String getThuEnd() {
		return thuEnd;
	}

	public void setThuEnd(String thuEnd) {
		this.thuEnd = thuEnd;
	}

	public String getFriOpen() {
		return friOpen;
	}

	public void setFriOpen(String friOpen) {
		this.friOpen = friOpen;
	}

	public String getFriEnd() {
		return friEnd;
	}

	public void setFriEnd(String friEnd) {
		this.friEnd = friEnd;
	}

	public String getSatOpen() {
		return satOpen;
	}

	public void setSatOpen(String satOpen) {
		this.satOpen = satOpen;
	}

	public String getSatEnd() {
		return satEnd;
	}

	public void setSatEnd(String satEnd) {
		this.satEnd = satEnd;
	}

	public String getSunOpen() {
		return sunOpen;
	}

	public void setSunOpen(String sunOpen) {
		this.sunOpen = sunOpen;
	}

	public String getSunEnd() {
		return sunEnd;
	}

	public void setSunEnd(String sunEnd) {
		this.sunEnd = sunEnd;
	}

	public String getLunOpen() {
		return lunOpen;
	}

	public void setLunOpen(String lunOpen) {
		this.lunOpen = lunOpen;
	}

	public String getLunEnd() {
		return lunEnd;
	}

	public void setLunEnd(String lunEnd) {
		this.lunEnd = lunEnd;
	}

	@Override
	public String toString() {
		return "hospId=" + hospId + ", monOpen=" + monOpen + ", monEnd=" + monEnd + ", tueOpen=" + tueOpen
				+ ", tueEnd=" + tueEnd + ", wedOpen=" + wedOpen + ", wedEnd=" + wedEnd + ", thuOpen=" + thuOpen
				+ ", thuEnd=" + thuEnd + ", friOpen=" + friOpen + ", friEnd=" + friEnd + ", satOpen=" + satOpen
				+ ", satEnd=" + satEnd + ", sunOpen=" + sunOpen + ", sunEnd=" + sunEnd + ", lunOpen=" + lunOpen
				+ ", lunEnd=" + lunEnd;
	}

	
	
}
