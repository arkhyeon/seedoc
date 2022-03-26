package booking.model.service;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.List;

import booking.model.dao.BookingDAO;
import booking.model.vo.Booking;
import booking.model.vo.BookingAdd;
import booking.model.vo.BookingCount;
import hospital.model.vo.HospDoctor;
import hospital.model.vo.HospFile;
import hospital.model.vo.HospTime;
import hospital.model.vo.Hospital;
import member.model.vo.User;

public class BookingService {
	
	BookingDAO bookingDAO = new BookingDAO();

	public List<Booking> bookingUserList(String userId) {
		Connection conn = getConnection();
		List<Booking> list = bookingDAO.bookingUserList(conn, userId);
		close(conn);
		return list;
	}

	public List<BookingAdd> bookingAddUserList(String userId, int cPage, int numPerPage) {
		Connection conn = getConnection();
		List<BookingAdd> list = bookingDAO.bookingAddUserList(conn, userId, cPage, numPerPage);
		close(conn);
		return list;
	}
	
//	public List<BookingAdd> bookingAddUserList(String userId) {
//		Connection conn = getConnection();
//		List<BookingAdd> list = bookingDAO.bookingAddUserList(conn, userId);
//		close(conn);
//		return list;
//	}

	public BookingCount bookingCount(String userId) {
		Connection conn = getConnection();
		BookingCount bc = bookingDAO.bookingCount(conn, userId);
		close(conn);
		return bc;
	}

	public List<BookingAdd> bookingAddUserApprovalList(String userId, String state, int cPage, int numPerPage) {
		Connection conn = getConnection();
		List<BookingAdd> list = bookingDAO.bookingAddUserApprovalList(conn, userId, state, cPage, numPerPage);
		close(conn);
		return list;
	}

	public List<HospDoctor> bookingHospDoctorSelect(String hospId) {
		Connection conn = getConnection();
		List<HospDoctor> list = bookingDAO.bookingHospDoctorSelect(conn, hospId);
		close(conn);
		return list;
	}

	public HospTime hospitalTimeSelect(String hospId) {
		Connection conn = getConnection();
		HospTime ht = bookingDAO.hospitalTimeSelect(conn, hospId);
		close(conn);
		return ht;
	}

	public List<HospFile> hospitalFileSelect(String hospId) {
		Connection conn = getConnection();
		List<HospFile> hfList = bookingDAO.hospitalFileSelect(conn, hospId);
		close(conn);
		return hfList;
	}

	public Hospital bookingHospSelect(String hospId) {
		Connection conn = getConnection();
		Hospital hosp = bookingDAO.bookingHospSelect(conn, hospId);
		close(conn);
		return hosp;
	}

	public List<Booking> bookingDocNoSelect(String doctorNo) {
		Connection conn = getConnection();
		List<Booking> list = bookingDAO.bookingDocNoSelect(conn, doctorNo);
		close(conn);
		return list;
	}

	public User userSelectOne(String userId) {
		Connection conn = getConnection();
		User user = bookingDAO.userSelectOne(conn, userId);
		close(conn);
		return user;
	}

	public int bookingInsert(Booking booking) {
		Connection conn = getConnection();
		int result = bookingDAO.bookingInsert(conn, booking);
		close(conn);
		return result;
	}

	public int updateStateBooking(String bookingNo, String state) {
//		System.out.println("service updateStateBooking");
		Connection conn = getConnection();
		int result = bookingDAO.updateStateBooking(conn, bookingNo, state);
		close(conn);
		return result;
	}

	public int deleteBooking(String bookingNo) {
		Connection conn = getConnection();
		int result = bookingDAO.deleteBooking(conn, bookingNo);
		close(conn);
		return result;
	}

	public Booking bookingNoSelect(String bookingNo) {
		Connection conn =getConnection();
		Booking booking = bookingDAO.bookingNoSelect(conn, bookingNo);
		close(conn);
		return booking;
	}

	public int bookingUpdate(Booking booking) {
		System.out.println("service bookingUpdate");
		Connection conn = getConnection();
		int result = bookingDAO.bookingUpdate(conn, booking);
		close(conn);
		return result;
	}

	public List<Booking> bookingHospOneSelect(String hospId) {
		Connection conn = getConnection();
		List<Booking> list = bookingDAO.bookingHospOneSelect(conn, hospId);
		close(conn);
		return list;
	}

	public List<BookingAdd> bookingAddHospList(String hospId, String state, int cPage, int numPerPage) {
		Connection conn = getConnection();
		List<BookingAdd> list = bookingDAO.bookingAddHospList(conn, hospId, state, cPage, numPerPage);
		close(conn);
		return list;
	}

	public BookingCount bookingHospCount(String hospId) {
		Connection conn = getConnection();
		BookingCount bc = bookingDAO.bookingHospCount(conn, hospId);
		close(conn);
		return bc;
	}

	public int updateStateHospBooking(String bookingNo, String state, String cancle) {
		Connection conn = getConnection();
		int result = bookingDAO.updateStateHospBooking(conn, bookingNo, state, cancle);
		close(conn);
		return result;
	}

	public List<BookingAdd> bookingAddHospFinderList(String hospId, String state, String searchType,
			String searchKeyword, int cPage, int numPerPage) {
		Connection conn = getConnection();
		List<BookingAdd> list = bookingDAO.bookingAddHospFinderList(conn, hospId, state, searchType, searchKeyword, cPage, numPerPage);
		close(conn);
		return list;
	}

	public BookingCount bookingHospFinderCount(String hospId, String searchType, String searchKeyword) {
		Connection conn = getConnection();
		BookingCount bc = bookingDAO.bookingHospFinderCount(conn, hospId, searchType, searchKeyword);
		close(conn);
		return bc;
	}

	public List<BookingAdd> bookingListMain(String userId, String state) {
		Connection conn = getConnection();
		List<BookingAdd> list = bookingDAO.bookingListMain(conn, userId, state);
		close(conn);
		return list;
	}

}
