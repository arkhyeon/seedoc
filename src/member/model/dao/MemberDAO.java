package member.model.dao;

import static common.JDBCTemplate.close;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import member.model.vo.User;

public class MemberDAO {
	
	private Properties prop = new Properties();
	
	public MemberDAO() {
		String fileName = MemberDAO.class.getResource("/sql/member/member-query.properties").getPath();
		try {
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public User selectOne(Connection conn, String userId) {
		User u = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String sql = prop.getProperty("selectOne");

		try {

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			rset = pstmt.executeQuery();

			if (rset.next()) {
				u = new User();
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
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return u;
	}

	public int insertMember(Connection conn, User u) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertMember");

		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, u.getUserId());
			pstmt.setString(2, u.getUserPwd());
			pstmt.setString(3, u.getUserName());
			pstmt.setString(4, u.getUserEmail());
			pstmt.setString(5, u.getUserPhone());
			pstmt.setString(6, u.getUserGender());
			pstmt.setString(7, u.getUserBirth());
			pstmt.setString(8, u.getUserAddr());
			pstmt.setString(9, u.getUserSymptom());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}

	public int updateMember(Connection conn, User u) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateMember");
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, u.getUserPwd());
			pstmt.setString(2, u.getUserName());
			pstmt.setString(3, u.getUserEmail());
			pstmt.setString(4, u.getUserPhone());
			pstmt.setString(5, u.getUserGender());
			pstmt.setString(6, u.getUserBirth());
			pstmt.setString(7, u.getUserAddr());
			pstmt.setString(8, u.getUserSymptom());
			pstmt.setString(9, u.getUserId());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}

	public int deleteMember(Connection conn, String userId) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteMember");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
	
	public User searchId(Connection conn, String userName, String userEmail, String userPhone) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("searchId");
		User u = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userName);
			pstmt.setString(2, userEmail);
			pstmt.setString(3, userPhone);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				u = new User();
				u.setUserId(rset.getString("user_id"));
				u.setUserPwd(rset.getString("user_pwd"));
				u.setUserName(rset.getString("user_name"));
				u.setUserEmail(rset.getString("user_email"));
				u.setUserPhone(rset.getString("user_phone"));
				u.setUserGender(rset.getString("user_gender"));
				u.setUserBirth(rset.getString("user_birth"));
				u.setUserAddr(rset.getString("user_addr"));
				u.setUserSymptom(rset.getString("user_symptom"));
				u.setUserEndrollDate(rset.getDate("user_enroll_date"));
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rset);
		}
		System.out.println(u);
		return u;
	}

	public int searchPwd(Connection conn, String userId, String userEmail) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("searchPwd");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setString(2, userEmail);
			pstmt.setString(3, "0000");

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}

}
