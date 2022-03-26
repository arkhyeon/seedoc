package hospital.model.dao;

import static common.JDBCTemplate.close;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import common.JDBCTemplate;
import hospital.model.vo.HospDoctor;
import hospital.model.vo.HospFile;
import hospital.model.vo.HospTime;
import hospital.model.vo.Hospital;

public class HospitalDAO {
	private Properties prop = new Properties();

	public HospitalDAO() {
		String fileName = JDBCTemplate.class.getResource("/sql/hospital/hospital-query.properties").getPath();
//		String fileName = HospitalDAO.class.getResource("/sql/hospital/hospital-query.properties").getPath();
//		System.out.println("fileName@dao: " + fileName);
		try {
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public Hospital selectOne(Connection conn, String hospId) {
		Hospital h = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = prop.getProperty("selectOne");

		try {

			pstmt = conn.prepareStatement(query);
			// 쿼리문미완성
			pstmt.setString(1, hospId);
			// 쿼리문실행
			// 완성된 쿼리를 가지고 있는 pstmt실행(파라미터 없음)
			rset = pstmt.executeQuery();

			if (rset.next()) {
				h = new Hospital();
				h.setHospId(rset.getString("hosp_id"));
				h.setHospPwd(rset.getString("hosp_pwd"));
				h.setHospName(rset.getString("hosp_name"));
				h.setHospAddr(rset.getString("hosp_addr"));
				h.setHospTel(rset.getString("hosp_tel"));
				h.setHospInfo(rset.getString("hosp_info"));
				h.setHospConv(rset.getString("hosp_conv"));
				h.setHospEnrollDate(rset.getDate("hosp_enroll_date"));
//				System.out.println("h@HospitalDAO.selectOne="+h);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return h;
	}

	public int insertHosp(Connection conn, Hospital h) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertHosp");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, h.getHospId());
			pstmt.setString(2, h.getHospPwd());
			pstmt.setString(3, h.getHospName());
			pstmt.setString(4, h.getHospAddr());
			pstmt.setString(5, h.getHospTel());
			pstmt.setString(6, h.getHospInfo());
			pstmt.setString(7, h.getHospConv());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
//		System.out.println("result@dao = "+result);
		return result;
	}

	public int updateHosp(Connection conn, Hospital h) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateHosp");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, h.getHospPwd());
			pstmt.setString(2, h.getHospName());
			pstmt.setString(3, h.getHospAddr());
			pstmt.setString(4, h.getHospTel());
			pstmt.setString(5, h.getHospInfo());
			pstmt.setString(6, h.getHospConv());
			pstmt.setString(7, h.getHospId());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
//		System.out.println("result@dao = "+result);
		return result;
	}

	public int deleteHosp(Connection conn, String hospId) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteHosp");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hospId);

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
//		System.out.println("result@dao = " + result);
		return result;
	}

	public int insertDoc(Connection conn, HospDoctor hd) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertDoc");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hd.getDoctorNo());
			pstmt.setString(2, hd.getHospId());
			pstmt.setString(3, hd.getDoctorName());
			pstmt.setString(4, hd.getHospDept());
			pstmt.setString(5, hd.getDoctorTreat());
			pstmt.setString(6, hd.getDoctorSpec());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
//		System.out.println("result@dao = " + result);
		return result;
	}

	public List<HospDoctor> selectAll(Connection conn, int cPage, int numPerPage, String hospId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<HospDoctor> list = null;

		String sql = prop.getProperty("selectAll");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hospId);
			pstmt.setInt(2, numPerPage * (cPage - 1) + 1);
			pstmt.setInt(3, cPage * numPerPage);

			rset = pstmt.executeQuery();

			list = new ArrayList<>();
			while (rset.next()) {
				HospDoctor hd = new HospDoctor();

				hd.setDoctorNo(rset.getString("doctor_no"));
				hd.setHospId(rset.getString("hosp_id"));
				hd.setDoctorName(rset.getString("doctor_name"));
				hd.setHospDept(rset.getString("hosp_dept"));
				hd.setDoctorTreat(rset.getString("doctor_treat"));
				hd.setDoctorSpec(rset.getString("doctor_spec"));

//				System.out.println("hd@hospDAO = "+hd);
				list.add(hd);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}
	public int selectTotalContents(Connection conn, String hospId) {
		int totalContents = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectTotalContents");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hospId);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				totalContents = rset.getInt("total_contents");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return totalContents;
	}

	public int updateDoc(Connection conn, HospDoctor hd) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateDoc");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hd.getDoctorName());
			pstmt.setString(2, hd.getHospDept());
			pstmt.setString(3, hd.getDoctorTreat());
			pstmt.setString(4, hd.getDoctorSpec());
			pstmt.setString(5, hd.getDoctorNo());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
//		System.out.println("result@dao = "+result);
		return result;
	}

	public HospDoctor selectOneDoc(Connection conn, String doctorNo) {
		HospDoctor hd = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = prop.getProperty("selectOneDoc");

		try {

			pstmt = conn.prepareStatement(query);
			// 쿼리문미완성
			pstmt.setString(1, doctorNo);
			// 쿼리문실행
			// 완성된 쿼리를 가지고 있는 pstmt실행(파라미터 없음)
			rset = pstmt.executeQuery();

			if (rset.next()) {
				hd = new HospDoctor();
				hd.setDoctorNo(rset.getString("doctor_no"));
				hd.setHospId(rset.getString("hosp_id"));
				hd.setDoctorName(rset.getString("doctor_name"));
				hd.setHospDept(rset.getString("hosp_dept"));
				hd.setDoctorTreat(rset.getString("doctor_treat"));
				hd.setDoctorSpec(rset.getString("doctor_spec"));
//				System.out.println("hd@HospitalDAO.selectOneDoc="+hd);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return hd;
	}

	public int deleteDoc(Connection conn, String doctorNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteDoc");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, doctorNo);

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
//		System.out.println("result@dao = " + result);
		return result;
	}

	public int insertHospTime(Connection conn, HospTime ht) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertHospTime");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ht.getHospId());
			pstmt.setString(2, ht.getMonOpen());
			pstmt.setString(3, ht.getMonEnd());
			pstmt.setString(4, ht.getTueOpen());
			pstmt.setString(5, ht.getTueEnd());
			pstmt.setString(6, ht.getWedOpen());
			pstmt.setString(7, ht.getWedEnd());
			pstmt.setString(8, ht.getThuOpen());
			pstmt.setString(9, ht.getThuEnd());
			pstmt.setString(10, ht.getFriOpen());
			pstmt.setString(11, ht.getFriEnd());
			pstmt.setString(12, ht.getSatOpen());
			pstmt.setString(13, ht.getSatEnd());
			pstmt.setString(14, ht.getSunOpen());
			pstmt.setString(15, ht.getSunEnd());
			pstmt.setString(16, ht.getLunOpen());
			pstmt.setString(17, ht.getLunEnd());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
//		System.out.println("result@dao = " + result);
		return result;
	}

	public HospTime selectOneTime(Connection conn, String hospId) {
		HospTime ht = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = prop.getProperty("selectOneTime");

		try {

			pstmt = conn.prepareStatement(query);
			// 쿼리문미완성
			pstmt.setString(1, hospId);
			// 쿼리문실행
			// 완성된 쿼리를 가지고 있는 pstmt실행(파라미터 없음)
			rset = pstmt.executeQuery();

			if (rset.next()) {
				ht = new HospTime();
				ht.setHospId(rset.getString("hosp_id"));
				ht.setMonOpen(rset.getString("mon_open"));
				ht.setMonEnd(rset.getString("mon_end"));
				ht.setTueOpen(rset.getString("tue_open"));
				ht.setTueEnd(rset.getString("tue_end"));
				ht.setWedOpen(rset.getString("wed_open"));
				ht.setWedEnd(rset.getString("wed_end"));
				ht.setThuOpen(rset.getString("thu_open"));
				ht.setThuEnd(rset.getString("thu_end"));
				ht.setFriOpen(rset.getString("fri_open"));
				ht.setFriEnd(rset.getString("fri_end"));
				ht.setSatOpen(rset.getString("sat_open"));
				ht.setSatEnd(rset.getString("sat_end"));
				ht.setSunOpen(rset.getString("sun_open"));
				ht.setSunEnd(rset.getString("sun_end"));
				ht.setLunOpen(rset.getString("lun_open"));
				ht.setLunEnd(rset.getString("lun_end"));
//				System.out.println("ht@HospitalDAO.selectOne="+ht);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return ht;
	}

	public int insertDocFile(Connection conn, HospFile hf) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertFile");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hf.getDoctorNo());
			pstmt.setString(2, hf.getHospId());
			pstmt.setString(3, hf.getBoardOriginalFileName());
			pstmt.setString(4, hf.getBoardRenamedFileName());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
//		System.out.println("result@dao = " + result);
		return result;
	}

	public int insertHospFile(Connection conn, HospFile hf) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertHospFile");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hf.getDoctorNo());
			pstmt.setString(2, hf.getHospId());
			pstmt.setString(3, hf.getBoardOriginalFileName());
			pstmt.setString(4, hf.getBoardRenamedFileName());
			pstmt.setString(5, hf.getUse());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
//		System.out.println("result@dao = " + result);
		return result;
	}

	public List<HospFile> selectHospDocFile(Connection conn, String hospId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<HospFile> list = null;

		String sql = prop.getProperty("selectHospDocFile");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hospId);

			rset = pstmt.executeQuery();

			list = new ArrayList<>();
			while (rset.next()) {
				HospFile hf = new HospFile();

				hf.setDoctorNo(rset.getString("doctor_no"));
				hf.setHospId(rset.getString("hosp_id"));
				hf.setBoardOriginalFileName(rset.getString("board_original_filename"));
				hf.setBoardRenamedFileName(rset.getString("board_renamed_filename"));
				hf.setUse(rset.getString("use"));
//				System.out.println("hf@hospDAO = "+hf);
				list.add(hf);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public int updateDocFile(Connection conn, HospFile hf) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateDocFile");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hf.getBoardOriginalFileName());
			pstmt.setString(2, hf.getBoardRenamedFileName());
			pstmt.setString(3, hf.getDoctorNo());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
//		System.out.println("result@dao = "+result);
		return result;
	}

	public List<HospFile> selectHospFile(Connection conn, String hospId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<HospFile> list = null;

		String sql = prop.getProperty("selectHospFile");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hospId);

			rset = pstmt.executeQuery();

			list = new ArrayList<>();
			while (rset.next()) {
				HospFile hf = new HospFile();

				hf.setDoctorNo(rset.getString("doctor_no"));
				hf.setHospId(rset.getString("hosp_id"));
				hf.setBoardOriginalFileName(rset.getString("board_original_filename"));
				hf.setBoardRenamedFileName(rset.getString("board_renamed_filename"));
				hf.setUse(rset.getString("use"));
//				System.out.println("hf@hospDAO = "+hf);
				list.add(hf);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public HospFile selectOneDocFile(Connection conn, String doctorNo) {
		HospFile hf = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = prop.getProperty("selectOneDocFile");

		try {

			pstmt = conn.prepareStatement(query);
			// 쿼리문미완성
			pstmt.setString(1, doctorNo);
			// 쿼리문실행
			// 완성된 쿼리를 가지고 있는 pstmt실행(파라미터 없음)
			rset = pstmt.executeQuery();

			if (rset.next()) {
				hf = new HospFile();
				hf.setHospId(rset.getString("hosp_id"));
				hf.setDoctorNo(rset.getString("doctor_no"));
				hf.setBoardOriginalFileName(rset.getString("board_original_filename"));
				hf.setBoardRenamedFileName(rset.getString("board_renamed_filename"));
//				System.out.println("h@HospitalDAO.selectOneDocFile="+h);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return hf;
	}

	public List<Hospital> searchHosp(Connection conn, String hospName, String doctorName, String hospDept) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Hospital> list = null;
		String sql = "";
		if(!"".equals(hospName))
			sql= prop.getProperty("selectHospName");
		if(!"".equals(doctorName))
			sql= prop.getProperty("selectHospDoctor");
		if(!"".equals(hospDept))
			sql= prop.getProperty("selectHospDept");

		try {
			pstmt = conn.prepareStatement(sql);
			if(!"".equals(hospName)) {
				hospName = "%"+hospName+"%";
				pstmt.setString(1, hospName);
			}
			if(!"".equals(doctorName)) {
				doctorName = "%"+doctorName+"%";
				pstmt.setString(1, doctorName);
			}
			if(!"".equals(hospDept)) {
				hospDept = "%"+hospDept+"%";
				pstmt.setString(1, hospDept);
			}
//			System.out.println(sql);
			rset = pstmt.executeQuery();

			list = new ArrayList<>();
			while (rset.next()) {
				Hospital h = new Hospital();

				h.setHospName(rset.getString("hosp_name"));
				h.setHospId(rset.getString("hosp_id"));
				h.setHospAddr(rset.getString("hosp_addr"));
				
//				System.out.println("h@hospDAO = "+h);
				list.add(h);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public List<Hospital> searchHospAddr(Connection conn, String addr1, String addr2, String addr3, String addr4, String addr5) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Hospital> list = null;
		String sql = prop.getProperty("searchHospAddr");
		try {
			pstmt = conn.prepareStatement(sql);
			if(!"".equals(addr1)) {
				addr1 = "%"+addr1+"%";
			}
			if(!"".equals(addr2)) {
				addr2 = "%"+addr2+"%";
			}
			if(!"".equals(addr3)) {
				addr3 = "%"+addr3+"%";
			}
			if(!"".equals(addr4)) {
				addr4 = "%"+addr4+"%";
			}
			if(!"".equals(addr5)) {
				addr5 = "%"+addr5+"%";
			}
			pstmt.setString(1, addr1);
			pstmt.setString(2, addr2);
			pstmt.setString(3, addr3);
			pstmt.setString(4, addr4);
			pstmt.setString(5, addr5);
			
			rset = pstmt.executeQuery();
			
			list = new ArrayList<>();
			while (rset.next()) {
				Hospital h = new Hospital();
				
				h.setHospName(rset.getString("hosp_name"));
				h.setHospId(rset.getString("hosp_id"));
				h.setHospAddr(rset.getString("hosp_addr"));
				
//				System.out.println("h@hospDAO = "+h);
				list.add(h);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public int updateHospTime(Connection conn, HospTime ht) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateHospTime");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ht.getMonOpen());
			pstmt.setString(2, ht.getMonEnd());
			pstmt.setString(3, ht.getTueOpen());
			pstmt.setString(4, ht.getTueEnd());
			pstmt.setString(5, ht.getWedOpen());
			pstmt.setString(6, ht.getWedEnd());
			pstmt.setString(7, ht.getThuOpen());
			pstmt.setString(8, ht.getThuEnd());
			pstmt.setString(9, ht.getFriOpen());
			pstmt.setString(10, ht.getFriEnd());
			pstmt.setString(11, ht.getSatOpen());
			pstmt.setString(12, ht.getSatEnd());
			pstmt.setString(13, ht.getSunOpen());
			pstmt.setString(14, ht.getSunEnd());
			pstmt.setString(15, ht.getLunOpen());
			pstmt.setString(16, ht.getLunEnd());
			pstmt.setString(17, ht.getHospId());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		System.out.println("result@UpdateHospTimedao = "+result);
		return result;
	}

	public int updateHospFile(Connection conn, HospFile hf) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateHospFile");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hf.getBoardOriginalFileName());
			pstmt.setString(2, hf.getBoardRenamedFileName());
			pstmt.setString(3, hf.getHospId());
			pstmt.setString(4, hf.getUse());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
//		System.out.println("result@UpdateHospFiledao = "+result);
		return result;
	}
	
	public List<HospDoctor> doctorList(Connection conn, String hospId) {
		List<HospDoctor> doctor = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = prop.getProperty("doctorList");
		try{
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, hospId);
			rset = pstmt.executeQuery();
			while(rset.next()){
				HospDoctor d = new HospDoctor();
				d.setDoctorNo(rset.getString("doctor_no"));
				d.setHospId(rset.getString("hosp_id"));
				d.setDoctorName(rset.getString("doctor_name"));
				d.setHospDept(rset.getString("hosp_dept"));
				d.setDoctorTreat(rset.getString("doctor_treat"));
				d.setDoctorSpec(rset.getString("doctor_spec"));
				doctor.add(d);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		return doctor;
	}
	public Hospital hospitalInfo(Connection conn, String hospId) {
		Hospital hosp = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("hospitalInfo");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hospId);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				hosp = new Hospital();
				hosp.setHospId(rset.getString("hosp_id"));
				hosp.setHospName(rset.getString("hosp_name"));
				hosp.setHospAddr(rset.getString("hosp_addr"));
				hosp.setHospTel(rset.getString("hosp_tel"));
				hosp.setHospInfo(rset.getString("hosp_info"));
				hosp.setHospConv(rset.getString("hosp_conv"));
				hosp.setHospEnrollDate(rset.getDate("hosp_enroll_date"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rset);
		}
		return hosp;
	}
	public HospTime hospTime(Connection conn, String hospId) {
		HospTime time = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("hospitalTime");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hospId);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				time = new HospTime();
				time.setMonOpen(rset.getString("mon_open"));
				time.setMonEnd(rset.getString("mon_end"));
				time.setTueOpen(rset.getString("tue_open"));
				time.setTueEnd(rset.getString("tue_end"));
				time.setWedOpen(rset.getString("wed_open"));
				time.setWedEnd(rset.getString("wed_end"));
				time.setThuOpen(rset.getString("thu_open"));
				time.setThuEnd(rset.getString("thu_end"));
				time.setFriOpen(rset.getString("fri_open"));
				time.setFriEnd(rset.getString("fri_end"));
				time.setSatOpen(rset.getString("sat_open"));
				time.setSatEnd(rset.getString("sat_end"));
				time.setSunOpen(rset.getString("sun_open"));
				time.setSunEnd(rset.getString("sun_end"));
				time.setLunOpen(rset.getString("lun_open"));
				time.setLunEnd(rset.getString("lun_end"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rset);
		}
		return time;
	}
	public int uploadFile(Connection conn, HospFile file) {
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("uploadFile");
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, file.getDoctorNo());
			pstmt.setString(2, file.getHospId());
			pstmt.setString(3, file.getBoardOriginalFileName());
			pstmt.setString(4, file.getBoardRenamedFileName());
			pstmt.setString(5, file.getUse());
			result = pstmt.executeUpdate();
			System.out.println("result@dao="+result);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
	public List<HospFile> hospFile(Connection conn, String hospId) {
		List<HospFile> file = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("doctorImg");
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hospId);
			rset = pstmt.executeQuery();
			while(rset.next()){
				HospFile f = new HospFile();
				f.setDoctorNo(rset.getString("doctor_no"));
				f.setHospId(rset.getString("hosp_id"));
				f.setBoardOriginalFileName(rset.getString("board_original_fileName"));
				f.setBoardRenamedFileName(rset.getString("board_renamed_fileName"));
				f.setUse(rset.getString("use"));
				file.add(f);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		return file;
	}
	public HospFile checkFile(Connection conn, String doctorNo) {
		HospFile file = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("checkFile");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, doctorNo);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				file = new HospFile();
				file.setHospId(rset.getString("hosp_id"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rset);
		}
		return file;
	}
	public int deleteFile(Connection conn, String doctorNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteFile");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, doctorNo);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
	public HospFile hosLogo(Connection conn, String hospId) {
		HospFile logo = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("hosLogo");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hospId);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				logo = new HospFile();
				logo.setDoctorNo(rset.getString("doctor_no"));
				logo.setHospId(rset.getString("hosp_id"));
				logo.setBoardOriginalFileName(rset.getString("board_original_fileName"));
				logo.setBoardRenamedFileName(rset.getString("board_renamed_fileName"));
				logo.setUse(rset.getString("use"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rset);
		}
		return logo;
	}
	public List<HospFile> thumbnail(Connection conn, String hospId) {
		List<HospFile> thumbnail = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("thumnail");
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hospId);
			rset = pstmt.executeQuery();
			while(rset.next()){
				HospFile f = new HospFile();
				f.setDoctorNo(rset.getString("doctor_no"));
				f.setHospId(rset.getString("hosp_id"));
				f.setBoardOriginalFileName(rset.getString("board_original_fileName"));
				f.setBoardRenamedFileName(rset.getString("board_renamed_fileName"));
				f.setUse(rset.getString("use"));
				thumbnail.add(f);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		return thumbnail;
	}

}
