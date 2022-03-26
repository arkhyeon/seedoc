<%@page import="reviewBoard.model.vo.Review"%>
<%@page import="hospital.model.vo.HospFile"%>
<%@page import="hospital.model.vo.HospTime"%>
<%@page import="hospital.model.vo.Hospital"%>
<%@page import="hospital.model.vo.HospDoctor"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	List<Review> list = (List<Review>) request.getAttribute("list");
	List<HospDoctor> doctor = (List<HospDoctor>)request.getAttribute("doctor");
	Hospital hosp = (Hospital)request.getAttribute("hosp");
	HospTime time = (HospTime)request.getAttribute("time");
	List<HospFile> file = (List<HospFile>)request.getAttribute("file");
	HospFile logo = (HospFile)request.getAttribute("logo");
	List<HospFile> thumbnail = (List<HospFile>)request.getAttribute("thumbnail");
%>
<script>
	//score계산
	var totalScore = 0;
	var cntScore = 0;
	var cntScoreArr = [ 0, 0, 0, 0, 0 ];
<%for (Review r : list) {
if(r.getReviewRef() ==0){%>
	totalScore +=<%=r.getReviewRank()%>;
	switch (<%=r.getReviewRank()%>) {
	case 1:
		cntScoreArr[0]++;
		break;
	case 2:
		cntScoreArr[1]++;
		break;
	case 3:
		cntScoreArr[2]++;
		break;
	case 4:
		cntScoreArr[3]++;
		break;
	case 5:
		cntScoreArr[4]++;
		break;
	}
	cntScore++;
<%}}%>
	$(function() {
		//총 별점 나타내기
		let valueArr = document.getElementsByClassName("value");
		let score = document.getElementById("score");

		score.innerHTML = (totalScore / cntScore).toFixed(1) == "NaN" ? 0 : (totalScore / cntScore).toFixed(1);
		valueArr[0].style.width = (totalScore / cntScore) * 20 + "%";
		//각 별점 나타내기
		for (var i = 1; i <= 5; i++) {
			let point = document.getElementById("point-" + i);
			point.value = (((cntScoreArr[i - 1]) / cntScore) * 100);
		}
		//대댓글
		$(".btn-reply").click(function(){
			let $replyWrap = $("<div class='reply-wrap'></div>");
			let $reply = $("<div class='reply' style='display:none; text-align:left;'></div>");
			let $frm = $("<form action='<%=request.getContextPath() %>/board/writeReview' method='POST'></form>");
			let $boardCommentTr = $(this);
			<%for (Review r : list) {%>
			if(<%= r.getReviewNo() %> == $(this).val()){

			$frm.append("<input type='hidden' name='boardRef' value='<%= r.getReviewNo() %>' />");
			$frm.append("<input type='hidden' name='boardCommentWriter' value='<%= hosp.getHospId()%>' />");
			$frm.append("<input type='hidden' name='hospId' value='<%= hosp.getHospId()%>' />");
			$frm.append("<input type='hidden' name='reviewLevel' value='2' />");
			$frm.append("<input type='hidden' name='bookingNo' value='<%= r.getBookingNo()%>' />");
			$frm.append("<input type='hidden' name='reviewRank' value='0' />");
			$frm.append("<input type='hidden' name='reviewRef' value='"+$(this).val()+"' />");
			$frm.append("<textarea name='reviewCon' cols=60 rows=3></textarea>");
			$frm.append("<button type='submit' class='btn-reply' style='display:block;'>등록</button>");
			
			$reply.append($frm);
			$replyWrap.append($reply);
			$replyWrap.insertAfter($boardCommentTr)
			   .children($reply).slideDown(800)
			   .children("form").submit(function(){
				   let $textarea = $(this).find("textarea");
				   if($textarea.val().length == 0){
					   return false;
				   }
			   })	
			   .children("textarea").focus();
			}
			<%}%>
		//1회만 작동하도록함.
		$(this).off("click");
	});
	});
</script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/hospital.css">
<section class="slide-wrap">
	<div class="slider">
		<div class="slide_viewer">
			<div class="slide_group">
				<% for(HospFile t : thumbnail){ %>
				<% if(t.getBoardOriginalFileName() == null){ %>
						<div style="background: url('../img/hospMain-base.jpg');background-size: cover;" class="slide"></div>
					<% } else {%>
						<div style="background: url('../upload/hospital/<%= t.getBoardRenamedFileName() %>');background-size: cover;" class="slide"></div>
					<% }%>
				<% } %>
			</div>
		</div>
	</div>
	<!-- End // .slider -->
	<div class="back-opa"></div>
	<div class="slide_buttons"></div>

	<div class="directional_nav">
		<div class="previous_btn" title="Previous">
			<svg xmlns="http://www.w3.org/2000/svg"
				xmlns:xlink="http://www.w3.org/1999/xlink" width="43px"
				height="81px">
                    <defs>
                        <filter id="Filter_0">
                            <feFlood flood-color="rgb(255, 255, 255)"
					flood-opacity="1" result="floodOut" />
                            <feComposite operator="atop" in="floodOut"
					in2="SourceGraphic" result="compOut" />
                            <feBlend mode="normal" in="compOut"
					in2="SourceGraphic" />
                        </filter>

                    </defs>
                    <g filter="url(#Filter_0)">
                        <path fill-rule="evenodd" fill="rgb(55, 59, 68)"
					d="M38.973,7.729 L7.773,38.929 C7.144,39.558 6.504,40.108 5.874,40.594 C6.504,41.079 7.144,41.629 7.772,42.257 L38.973,73.457 C41.844,76.329 43.353,79.477 42.342,80.487 C41.332,81.498 38.185,79.989 35.313,77.118 L4.113,45.917 C2.993,44.798 2.084,43.638 1.448,42.577 C1.165,42.545 0.914,42.471 0.743,42.300 C0.395,41.952 0.352,41.348 0.553,40.593 C0.352,39.839 0.395,39.235 0.743,38.887 C0.914,38.716 1.165,38.642 1.448,38.610 C2.084,37.550 2.993,36.390 4.113,35.270 L35.313,4.070 C38.184,1.198 41.332,-0.311 42.343,0.700 C43.353,1.710 41.845,4.858 38.973,7.729 Z" />
                    </g>
                </svg>
		</div>
		<div class="next_btn" title="Next">
			<svg xmlns="http://www.w3.org/2000/svg"
				xmlns:xlink="http://www.w3.org/1999/xlink" width="43px"
				height="81px">
                    <defs>
                        <filter id="Filter_0">
                            <feFlood flood-color="rgb(255, 255, 255)"
					flood-opacity="1" result="floodOut" />
                            <feComposite operator="atop" in="floodOut"
					in2="SourceGraphic" result="compOut" />
                            <feBlend mode="normal" in="compOut"
					in2="SourceGraphic" />
                        </filter>

                    </defs>
                    <g filter="url(#Filter_0)">
                        <path fill-rule="evenodd" fill="rgb(55, 59, 68)"
					d="M42.541,40.594 C42.742,41.348 42.698,41.952 42.351,42.300 C42.179,42.471 41.928,42.545 41.646,42.577 C41.009,43.637 40.101,44.797 38.981,45.917 L7.781,77.117 C4.909,79.989 1.762,81.498 0.751,80.487 C-0.260,79.476 1.249,76.329 4.121,73.457 L35.321,42.257 C35.950,41.628 36.590,41.079 37.219,40.593 C36.590,40.107 35.950,39.558 35.321,38.930 L4.121,7.730 C1.249,4.858 -0.259,1.710 0.751,0.699 C1.762,-0.311 4.909,1.197 7.781,4.069 L38.981,35.269 C40.101,36.389 41.009,37.549 41.646,38.610 C41.929,38.642 42.179,38.716 42.351,38.887 C42.698,39.235 42.742,39.839 42.541,40.594 Z" />
                    </g>
                </svg>
		</div>
		<div class="main-wrap">
			<div class="main-box">
				<div class="hos-title">
			<% if(logo.getBoardOriginalFileName()==logo.getBoardRenamedFileName()){ %>
					<p style="font-size: 39px; margin-top: 100px; font-weight: 800; color: white;"><%=hosp.getHospName() %></p>
			<% } else {%>
					<img src="<%=request.getContextPath()%>/upload/hospital/<%= logo.getBoardRenamedFileName() %>" alt="">
			<% }%>
				</div>
				<% if(userLoggedIn != null) {%>
				<a href="<%= request.getContextPath() %>/booking/bookingfrm?hospId=<%= hosp.getHospId() %>&userId=<%= userLoggedIn.getUserId() %>">
					<div class="res-btn btn">병원 예약하기</div>
				</a>
				<% } %>
			</div>
		</div>
	</div>
	<!-- End // .directional_nav -->
</section>
<section class="hosinfo-wrap">
	<p class="title">
		<span>●</span> 병원소개
	</p>
	<div class="hos-main">
		<div class="hos-logo">
			<% if(logo.getBoardOriginalFileName()==logo.getBoardRenamedFileName()){ %>
					<p style="font-size: 39px; margin-top: 100px; font-weight: 800; color: #4286f4;"><%=hosp.getHospName() %></p>
			<% } else {%>
					<img src="<%=request.getContextPath()%>/upload/hospital/<%= logo.getBoardRenamedFileName() %>" alt="">
			<% }%>
		</div>
		<div class="hos-info">
			<h2><%=hosp.getHospName() %></h2>
			<br> <img src="<%=request.getContextPath()%>/img/address.png"
				alt="">
			<p><%=hosp.getHospAddr() %></p>
			<br> <img src="<%=request.getContextPath()%>/img/call.png"
				alt="">
			<p><%=hosp.getHospTel() %></p>
			<br> <img src="<%=request.getContextPath()%>/img/docicon.png"
				alt="">
			<p>
				<%=hosp.getHospInfo() %>
				<br> <br />
				[영업시간] 
				<br />
				월 : <%= time.getMonOpen() == null ? "휴무": time.getMonOpen() + " ~ " +time.getMonEnd() %>&nbsp;
				화 : <%= time.getTueOpen() == null ? "휴무": time.getTueOpen() + " ~ " +time.getTueEnd() %>&nbsp;
				수 : <%= time.getWedOpen() == null ? "휴무": time.getWedOpen() + " ~ " +time.getWedEnd() %>
				<br />
				목 : <%= time.getThuOpen() == null ? "휴무": time.getThuOpen() + " ~ " +time.getThuEnd() %>&nbsp;
				금 : <%= time.getFriOpen() == null ? "휴무": time.getFriOpen() + " ~ " +time.getFriEnd() %>&nbsp;
				토 : <%= time.getSatOpen() == null ? "휴무": time.getSatOpen() + " ~ " +time.getSatEnd() %>
				<br />
				일 : <%= time.getSunOpen() == null ? "휴무": time.getSunOpen()+ " ~ " +time.getSunEnd()%>&nbsp;
				 <br>
				점심시간 : <%= time.getLunOpen() == null ? "점심시간 없음": time.getLunOpen()+ " ~ " +time.getLunEnd()%>
				<br> <br> 
				편의시설 :	<%=hosp.getHospConv() %>
			</p>
			<div class="btn-wrap">
				<a href="#">
						<a href="" onclick="window.open(url_combine_naver, '', 'scrollbars=no, width=600, height=600'); return false;">
					<div class="hos-infobtn btn" style="background-color:white;color:black;text-align:left;">
						공유하기
							<img src="https://www.naver.com/favicon.ico" class="sharebtn_custom" style="width: 32px; height:32px; margin:9px 14px 9px;">
					</div>
						</a>
				</a>
			</div>
		</div>
	</div>
</section>
<script async>
var url_this_page = "http://localhost:9907/SeeDoc/hospital/hospital?hospId=hospital1"; 
var title_this_page = document.title;

var url_default_naver = "http://share.naver.com/web/shareView.nhn?url="; 
var title_default_naver = "&title=";
var url_combine_naver = url_default_naver + encodeURI(url_this_page) + title_default_naver + encodeURI(title_this_page);

</script>
<section class="docinfo-wrap">
	<div id="docinfo-box" class="docinfo-box">
		<p class="title">
			<span>●</span> 의료진 소개
		</p>
		<form action="" id="doctorSetRows">
			<input type="hidden" name="doctorRowPerPage" value="4">
		</form>
		<% for(HospDoctor d : doctor){ 
				%>
		<div class="doc-card">
				<% if(!file.isEmpty()) { 
                		for(HospFile f : file) {
 		            		if(f.getDoctorNo() != null) {
                				if((f.getDoctorNo()).equals(d.getDoctorNo())) { 
                					if(f.getBoardOriginalFileName() != null) { 
                				%>
										<img alt="의사이미지" src="<%=request.getContextPath() %>/upload/hospital/<%=f.getBoardRenamedFileName() %>">
                					<%}else { %>
										<img alt="의사이미지" src="<%=request.getContextPath() %>/img/doctor.png">
                	<%				}
				 				}	
							} else {%>
					                <%-- <div class="doc-img">
										<img alt="의사이미지" src="<%=request.getContextPath() %>/img/doctor.png">
                					</div> --%>
					<% 		}
 		            	}
                	} else {%>
						<img alt="의사이미지" src="<%=request.getContextPath() %>/img/doctor.png">
                	<% } %>
			<div class="doc-info">
				<h3><%=hosp.getHospName() %></h3>
				<br>
				<h2>
					<%= d.getDoctorName() %> 교수<span>[<%= d.getHospDept() %>]</span>
				</h2>
				<br>
				<p>[진료분야]</p>
				<p>
					<%= d.getDoctorTreat() %>
				</p>
			</div>
		</div>
		<% } %>
	</div>
</section>
	<script src="<%=request.getContextPath()%>/js/doctorPaging.js"></script>
<section class="eval-wrap">
	<div class="eval-star">
		<h3>고객만족도</h3>


		<span class="bg"> <em class="value"></em>
		</span>
		<p class="star-point">
			평점 : <span id="score"></span> / 5.0
		</p>
		<div class="bar-wrap">
			<progress id="point-5" max="100" value="0"></progress>
			<label for="point-5">5점</label>
			<progress id="point-4" max="100" value="0"></progress>
			<label for="point-4">4점</label>
			<progress id="point-3" max="100" value="0"></progress>
			<label for="point-3">3점</label>
			<progress id="point-2" max="100" value="0"></progress>
			<label for="point-2">2점</label>
			<progress id="point-1" max="100" value="0"></progress>
			<label for="point-1">1점</label>
		</div>

	</div>
	<div class="eval-bbc">
		<div id="products">
			<form action="" id="setRows">
				<input type="hidden" name="rowPerPage" value="3">
			</form>
			<%
				if (list == null || list.isEmpty()) {
			%>
			<%--조회된 행이 없는 경우 --%>
			<p>조회된 행이 없습니다.</p>
			<%
				} else {

					for (Review r : list) {
						if(r.getReviewRef()==0){
			%>
			<%--조회된 행이 있는 경우 --%>
			<div class="eval-contents">
				<img class="person-img" src="<%=request.getContextPath()%>/img/emoji<%=r.getReviewRank()%>.png" alt="" />
				<h3>
					<%
						String[] idArr = r.getUserId().split("");
								String secretId = "";
								for (int i = 0; i < idArr.length; i++) {
									if (i % 2 == 0) {
										idArr[i] = "*";
									}
									secretId += idArr[i];
								}
					%>
					<%=secretId%>
				</h3>
				<img src="<%=request.getContextPath()%>/img/star<%=r.getReviewRank()%>.png"	alt="">
				<p><%=r.getReviewCon()%></p>
				<% boolean hasComment = true;
					for(Review r1 : list){ 
					if(r.getReviewNo()==r1.getReviewRef()){ hasComment = false;%>
										
				<%}} if(hasComment && hospLoggedIn != null){
						if(hospLoggedIn.getHospId().equals(hosp.getHospId())){%>
				<button class="btn-reply" value="<%= r.getReviewNo() %>">리뷰답글</button>
				<%}} for(Review r1 : list){
				if(r.getReviewNo()==r1.getReviewRef()){ %>
				<div class="review-reply">
					<img src="<%=request.getContextPath()%>/upload/hospital/<%=logo.getBoardRenamedFileName() %>" alt="">
					<h3><%= hosp.getHospId() %></h3>
					<p><%= r1.getReviewCon() %></p>
				</div>
				<% if(hospLoggedIn != null){
					if(hospLoggedIn.getHospId().equals(hosp.getHospId())){ %>
			<form action='<%=request.getContextPath() %>/board/deleteReview' method='POST'>
				<button class="btn-delete" value="<%= r1.getReviewNo() %>">삭제</button>
				<input type="hidden" name="reviewNo" value="<%= r1.getReviewNo() %>"/>
				<input type="hidden" name="hospId" value="<%= r.getHospId() %>"/>
			</form>
			<%}}}}
				%>
			</div>
			
			<%}
				}
				}
			%>
		</div>
		<script src="<%=request.getContextPath()%>/js/paging.js"></script>
	</div>
</section>
<section class="loc-wrap">
	<p class="title">
		<span>●</span> 위치정보
	</p>
	<div id="map" style="width:100%;height:350px;"></div>
	<h2><%=hosp.getHospName() %></h2>
	<p><%=hosp.getHospAddr() %></p>
	<a href="tel"><%=hosp.getHospTel() %></a>
</section>
<script type="text/javascript" 	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fb0204adc292a3c2b98ea0c6ea7fb60c&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 5 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
geocoder.addressSearch("<%=hosp.getHospAddr() %>", function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;"><%=hosp.getHospName()%></div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});    
</script>
<script src="<%=request.getContextPath()%>/js/slide.js"></script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>