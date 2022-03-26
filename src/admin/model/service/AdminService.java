package admin.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import admin.model.dao.AdminDAO;
import hospital.model.vo.Hospital;
import member.model.vo.User;

public class AdminService {
	
	AdminDAO adminDAO = new AdminDAO();
	

	public List<User> allUser() {
		Connection conn = getConnection();
		List<User> member = adminDAO.allUser(conn);
		close(conn);
		return member;
	}


	public int delUser(String userId) {
		Connection conn = getConnection();
		int result = adminDAO.delUser(conn, userId);
		if(result>0) {
			commit(conn);
		}
		else 
			rollback(conn);
		close(conn);
		return result;
	}


	public int delBooking(String userId) {
		Connection conn = getConnection();
		int result = adminDAO.delBooking(conn, userId);
		if(result>0) {
			commit(conn);
		}
		else 
			rollback(conn);
		close(conn);
		return result;
	}


	public List<User> searchId(String searchType, String searchKeyword) {
		Connection conn = getConnection();
		List<User> member = adminDAO.searchId(conn, searchType, searchKeyword);
		close(conn);
		return member;
	}


	public List<Hospital> allHosp() {
		Connection conn = getConnection();
		List<Hospital> hosp = adminDAO.allHosp(conn);
		close(conn);
		return hosp;
	}


	public int delHosp(String hospId) {
		Connection conn = getConnection();
		int result = adminDAO.delHosp(conn, hospId);
		if(result>0) {
			commit(conn);
		}
		else 
			rollback(conn);
		close(conn);
		return result;
	}


	public List<Hospital> searchHosp(String searchType, String searchKeyword) {
		Connection conn = getConnection();
		List<Hospital> list = adminDAO.searchHosp(conn, searchType, searchKeyword);
		close(conn);
		return list;
	}


	public int delHospBooking(String hospId) {
		Connection conn = getConnection();
		int result = adminDAO.delHospBooking(conn, hospId);
		if(result>0) {
			commit(conn);
		}
		else 
			rollback(conn);
		close(conn);
		return result;
	}
}
