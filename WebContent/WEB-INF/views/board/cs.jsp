<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="../css/cs.css">
<section>
	<h1>고객센터</h1>
	<table class="bbc">
		<tr>
			<th>번호</th>
			<th colspan="6">제목</th>
			<th>작성자</th>
			<th>작성날짜</th>
			<th>조회수</th>
		</tr>
		<tr>
			<td>1</td>
			<td colspan="6">병원 예약전 확인사항</td>
			<td>관리자</td>
			<td>2020.07.01</td>
			<td>28</td>
		</tr>
		<tr>
			<td>2</td>
			<td colspan="6">SeeDoc 이용설명서</td>
			<td>관리자</td>
			<td>2020.06.30</td>
			<td>17</td>
		</tr>
		<tr>
			<td>3</td>
			<td colspan="6">병원 예약 중 오류 발생 시 대처방법</td>
			<td>관리자</td>
			<td>2020.06.28</td>
			<td>3</td>
		</tr>
	</table>
	<div class="paging" style="text-align: center;">
		<a href="#"> <svg xmlns="http://www.w3.org/2000/svg"
				xmlns:xlink="http://www.w3.org/1999/xlink" width="7px" height="11px">
                    <path fill-rule="evenodd" fill="rgb(55, 59, 68)"
					d="M0.818,4.634 C1.177,4.275 1.758,4.275 2.117,4.634 L6.014,8.531 C6.372,8.889 6.372,9.471 6.014,9.830 C5.655,10.188 5.074,10.188 4.715,9.830 L0.818,5.933 C0.459,5.574 0.459,4.993 0.818,4.634 Z" />
                    <path fill-rule="evenodd" fill="rgb(55, 59, 68)"
					d="M0.818,5.067 L4.715,1.170 C5.074,0.812 5.655,0.812 6.014,1.170 C6.372,1.529 6.372,2.110 6.014,2.469 L2.117,6.366 C1.758,6.725 1.177,6.725 0.818,6.366 C0.459,6.007 0.459,5.426 0.818,5.067 Z" />
                </svg>
		</a> <a href="#" style="font-weight: 800;">1</a> <a href="#">2</a> <a
			href="#">3</a> <a href="#"> <svg
				xmlns="http://www.w3.org/2000/svg"
				xmlns:xlink="http://www.w3.org/1999/xlink" width="7px" height="11px">
                    <path fill-rule="evenodd" fill="rgb(55, 59, 68)"
					d="M6.026,6.397 C5.667,6.756 5.085,6.756 4.727,6.397 L0.830,2.500 C0.471,2.142 0.471,1.560 0.830,1.201 C1.189,0.843 1.770,0.843 2.129,1.201 L6.026,5.098 C6.384,5.457 6.384,6.038 6.026,6.397 Z" />
                    <path fill-rule="evenodd" fill="rgb(55, 59, 68)"
					d="M6.026,5.964 L2.129,9.861 C1.770,10.220 1.189,10.220 0.830,9.861 C0.471,9.502 0.471,8.920 0.830,8.562 L4.727,4.665 C5.085,4.306 5.667,4.306 6.026,4.665 C6.384,5.024 6.384,5.605 6.026,5.964 Z" />
                </svg>
		</a>
	</div>
	<div class="search-wrap">
		<select id="cars" name="cars">
			<option value="volvo">제목</option>
			<option value="saab">작성자</option>
			<option value="fiat">작성날짜</option>
		</select> <input type="search" name="" id=""> <input type="button"
			value="검 색">
	</div>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>