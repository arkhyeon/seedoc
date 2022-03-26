<%@page import="member.model.vo.User"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="hospital.model.vo.Hospital"%>
<%@page import="hospital.model.vo.HospTime"%>
<%@page import="hospital.model.vo.HospFile"%>
<%@page import="hospital.model.vo.HospDoctor"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	User user = (User)request.getAttribute("user");
	Hospital hosp = (Hospital)request.getAttribute("hosp");
	List<HospDoctor> doclist = (List<HospDoctor>)request.getAttribute("doclist");
	List<HospFile> hfList = (List<HospFile>)request.getAttribute("hflist");
	HospTime ht = (HospTime)request.getAttribute("ht");
	
	String birth = null;
	if("1".equals(user.getUserBirth().substring(7)) || "2".equals(user.getUserBirth().substring(7))){
		birth = "19"+ user.getUserBirth().substring(0, 6);
	} else {
		birth = "20"+ user.getUserBirth().substring(0, 6);
	}
	
	//System.out.println(birth);
	birth = birth.substring(0,4) + "-" + birth.substring(4,6) + "-" + birth.substring(6);
	//System.out.println(birth);
%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="../css/booking-hos.css">
<script src="../js/datepicker.js"></script>
<section>
	<div class="bk-logo-wrap">
		<div class="hos-logo">
		        <% for(HospFile hf: hfList) { %>
	        		<% if("logo".equals(hf.getUse()) && hf.getBoardOriginalFileName()!=null){ %>
	        			<img src="<%=request.getContextPath() %>/upload/hospital/<%=hf.getBoardRenamedFileName() %>" alt="">
		        	<% } else if("logo".equals(hf.getUse()) && hf.getBoardOriginalFileName()==null){ %>
		        		<img src="../img/default-logo.png" alt="" style="width: 200px; margin-top: 130px;">
	        		<% } %>
	        		<% if("thumbnail".equals(hf.getUse()) && hf.getBoardOriginalFileName()!=null){ %>
	        			<img src="<%=request.getContextPath() %>/upload/hospital/<%=hf.getBoardRenamedFileName() %>" alt="">
		        	<% } else if("thumbnail".equals(hf.getUse()) && hf.getBoardOriginalFileName()==null){ %>
		        		<img src="../img/default-thumbnail.png" alt="" style="width: 200px; margin-top: 130px;">
	        		<% } %>
        		<% } %>
		</div>
		<div class="opa-back"></div>
	</div>
	<h1 class="title">
		<span>●</span> 병원 의사
	</h1>
	<div class="bk-main-wrap">
		<div class="doc-wrap">
			<% for(HospDoctor hd : doclist) {%>
			<div class="doc-card">
				<div class="doc-img">
					<% for(HospFile fl : hfList) {
 		            		if(fl.getDoctorNo() != null) {
                				if((fl.getDoctorNo()).equals(hd.getDoctorNo())) { 
                					if(fl.getBoardOriginalFileName() != null) { 
                				%>
										<img alt="의사이미지" src="<%=request.getContextPath() %>/upload/hospital/<%=fl.getBoardRenamedFileName() %>">
                					<%}else { %>
										<img alt="의사이미지" src="<%=request.getContextPath() %>/img/doctor.png">
                	<%				}
				 				}
				 			}
						}%>
				</div>
				<div class="doc-info">
					<h1><%= hd.getDoctorName() %></h1>
					<p>[진료과]</p>
					<p><%= hd.getHospDept() %></p>
					<% if(hd.getDoctorTreat()!=null){ %>
					<p>[진료내용]</p>
					<p><%= hd.getDoctorTreat() %></p>
					<% } %>
				</div>
				<div class="doc-button">				
					<input type="hidden" name="doctorNoView" value="<%= hd.getDoctorNo() %>"/>
					<input type="button" value="진료예약" id="doctor-select"/>
				</div>
			</div>
			<% } %>
		</div>
		<div class="bk-info-wrap">
			<div class="bk-title">날짜입력<span>
                        <img src="../img/check-off.png" alt="">
                            	필수입력</span>
                    </div>
			<table id="calendar">
				<tr class="cal-title">
					<th colspan="2" style="text-align: right;">
						<label onclick="prevCalendar()">
						<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="7px" height="11px">
	                    <path fill-rule="evenodd" fill="rgb(55, 59, 68)" d="M2.983,5.500 L6.014,8.530 C6.372,8.889 6.372,9.471 6.014,9.830 C5.655,10.188 5.073,10.188 4.715,9.830 L1.511,6.626 C1.262,6.638 1.009,6.556 0.818,6.366 C0.583,6.130 0.517,5.801 0.591,5.500 C0.517,5.198 0.583,4.869 0.818,4.634 C1.009,4.443 1.262,4.361 1.512,4.373 L4.715,1.170 C5.073,0.811 5.655,0.811 6.014,1.170 C6.372,1.529 6.372,2.110 6.014,2.469 L2.983,5.500 Z" />
	                    </svg>
						</label>
					</th>
					<th id="tbCalendarYM" colspan="3">yyyy년 m월</th>
					<th colspan="2" style="text-align: left;">
						<label onclick="nextCalendar()"> 
						<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="7px" height="11px">
	                    <path fill-rule="evenodd" fill="rgb(55, 59, 68)" d="M6.026,6.397 C5.835,6.588 5.582,6.670 5.332,6.657 L2.129,9.861 C1.770,10.219 1.188,10.219 0.830,9.861 C0.471,9.502 0.471,8.920 0.830,8.562 L3.860,5.531 L0.830,2.500 C0.471,2.142 0.471,1.560 0.830,1.201 C1.188,0.843 1.770,0.843 2.129,1.201 L5.332,4.405 C5.582,4.392 5.835,4.474 6.026,4.665 C6.261,4.900 6.326,5.230 6.252,5.531 C6.326,5.833 6.261,6.161 6.026,6.397 Z" />
	                    </svg>
						</label>
					</th>
				</tr>
				<tr>
					<th style="text-align: center; color: #ff5d5d;">일</th>
					<th>월</th>
					<th>화</th>
					<th>수</th>
					<th>목</th>
					<th>금</th>
					<th style="text-align: center; color: #427cff;">토</th>
				</tr>
			</table>
			<script language="javascript" type="text/javascript">
				buildCalendar(); //
			</script>
			
			<div class="time-wrap">
			<h2 style="text-align:center">예약시간</h2>
				<h4 style="text-align: center; margin-top:150px;">예약일을 선택해주세요.</h4>
			</div>
			<div class="bk-info">
                    <div class="bk-title">추가정보<span>
                        <img src="../img/check-off.png" alt="">
                            	필수입력</span>
                    </div>
                    <div class="bk-info-main">
                        
                        <form action="<%= request.getContextPath() %>/booking/bookingInsert" name="bookingInsertFrm" method="post">
                        <p class="item-title"><img src="../img/check-on.png" alt="">생년월일</p>
                        <input type="date" class="user-input check-input" name="birth" value="<%= birth %>">
                        <p class="item-title choice"><img src="../img/check-on.png" alt="">연락처</p>
                        <input type="text" name="phone" value="<%= user.getUserPhone() %>" placeholder="연락처">
                        <p class="item-title choice"><img src="../img/s-round.png" alt="">이메일</p>
                        <input type="text" name="email" value="<%= user.getUserEmail() %>" placeholder="이메일">
                        <p class="item-title choice">
                            <img src="../img/s-round.png" alt="">증상
                        </p>
                        <textarea name="sysptom" id="" cols="30" rows="10" placeholder="아픈 증상을 적어주세요"></textarea><br />
                        <h3>&lt;예약안내 공지사항&gt;</h3>
                        <p class="notice">
				         1. 기본수집항목: [필수] 아이디, 이름, (휴대)전화번호, [선택] 이메일 주소 , 증상</p>
						 <p class="notice">2. 수집 및 이용목적 : 사업자회원과 예약이용자의 원활한 거래 진행, 고객상담, 불만처리 등 민원 처리, 분쟁조정 해결을 위한 기록보존</p>
						 <p class="notice">3. 보관기간 : 회원탈퇴 등 개인정보 이용목적 달성 시까지 보관</p>
						 <p class="notice">4. 동의 거부권 등에 대한 고지: 정보주체는 개인정보의 수집 및 이용 동의를 거부할 권리가 있으나, 이 경우 상품 및 서비스 예약이 제한될 수 있습니다.</p>
                        <span id="check-reg">
                        <input type="checkbox" name="agree" id="agree">
                        <label class="agree-label" for="agree">이용자 약관 전체동의</label>
                        </span>
                        <!-- <span><img src="../img/w-check.png" alt=""> 필수입력</span><br /> -->
                        <input class="reg-btn" type="button" value="예약" >
                        <input type="hidden" name="userId" value="<%= user.getUserId() %>"/>
                        <input type="hidden" name="hospId" value="<%= hosp.getHospId() %>"/>
                        <input type="hidden" name="doctorNo" value=""/>
                        <input type="hidden" name="doctorName" value=""/>
                        <input type="hidden" name="userName" value="<%= user.getUserName() %>"/>
                        <input type="hidden" name="bookingDate" value=""/>
                        <input type="hidden" name="bookingTime" id="bookingTime" value=""/>
                        </form>
                    </div>
                </div>
		</div>
	</div>
</section>
	<div class="modal_back cancle"></div>
    <div class="modal">
        <h1>예약확인</h1>
        <p>예약자 : <%=user.getUserId() %></p>
        <p>예약 날짜 : </p>
        <p>예약 시간 : </p>
        <p>생년월일: </p>
        <p>전화번호(환자): <%= user.getUserPhone() %></p>
        <p>병원 : <%= hosp.getHospName() %></p>
        <p>전화번호: <%= hosp.getHospTel() %></p>
        <p>담당의사 : </p>
        <!-- <a href="../index.html"><input type="button" id="btn-insert" value="확인"></a> -->
        <input type="button" id="btn-insert" class="check-btn" value="확인">
        <input type="button" class="check-btn cancle" value="취소" >
    </div>
<script>
	$(".time").find("input").click(function() {
		$(".time").find("input").css({
			"background-color" : "white",
			"color" : "black"
		});
		$(this).css({
			"background-color" : "#4286f4",
			"color" : "white"
		});
	});
	
	
$(function (){
	var doctorNo = "";
	var doctorName = "";
/* 	var bookingDate = ""; */
	var bookingTime = "";


	
	/* 의사 클릭시 의사번호, 의사이름 변수에 담기 */
 	$(".doc-button").on('click','input:button',function() {
		$("[name=doctorNo]").attr('value', $(this).prev().val());
		$("[name=doctorName]").attr('value', $(this).parent().prev().find("h1").text());
		$(".modal").children().eq(8).html("담당의사 : "+$(this).parent().prev().find("h1").text()+" 의사");
		doctorNo = $(this).prev().val();
		console.log(doctorNo);
		$(".doc-card").css("border-color","#ebebeb");
		$(this).parent().parent().css("border-color","#4286f4");
/* 		doctorName = $(this).parent().prev().find("h1").text();
		console.log(doctorName); */
	});

	/* 달력 클릭시 예약 시간 변경 */
	$("#calendar").on('click','td',function() {
		/* 의사 선택 없이 캘린더 선택시 알림 */
		if($("[name=doctorNo]").val() == "" && $("[name=doctorName]").val() == ""){
			alert("진료 받을 의사를 선택해주세요.");
			return;
		}
		
		let year = $("#tbCalendarYM").text().substr(0,$("#tbCalendarYM").text().indexOf("."));
		let mon = $("#tbCalendarYM").text().substr($("#tbCalendarYM").text().indexOf(".")+1)<10?"0"+$("#tbCalendarYM").text().substr($("#tbCalendarYM").text().indexOf(".")+1):$("#tbCalendarYM").text().substr($("#tbCalendarYM").text().indexOf(".")+1);
		let days = $("#calendar td.on").text().replace(/[^0-9]/g,'');
		let day = days <10 ? "0"+days:days;
		let date = year+mon+day; //20200709
		
		let week=new Date(year, mon-1, day);
		let bookingDate = year+"-"+mon+"-"+day;
		
		//정보 확인창용
		$("[name=bookingDate]").attr('value', year+"-"+mon+"-"+day);
		$(".modal").children().eq(2).html("예약날짜 : "+year+"."+mon+"."+day);
		
		// 0:일요일, 1:월, 2:화, 3:수, 4:목, 5:금, 6:토 
		$.ajax({
			url:"<%= request.getContextPath() %>/booking/bookingCalendar",
			method: "Post",
			dataType: "html",
			data: {week:week.getDay(), year: year, mon:mon, day:day, 
				hospId:"<%= hosp.getHospId() %>", doctorNo:doctorNo},
			success: function(data) {
		        let today = new Date();
		        
		        if(year == today.getFullYear() &&  mon == today.getMonth()+1 && day < today.getDate()
	            		|| year == today.getFullYear() &&  mon < today.getMonth()+1 
	            		|| year < today.getFullYear()){
		        	$(".time-wrap").html("<h2 style='text-align:center'>예약시간</h2><h4 style='text-align: center; margin-top:150px;'>지난 예약 일자입니다.</h4>");
		        	console.log(data);
		        }else{
					$(".time-wrap").html(data);
		        }
			},
			error: function(xhr, textStatus, errorThrown) {
				console.log("ajax 요청 실패!");
				console.log(xhr, textStatus, errorThrown);
			}
			
		});
		
	});
	
	/* 약관동의 */
	$(".reg-btn").click(function () {
				
		if($("[name=doctorNo]").val() == "" && $("[name=doctorName]").val() == ""){
			alert("진료 받을 의사를 선택해주세요.");
			return;
		}

  		if($("[name=bookingDate]").val() == ""){
			alert("진료 받을 일정을 선택해주세요.");
			return;
		}

		if($("[name=bookingTime]").val() == ""){
			alert("진료 받을 시간을 선택해주세요.");
			return;
		}
		
		if($("[name=birth]").val() == "" ) {
			alert("생년월일을 입력해주세요.");
			return;
		}
		
		if($("[name=phone]").val() == "") {
			alert("핸드폰 번호를 입력해주세요.");
			return;
		}
		
		/* 7/15 변경 */
		var regExp = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
		if(!regExp.test($("[name=phone]").val())) {
			alert("핸드폰 번호를 다시 확인해주세요.");
			return;
		}
		
		if($("[name=agree]").is(":checked") == true){
			$(".modal").children().eq(4).html("생년월일: "+$("[name=birth]").val());
	        $(".modal").css("display", "block");
	        $(".modal_back").css("display", "block");	
		}else {
			alert("이용자 약관 동의을 확인해주세요.");
			return;
		}
		
	    /* 예약 확인창 확인 버튼 클릭시 submit 처리 */
		$("#btn-insert").click(function(){
			$("[name=bookingInsertFrm]").submit();
		});
		
    });
    $(".cancle").click(function () {
        $(".modal").css("display", "none");
        $(".modal_back").css("display", "none");
    });
		
	$("#앷색-")
});
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>