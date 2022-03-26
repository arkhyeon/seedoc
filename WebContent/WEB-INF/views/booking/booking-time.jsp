<%@page import="java.sql.Date"%>
<%@page import="booking.model.vo.Booking"%>
<%@page import="hospital.model.vo.Hospital"%>
<%@page import="hospital.model.vo.HospTime"%>
<%@page import="hospital.model.vo.HospFile"%>
<%@page import="hospital.model.vo.HospDoctor"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	List<Booking> blist = (List<Booking>)request.getAttribute("list");
	HospTime ht = (HospTime)request.getAttribute("ht");
	int week = (int)request.getAttribute("week");
	int year = Integer.parseInt((String)request.getAttribute("year"));
	int mon = Integer.parseInt((String)request.getAttribute("mon"));
	int day = Integer.parseInt((String)request.getAttribute("day"));
//	System.out.println("jsp: "+blist);
//	System.out.println("jsp: "+ht);
//	System.out.println("jsp: "+week);
//	System.out.println("jsp: "+year);
//	System.out.println("jsp: "+mon);
//	System.out.println("jsp: "+day);
	
	int amHourOpen = 0;
	int amMinOpen = 0;
	int pmHourEnd = 0;
	int pmMinEnd = 0;
	String lunHourOpen_ = ht.getLunOpen()!=null ? ht.getLunOpen().substring(0, ht.getLunOpen().indexOf(":")) : "";
	int lunHourOpen = Integer.parseInt(lunHourOpen_);
	String lunMinOpen_ = ht.getLunOpen()!=null ?  ht.getLunOpen().substring(ht.getLunOpen().indexOf(":")+1) : "";
	int lunMinOpen = Integer.parseInt(lunMinOpen_);
	String lunHourEnd_ = ht.getLunEnd()!= null ? ht.getLunEnd().substring(0, ht.getLunEnd().indexOf(":")) : "";
	int lunHourEnd = Integer.parseInt(lunHourEnd_);
	String lunMinEnd_ = ht.getLunEnd()!= null ?  ht.getLunEnd().substring(ht.getLunEnd().indexOf(":")+1) : "";
	int lunMinEnd = Integer.parseInt(lunMinEnd_);
	
	
	if(ht.getSunOpen()!=null && ht.getSunEnd()!= null && week==0) {
		String amHourOpen_ = ht.getSunOpen().substring(0, ht.getSunOpen().indexOf(":"));
		amHourOpen = Integer.parseInt(amHourOpen_);
		String amMinOpen_ = ht.getSunOpen().substring(ht.getSunOpen().indexOf(":")+1);
		amMinOpen = Integer.parseInt(amMinOpen_);
		String pmHourEnd_ = ht.getSunEnd().substring(0, ht.getSunEnd().indexOf(":"));
		pmHourEnd = Integer.parseInt(pmHourEnd_);
		String pmMinEnd_ = ht.getSunEnd().substring(ht.getSunEnd().indexOf(":")+1);
		pmMinEnd = Integer.parseInt(pmMinEnd_);
	} else if(ht.getMonOpen() != null && ht.getMonEnd() != null && week==1) {
		String amHourOpen_ = ht.getMonOpen().substring(0, ht.getMonOpen().indexOf(":"));
		amHourOpen = Integer.parseInt(amHourOpen_);
		String amMinOpen_ = ht.getMonOpen().substring(ht.getMonOpen().indexOf(":")+1);
		amMinOpen = Integer.parseInt(amMinOpen_);
		String pmHourEnd_ = ht.getMonEnd().substring(0, ht.getMonEnd().indexOf(":"));
		pmHourEnd = Integer.parseInt(pmHourEnd_);
		String pmMinEnd_ = ht.getMonEnd().substring(ht.getMonEnd().indexOf(":")+1);
		pmMinEnd = Integer.parseInt(pmMinEnd_);
	} else if(ht.getTueOpen() != null && ht.getTueEnd() != null && week==2) {
		String amHourOpen_ = ht.getTueOpen().substring(0, ht.getTueOpen().indexOf(":"));
		amHourOpen = Integer.parseInt(amHourOpen_);
		String amMinOpen_ = ht.getTueOpen().substring(ht.getTueOpen().indexOf(":")+1);
		amMinOpen = Integer.parseInt(amMinOpen_);
		String pmHourEnd_ = ht.getTueEnd().substring(0, ht.getTueEnd().indexOf(":"));
		pmHourEnd = Integer.parseInt(pmHourEnd_);
		String pmMinEnd_ = ht.getTueEnd().substring(ht.getTueEnd().indexOf(":")+1);
		pmMinEnd = Integer.parseInt(pmMinEnd_);
	} else if(ht.getWedOpen() != null && ht.getWedEnd() != null && week==3) {
		String amHourOpen_ = ht.getWedOpen().substring(0, ht.getWedOpen().indexOf(":"));
		amHourOpen = Integer.parseInt(amHourOpen_);
		String amMinOpen_ = ht.getWedOpen().substring(ht.getWedOpen().indexOf(":")+1);
		amMinOpen = Integer.parseInt(amMinOpen_);
		String pmHourEnd_ = ht.getWedEnd().substring(0, ht.getWedEnd().indexOf(":"));
		pmHourEnd = Integer.parseInt(pmHourEnd_);
		String pmMinEnd_ = ht.getWedEnd().substring(ht.getWedEnd().indexOf(":")+1);
		pmMinEnd = Integer.parseInt(pmMinEnd_);
	} else if(ht.getThuOpen() != null && ht.getThuEnd() != null && week==4) {
		String amHourOpen_ = ht.getThuOpen().substring(0, ht.getThuOpen().indexOf(":"));
		amHourOpen = Integer.parseInt(amHourOpen_);
		String amMinOpen_ = ht.getThuOpen().substring(ht.getThuOpen().indexOf(":")+1);
		amMinOpen = Integer.parseInt(amMinOpen_);
		String pmHourEnd_ = ht.getThuEnd().substring(0, ht.getThuEnd().indexOf(":"));
		pmHourEnd = Integer.parseInt(pmHourEnd_);
		String pmMinEnd_ = ht.getThuEnd().substring(ht.getThuEnd().indexOf(":")+1);
		pmMinEnd = Integer.parseInt(pmMinEnd_);
	} else if(ht.getFriOpen() != null && ht.getFriEnd() != null && week==5) {
		String amHourOpen_ = ht.getFriOpen().substring(0, ht.getFriOpen().indexOf(":"));
		amHourOpen = Integer.parseInt(amHourOpen_);
		String amMinOpen_ = ht.getFriOpen().substring(ht.getFriOpen().indexOf(":")+1);
		amMinOpen = Integer.parseInt(amMinOpen_);
		String pmHourEnd_ = ht.getFriEnd().substring(0, ht.getFriEnd().indexOf(":"));
		pmHourEnd = Integer.parseInt(pmHourEnd_);
		String pmMinEnd_ = ht.getFriEnd().substring(ht.getFriEnd().indexOf(":")+1);
		pmMinEnd = Integer.parseInt(pmMinEnd_);
	} else if(ht.getSatOpen() != null && ht.getSatEnd() != null && week==6) {
		String amHourOpen_ = ht.getSatOpen().substring(0, ht.getSatOpen().indexOf(":"));
		amHourOpen = Integer.parseInt(amHourOpen_);
		String amMinOpen_ = ht.getSatOpen().substring(ht.getSatOpen().indexOf(":")+1);
		amMinOpen = Integer.parseInt(amMinOpen_);
		String pmHourEnd_ = ht.getSatEnd().substring(0, ht.getSatEnd().indexOf(":"));
		pmHourEnd = Integer.parseInt(pmHourEnd_);
		String pmMinEnd_ = ht.getSatEnd().substring(ht.getSatEnd().indexOf(":")+1);
		pmMinEnd = Integer.parseInt(pmMinEnd_);
	}
	int amOpen = (amHourOpen*60)+amMinOpen;
	int lunOpen = (lunHourOpen*60)+lunMinOpen;
	int lunEnd = (lunHourEnd*60)+lunMinEnd;
	int pmEnd = (pmHourEnd*60)+pmMinEnd;
	

		//System.out.println("amOpen: "+amHourOpen+":"+amMinOpen);
		//System.out.println("lunOpen: "+lunHourOpen+":"+lunMinOpen);
		//System.out.println("lunEnd: "+lunHourEnd+":"+lunMinEnd);
		//System.out.println("pmEnd: "+pmHourEnd+":"+pmMinEnd);
		//System.out.println("amOpen: "+amOpen);
		//System.out.println("lunOpen: "+lunOpen);
		//System.out.println("lunEnd: "+lunEnd);
		//System.out.println("pmEnd: "+pmEnd);
%>
<%-- <%@ include file="/WEB-INF/views/common/header.jsp"%> --%>
<link rel="stylesheet" href="../css/booking-hos.css">
<script src="../js/datepicker.js"></script>

<h2 style="text-align:center">예약시간</h2>
	<% if(amHourOpen != 0 && pmHourEnd != 0) {%>
	<p class="time-title">오전</p>
	<div class="time">
	<% if(amOpen<lunOpen) { %>
		<% for(int i=amOpen; i<lunOpen; i=i+30){ %>
			<input type="button" value="<%= i/60 < 10 ? "0"+i/60:i/60 %>:<%= i%60 < 10 ? "0"+i%60 : i%60%>">
		<% } %>
	<% } else {%>
		<h4 style="text-align: center">오전 진료가 없습니다.</h4>
	<% } %>
	</div>
	<p class="time-title">오후</p>
	<div class="time">
	<% if(lunEnd < pmEnd){ %>
		<% for(int i=lunEnd; i<pmEnd; i=i+30){ %>
			<input type="button" value="<%= i/60 < 10 ? "0"+i/60:i/60 %>:<%= i%60 < 10 ? "0"+i%60 : i%60%>">
		<% } %>
	<% } else {%>
		<h4 style="text-align: center">오후 진료가 없습니다.</h4>
	<% } %>
	</div>
	<% } else {%>
		<h4 style="text-align: center; margin-top:150px;">해당 병원의 휴무일입니다.</h4>
	<% } %>
<script>
	$(function() {
			let today = new Date();
			let time = today.getHours()+":"+today.getMinutes() 
	 		let times = today.getHours()*60 + today.getMinutes() 
	 		//console.log(times);
				let iArr = $(".time input:button");
				
			/* 예약된 예약시간 disabled */
			<% if(blist != null) {
 				for(Booking b : blist) { 
				Date cal = Date.valueOf(year+"-"+mon+"-"+day);
					if(cal.equals(b.getBookingDate())) {%>
						for(let i=0; i<iArr.length; i++) { 
					 		new Date(iArr[i].value);
							if(iArr[i].value=="<%= b.getBookingTime() %>"){
								$(iArr[i]).attr('disabled', true);
							};
						 };
					<% } %>
				<% } %>
			<% } %>
			
			/* 금일 지난 예약시간 disabled */
			for(let i=0; i<iArr.length; i++) {
				let btnTime = (iArr[i].value.substr(0,2) * 60) + (iArr[i].value.substr(3,5)*1);
				if (<%= day %>==today.getDate() && btnTime < times){
					$(iArr[i]).attr('disabled', true);
				}
			};
			
			/* 7/15 변경내용 */
			$(".time").on('click','input:button',function() {
				bookingTime = $(this).val();
				$("[name=bookingTime]").attr('value', $(this).val());
				$(".modal").children().eq(3).html("예약 시간 : "+$(this).val());
				
				/* $(".time").find("input").css({
					"background-color" : "white",
					"color" : "black"
				}); */
				$(".time").find("input[disabled!=disabled]").css({
					"background-color" : "white",
					"color" : "black"
				});
				
				/* $(".time").find("input[disabled='disabled']").css({
					"background-color" : "white",
					"color" : "(rgba(16, 16, 16, 0.3), rgb(170, 170, 170)"
				}); */
				
				$(this).css({
					"background-color" : "#4286f4",
					"color" : "white"
				});
				//console.log(bookingTime);
			});
	});

</script>