<%@page import="java.util.List"%>
<%@page import="hospital.model.vo.HospDoctor"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/style.css" />
<script>
$(function() {
	var cnt = 0;
		
	$(".seoul-lt").click(function() {
		cnt = 0;
		$.ajax({
			url: "<%= request.getContextPath() %>/searchAddr",
			method: "GET",
			dataType: "json",
			data: {
				addr1: "서대문구",
				addr2: "마포구",
				addr3: "용산구",
				addr4: "중구"
				},
			success: function(res) {
				let $ul = $(".work-bot");
				if(res == null || res.length==0) {
					$ul.html("<li class='no-search'>조회된 병원이 없습니다.</li>");
				} else {
					$ul.html("");
					for(let i in res) {
						cnt++;
						let hosp = res[i];
						//사진있을때
						if(hosp.hospInfo!=null)
							$ul.append("<a class='work-card' href='<%=request.getContextPath()%>/hospital/hospital?hospId="+hosp.hospId+"'><li><img src='upload/hospital/"+hosp.hospInfo+"' alt=''><div class='s-info'><p class='hos-title'>"+hosp.hospName+"</p><p>"+hosp.hospAddr+"</p></div></li></a>");
						//사진없을때
						else
							$ul.append("<a class='work-card' href='<%=request.getContextPath()%>/hospital/hospital?hospId="+hosp.hospId+"'><li><img src='img/hos.jpg' alt=''><div class='s-info'><p class='hos-title'>"+hosp.hospName+"</p><p>"+hosp.hospAddr+"</p></div></li></a>");
					}
				}
				paging(cnt);
			},
			error: function(xhr, status, err) {
				console.log(xhr, status, err);
			}
		});
	});
	$(".seoul-lb").click(function() {
		cnt = 0;
		$.ajax({
			url: "<%= request.getContextPath() %>/searchAddr",
			method: "GET",
			dataType: "json",
			data: {
				addr1: "양천구",
				addr2: "관악구",
				addr3: "구로구",
				addr4: "금천구"
				},
			success: function(res) {
				let $ul = $(".work-bot");
				if(res == null || res.length==0) {
					$ul.html("<li class='no-search'>조회된 병원이 없습니다.</li>");
				} else {
						let $ul = $(".work-bot");
						$ul.html("");
					for(let i in res) {
						cnt++;
						let hosp = res[i];
						//사진있을때
						if(hosp.hospInfo!=null)
							$ul.append("<a class='work-card' href='<%=request.getContextPath()%>/hospital/hospital?hospId="+hosp.hospId+"'><li><img src='upload/hospital/"+hosp.hospInfo+"' alt=''><div class='s-info'><p class='hos-title'>"+hosp.hospName+"</p><p>"+hosp.hospAddr+"</p></div></li></a>");
						//사진없을때
						else
							$ul.append("<a class='work-card' href='<%=request.getContextPath()%>/hospital/hospital?hospId="+hosp.hospId+"'><li><img src='img/hos.jpg' alt=''><div class='s-info'><p class='hos-title'>"+hosp.hospName+"</p><p>"+hosp.hospAddr+"</p></div></li></a>");
					}
				}
				paging(cnt);
			},
			error: function(xhr, status, err) {
				console.log(xhr, status, err);
			}
		});
	});
	$(".seoul-rt").click(function() {
		cnt = 0;
		$.ajax({
			url: "<%= request.getContextPath() %>/searchAddr",
			method: "GET",
			dataType: "json",
			data: {
				addr1: "도봉구",
				addr2: "중랑구",
				addr3: "성북구",
				addr4: "성동구",
				addr5: "광진구"
				},
			success: function(res) {
				let $ul = $(".work-bot");
				if(res == null || res.length==0) {
					$ul.html("<li class='no-search'>조회된 병원이 없습니다.</li>");
				} else {
					$ul.html("");
					for(let i in res) {
						cnt++;
						let hosp = res[i];
						//사진있을때
						if(hosp.hospInfo!=null)
							$ul.append("<a class='work-card' href='<%=request.getContextPath()%>/hospital/hospital?hospId="+hosp.hospId+"'><li><img src='upload/hospital/"+hosp.hospInfo+"' alt=''><div class='s-info'><p class='hos-title'>"+hosp.hospName+"</p><p>"+hosp.hospAddr+"</p></div></li></a>");
						//사진없을때
						else
							$ul.append("<a class='work-card' href='<%=request.getContextPath()%>/hospital/hospital?hospId="+hosp.hospId+"'><li><img src='img/hos.jpg' alt=''><div class='s-info'><p class='hos-title'>"+hosp.hospName+"</p><p>"+hosp.hospAddr+"</p></div></li></a>");
					}
				}
				paging(cnt);
			},
			error: function(xhr, status, err) {
				console.log(xhr, status, err);
			}
		});
	});
	$(".seoul-mb").click(function() {
		cnt = 0;
		$.ajax({
			url: "<%= request.getContextPath() %>/searchAddr",
			method: "GET",
			dataType: "json",
			data: {
				addr1: "강남구",
				addr2: "서초구",
				},
			success: function(res) {
				let $ul = $(".work-bot");
				if(res == null || res.length==0) {
					$ul.html("<li class='no-search'>조회된 병원이 없습니다.</li>");
				} else {
					$ul.html("");
					for(let i in res) {
						cnt++;
						let hosp = res[i];
						//사진있을때
						if(hosp.hospInfo!=null)
							$ul.append("<a class='work-card' href='<%=request.getContextPath()%>/hospital/hospital?hospId="+hosp.hospId+"'><li><img src='upload/hospital/"+hosp.hospInfo+"' alt=''><div class='s-info'><p class='hos-title'>"+hosp.hospName+"</p><p>"+hosp.hospAddr+"</p></div></li></a>");
						//사진없을때
						else
							$ul.append("<a class='work-card' href='<%=request.getContextPath()%>/hospital/hospital?hospId="+hosp.hospId+"'><li><img src='img/hos.jpg' alt=''><div class='s-info'><p class='hos-title'>"+hosp.hospName+"</p><p>"+hosp.hospAddr+"</p></div></li></a>");
					}
				}
				paging(cnt);
			},
			error: function(xhr, status, err) {
				console.log(xhr, status, err);
			}
		});
	});
	$(".seoul-rb").click(function() {
		cnt = 0;
		$.ajax({
			url: "<%= request.getContextPath() %>/searchAddr",
			method: "GET",
			dataType: "json",
			data: {
				addr1: "강동구",
				addr2: "송파구",
				},
			success: function(res) {
				let $ul = $(".work-bot");
				if(res == null || res.length==0) {
					$ul.html("<li class='no-search'>조회된 병원이 없습니다.</li>");
				} else {
					$ul.html("");
					for(let i in res) {
						cnt++;
						let hosp = res[i];
						//사진있을때
						if(hosp.hospInfo!=null)
							$ul.append("<a class='work-card' href='<%=request.getContextPath()%>/hospital/hospital?hospId="+hosp.hospId+"'><li><img src='upload/hospital/"+hosp.hospInfo+"' alt=''><div class='s-info'><p class='hos-title'>"+hosp.hospName+"</p><p>"+hosp.hospAddr+"</p></div></li></a>");
						//사진없을때
						else
							$ul.append("<a class='work-card' href='<%=request.getContextPath()%>/hospital/hospital?hospId="+hosp.hospId+"'><li><img src='img/hos.jpg' alt=''><div class='s-info'><p class='hos-title'>"+hosp.hospName+"</p><p>"+hosp.hospAddr+"</p></div></li></a>");
					}
				}
				paging(cnt);
			},
			error: function(xhr, status, err) {
				console.log(xhr, status, err);
			}
		});
	});
	
	
	//진료과목별 검색
	$(".work-mid li:first-child").click(function() {
		cnt = 0;
		$.ajax({
			url: "<%= request.getContextPath() %>/searchButton",
			method: "GET",
			dataType: "json",
			data: {
				hospDept: "내과"
				},
			success: function(res) {
				let $ul = $(".work-bot");
				if(res == null || res.length==0) {
					$ul.html("<li class='no-search'>조회된 병원이 없습니다.</li>");
				} else {
					$ul.html("");
					for(let i in res) {
						cnt++;
						let hosp = res[i];
						if(hosp.hospInfo!=null)
							$ul.append("<a class='work-card' href='<%=request.getContextPath()%>/hospital/hospital?hospId="+hosp.hospId+"'><li><img src='upload/hospital/"+hosp.hospInfo+"' alt=''><div class='s-info'><p class='hos-title'>"+hosp.hospName+"</p><p>"+hosp.hospAddr+"</p></div></li></a>");
						//사진없을때
						else
							$ul.append("<a class='work-card' href='<%=request.getContextPath()%>/hospital/hospital?hospId="+hosp.hospId+"'><li><img src='img/hos.jpg' alt=''><div class='s-info'><p class='hos-title'>"+hosp.hospName+"</p><p>"+hosp.hospAddr+"</p></div></li></a>");
					}
				}
				console.log(cnt);
				paging(cnt);
			},
			error: function(xhr, status, err) {
				console.log(xhr, status, err);
			}
		});
	});
	$(".work-mid li:nth-child(2)").click(function() {
		cnt = 0;
		$.ajax({
			url: "<%= request.getContextPath() %>/searchButton",
			method: "GET",
			dataType: "json",
			data: {
				hospDept: "외과"
				},
			success: function(res) {
				let $ul = $(".work-bot");
				if(res == null || res.length==0) {
					$ul.html("<li class='no-search'>조회된 병원이 없습니다.</li>");
				} else {
					$ul.html("");
					for(let i in res) {
						cnt++;
						let hosp = res[i];
						//사진있을때
						if(hosp.hospInfo!=null)
							$ul.append("<a class='work-card' href='<%=request.getContextPath()%>/hospital/hospital?hospId="+hosp.hospId+"'><li><img src='upload/hospital/"+hosp.hospInfo+"' alt=''><div class='s-info'><p class='hos-title'>"+hosp.hospName+"</p><p>"+hosp.hospAddr+"</p></div></li></a>");
						//사진없을때
						else
							$ul.append("<a class='work-card' href='<%=request.getContextPath()%>/hospital/hospital?hospId="+hosp.hospId+"'><li><img src='img/hos.jpg' alt=''><div class='s-info'><p class='hos-title'>"+hosp.hospName+"</p><p>"+hosp.hospAddr+"</p></div></li></a>");
					}
				}
				paging(cnt);
			},
			error: function(xhr, status, err) {
				console.log(xhr, status, err);
			}
		});
	});
	$(".work-mid li:nth-child(3)").click(function() {
		cnt = 0;
		$.ajax({
			url: "<%= request.getContextPath() %>/searchButton",
			method: "GET",
			dataType: "json",
			data: {
				hospDept: "안과"
				},
			success: function(res) {
				let $ul = $(".work-bot");
				if(res == null || res.length==0) {
					$ul.html("<li class='no-search'>조회된 병원이 없습니다.</li>");
				} else {
					$ul.html("");
					for(let i in res) {
						cnt++;
						let hosp = res[i];
						//사진있을때
						if(hosp.hospInfo!=null)
							$ul.append("<a class='work-card' href='<%=request.getContextPath()%>/hospital/hospital?hospId="+hosp.hospId+"'><li><img src='upload/hospital/"+hosp.hospInfo+"' alt=''><div class='s-info'><p class='hos-title'>"+hosp.hospName+"</p><p>"+hosp.hospAddr+"</p></div></li></a>");
						//사진없을때
						else
							$ul.append("<a class='work-card' href='<%=request.getContextPath()%>/hospital/hospital?hospId="+hosp.hospId+"'><li><img src='img/hos.jpg' alt=''><div class='s-info'><p class='hos-title'>"+hosp.hospName+"</p><p>"+hosp.hospAddr+"</p></div></li></a>");
					}
				}
				paging(cnt);
			},
			error: function(xhr, status, err) {
				console.log(xhr, status, err);
			}
		});
	});
	$(".work-mid li:nth-child(4)").click(function() {
		cnt = 0;
		$.ajax({
			url: "<%= request.getContextPath() %>/searchButton",
			method: "GET",
			dataType: "json",
			data: {
				hospDept: "치과"
				},
			success: function(res) {
				let $ul = $(".work-bot");
				if(res == null || res.length==0) {
					$ul.html("<li class='no-search'>조회된 병원이 없습니다.</li>");
				} else {
					$ul.html("");
					for(let i in res) {
						cnt++;
						let hosp = res[i];
						//사진있을때
						if(hosp.hospInfo!=null)
							$ul.append("<a class='work-card' href='<%=request.getContextPath()%>/hospital/hospital?hospId="+hosp.hospId+"'><li><img src='upload/hospital/"+hosp.hospInfo+"' alt=''><div class='s-info'><p class='hos-title'>"+hosp.hospName+"</p><p>"+hosp.hospAddr+"</p></div></li></a>");
						//사진없을때
						else
							$ul.append("<a class='work-card' href='<%=request.getContextPath()%>/hospital/hospital?hospId="+hosp.hospId+"'><li><img src='img/hos.jpg' alt=''><div class='s-info'><p class='hos-title'>"+hosp.hospName+"</p><p>"+hosp.hospAddr+"</p></div></li></a>");
					}
				}
				paging(cnt);
			},
			error: function(xhr, status, err) {
				console.log(xhr, status, err);
			}
		});
	});
	$(".work-mid li:nth-child(5)").click(function() {
		cnt = 0;
		$.ajax({
			url: "<%= request.getContextPath() %>/searchButton",
			method: "GET",
			dataType: "json",
			data: {
				hospDept: "피부과"
				},
			success: function(res) {
				let $ul = $(".work-bot");
				if(res == null || res.length==0) {
					$ul.html("<li class='no-search'>조회된 병원이 없습니다.</li>");
				} else {
					$ul.html("");
					for(let i in res) {
						cnt++;
						let hosp = res[i];
						//사진있을때
						if(hosp.hospInfo!=null)
							$ul.append("<a class='work-card' href='<%=request.getContextPath()%>/hospital/hospital?hospId="+hosp.hospId+"'><li><img src='upload/hospital/"+hosp.hospInfo+"' alt=''><div class='s-info'><p class='hos-title'>"+hosp.hospName+"</p><p>"+hosp.hospAddr+"</p></div></li></a>");
						//사진없을때
						else
							$ul.append("<a class='work-card' href='<%=request.getContextPath()%>/hospital/hospital?hospId="+hosp.hospId+"'><li><img src='img/hos.jpg' alt=''><div class='s-info'><p class='hos-title'>"+hosp.hospName+"</p><p>"+hosp.hospAddr+"</p></div></li></a>");
					}
				}
				paging(cnt);
			},
			error: function(xhr, status, err) {
				console.log(xhr, status, err);
			}
		});
	});
	$(".work-mid li:nth-child(6)").click(function() {
		cnt = 0;
		$.ajax({
			url: "<%= request.getContextPath() %>/searchButton",
			method: "GET",
			dataType: "json",
			data: {
				hospDept: "정신과"
				},
			success: function(res) {
				let $ul = $(".work-bot");
				if(res == null || res.length==0) {
					$ul.html("<li class='no-search'>조회된 병원이 없습니다.</li>");
				} else {
					$ul.html("");
					for(let i in res) {
						cnt++;
						let hosp = res[i];
						//사진있을때
						if(hosp.hospInfo!=null)
							$ul.append("<a class='work-card' href='<%=request.getContextPath()%>/hospital/hospital?hospId="+hosp.hospId+"'><li><img src='upload/hospital/"+hosp.hospInfo+"' alt=''><div class='s-info'><p class='hos-title'>"+hosp.hospName+"</p><p>"+hosp.hospAddr+"</p></div></li></a>");
						//사진없을때
						else
							$ul.append("<a class='work-card' href='<%=request.getContextPath()%>/hospital/hospital?hospId="+hosp.hospId+"'><li><img src='img/hos.jpg' alt=''><div class='s-info'><p class='hos-title'>"+hosp.hospName+"</p><p>"+hosp.hospAddr+"</p></div></li></a>");
					}
				}
				paging(cnt);
			},
			error: function(xhr, status, err) {
				console.log(xhr, status, err);
			}
		});
	});
});
function searchHosp() {
	let $hospName = $("#hospName");
	let $doctorName = $("#doctorName");
	let $hospDept = $("#hospDept");
	cnt = 0;
	$.ajax({
		url: "<%= request.getContextPath() %>/searchButton",
		method: "GET",
		dataType: "json",
		data: {
			hospName: $hospName.val(),
			doctorName: $doctorName.val(),
			hospDept: $hospDept.val()
			},
		success: function(res) {
			if(res == null) {
				console.log("조회된 병원이 없습니다.");
			} else {
				let $ul = $(".s-result");
				$ul.html("");
				for(let i in res) {
					cnt++;
					let hosp = res[i];
					//사진있을때
					if(hosp.hospInfo!=null)
						$ul.append("<a class='work-card' href='<%=request.getContextPath()%>/hospital/hospital?hospId="+hosp.hospId+"'><li><img src='upload/hospital/"+hosp.hospInfo+"' alt=''><div class='s-info'><p class='hos-title'>"+hosp.hospName+"</p><p>"+hosp.hospAddr+"</p></div></li></a>");
					//사진없을때
					else
						$ul.append("<a class='work-card' href='<%=request.getContextPath()%>/hospital/hospital?hospId="+hosp.hospId+"'><li><img src='img/hos.jpg' alt=''><div class='s-info'><p class='hos-title'>"+hosp.hospName+"</p><p>"+hosp.hospAddr+"</p></div></li></a>");
				}
			}
			mainPaging(cnt);
		},
		error: function(xhr, status, err) {
			console.log(xhr, status, err);
		}
	});
}
$(function(){
	$("#mybooking_main").click(function () {
	
	   	<%if(userLoggedIn != null) { %>
			
				let $userId = "<%= userLoggedIn!=null? userLoggedIn.getUserId():"" %>";
				$.ajax({
					url: "<%= request.getContextPath() %>/booking/bookingListMain",
					method: "GET",
					dataType: "html",
					data: {
						userId: $userId,
						state: "A",
						},
					success: function(data) {
						<% if(userLoggedIn != null) {%>
							$("#profile-tap").html(data);
						<% } else { %>
							$("#profile-tap").children().html("<h1 style='text-align:center'>예약조회</h1><h4 style='text-align: center; margin-top:150px;'>로그인이 필요한 페이지입니다.</h4>");
						<% }%>
					},
					error: function(xhr, status, err) {
						console.log(xhr, status, err);
					}
				});
			
	   	<% } %>
	});
});
</script>
    <section>
        <article>
            <ul class="work-btn">
                <style>
                    li svg {
                        width: 100px;
                        height: 100px;
                        margin: 45px auto 10px;
                        display: block;
                    }
                </style>
                <li id="mybooking_main">
                    <svg xmlns:x="http://ns.adobe.com/Extensibility/1.0/"
                        xmlns:i="http://ns.adobe.com/AdobeIllustrator/10.0/"
                        xmlns:graph="http://ns.adobe.com/Graphs/1.0/" xmlns="http://www.w3.org/2000/svg"
                        xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" x="0px" y="0px" viewBox="0 0 100 125"
                        fill="white" style="enable-background:new 0 0 100 100;" xml:space="preserve">
                        <switch>
                            <foreignObject requiredExtensions="http://ns.adobe.com/AdobeIllustrator/10.0/" x="0" y="0"
                                width="1" height="1" />
                            <g i:extraneous="self">
                                <g>
                                    <path d="M5273.1,2400.1v-2c0-2.8-5-4-9.7-4s-9.7,1.3-9.7,4v2c0,1.8,0.7,3.6,2,4.9l5,4.9c0.3,0.3,0.4,0.6,0.4,1v6.4     c0,0.4,0.2,0.7,0.6,0.8l2.9,0.9c0.5,0.1,1-0.2,1-0.8v-7.2c0-0.4,0.2-0.7,0.4-1l5.1-5C5272.4,2403.7,5273.1,2401.9,5273.1,2400.1z      M5263.4,2400c-4.8,0-7.4-1.3-7.5-1.8v0c0.1-0.5,2.7-1.8,7.5-1.8c4.8,0,7.3,1.3,7.5,1.8C5270.7,2398.7,5268.2,2400,5263.4,2400z" />
                                    <path d="M5268.4,2410.3c-0.6,0-1,0.4-1,1c0,0.6,0.4,1,1,1h4.3c0.6,0,1-0.4,1-1c0-0.6-0.4-1-1-1H5268.4z" />
                                    <path d="M5272.7,2413.7h-4.3c-0.6,0-1,0.4-1,1c0,0.6,0.4,1,1,1h4.3c0.6,0,1-0.4,1-1C5273.7,2414.1,5273.3,2413.7,5272.7,2413.7z" />
                                    <path d="M5272.7,2417h-4.3c-0.6,0-1,0.4-1,1c0,0.6,0.4,1,1,1h4.3c0.6,0,1-0.4,1-1C5273.7,2417.5,5273.3,2417,5272.7,2417z" />
                                </g>
                                <g>
                                    <path d="M83.6,8.8H70.9V5.2c0-1.5-1.2-2.7-2.7-2.7c-1.5,0-2.7,1.2-2.7,2.7v3.6H52.7V5.2c0-1.5-1.2-2.7-2.7-2.7     c-1.5,0-2.7,1.2-2.7,2.7v3.6H34.5V5.2c0-1.5-1.2-2.7-2.7-2.7c-1.5,0-2.7,1.2-2.7,2.7v3.6H16.4c-2.4,0-4.4,2-4.4,4.4v79.9     c0,2.4,2,4.4,4.4,4.4h67.2c2.4,0,4.4-2,4.4-4.4V13.2C88,10.8,86,8.8,83.6,8.8z M82.6,92.1H17.4V14.2h11.7v3.6     c0,1.5,1.2,2.7,2.7,2.7c1.5,0,2.7-1.2,2.7-2.7v-3.6h12.8v3.6c0,1.5,1.2,2.7,2.7,2.7c1.5,0,2.7-1.2,2.7-2.7v-3.6h12.8v3.6     c0,1.5,1.2,2.7,2.7,2.7c1.5,0,2.7-1.2,2.7-2.7v-3.6h11.7V92.1z" />
                                    <path d="M30,42.3c0.5,0.6,1.2,0.9,2,0.9c0.8,0,1.5-0.3,2-0.9l6.2-6.7c1-1.1,1-2.8-0.1-3.8c-1.1-1-2.8-1-3.8,0.1L32,36.5l-1.3-1.4     C29.7,34,28,34,26.9,35c-1.1,1-1.2,2.7-0.1,3.8L30,42.3z" />
                                    <path d="M36.2,50.6L32,55.1l-1.3-1.4c-1-1.1-2.7-1.2-3.8-0.1c-1.1,1-1.2,2.7-0.1,3.8L30,61c0.5,0.6,1.2,0.9,2,0.9     c0.8,0,1.5-0.3,2-0.9l6.2-6.7c1-1.1,1-2.8-0.1-3.8C39,49.5,37.2,49.5,36.2,50.6z" />
                                    <path d="M36.2,69.3L32,73.8l-1.3-1.4c-1-1.1-2.7-1.2-3.8-0.1c-1.1,1-1.2,2.7-0.1,3.8l3.3,3.5c0.5,0.6,1.2,0.9,2,0.9     c0.8,0,1.5-0.3,2-0.9l6.2-6.7c1-1.1,1-2.8-0.1-3.8C39,68.1,37.2,68.2,36.2,69.3z" />
                                    <path d="M71.2,53.1H47.7c-1.5,0-2.7,1.2-2.7,2.7c0,1.5,1.2,2.7,2.7,2.7h23.6c1.5,0,2.7-1.2,2.7-2.7     C73.9,54.3,72.7,53.1,71.2,53.1z" />
                                    <path d="M47.7,34.4c-1.5,0-2.7,1.2-2.7,2.7c0,1.5,1.2,2.7,2.7,2.7h23.6c1.5,0,2.7-1.2,2.7-2.7c0-1.5-1.2-2.7-2.7-2.7H47.7z" />
                                    <path d="M71.2,71.8H47.7c-1.5,0-2.7,1.2-2.7,2.7s1.2,2.7,2.7,2.7h23.6c1.5,0,2.7-1.2,2.7-2.7S72.7,71.8,71.2,71.8z" />
                                </g>
                            </g>
                        </switch>
                    </svg>
                    예약조회
                </li>
                <li>
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 80" x="0px" y="0px" fill="white">
                        <g data-name="16">
                            <path
                                d="M53.3,51.89a11.52,11.52,0,1,0-1.41,1.41l6.4,6.41a1,1,0,0,0,1.42,0,1,1,0,0,0,0-1.42ZM44.5,54A9.5,9.5,0,1,1,54,44.5,9.51,9.51,0,0,1,44.5,54Z" />
                            <path
                                d="M59,23H41V5a1,1,0,0,0-1-1H24a1,1,0,0,0-1,1V23H5a1,1,0,0,0-1,1V40a1,1,0,0,0,1,1H23V59a1,1,0,0,0,1,1H40a1,1,0,0,0,1-1v-.43A14.5,14.5,0,1,1,58.57,41H59a1,1,0,0,0,1-1V24A1,1,0,0,0,59,23Z" />
                        </g>
                    </svg>
                    검색
                </li>
                <li>
                 <a href="<%=request.getContextPath()%>/healthBoard/healthboardList" style="display: block; padding: 1px 0px 36px 0px; color:white;"  fill="white">
                 <svg version="1.0" xmlns="http://www.w3.org/2000/svg"
					 width="1280.000000pt" height="1280.000000pt" viewBox="0 0 1280.000000 1280.000000"
					 preserveAspectRatio="xMidYMid meet">
					<metadata>
					</metadata>
					<g transform="translate(0.000000,1280.000000) scale(0.100000,-0.100000)"
					fill="#ffffff" stroke="none">
					<path d="M1820 12779 c-285 -30 -596 -134 -838 -282 -542 -331 -894 -887 -962
					-1519 -14 -135 -14 -9021 0 -9156 52 -480 262 -911 606 -1242 338 -326 758
					-518 1224 -560 91 -8 1367 -10 4645 -8 4277 3 4525 4 4615 21 234 44 406 100
					595 194 531 266 908 739 1058 1331 l32 127 0 4715 0 4715 -32 127 c-96 380
					-268 684 -537 954 -307 306 -657 485 -1116 571 -90 17 -335 18 -4650 19 -2549
					1 -4592 -2 -4640 -7z m4655 -1379 c494 -35 945 -133 1355 -293 146 -57 433
					-202 567 -285 586 -366 940 -837 1103 -1469 76 -291 111 -671 90 -983 -32
					-498 -149 -869 -385 -1225 -200 -302 -474 -561 -1185 -1118 -211 -166 -423
					-340 -470 -387 -181 -179 -307 -388 -366 -608 -28 -104 -54 -314 -66 -529
					l-11 -213 -915 0 -915 0 7 168 c28 687 118 1228 245 1479 102 204 335 471 626
					722 66 57 278 225 470 374 193 150 394 315 449 367 170 164 310 372 385 570
					59 158 72 231 78 435 4 151 2 199 -15 300 -26 152 -68 280 -137 420 -191 390
					-416 552 -880 631 -157 27 -533 25 -685 -4 -318 -60 -553 -194 -713 -405 -158
					-208 -296 -520 -346 -780 -18 -91 -41 -287 -41 -350 0 -16 -51 -17 -962 -15
					l-963 3 2 85 c4 122 21 304 44 460 154 1030 613 1765 1382 2215 417 243 905
					388 1465 434 142 12 625 12 787 1z m775 -9005 l0 -965 -1005 0 -1005 0 0 965
					0 965 1005 0 1005 0 0 -965z"/>
					</g>
				</svg>
                   게시판
                 </a>
                </li>
            </ul>
            <div class="work-wrap">
                <div class="work-tap tap">
                	<ul class="search-btn">
                		<li style="background-color: #4286f4">검색어</li>
                		<li>지도</li>
                		<li>진료과</li>
                	</ul>
                	<div class="search-wrap s-tap">
                        <div class="search">
                            <img src="img/s-round.png" alt="">
                            <input type="text" id="hospName" name="hospName" placeholder="병원이름">
                        </div>
                        <div class="search">
                            <img src="img/s-round.png" alt="">
                            <input type="text" id="doctorName" name="doctorName" placeholder="의사">
                        </div>
                        <div class="search">
                            <img src="img/s-round.png" alt="">
                            <input type="text" id="hospDept" name="hospDept" placeholder="진료">
                        </div>
                        <input type="button" value="검색" onclick="searchHosp();" >
                    	<ul class="s-result">
	                    	<form action="" id="s-SetRows">
								<input type="hidden" name="s-RowPerPage" value="3">
							</form>
                    	</ul>
                    </div>
                    <div class="work-top work s-tap" style="display:none;">
                        <div class="seoul">
                            <p class="work-title"><span>●</span>지역선택</p>
                            <div class="map"></div>
                            <div class="seoul-lt"></div>
                            <div class="seoul-lb"></div>
                            <div class="seoul-rt"></div>
                            <div class="seoul-mb"></div>
                            <div class="seoul-rb"></div>
                        </div>
                    </div>
                    <ul class="work-mid s-tap" style="display:none;">
                        <li>내과</li>
                        <li>외과</li>
                        <li>안과</li>
                        <li>치과</li>
                        <li>피부과</li>
                        <li>정신과</li>
                    </ul>
                    <ul class="work-bot s-tap" style="display:none;">
                    </ul>
                </div>
                
                <div class="profile-tap tap" id="profile-tap" style="display: none;">
                    <div class="profile-wrap">
                <% if( userLoggedIn != null) {%>
                        <div class="profile">
                          
                        <ul class="res-result">
                         
                        </ul>
                    <div class="res-wrap">
                        <h1><span>●</span> 내 예약 </h1>
                        <h3>로그인후 이용해주세요.</h3>
                	</div>
                    
                <% } else { %>
                	<div class="profile-wrap">
                		<div class="profile">
                            <img src="img/person1.png" alt="">
                        </div>
                        <ul class="res-result">
                            <li>
                                <img src="img/mypage-1.png" alt="">
                                <p>전체</p>
                                <h1>0</h1>
                            </li>
                            <li>
                                <img src="img/mypage-2.png" alt="">
                                <p>이용예정</p>
                                <h1>0</h1>
                            </li>
                            <li>
                                <img src="img/mypage-3.png" alt="">
                                <p>이용완료</p>
                                <h1>0</h1>
                            </li>
                            <li>
                                <img src="img/mypage-4.png" alt="">
                                <p>취소</p>
                                <h1>0</h1>
                            </li>
                        </ul>
                    </div>
                    <div class="res-wrap">
                		<h1 style="margin-top: 200px; text-align:center;">예약 내역을 확인하기위해 로그인을 해주세요.</h1>
                	</div>
                <% } %>
                </div>
                </div>
            </div>
        </article>
    </section>
    <script>
    $(".work-mid").find("li").click(function () {
        $(".work-mid").find("li").css({
            "background-color": "white",
            "color": "black"
        });
        $(this).css({
            "background-color": "#4286f4",
            "color": "white"
        });
    });
    $(".search-btn").find("li").eq(0).click(function(){
		$(".s-tap").css("display","none");
		$(".search-wrap").css("display","block");
		$(".search-btn").find("li").css("background-color","#83b2ff");
		$(this).css("background-color","#4286f4");
	});
	$(".search-btn").find("li").eq(1).click(function(){
		$(".s-tap").css("display","none");
		$(".work-top").css("display","block");
		$(".work-bot").css("display","block");
		$(".search-btn").find("li").css("background-color","#83b2ff");
		$(this).css("background-color","#4286f4");
		$(".work-bot").html("");
		$(".paging").html("");
	});
	$(".search-btn").find("li").eq(2).click(function(){
		$(".s-tap").css("display","none");
		$(".work-mid").css("display","block");
		$(".work-bot").css("display","block");
		$(".search-btn").find("li").css("background-color","#83b2ff");
		$(this).css("background-color","#4286f4");
		$(".work-bot").html("");
		$(".paging").html("");
	});
    </script>
    <script src="<%= request.getContextPath() %>/js/main_tap.js"></script>
    <script src="<%=request.getContextPath()%>/js/workPaging.js"></script>
    <script src="<%=request.getContextPath()%>/js/mainSearchPaging.js"></script>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
