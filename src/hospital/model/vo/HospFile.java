package hospital.model.vo;

import java.sql.Date;

public class HospFile extends Hospital{
	
	private String hospId;
	private String doctorNo;
	private String boardOriginalFileName;
	private String boardRenamedFileName;
	private String use;
	

	public HospFile() {
		super();
	}

	public HospFile(String hospId, String doctorNo, String boardOriginalFileName, String boardRenamedFileName) {
		super();
		this.hospId = hospId;
		this.doctorNo = doctorNo;
		this.boardOriginalFileName = boardOriginalFileName;
		this.boardRenamedFileName = boardRenamedFileName;
	}
	public HospFile(String hospId, String doctorNo, String boardOriginalFileName, String boardRenamedFileName, String use) {
		super();
		this.hospId = hospId;
		this.doctorNo = doctorNo;
		this.boardOriginalFileName = boardOriginalFileName;
		this.boardRenamedFileName = boardRenamedFileName;
		this.use = use;
	}


	public HospFile(String hospId, String hospPwd, String hospName, String hospAddr, String hospTel, String hospInfo,
			String hospConv, Date hospEnrollDate, String hospId2, String doctorNo, String boardOriginalFileName,
			String boardRenamedFileName) {
		super(hospId, hospPwd, hospName, hospAddr, hospTel, hospInfo, hospConv, hospEnrollDate);
		hospId = hospId2;
		this.doctorNo = doctorNo;
		this.boardOriginalFileName = boardOriginalFileName;
		this.boardRenamedFileName = boardRenamedFileName;
	}

	public String getUse() {
		return use;
	}

	public void setUse(String use) {
		this.use = use;
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

	public String getBoardOriginalFileName() {
		return boardOriginalFileName;
	}

	public void setBoardOriginalFileName(String boardOriginalFileName) {
		this.boardOriginalFileName = boardOriginalFileName;
	}

	public String getBoardRenamedFileName() {
		return boardRenamedFileName;
	}

	public void setBoardRenamedFileName(String boardRenamedFileName) {
		this.boardRenamedFileName = boardRenamedFileName;
	}

	@Override
	public String toString() {
		return "hospId=" + hospId + ", doctorNo=" + doctorNo + ", boardOriginalFileName="
				+ boardOriginalFileName + ", boardRenamedFileName=" + boardRenamedFileName + ", use="+use;
	}
	
	

}
