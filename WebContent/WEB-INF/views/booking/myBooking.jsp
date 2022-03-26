<%@page import="booking.model.vo.BookingCount"%>
<%@page import="booking.model.vo.BookingAdd"%>
<%@page import="booking.model.vo.Booking"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% List<BookingAdd> list = (List<BookingAdd>)request.getAttribute("list"); 
	BookingCount bc = (BookingCount)request.getAttribute("bc");
	User user = (User)request.getAttribute("user");
	String pageBar = (String)request.getAttribute("pageBar");
	//System.out.print("jsp"+user);
%>
    <%@ include file="/WEB-INF/views/common/header.jsp"%>
    <link rel="stylesheet" href="../css/myBooking.css">
<script>
$(function(){
	$("#btn-total").click(function() {
		location.href="<%= request.getContextPath() %>/booking/bookinglist?userId=<%= user.getUserId() %>";
	});
	$("#btn-approval").click(function() {
		let $frm = $("[name=bookingStateFrm]");
		$frm.children("[name=state]").val("A");
		$frm.submit();
	});
	$("#btn-finish").click(function() {
		let $frm = $("[name=bookingStateFrm]");
		$frm.children("[name=state]").val("F");
		$frm.submit();
	});
	$("#btn-cancle").click(function() {
		let $frm = $("[name=bookingStateFrm]");
		$frm.children("[name=state]").val("C");
		$frm.submit();
	});
	
	/* hospital review  */
	let rank = document.getElementById("rank-wrap").childNodes;
	let star = document.getElementById("star");
	let point = document.getElementById("point");
	let value = document.getElementsByName("reviewRank");
	let text = document.getElementById("text");
	let $rank = $("input[name=reviewRank]");
	
	$(".review-btn").click(function() {
		$("#bookingNo").val($(this).parent().find("[name=bookingNo]").val());
		$("#userId").val($(this).parent().find("[name=userId]").val());
		$("#hospId").val($(this).parent().find("[name=hospId]").val());
	});
	
	rank[1].onclick = function(){
		star.style.width = "23%";
		$rank.val('1');
		point.innerHTML= "1점";
		text.innerHTML = "최악입니다";
	}
	rank[2].onclick = function(){
		star.style.width = "42%";
		$rank.val('2');
		point.innerHTML= "2점";
		text.innerHTML = "별로에요";
	}
	rank[3].onclick = function(){
		star.style.width = "60%";
		$rank.val('3');
		point.innerHTML= "3점";
		text.innerHTML = "괜찮아요";
	}
	rank[4].onclick = function(){
		star.style.width = "79%";
		$rank.val('4');
		point.innerHTML= "4점";
		text.innerHTML = "만족합니다";
	}
	rank[5].onclick = function(){
		star.style.width = "100%";
		$rank.val('5');
		point.innerHTML= "5점";
		text.innerHTML = "최고에요";
	}
	$('#reviewCon').keyup(function (e){
		var content = $(this).val();
        $('#counter').html(content.length + '/300자');
        if(content.length>300){
    		alert("300자 제한입니다.");
        	$(this).val($(this).val().substr(0, 300));
        	$('#counter').html(300 + '/300자');
        	$('#counter').css("color","black");
        }
      });
      $('#reviewCon').keyup();
      
    $(".review-btn").click(function () {
        $(".modal_back").css("display", "block");
        $(".review-wrap").css("display", "block");
    });
    $(".modal_back").click(function () {
        $(".modal_back").css("display", "none");
        $(".review-wrap").css("display", "none");
    });
});
	<% for(BookingAdd b : list) {%>
	function deleteBooking<%=b.getBookingNo() %>(){
		if(confirm("예약을 취소하시겠습니까?")){
			let $deleteFrm = $("[name=deleteBookingFrm<%=b.getBookingNo() %>]");
			$deleteFrm.attr("action", "<%= request.getContextPath() %>/booking/deleteBooking?userId=<%= user.getUserId() %>");
			$deleteFrm.submit();
		}else {
			return;
		}
	}
	<% } %>
	
	<% for(BookingAdd b : list) {%>
	function updateBooking<%=b.getBookingNo() %>(){
		if(confirm("예약을 변경하시겠습니까?")){
			let $deleteFrm = $("[name=updateBookingFrm<%=b.getBookingNo() %>]");
			$deleteFrm.attr("action", "<%= request.getContextPath() %>/booking/updateBookingFrm");
			$deleteFrm.submit();
		}else {
			return;
		}
	}
	<% } %>
	function writeReview(){	
		let url = "<%= request.getContextPath() %>/board/writeReview";
		let title = "updatePasswordPopup";
		let spec = "left=500px, top=200px, width=500px, height=530px";
		
		open(url, title, spec);
	}
</script>
<section>
        <div class="profile-wrap">
            <div class="profile">
                <img src="../img/person1.png" alt="">
                <h1><%= user.getUserName() %>님</h1>
                <p><%= user.getUserId() %></p>
            </div>
            <ul class="res-result">
                <li id="btn-total">
                    <img src="../img/mypage-1.png" alt="">
                    <p>전체</p>
                    <h1><%= bc.getTotal() %></h1>
                </li>
                <li id="btn-approval">
                    <img src="../img/mypage-2.png" alt="" >
                    <p>이용예정</p>
                    <h1><%= bc.getApproval() %></h1>
                </li>
                <li id="btn-finish">
                    <img src="../img/mypage-3.png" alt="">
                    <p>이용완료</p>
                    <h1><%= bc.getFinish() %></h1>
                </li>
                <li id="btn-cancle">
                    <img src="../img/mypage-4.png" alt="">
                    <p>취소</p>
                    <h1><%= bc.getCancle() %></h1>
                </li>
                <form action="<%= request.getContextPath() %>/booking/bookingListApproval" 
                		name="bookingStateFrm" method="get" >
                	<input type="hidden" name="userId" value="<%= user.getUserId() %>"/>
                	<input type="hidden" name="state" />
                </form>
            </ul>
        </div>
        </div>
        <div class="res-wrap">
            <h1><span>●</span> 내 예약</h1>
            <% if(list == null || list.isEmpty()) {%>
            	<div class="res-card" style="text-align:center">
            		<h3>조회된 예약이 없습니다.</h3>
            	</div>
            <% } else { %>
            	<% for(BookingAdd b : list) { %>
	            <div class="res-card">
	                <div class="res-type">
	                    <img src="../img/mypage-3.png" alt="">
	                    <p><%= "A".equals(b.getBookingState())?"이용예정":"F".equals(b.getBookingState())?"이용완료":"취소" %></p>
	                    <% if("A".equals(b.getBookingState())) {%>
	                    <input type="button" value="수정" onclick="updateBooking<%=b.getBookingNo() %>();"/>
	                    <input type="button" value="삭제" onclick="deleteBooking<%=b.getBookingNo() %>();"/>
	                    <% } else if("F".equals(b.getBookingState())){ %>
	                    <input type="button" value="리뷰작성" class="review-btn"/>
	                    <% }%>
	                    <!-- 예약 수정 폼 -->
	                    <form name="updateBookingFrm<%=b.getBookingNo() %>" method="post">
	                    	<input type="hidden" name="bookingNo" value="<%=b.getBookingNo() %>"/>
	                    	<input type="hidden" name="hospId" value="<%=b.getHospId() %>"/>
	                    	<input type="hidden" name="userId" value="<%=b.getUserId() %>"/>
	                    </form>
	                    <!-- 예약 삭제 폼 -->
	                    <form name="deleteBookingFrm<%=b.getBookingNo() %>" method="post">
	                    	<input type="hidden" name="bookingNo" value="<%=b.getBookingNo() %>"/>
	                    	<input type="hidden" name="state" value="C"/>
	                    	<input type="hidden" name="userId" value="<%=b.getUserId() %>"/>
	                    </form>
	                    
	                </div>
	                </div>
	                <div class="res-main">
	                    <p class="res-no">No.<%=b.getBookingNo() %></p>
	                    <h1><%= b.getHospName() %> - <%= b.getDocName() %> 의사</h1>
	                    <p>일정 : <%= b.getBookingDate() %> <%= b.getBookingTime() %></p>
	                    <p>진료 : <%= b.getHospDept() %></p>
	                    <% if((b.getBookingState() != null && "C".equals(b.getBookingState()))
	                    		&& b.getBookingCancel() != null) {%>
	                    <p>취소사유: <%=b.getBookingCancel() %></p>
	                    <% } %>
	                </div>
	            
	            
	            <% } %>
            <% } %>
            <div class="paging">
                <%= pageBar %>
            </div>
        </div>
    </section>
    <div class="modal_back"></div>
    <!-- 예약 리뷰 폼 -->
	<div class="review-wrap">
                <div class="review-top">리뷰작성하기</div>
	<p class="title">진료는 만족하셨나요?</p>
		<!-- 댓글 작성폼 -->
		<div class="review">
			<form action="<%=request.getContextPath()%>/board/writeReview"
				method="post" name="writeReviewFrm">
				<span class="bg"> <em id="star" class="value"></em></span>
				<div id="rank-wrap">
					<a id="1"></a><a id="2"></a><a id="3"></a><a id="4"></a><a id="5"></a>
				</div>
				<p class="point-text"><span id="point">5점</span>&nbsp;(<span id="text">최고에요</span>)</p>
				<p class="review-text">어떤 점이 리뷰를 작성하게 했나요?</p>
				<input type="hidden" name="reviewRank" value="5" /> 
				<input type="hidden" name="reviewWriter" value="hong" /> 
				<input type="hidden" name="reviewLevel" value="1" />
				<input type="hidden" name="reviewRef" value="0" />
				<textarea name="reviewCon" id="reviewCon" cols="60" rows="10"></textarea>
				<span id="counter">###</span>
				<input type="hidden" name="bookingNo" id="bookingNo" value=""/>
                <input type="hidden" name="hospId" id="hospId" value=""/>
                <input type="hidden" name="userId" id="userId" value=""/>
				
				<input type="submit" value="등록" id="write-btn" />
			</form>
		</div>
	</div>
    
    <%@ include file="/WEB-INF/views/common/footer.jsp"%>