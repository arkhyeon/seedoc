package booking.model.dao;

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

import booking.model.vo.Booking;
import booking.model.vo.BookingAdd;
import booking.model.vo.BookingCount;
import common.JDBCTemplate;
import hospital.model.vo.HospDoctor;
import hospital.model.vo.HospFile;
import hospital.model.vo.HospTime;
import hospital.model.vo.Hospital;
import member.model.vo.User;

import static common.JDBCTemplate.*;

public class BookingDAO {
	
	Properties prop = new Properties();

	public BookingDAO() {
		
		String fileName = "/sql/booking/booking-query.properties";
		fileName = JDBCTemplate.class.getResource(fileName).getPath();
		//System.out.println("fileName@dao: " + fileName);
		
		try {
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public List<Booking> bookingUserList(Connection conn, String userId) {
		Booking b = null;
		List<Booking> list = new ArrayList();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("bookingUserList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			
			rset = pstmt.executeQuery();
			while(rset.next()) {
				b = new Booking();
				b.setBookingNo(rset.getString("booking_no"));
				b.setUserId(rset.getString("user_id"));
				b.setHospId(rset.getString("hosp_id"));
				b.setDoctorNo(rset.getString("doctor_no"));
				b.setUserName(rset.getString("user_name"));
				b.setBookingDate(rset.getDate("booking_date"));
				b.setBookingTime(rset.getString("booking_time"));
				b.setSysmptom(rset.getString("sysmptom"));
				b.setBookingState(rset.getString("booking_state"));
				b.setBookingCancel(rset.getString("booking_cancle"));
				list.add(b);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
//		System.out.println("dao:" + list);
		return list;
	}

	public List<BookingAdd> bookingAddUserList(Connection conn, String userId, int cPage, int numPerPage) {
		BookingAdd b = null;
		List<BookingAdd> list = new ArrayList();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("bookingAddUserListPage");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setInt(2, (cPage-1)* numPerPage+1);
			pstmt.setInt(3, cPage * numPerPage);
			
			rset = pstmt.executeQuery();
			while(rset.next()) {
				b = new BookingAdd();
				b.setBookingNo(rset.getString("booking_no"));
				b.setUserId(rset.getString("user_id"));
				b.setHospId(rset.getString("hosp_id"));
				b.setDoctorNo(rset.getString("doctor_no"));
				b.setUserName(rset.getString("user_name"));
				b.setBookingDate(rset.getDate("booking_date"));
				b.setBookingTime(rset.getString("booking_time"));
				b.setSysmptom(rset.getString("sysmptom"));
				b.setBookingState(rset.getString("booking_state"));
				b.setBookingCancel(rset.getString("booking_cancle"));
				b.setHospName(rset.getString("hosp_name"));
				b.setDocName(rset.getString("doctor_name"));
				b.setHospDept(rset.getString("hosp_dept"));
				b.setUserBirth(rset.getString("user_birth"));
				b.setUserPhone(rset.getString("user_phone"));
				b.setUserEmail(rset.getString("user_email"));
				
				list.add(b);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
//		System.out.println("dao:" + list);
		return list;
	}
	
	public BookingCount bookingCount(Connection conn, String userId) {
		BookingCount bc = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("bookingCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			rset=pstmt.executeQuery();
			while(rset.next()) {
				bc = new BookingCount();
				bc.setTotal(rset.getInt("total"));
				bc.setApproval(rset.getInt("approval"));
				bc.setFinish(rset.getInt("finish"));
				bc.setCancle(rset.getInt("cancle"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return bc;
	}

	public List<BookingAdd> bookingAddUserApprovalList(Connection conn, String userId, String state, int cPage, int numPerPage) {
		BookingAdd b = null;
		List<BookingAdd> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("bookingAddUserApprovalListPage");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setString(2, state);
			pstmt.setInt(3, (cPage-1)* numPerPage+1);
			pstmt.setInt(4, cPage * numPerPage);
			
						
			rset = pstmt.executeQuery();
			while(rset.next()) {
				b = new BookingAdd();
				b.setBookingNo(rset.getString("booking_no"));
				b.setUserId(rset.getString("user_id"));
				b.setHospId(rset.getString("hosp_id"));
				b.setDoctorNo(rset.getString("doctor_no"));
				b.setUserName(rset.getString("user_name"));
				b.setBookingDate(rset.getDate("booking_date"));
				b.setBookingTime(rset.getString("booking_time"));
				b.setSysmptom(rset.getString("sysmptom"));
				b.setBookingState(rset.getString("booking_state"));
				b.setBookingCancel(rset.getString("booking_cancle"));
				b.setHospName(rset.getString("hosp_name"));
				b.setDocName(rset.getString("doctor_name"));
				b.setHospDept(rset.getString("hosp_dept"));
				b.setUserBirth(rset.getString("user_birth"));
				b.setUserPhone(rset.getString("user_phone"));
				b.setUserEmail(rset.getString("user_email"));
				
				list.add(b);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
//		System.out.println("dao:" + list);
		return list;
	}

	public List<HospDoctor> bookingHospDoctorSelect(Connection conn, String hospId) {
		HospDoctor hd = null;
		List<HospDoctor> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("BookingHospDoctorSelect");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hospId);
			rset=pstmt.executeQuery();
			
			while(rset.next()) {
				hd = new HospDoctor();
				hd.setHospId(rset.getString("hosp_id"));
				hd.setDoctorNo(rset.getString("doctor_no"));
				hd.setHospId(rset.getString("hosp_id"));
				hd.setDoctorName(rset.getString("doctor_name"));
				hd.setHospDept(rset.getString("hosp_dept"));
				hd.setDoctorTreat(rset.getString("doctor_treat"));
				hd.setDoctorSpec(rset.getString("doctor_spec"));
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

	public HospTime hospitalTimeSelect(Connection conn, String hospId) {
		HospTime ht = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("hospitalTimeSelect");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hospId);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
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
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return ht;
	}

	public List<HospFile> hospitalFileSelect(Connection conn, String hospId) {
		HospFile hf = null;
		List<HospFile> hfList = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("hospitalFileSelect");
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, hospId);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				hf = new HospFile();
				hf.setDoctorNo(rset.getString("doctor_no"));
				hf.setHospId(rset.getString("hosp_id"));
				hf.setBoardOriginalFileName(rset.getString("board_original_filename"));
				hf.setBoardRenamedFileName(rset.getString("board_renamed_filename"));
				hf.setUse(rset.getString("use"));
				hfList.add(hf);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
//		System.out.println("dao" + hfList);
		return hfList;
	}

	public Hospital bookingHospSelect(Connection conn, String hospId) {
		Hospital hosp = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("bookingHospSelect");
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, hospId);
			rset=pstmt.executeQuery();
			while(rset.next()) {
				hosp=new Hospital();
				hosp.setHospId(rset.getString("hosp_id"));
				hosp.setHospPwd(rset.getString("hosp_pwd"));
				hosp.setHospName(rset.getString("hosp_name"));
				hosp.setHospAddr(rset.getString("hosp_addr"));
				hosp.setHospTel(rset.getString("hosp_tel"));
				hosp.setHospInfo(rset.getString("hosp_info"));
				hosp.setHospConv(rset.getString("hosp_conv"));
				hosp.setHospEnrollDate(rset.getDate("hosp_enroll_date"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return hosp;
	}

	public List<Booking> bookingDocNoSelect(Connection conn, String doctorNo) {
		Booking b = null;
		List<Booking> list = new ArrayList<>(); 
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("bookingDocNoSelect");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, doctorNo);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				b = new Booking();
				b.setBookingNo(rset.getString("booking_no"));
				b.setUserId(rset.getString("user_id"));
				b.setHospId(rset.getString("hosp_id"));
				b.setDoctorNo(rset.getString("doctor_no"));
				b.setUserName(rset.getString("user_name"));
				b.setBookingDate(rset.getDate("booking_date"));
				b.setBookingTime(rset.getString("booking_time"));
				b.setSysmptom(rset.getString("sysmptom"));
				b.setBookingState(rset.getString("booking_state"));
				b.setBookingCancel(rset.getString("booking_cancle"));
				list.add(b);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public User userSelectOne(Connection conn, String userId) {
		User user = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("userSelectOne");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				user = new User();
				user.setUserId(rset.getString("user_id"));
				user.setUserPwd(rset.getString("user_pwd"));
				user.setUserName(rset.getString("user_name"));
				user.setUserEmail(rset.getString("user_email"));
				user.setUserPhone(rset.getString("user_phone"));
				user.setUserGender(rset.getString("user_gender"));
				user.setUserBirth(rset.getString("user_birth"));
				user.setUserAddr(rset.getString("user_addr"));
				user.setUserSymptom(rset.getString("user_symptom"));
				user.setUserRole(rset.getString("user_role"));
				user.setUserEndrollDate(rset.getDate("user_enroll_date"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return user;
	}

	public int bookingInsert(Connection conn, Booking booking) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("bookingInsert");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, booking.getUserId());
			pstmt.setString(2, booking.getHospId());
			pstmt.setString(3, booking.getDoctorNo());
			pstmt.setString(4, booking.getUserName());
			pstmt.setDate(5, booking.getBookingDate());
			pstmt.setString(6, booking.getBookingTime());
			pstmt.setString(7, booking.getSysmptom());
			result= pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
//		System.out.println("insert@dao: "+result);
		return result;
	}

	public int updateStateBooking(Connection conn, String bookingNo, String state) {
//		System.out.println("DAO updateStateBooking");
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateStateBooking");
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, state);
			pstmt.setString(2, bookingNo);
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int deleteBooking(Connection conn, String bookingNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteBooking");
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, bookingNo);
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public Booking bookingNoSelect(Connection conn, String bookingNo) {
		Booking b = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("bookingNoSelect");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bookingNo);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				b = new Booking();
				b.setBookingNo(rset.getString("booking_no"));
				b.setUserId(rset.getString("user_id"));
				b.setHospId(rset.getString("hosp_id"));
				b.setDoctorNo(rset.getString("doctor_no"));
				b.setUserName(rset.getString("user_name"));
				b.setBookingDate(rset.getDate("booking_date"));
				b.setBookingTime(rset.getString("booking_time"));
				b.setSysmptom(rset.getString("sysmptom"));
				b.setBookingState(rset.getString("booking_state"));
				b.setBookingCancel(rset.getString("booking_cancle"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return b;
	}

	public int bookingUpdate(Connection conn, Booking booking) {
//		System.out.println("DAO bookingUpdate");
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("bookingUpdate");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, booking.getUserId());
			pstmt.setString(2, booking.getHospId());
			pstmt.setString(3, booking.getDoctorNo());
			pstmt.setString(4, booking.getUserName());
			pstmt.setDate(5, booking.getBookingDate());
			pstmt.setString(6, booking.getBookingTime());
			pstmt.setString(7, booking.getSysmptom());
			pstmt.setString(8, booking.getBookingNo());
			result= pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
//		System.out.println("insert@dao: "+result);
		return result;
	}

	public List<Booking> bookingHospOneSelect(Connection conn, String hospId) {
		Booking b = null;
		List<Booking> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("bookingHospOneSelect");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hospId);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				b = new Booking();
				b.setBookingNo(rset.getString("booking_no"));
				b.setUserId(rset.getString("user_id"));
				b.setHospId(rset.getString("hosp_id"));
				b.setDoctorNo(rset.getString("doctor_no"));
				b.setUserName(rset.getString("user_name"));
				b.setBookingDate(rset.getDate("booking_date"));
				b.setBookingTime(rset.getString("booking_time"));
				b.setSysmptom(rset.getString("sysmptom"));
				b.setBookingState(rset.getString("booking_state"));
				b.setBookingCancel(rset.getString("booking_cancle"));
				list.add(b);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public List<BookingAdd> bookingAddHospList(Connection conn, String hospId, String state, int cPage,
			int numPerPage) {
		BookingAdd b = null;
		List<BookingAdd> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("bookingAddHospList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hospId);
			pstmt.setString(2, state);
			pstmt.setInt(3, (cPage-1)* numPerPage+1);
			pstmt.setInt(4, cPage * numPerPage);
					
			rset = pstmt.executeQuery();
			while(rset.next()) {
				b = new BookingAdd();
				b.setBookingNo(rset.getString("booking_no"));
				b.setUserId(rset.getString("user_id"));
				b.setHospId(rset.getString("hosp_id"));
				b.setDoctorNo(rset.getString("doctor_no"));
				b.setUserName(rset.getString("user_name"));
				b.setBookingDate(rset.getDate("booking_date"));
				b.setBookingTime(rset.getString("booking_time"));
				b.setSysmptom(rset.getString("sysmptom"));
				b.setBookingState(rset.getString("booking_state"));
				b.setBookingCancel(rset.getString("booking_cancle"));
				b.setHospName(rset.getString("hosp_name"));
				b.setDocName(rset.getString("doctor_name"));
				b.setHospDept(rset.getString("hosp_dept"));
				b.setUserBirth(rset.getString("user_birth"));
				b.setUserPhone(rset.getString("user_phone"));
				b.setUserEmail(rset.getString("user_email"));
				
				list.add(b);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
//		System.out.println("dao:" + list);
		return list;
	}

	public BookingCount bookingHospCount(Connection conn, String hospId) {
		BookingCount bc = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("bookingHospCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hospId);
			rset=pstmt.executeQuery();
			while(rset.next()) {
				bc = new BookingCount();
				bc.setTotal(rset.getInt("total"));
				bc.setApproval(rset.getInt("approval"));
				bc.setFinish(rset.getInt("finish"));
				bc.setCancle(rset.getInt("cancle"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return bc;
	}

	public int updateStateHospBooking(Connection conn, String bookingNo, String state, String cancle) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateStateHospBooking");
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, state);
			pstmt.setString(2, cancle);
			pstmt.setString(3, bookingNo);
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public List<BookingAdd> bookingAddHospFinderList(Connection conn, String hospId, String state, String searchType,
			String searchKeyword, int cPage, int numPerPage) {
		BookingAdd b = null;
		List<BookingAdd> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("bookingAddHospFinderList1");
		
		switch(searchType) {
		case "doctorName": sql += " " + "doctor_name" + " "; break;
		case "userName": sql += " " + "b.user_name" + " "; break;
		case "schedule": sql += " " + "booking_date" + " "; break;
		}
		if("schedule".equals(searchType)) {
			sql += prop.getProperty("bookingAddHospFinderList3");
		}else {
			sql += prop.getProperty("bookingAddHospFinderList2");
		}
//		System.out.println(sql);
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hospId);
			pstmt.setString(2, state);
			if("schedule".equals(searchType)) {
				pstmt.setString(3, searchKeyword);
			} else {
				pstmt.setString(3, "%"+searchKeyword+"%");
			}
			pstmt.setInt(4, (cPage-1)* numPerPage+1);
			pstmt.setInt(5, cPage * numPerPage);
					
			rset = pstmt.executeQuery();
			while(rset.next()) {
				b = new BookingAdd();
				b.setBookingNo(rset.getString("booking_no"));
				b.setUserId(rset.getString("user_id"));
				b.setHospId(rset.getString("hosp_id"));
				b.setDoctorNo(rset.getString("doctor_no"));
				b.setUserName(rset.getString("user_name"));
				b.setBookingDate(rset.getDate("booking_date"));
				b.setBookingTime(rset.getString("booking_time"));
				b.setSysmptom(rset.getString("sysmptom"));
				b.setBookingState(rset.getString("booking_state"));
				b.setBookingCancel(rset.getString("booking_cancle"));
				b.setHospName(rset.getString("hosp_name"));
				b.setDocName(rset.getString("doctor_name"));
				b.setHospDept(rset.getString("hosp_dept"));
				b.setUserBirth(rset.getString("user_birth"));
				b.setUserPhone(rset.getString("user_phone"));
				b.setUserEmail(rset.getString("user_email"));
				
				list.add(b);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
//		System.out.println("dao:" + list);
		return list;
	}

	public BookingCount bookingHospFinderCount(Connection conn, String hospId, String searchType,
			String searchKeyword) {
		BookingCount bc = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("bookingHospFinderCount1");
		
		switch(searchType) {
		case "doctorName": sql += " " + "doctor_name" + " "; break;
		case "userName": sql += " " + "user_name" + " "; break;
		case "schedule": sql += " " + "booking_date" + " "; break;
		}
		if("schedule".equals(searchType)) {
			sql += prop.getProperty("bookingHospFinderCount3");
		} else {
			sql += prop.getProperty("bookingHospFinderCount2");
		}
//		System.out.println(sql);
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hospId);
			if("schedule".equals(searchType)) {
				pstmt.setString(2, searchKeyword);
			} else {
				pstmt.setString(2, "%"+searchKeyword+"%");
			}
			rset=pstmt.executeQuery();
			while(rset.next()) {
				bc = new BookingCount();
				bc.setTotal(rset.getInt("total"));
				bc.setApproval(rset.getInt("approval"));
				bc.setFinish(rset.getInt("finish"));
				bc.setCancle(rset.getInt("cancle"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return bc;
	}

	public List<BookingAdd> bookingListMain(Connection conn, String userId, String state) {
		BookingAdd b = null;
		List<BookingAdd> list = new ArrayList();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("bookingListMain");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setString(2, state);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				b = new BookingAdd();
				b.setBookingNo(rset.getString("booking_no"));
				b.setUserId(rset.getString("user_id"));
				b.setHospId(rset.getString("hosp_id"));
				b.setDoctorNo(rset.getString("doctor_no"));
				b.setUserName(rset.getString("user_name"));
				b.setBookingDate(rset.getDate("booking_date"));
				b.setBookingTime(rset.getString("booking_time"));
				b.setSysmptom(rset.getString("sysmptom"));
				b.setBookingState(rset.getString("booking_state"));
				b.setBookingCancel(rset.getString("booking_cancle"));
				b.setHospName(rset.getString("hosp_name"));
				b.setDocName(rset.getString("doctor_name"));
				b.setHospDept(rset.getString("hosp_dept"));
				b.setUserBirth(rset.getString("user_birth"));
				b.setUserPhone(rset.getString("user_phone"));
				b.setUserEmail(rset.getString("user_email"));
				list.add(b);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
//		System.out.println("dao:" + list);
		return list;
	}

	
	
	
	
	

}
