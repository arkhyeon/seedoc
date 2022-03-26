package hospital.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import hospital.model.dao.HospitalDAO;
import hospital.model.vo.HospDoctor;
import hospital.model.vo.HospFile;
import hospital.model.vo.HospTime;
import hospital.model.vo.Hospital;


public class HospitalService {
	
	private HospitalDAO hospDAO = new HospitalDAO();

	public Hospital selectOne(String hospId) {
		Connection conn = getConnection();
		Hospital h = hospDAO.selectOne(conn, hospId);
		close(conn);
		return h;
	}

	public int insertHosp(Hospital h) {
		Connection conn = getConnection();
		int result = hospDAO.insertHosp(conn, h);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}

	public int updateHosp(Hospital h) {
		Connection conn = getConnection();
		int result = hospDAO.updateHosp(conn, h);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}

	public int deleteHosp(String hospId) {
		Connection conn = getConnection();
		int result = hospDAO.deleteHosp(conn, hospId);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}

	public int insertDoc(HospDoctor hd) {
		Connection conn = getConnection();
		int result = hospDAO.insertDoc(conn, hd);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}

	public List<HospDoctor> selectAll(int cPage, int numPerPage, String hospId) {
		Connection conn = getConnection();
		List<HospDoctor> list = hospDAO.selectAll(conn, cPage, numPerPage, hospId);
		close(conn);
		return list;
	}
	public int selectTotalContents(String hospId) {
		Connection conn = getConnection();
		int totalContents = hospDAO.selectTotalContents(conn, hospId);
		close(conn);
		return totalContents;
	}

	public int updateDoc(HospDoctor hd) {
		Connection conn = getConnection();
		int result = hospDAO.updateDoc(conn, hd);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}

	public HospDoctor selectOneDoc(String doctorNo) {
		Connection conn = getConnection();
		HospDoctor hd = hospDAO.selectOneDoc(conn, doctorNo);
		close(conn);
		return hd;
	}

	public int deleteDoc(String doctorNo) {
		Connection conn = getConnection();
		int result = hospDAO.deleteDoc(conn, doctorNo);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}

	public int insertHospTime(HospTime ht) {
		Connection conn = getConnection();
		int result = hospDAO.insertHospTime(conn, ht);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}

	public HospTime selectOneTime(String hospId) {
		Connection conn = getConnection();
		HospTime ht = hospDAO.selectOneTime(conn, hospId);
		close(conn);
		return ht;
	}

	public int insertDocFile(HospFile hf) {
		Connection conn = getConnection();
		int result = hospDAO.insertDocFile(conn, hf);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}

	public int insertHospFile(HospFile hf) {
		Connection conn = getConnection();
		int result = hospDAO.insertHospFile(conn, hf);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
	public List<HospFile> selectHospDocFile(String hospId) {
		Connection conn = getConnection();
		List<HospFile> hospFileList = hospDAO.selectHospDocFile(conn, hospId);
		close(conn);
		return hospFileList;
	}

	public int updateDocFile(HospFile hf) {
		Connection conn = getConnection();
		int result = hospDAO.updateDocFile(conn, hf);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}

	//병원사진
	public List<HospFile> selectHospFile(String hospId) {
		Connection conn = getConnection();
		List<HospFile> list = hospDAO.selectHospFile(conn, hospId);
		close(conn);
		return list;
	}

	public HospFile selectOneDocFile(String doctorNo) {
		Connection conn = getConnection();
		HospFile hf = hospDAO.selectOneDocFile(conn, doctorNo);
		close(conn);
		return hf;
	}

	public List<Hospital> searchHosp(String hospName, String doctorName, String hospDept) {
		Connection conn = getConnection();
		List<Hospital> list = hospDAO.searchHosp(conn, hospName, doctorName, hospDept);
		close(conn);
		return list;
	}

	public List<Hospital> searchHospAddr(String addr1, String addr2, String addr3, String addr4, String addr5) {
		Connection conn = getConnection();
		List<Hospital> list = hospDAO.searchHospAddr(conn, addr1, addr2, addr3, addr4, addr5);
		close(conn);
		return list;
	}

	public int updateHospTime(HospTime ht) {
		Connection conn = getConnection();
		int result = hospDAO.updateHospTime(conn, ht);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}

	public int updateHospFile(HospFile hf) {
		Connection conn = getConnection();
		int result = hospDAO.updateHospFile(conn, hf);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
	public List<HospDoctor> doctorList(String hospId) {
		Connection conn = getConnection();
		List<HospDoctor> doctor = hospDAO.doctorList(conn,hospId);
		close(conn);
		return doctor;
	}
	public Hospital hospitalInfo(String hospId) {
		Connection conn = getConnection();
		Hospital hosp = hospDAO.hospitalInfo(conn, hospId);
		close(conn);
		return hosp;
	}
	public HospTime hospTime(String hospId) {
		Connection conn = getConnection();
		HospTime time = hospDAO.hospTime(conn, hospId);
		close(conn);
		return time;
	}
	public int uploadFile(HospFile file) {
		Connection conn = getConnection();
		int result = hospDAO.uploadFile(conn, file);
		if(result>0) {
			commit(conn);
		}
		else 
			rollback(conn);
		close(conn);
		return result;
	}
	public List<HospFile> hospFile(String hospId) {
		Connection conn = getConnection();
		List<HospFile> file = hospDAO.hospFile(conn, hospId);
		close(conn);
		return file;
	}
	public HospFile checkFile(String doctorNo) {
		Connection conn = getConnection();
		HospFile checkFile = hospDAO.checkFile(conn, doctorNo);
		close(conn);
		return checkFile;
	}
	public int deleteFile(String doctorNo) {
		Connection conn = getConnection();
		int result = hospDAO.deleteFile(conn, doctorNo);
		if(result>0) {
			commit(conn);
		}
		else 
			rollback(conn);
		close(conn);
		return result;
	}
	public HospFile hosLogo(String hospId) {
		Connection conn = getConnection();
		HospFile logo = hospDAO.hosLogo(conn, hospId);
		close(conn);
		return logo;
	}
	public List<HospFile> thumnail(String hospId) {
		Connection conn = getConnection();
		List<HospFile> logo = hospDAO.thumbnail(conn, hospId);
		close(conn);
		return logo;
	}

}
