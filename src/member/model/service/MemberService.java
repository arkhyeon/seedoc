package member.model.service;

import static common.JDBCTemplate.*;

import java.sql.Connection;

import member.model.dao.MemberDAO;
import member.model.vo.User;

public class MemberService {
	
	private MemberDAO memberDAO = new MemberDAO();
	
	public static final String MEMBER_ROLE_USER = "U";
	public static final String MEMBER_ROLE_ADMIN = "A";
	
	public User selectOne(String userId) {
		Connection conn = getConnection();
		User u = memberDAO.selectOne(conn, userId);
		close(conn);
		return u;
	}

	public int insertMember(User newUser) {
		Connection conn = getConnection();
		int result = memberDAO.insertMember(conn, newUser);
		
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}

	public int updateMember(User newUser) {
		Connection conn = getConnection();
		int result = memberDAO.updateMember(conn, newUser);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		
		return result;
	}

	public int deleteMember(String userId) {
		Connection conn = getConnection();
		int result = memberDAO.deleteMember(conn, userId);
		if(result>0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
public User searchId(String userName, String userEmail, String userPhone) {
		
		Connection conn = getConnection();
		User u  =  memberDAO.searchId(conn, userName, userEmail, userPhone);
		close(conn);
		
		return u;
		
	}

public int searchPwd(String userId, String userEmail) {
	Connection conn = getConnection();
	int result = memberDAO.searchPwd(conn, userId, userEmail);
	if(result>0) commit(conn);
	else rollback(conn);
	close(conn);
	return result;
}
	
}
