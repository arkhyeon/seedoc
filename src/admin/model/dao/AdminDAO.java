package admin.model.dao;

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

import hospital.model.vo.Hospital;
import member.model.vo.User;

public class AdminDAO {

private Properties prop = new Properties();
	
	public AdminDAO() {
		//build-path의 절대경로를 가져오기
		String fileName 
			= AdminDAO.class.getResource("/sql/admin/admin-query.properties").getPath();
//		System.out.println("fileName@dao = " + fileName);
		
		try {
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public List<User> allUser(Connection conn) {
		List<User> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("allUser");
			
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			list = new ArrayList<>();
			while(rset.next()) {
				User u = new User();
				u.setUserId(rset.getString("user_id"));
				u.setUserPwd(rset.getString("user_pwd"));
				u.setUserName(rset.getString("user_name"));
				u.setUserEmail(rset.getString("user_email"));
				u.setUserPhone(rset.getString("user_phone"));
				u.setUserGender(rset.getString("user_gender"));
				u.setUserBirth(rset.getString("user_birth"));
				u.setUserAddr(rset.getString("user_addr"));
				u.setUserSymptom(rset.getString("user_symptom"));
				u.setUserRole(rset.getString("user_role"));
				u.setUserEndrollDate(rset.getDate("user_enroll_date"));
				list.add(u);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}
	
	

	public int delUser(Connection conn, String userId) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("delUser");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public int delBooking(Connection conn, String userId) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("delUserBooking");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public List<User> searchId(Connection conn, String searchType, String searchKeyword) {
		List<User> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("searchId");
		
		String columnName = "";
		switch(searchType) {
		case "memberId": columnName = "user_id"; break;
		case "memberName": columnName = "user_name"; break;
		case "gender": columnName = "user_gender"; break;
		}
		
		sql = sql.replace("#", columnName);
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, '%'+searchKeyword+'%');
			rset = pstmt.executeQuery();
			list = new ArrayList<>();
			while(rset.next()) {
				User u = new User();
				u.setUserId(rset.getString("user_id"));
				u.setUserPwd(rset.getString("user_pwd"));
				u.setUserName(rset.getString("user_name"));
				u.setUserEmail(rset.getString("user_email"));
				u.setUserPhone(rset.getString("user_phone"));
				u.setUserGender(rset.getString("user_gender"));
				u.setUserBirth(rset.getString("user_birth"));
				u.setUserAddr(rset.getString("user_addr"));
				u.setUserSymptom(rset.getString("user_symptom"));
				u.setUserRole(rset.getString("user_role"));
				u.setUserEndrollDate(rset.getDate("user_enroll_date"));
				list.add(u);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public List<Hospital> allHosp(Connection conn) {
		List<Hospital> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("allHosp");
			
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			list = new ArrayList<>();
			while(rset.next()) {
				Hospital h = new Hospital();
				h.setHospId(rset.getString("hosp_id"));
				h.setHospPwd(rset.getString("hosp_pwd"));
				h.setHospName(rset.getString("hosp_name"));
				h.setHospAddr(rset.getString("hosp_addr"));
				h.setHospTel(rset.getString("hosp_tel"));
				h.setHospInfo(rset.getString("hosp_info"));
				h.setHospConv(rset.getString("hosp_conv"));
				h.setHospEnrollDate(rset.getDate("hosp_enroll_date"));
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

	public int delHosp(Connection conn, String hospId) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("delHosp");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hospId);
			

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public List<Hospital> searchHosp(Connection conn, String searchType, String searchKeyword) {
		List<Hospital> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("searchHosp");
		
		String columnName = "";
		switch(searchType) {
		case "hospId": columnName = "hosp_id"; break;
		case "hospName": columnName = "hosp_name"; break;
		case "hospAddr": columnName = "hosp_addr"; break;
		}
		
		sql = sql.replace("#", columnName);
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, '%'+searchKeyword+'%');
			rset = pstmt.executeQuery();
			list = new ArrayList<>();
			while(rset.next()) {
				Hospital h = new Hospital();
				h.setHospId(rset.getString("hosp_id"));
				h.setHospPwd(rset.getString("hosp_pwd"));
				h.setHospName(rset.getString("hosp_name"));
				h.setHospAddr(rset.getString("hosp_addr"));
				h.setHospTel(rset.getString("hosp_tel"));
				h.setHospInfo(rset.getString("hosp_info"));
				h.setHospConv(rset.getString("hosp_conv"));
				h.setHospEnrollDate(rset.getDate("hosp_enroll_date"));
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

	public int delHospBooking(Connection conn, String hospId) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("delHospBooking");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hospId);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

}
