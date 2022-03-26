package hospital.model.vo;

public class HospDoctor extends Hospital{
	
	private String doctorNo; //의사번호(면허)
	private String hospId; //병원아이디
	private String doctorName; // 의사이름
	private String hospDept; // 병원 진료과
	private String doctorTreat; // 진료내용
	private String doctorSpec; // 학력/전공
	
	public HospDoctor() {
		super();
	}

	public HospDoctor(String doctorNo, String hospId, String doctorName, String hospDept, String doctorTreat,
			String doctorSpec) {
		super();
		this.doctorNo = doctorNo;
		this.hospId = hospId;
		this.doctorName = doctorName;
		this.hospDept = hospDept;
		this.doctorTreat = doctorTreat;
		this.doctorSpec = doctorSpec;
	}

	public String getDoctorNo() {
		return doctorNo;
	}

	public void setDoctorNo(String doctorNo) {
		this.doctorNo = doctorNo;
	}

	public String getHospId() {
		return hospId;
	}

	public void setHospId(String hospId) {
		this.hospId = hospId;
	}

	public String getDoctorName() {
		return doctorName;
	}

	public void setDoctorName(String doctorName) {
		this.doctorName = doctorName;
	}

	public String getHospDept() {
		return hospDept;
	}

	public void setHospDept(String hospDept) {
		this.hospDept = hospDept;
	}

	public String getDoctorTreat() {
		return doctorTreat;
	}

	public void setDoctorTreat(String doctorTreat) {
		this.doctorTreat = doctorTreat;
	}

	public String getDoctorSpec() {
		return doctorSpec;
	}

	public void setDoctorSpec(String doctorSpec) {
		this.doctorSpec = doctorSpec;
	}

	@Override
	public String toString() {
		return "doctorNo=" + doctorNo + ", hospId=" + hospId + ", doctorName=" + doctorName + ", hospDept="
				+ hospDept + ", doctorTreat=" + doctorTreat + ", doctorSpec=" + doctorSpec;
	}
}
