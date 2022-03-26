<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<style>
section {
	width: 890px;
	padding-top: 100px;
	margin: 0px auto 50px;
}

table.bbs_default {
	width: 100%;
	border-collapse: collapse;
	margin: 0;
}

table.bbs_default.view tr:first-child th, table.bbs_default.view tr:first-child td
	{
	border-top: 3px solid #4286f4;
}

caption {
	height: 1px;
	font-size: 0;
	line-height: 0;
}

table.bbs_default.view th {
	width: 20%;
	padding: 15px 10px;
	border-bottom: 1px solid #d9d9d9;
	background: #f8f8f8;
	font-weight: 600;
	text-align: center;
}

table.bbs_default.view td {
	padding: 15px 10px 15px 25px;
	border-bottom: 1px solid #d9d9d9;
}

table.bbs_default.view th {
	width: 20%;
	padding: 15px 10px;
	border-bottom: 1px solid #d9d9d9;
	background: #f8f8f8;
	font-weight: 600;
	text-align: center;
}

.box.type4 {
	padding-left: 30px;
	border-top-width: 0;
	border-bottom-width: 0;
	background-color: #f6f6f6;
}

.box {
	position: relative;
	min-height: 50px;
	margin-top: 10px;
	margin-bottom: 30px;
	padding-top: 20px;
	padding-right: 30px;
	padding-bottom: 20px;
	padding-left: 145px;
	border-top-width: 2px;
	border-top-style: solid;
	border-top-color: #232c3b;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #dde1e2;
	background-color: #f4f4f4;
}
</style>
<section>
	<table class="bbs_default view">
		<caption>통신판매사업자(상세) - 통신판매번호, 신고기관명, 상호, 사업자등록번호, 법인여부,
			법인등록번호, 대표자명, 전화번호, 전자우편(E-mail), 신고일자, 사업장소재지, 사업장소재지(도로명), 신고현황,
			신고기관 대표연락처, 판매방식, 취급품목, 인터넷도메인, 호스트서버소재지 순으로 내용을 제공하고 있습니다.</caption>
		<tbody>
			<tr>
				<th scope="row">통신판매번호</th>
				<td>2019-서울강남-2917</td>
				<th scope="row">사업자등록번호</th>
				<td>2X0-X8-415XX</td>
			</tr>
			<tr>
				<th scope="row">신고현황</th>
				<td>통신판매업 신고</td>
				<th scope="row">법인여부</th>
				<td>법인</td>
			</tr>
			<tr>
				<th scope="row">상호</th>
				<td colspan="3">SeeDoc</td>
			</tr>
			<tr>
				<th scope="row">대표자명</th>
				<td>KH</td>
				<th scope="row">대표 전화번호</th>
				<td>0X0-8XX2-XX08</td>
			</tr>
			<tr>
				<th scope="row">판매방식</th>
				<td>인터넷</td>
				<th scope="row">취급품목</th>
				<td>병원부가서비스</td>
			</tr>
			<tr>
				<th scope="row">전자우편(E-mail)</th>
				<td>KHM0627@naver.com</td>
				<th scope="row">신고일자</th>
				<td>201XXX0X</td>
			</tr>
			<tr>
				<th scope="row">사업장소재지</th>
				<td colspan="3">서울특별시 역삼동 제2KH M강의장</td>
			</tr>
			<tr>
				<th scope="row">사업장소재지(도로명)</th>
				<td colspan="3">서울특별시 역삼동 제2KH M강의장(역삼동)</td>
			</tr>
			<tr>
				<th scope="row">인터넷도메인</th>
				<td colspan="3">localhost</td>
			</tr>
			<tr>
				<th scope="row">호스트서버소재지</th>
				<td colspan="3">localhost:9090/seedoc</td>
			</tr>
			<tr>
				<th scope="row">통신판매업 신고기관명</th>

				<td colspan="3">서울특별시 강남구청&nbsp;&nbsp;(02-XX55-6XX5)</td>
			</tr>
		</tbody>
	</table>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>