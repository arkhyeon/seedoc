<%@page import="member.model.service.MemberService"%>
<%@page import="healthBoard.model.vo.HealthBoardComment"%>
<%@page import="healthBoard.model.vo.HealthBoard"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	HealthBoard hb = (HealthBoard)request.getAttribute("hb");
	List<HealthBoardComment> commentList = (List<HealthBoardComment>)request.getAttribute("commentList");
	String pageBar = (String)request.getAttribute("pageBar");
%>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/healthBoard.css">
<script>
function filedDownLoad(oname, rname) {
	
	let url = "<%=request.getContextPath()%>/healthBoard/fileDownload";
	//한글을 %문자(유니코드)로 변경
	oname = encodeURIComponent(oname);
	
	location.href = url + "?oname="+oname + "&rname=" + rname;
}


$(function () {
	$(".btn-delete").click(function () {
		if(!confirm('댓글을 정말 삭제하시겠습니까?')){
			return;
		}
		//삭제할 번호 가져오기
		let boardCommentNo = $(this).val();
		
		let $frm = $("[name=deleteCommentFrm]");
		$frm.children("[name=boardCommentNo]").val(boardCommentNo);
		$frm.submit();
	});
	
	$("#btn1").click(function () {
		if($("input:checkbox[name=btn1]").is(":checked") == true){
			$(".result-container").css("display","block");
			$("#box1").css("background","#ada9af1f");
		}else{
			$(".result-container").css("display","none");
			$("#box1").css("background","white");
		}
	});
	$(".btn-reply").click(function () {
			let $tr = $("<tr></tr>");
			let $td = $("<td style='display:none; text-align:left;' colspan=2></td>");
			let $frm = $("<form action='<%=request.getContextPath()%>/healthBoard/healthBoardCommentInsert' method='post'></form>");
			$frm.append("<input type='hidden' name='healthBoardRef' value='<%=hb.getBoardNo()%>' />");
			<%if(userLoggedIn!=null){%>
			$frm.append("<input type='hidden' name='healthBoardCommentWriter' value='<%=userLoggedIn.getUserId()%>'/>");
			<%}else if(hospLoggedIn!=null){%>
			$frm.append("<input type='hidden' name='healthBoardCommentWriter' value='<%=hospLoggedIn.getHospId()%>'/>");
			<%}%>
			$frm.append("<input type='hidden' name='healthBoardCommentLevel' value='2'/>");
			$frm.append("<input type='hidden' name='healthBoardCommentRef' value='"+$(this).val()+"'/>");
			$frm.append("<textarea name='healthBoardCommentContent' cols=60 rows=3 placeholder='답변을 남겨주세요.' style='padding:7px 5px; resize: none; border:2px solid #cdcdcd; font-size: 15px;' ></textarea>");
			$frm.append("<button type='submit' class='btn-insert2'>등록</button>");
			
			$td.append($frm);
			$tr.append($td);
			
			let $boardCommentTr = $(this).parent().parent();
			$tr.insertAfter($boardCommentTr).children("td").slideDown(800)
					.children("form").submit(function () {
						let $textarea = $(this).find("textarea");
						if ($textarea.val().length ==0) {
							return false;
						}
					})
					.children("textarea").focus();
		//1회만 작동하도록 함
		$(this).off("click");
	});
});
function loginAlert() {
	alert("로그인 후 이용하실 수 있습니다.");
	/* $("#memberId").focus(); */
}
</script>

<section>
	<h1>건강상식 게시판</h1>
	<table class="bbc2">
		<tr>
			<th style="width: 0px; background: #9e9e9e47" >No</th>
			<td style="width: 55px; font-weight: bold; color: #513fb5" ><%=hb.getBoardNo()%></td>
			<th style="width:70px; background: #9e9e9e47" >제 목</th>
			<td colspan="3" style="padding: 0px 5px; width: 45%"><%=hb.getBoardTitle()%></td>
			<th style="width:70px; background: #9e9e9e47">조회수</th>
			<td style="width: 60px"><%=hb.getBoardReadCount()%></td>
		</tr>
		<tr>
			<th style="width: 0px;background: #9e9e9e47" >작성자</th>
			
			<td colspan="2"><%if(hb.getBoardWriter().contains("admin")){ %>
			<div style="margin-left: 45px;float: left;">
				<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="12pt" height="12pt" viewBox="0 0 12 12" version="1.1">
					<g id="surface1">
						<path style=" stroke:none;fill-rule:nonzero;fill:red;fill-opacity:1;" d="M 5.25 4.5 C 5.042969 4.5 4.875 4.667969 4.875 4.875 C 4.875 5.082031 5.042969 5.25 5.25 5.25 C 5.457031 5.25 5.625 5.082031 5.625 4.875 C 5.625 4.667969 5.457031 4.5 5.25 4.5 Z M 10.933594 1.960938 L 6.433594 0.0859375 C 6.296875 0.0351562 6.148438 0.00390625 6 0 C 5.851562 0.00390625 5.707031 0.0351562 5.570312 0.0859375 L 1.070312 1.960938 C 0.648438 2.136719 0.375 2.546875 0.375 3 C 0.375 7.652344 3.058594 10.867188 5.566406 11.914062 C 5.84375 12.027344 6.15625 12.027344 6.429688 11.914062 C 8.441406 11.078125 11.625 8.1875 11.625 3 C 11.625 2.546875 11.351562 2.136719 10.933594 1.960938 Z M 9 6 L 8.714844 6 C 8.046875 6 7.714844 6.808594 8.1875 7.28125 L 8.386719 7.480469 C 8.53125 7.628906 8.53125 7.863281 8.386719 8.011719 C 8.238281 8.15625 8.003906 8.15625 7.855469 8.011719 L 7.65625 7.8125 C 7.183594 7.339844 6.375 7.671875 6.375 8.339844 L 6.375 8.625 C 6.375 8.832031 6.207031 9 6 9 C 5.792969 9 5.625 8.832031 5.625 8.625 L 5.625 8.339844 C 5.625 7.671875 4.816406 7.339844 4.34375 7.8125 L 4.144531 8.011719 C 3.996094 8.15625 3.761719 8.15625 3.613281 8.011719 C 3.46875 7.863281 3.46875 7.628906 3.613281 7.480469 L 3.816406 7.28125 C 4.285156 6.808594 3.953125 6 3.285156 6 L 3 6 C 2.792969 6 2.625 5.832031 2.625 5.625 C 2.625 5.417969 2.792969 5.25 3 5.25 L 3.285156 5.25 C 3.953125 5.25 4.285156 4.441406 3.8125 3.96875 L 3.613281 3.769531 C 3.46875 3.621094 3.46875 3.386719 3.613281 3.238281 C 3.761719 3.09375 3.996094 3.09375 4.144531 3.238281 L 4.34375 3.441406 C 4.816406 3.910156 5.625 3.578125 5.625 2.910156 L 5.625 2.625 C 5.625 2.417969 5.792969 2.25 6 2.25 C 6.207031 2.25 6.375 2.417969 6.375 2.625 L 6.375 2.910156 C 6.375 3.578125 7.183594 3.910156 7.65625 3.4375 L 7.855469 3.238281 C 8.003906 3.09375 8.238281 3.09375 8.386719 3.238281 C 8.53125 3.386719 8.53125 3.621094 8.386719 3.769531 L 8.1875 3.96875 C 7.714844 4.441406 8.046875 5.25 8.714844 5.25 L 9 5.25 C 9.207031 5.25 9.375 5.417969 9.375 5.625 C 9.375 5.832031 9.207031 6 9 6 Z M 6.75 6 C 6.542969 6 6.375 6.167969 6.375 6.375 C 6.375 6.582031 6.542969 6.75 6.75 6.75 C 6.957031 6.75 7.125 6.582031 7.125 6.375 C 7.125 6.167969 6.957031 6 6.75 6 Z M 6.75 6 "/>
					</g>
				</svg>
			</div>
			<%}else{ %>
			<div style="margin-left: 45px;float: left;">
				<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="10pt" height="11pt" viewBox="0 0 10 11" version="1.1">
					<g id="surface1">
					<path style=" stroke:none;fill-rule:nonzero;fill:#242d9a;fill-opacity:1;" d="M 2.855469 5.242188 L 2.855469 4.382812 C 2.855469 4.242188 2.976562 4.125 3.125 4.125 L 4.019531 4.125 C 4.164062 4.125 4.285156 4.242188 4.285156 4.382812 L 4.285156 5.242188 C 4.285156 5.382812 4.164062 5.5 4.019531 5.5 L 3.125 5.5 C 2.976562 5.5 2.855469 5.382812 2.855469 5.242188 Z M 5.980469 5.5 L 6.875 5.5 C 7.023438 5.5 7.144531 5.382812 7.144531 5.242188 L 7.144531 4.382812 C 7.144531 4.242188 7.023438 4.125 6.875 4.125 L 5.980469 4.125 C 5.835938 4.125 5.714844 4.242188 5.714844 4.382812 L 5.714844 5.242188 C 5.714844 5.382812 5.835938 5.5 5.980469 5.5 Z M 4.285156 7.304688 L 4.285156 6.445312 C 4.285156 6.304688 4.164062 6.1875 4.019531 6.1875 L 3.125 6.1875 C 2.976562 6.1875 2.855469 6.304688 2.855469 6.445312 L 2.855469 7.304688 C 2.855469 7.445312 2.976562 7.5625 3.125 7.5625 L 4.019531 7.5625 C 4.164062 7.5625 4.285156 7.445312 4.285156 7.304688 Z M 5.980469 7.5625 L 6.875 7.5625 C 7.023438 7.5625 7.144531 7.445312 7.144531 7.304688 L 7.144531 6.445312 C 7.144531 6.304688 7.023438 6.1875 6.875 6.1875 L 5.980469 6.1875 C 5.835938 6.1875 5.714844 6.304688 5.714844 6.445312 L 5.714844 7.304688 C 5.714844 7.445312 5.835938 7.5625 5.980469 7.5625 Z M 10 10.226562 L 10 11 L 0 11 L 0 10.226562 C 0 10.085938 0.121094 9.96875 0.269531 9.96875 L 0.703125 9.96875 L 0.703125 1.828125 C 0.703125 1.578125 0.941406 1.375 1.238281 1.375 L 3.214844 1.375 L 3.214844 0.515625 C 3.214844 0.230469 3.453125 0 3.75 0 L 6.25 0 C 6.546875 0 6.785156 0.230469 6.785156 0.515625 L 6.785156 1.375 L 8.761719 1.375 C 9.058594 1.375 9.296875 1.578125 9.296875 1.828125 L 9.296875 9.96875 L 9.730469 9.96875 C 9.878906 9.96875 10 10.085938 10 10.226562 Z M 1.773438 9.945312 L 4.285156 9.945312 L 4.285156 8.507812 C 4.285156 8.367188 4.40625 8.25 4.554688 8.25 L 5.445312 8.25 C 5.59375 8.25 5.714844 8.367188 5.714844 8.507812 L 5.714844 9.945312 L 8.226562 9.945312 L 8.226562 2.40625 L 6.785156 2.40625 L 6.785156 2.921875 C 6.785156 3.207031 6.546875 3.4375 6.25 3.4375 L 3.75 3.4375 C 3.453125 3.4375 3.214844 3.207031 3.214844 2.921875 L 3.214844 2.40625 L 1.773438 2.40625 Z M 5.9375 1.375 L 5.355469 1.375 L 5.355469 0.816406 C 5.355469 0.746094 5.296875 0.6875 5.222656 0.6875 L 4.777344 0.6875 C 4.703125 0.6875 4.644531 0.746094 4.644531 0.816406 L 4.644531 1.375 L 4.0625 1.375 C 3.988281 1.375 3.929688 1.433594 3.929688 1.503906 L 3.929688 1.933594 C 3.929688 2.003906 3.988281 2.0625 4.0625 2.0625 L 4.644531 2.0625 L 4.644531 2.621094 C 4.644531 2.691406 4.703125 2.75 4.777344 2.75 L 5.222656 2.75 C 5.296875 2.75 5.355469 2.691406 5.355469 2.621094 L 5.355469 2.0625 L 5.9375 2.0625 C 6.011719 2.0625 6.070312 2.003906 6.070312 1.933594 L 6.070312 1.503906 C 6.070312 1.433594 6.011719 1.375 5.9375 1.375 Z M 5.9375 1.375 "/>
					</g>
					</svg>
			</div>
			<%} %><%=hb.getBoardWriter()%></td>
			<th style="width: 27%"></th>
			<th style="width: 10%;background: #9e9e9e47">첨부파일</th>
			<td colspan="5">
				<%if(hb.getBoardOriginalFileName()!=null){ %>
				<!-- 첨부파일이 있을경우만, 이미지와 함께 original파일명 표시 -->
				<a href="javascript:filedDownLoad('<%=hb.getBoardOriginalFileName()%>','<%=hb.getBoardRenamedFileName()%>');">
					<%
					String result = hb.getBoardRenamedFileName().substring(hb.getBoardRenamedFileName().lastIndexOf(".")+1);
					if(result.contains("png")||result.contains("jpg")){ %>
					<img src="<%=request.getContextPath()%>/upload/healthBoard/<%=hb.getBoardRenamedFileName()%>" width="40px" class="img1"/>
					<%}else{ %>
					<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="35pt" height="35pt" viewBox="0 0 35 35" version="1.1" class="img1">
					<g id="surface1">
					<path style=" stroke:none;fill-rule:nonzero;fill:rgb(12.941176%,58.823529%,95.294118%);fill-opacity:1;" d="M 6.777344 2.164062 C 6.539062 2.199219 5.925781 2.34375 5.691406 2.421875 C 4.917969 2.679688 4.0625 3.308594 3.542969 4.003906 C 3.058594 4.648438 2.871094 5.054688 2.695312 5.824219 C 2.640625 6.042969 2.585938 6.339844 2.574219 6.484375 C 2.53125 6.847656 2.53125 28.078125 2.570312 28.421875 C 2.636719 28.992188 2.839844 29.710938 3.058594 30.144531 C 3.347656 30.707031 3.863281 31.339844 4.335938 31.703125 C 4.964844 32.195312 5.398438 32.410156 6.121094 32.59375 C 6.828125 32.773438 5.875 32.757812 17.867188 32.757812 C 29.824219 32.757812 28.890625 32.773438 29.601562 32.597656 C 30.230469 32.441406 30.617188 32.265625 31.15625 31.886719 C 31.796875 31.441406 32.324219 30.820312 32.675781 30.117188 C 32.925781 29.613281 33.109375 28.964844 33.167969 28.351562 C 33.1875 28.160156 33.195312 24.488281 33.1875 17.253906 C 33.179688 7.089844 33.175781 6.425781 33.132812 6.207031 C 32.933594 5.25 32.746094 4.78125 32.300781 4.152344 C 32.015625 3.742188 31.6875 3.402344 31.304688 3.121094 C 30.710938 2.675781 30.292969 2.472656 29.640625 2.308594 C 28.878906 2.117188 29.859375 2.132812 17.828125 2.136719 C 11.835938 2.136719 6.863281 2.148438 6.777344 2.164062 Z M 26.886719 6.070312 C 27.597656 6.152344 28.355469 6.652344 28.738281 7.296875 C 28.894531 7.558594 29.03125 7.910156 29.066406 8.132812 C 29.085938 8.269531 29.09375 11.074219 29.089844 17.5 L 29.082031 26.671875 L 29 26.878906 C 28.722656 27.613281 28.296875 28.109375 27.6875 28.410156 C 27.347656 28.574219 27.203125 28.625 26.9375 28.660156 C 26.800781 28.675781 23.554688 28.683594 17.636719 28.679688 L 8.546875 28.671875 L 8.261719 28.570312 C 7.429688 28.269531 6.867188 27.703125 6.570312 26.867188 L 6.496094 26.648438 L 6.496094 8.105469 L 6.558594 7.914062 C 6.714844 7.453125 6.925781 7.109375 7.25 6.792969 C 7.5 6.546875 7.699219 6.410156 7.996094 6.273438 C 8.273438 6.152344 8.449219 6.097656 8.664062 6.070312 C 8.945312 6.039062 26.601562 6.039062 26.886719 6.070312 Z M 26.886719 6.070312 "/>
					<path style=" stroke:none;fill-rule:nonzero;fill:rgb(12.941176%,58.823529%,95.294118%);fill-opacity:1;" d="M 14.453125 10.175781 L 14.382812 10.230469 L 14.382812 17.910156 L 12.609375 17.910156 C 10.605469 17.910156 10.707031 17.898438 10.722656 18.109375 L 10.734375 18.226562 L 11.71875 18.90625 C 12.257812 19.277344 13.730469 20.292969 14.984375 21.160156 L 17.265625 22.734375 L 13.996094 22.75 C 10.828125 22.765625 10.722656 22.765625 10.667969 22.816406 C 10.609375 22.867188 10.609375 22.886719 10.609375 23.753906 C 10.609375 24.601562 10.613281 24.640625 10.664062 24.691406 C 10.71875 24.746094 10.753906 24.746094 17.878906 24.746094 L 25.039062 24.746094 L 25.089844 24.6875 C 25.140625 24.632812 25.144531 24.570312 25.152344 23.820312 C 25.160156 22.984375 25.144531 22.832031 25.050781 22.789062 C 25.027344 22.773438 23.5625 22.757812 21.796875 22.75 L 18.582031 22.734375 L 20.347656 21.519531 C 24.578125 18.597656 25.105469 18.230469 25.128906 18.167969 C 25.160156 18.085938 25.125 17.976562 25.050781 17.941406 C 25.015625 17.917969 24.421875 17.910156 23.230469 17.910156 L 21.464844 17.910156 L 21.464844 10.230469 L 21.394531 10.175781 C 21.320312 10.117188 21.320312 10.117188 17.921875 10.117188 C 14.527344 10.117188 14.527344 10.117188 14.453125 10.175781 Z M 14.453125 10.175781 "/>
					</g>
					</svg>
					<%} %>
					<input class="upload-name2" value="<%=hb.getBoardOriginalFileName()%>" disabled="disabled" />
				</a>
				<%} %>
			</td>
		</tr>
		<tr>
			<th style="width: 10%; height: 175px;background: #9e9e9e47">내 용</th>
			<td colspan="7" style="word-break: break-all; padding: 10px 14px"><%=hb.getBoardContent()%></td>
		</tr>
		<tr>
			<th colspan="8">
				<div class="btn1">
					<input type="button" value="목록" onclick="location.href='<%=request.getContextPath()%>/healthBoard/healthboardList';" />
					<input type="button" value="글쓰기" id="btn-add1" onclick="location.href='<%=request.getContextPath()%>/healthBoard/healthBoardForm';" style="display: none; margin-left: 7px" />
					<%if(userLoggedIn!=null){ 
						if(MemberService.MEMBER_ROLE_ADMIN.equals(userLoggedIn.getUserRole())){%>
						<script>$('#btn-add1').css('display','block');</script>
					<%  } 
					  }else if(hospLoggedIn!=null ){%>
						<script>$('#btn-add1').css('display','block');</script>
					<%} %>
					<span style="display: block;">댓글보기
						<label class="switch">
						  <input type="checkbox" id="btn1" name="btn1" checked="checked">
						  <span class="slider round"></span>
						</label>
					
					</span>
					
				</div>
		<div class="btn2" style="display: none ">
					<input type="button" value="수정하기" id="btn-update" style="display: none" onclick="location.href='<%=request.getContextPath()%>/healthBoard/healthBoardUpdate?boardNo=<%=hb.getBoardNo()%>';" /> 
					<input type="button" value="삭제하기" id="btn-boardDel" style="display: none" onclick="deleteBoard();"/>
				</div>
				<%if(userLoggedIn!=null){ 
						if(MemberService.MEMBER_ROLE_ADMIN.equals(userLoggedIn.getUserRole())){%>
						<script>$('.btn2').css('display','block');</script>
						<script>$('#btn-update').css('display','block');</script>
						<script>$('#btn-update').css('margin-left','7px');</script>
						<script>$('#btn-update').css('float','right');</script>
						<script>$('#btn-boardDel').css('display','block');</script>
					<%  } 
					  }else if(hospLoggedIn!=null && hb.getBoardWriter().equals(hospLoggedIn.getHospId()) ){%>
						<script>$('.btn2').css('display','block');</script>
						<script>$('#btn-update').css('display','block');</script>
						<script>$('#btn-update').css('margin-left','7px');</script>
						<script>$('#btn-update').css('float','right');</script>
						<script>$('#btn-boardDel').css('display','block');</script>
					<%} %>
			</th>
		</tr>
		<tr>
			<th colspan="8" id="box1" style="background: #ada9af1f">
				<div class="result-container">
					<div class="comment-container" id="tbl-celebrity">
							<!-- 댓글작성폼 -->
							<div class="comment-editor">
								<%if(hospLoggedIn!=null){%>
								<form action="<%= request.getContextPath()%>/healthBoard/healthBoardCommentInsert" method="post" name="boardCommentFrm">
									<input type="hidden" name="healthBoardRef" value="<%=hb.getBoardNo()%>" />
									<input type="hidden" name="healthBoardCommentWriter" value="<%=hospLoggedIn.getHospId()%>" />
									<input type="hidden" name="healthBoardCommentLevel" value="1" />
									<input type="hidden" name="healthBoardCommentRef" value="0" />
									<textarea name="healthBoardCommentContent" id="boardCommentContent" cols="60" rows="3" placeholder="소중한 말씀 감사드립니다." required="required" ></textarea>
									<input type="submit" value="등록" id="btn-insert" style="margin-right: 8px" />
								</form>
								<%}else if(userLoggedIn!=null){%>
								<form action="<%= request.getContextPath()%>/healthBoard/healthBoardCommentInsert" method="post" name="boardCommentFrm">
									<input type="hidden" name="healthBoardRef" value="<%=hb.getBoardNo()%>" />
									<input type="hidden" name="healthBoardCommentWriter" value="<%=userLoggedIn.getUserId()%>" />
									<input type="hidden" name="healthBoardCommentLevel" value="1" />
									<input type="hidden" name="healthBoardCommentRef" value="0" />
									<textarea name="healthBoardCommentContent" id="boardCommentContent" cols="60" rows="3" placeholder="소중한 말씀 감사드립니다." required="required" ></textarea>
									<input type="submit" value="등록" id="btn-insert" style="margin-right: 8px" />
								</form>
								<%} %>
							</div>
							<table id="tbl-comment">
								<%if(commentList!=null && !commentList.isEmpty()){ 
									for(HealthBoardComment hbc : commentList){
										if(hbc.getHealthBoardCommentLevel()==1){%>
										<!-- 댓글 -->
										<tr class="level1"  >
											<td style="text-indent: -40px; font-size: 15px">
											
											<%if(hbc.getHealthBoardCommentWriter().contains("admin")){ %>
											<div style="margin-right: 23px; margin-top:3px; float: left;">
												<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="12pt" height="12pt" viewBox="0 0 12 12" version="1.1">
												<g id="surface1">
												<path style=" stroke:none;fill-rule:nonzero;fill:red;fill-opacity:1;" d="M 5.25 4.5 C 5.042969 4.5 4.875 4.667969 4.875 4.875 C 4.875 5.082031 5.042969 5.25 5.25 5.25 C 5.457031 5.25 5.625 5.082031 5.625 4.875 C 5.625 4.667969 5.457031 4.5 5.25 4.5 Z M 10.933594 1.960938 L 6.433594 0.0859375 C 6.296875 0.0351562 6.148438 0.00390625 6 0 C 5.851562 0.00390625 5.707031 0.0351562 5.570312 0.0859375 L 1.070312 1.960938 C 0.648438 2.136719 0.375 2.546875 0.375 3 C 0.375 7.652344 3.058594 10.867188 5.566406 11.914062 C 5.84375 12.027344 6.15625 12.027344 6.429688 11.914062 C 8.441406 11.078125 11.625 8.1875 11.625 3 C 11.625 2.546875 11.351562 2.136719 10.933594 1.960938 Z M 9 6 L 8.714844 6 C 8.046875 6 7.714844 6.808594 8.1875 7.28125 L 8.386719 7.480469 C 8.53125 7.628906 8.53125 7.863281 8.386719 8.011719 C 8.238281 8.15625 8.003906 8.15625 7.855469 8.011719 L 7.65625 7.8125 C 7.183594 7.339844 6.375 7.671875 6.375 8.339844 L 6.375 8.625 C 6.375 8.832031 6.207031 9 6 9 C 5.792969 9 5.625 8.832031 5.625 8.625 L 5.625 8.339844 C 5.625 7.671875 4.816406 7.339844 4.34375 7.8125 L 4.144531 8.011719 C 3.996094 8.15625 3.761719 8.15625 3.613281 8.011719 C 3.46875 7.863281 3.46875 7.628906 3.613281 7.480469 L 3.816406 7.28125 C 4.285156 6.808594 3.953125 6 3.285156 6 L 3 6 C 2.792969 6 2.625 5.832031 2.625 5.625 C 2.625 5.417969 2.792969 5.25 3 5.25 L 3.285156 5.25 C 3.953125 5.25 4.285156 4.441406 3.8125 3.96875 L 3.613281 3.769531 C 3.46875 3.621094 3.46875 3.386719 3.613281 3.238281 C 3.761719 3.09375 3.996094 3.09375 4.144531 3.238281 L 4.34375 3.441406 C 4.816406 3.910156 5.625 3.578125 5.625 2.910156 L 5.625 2.625 C 5.625 2.417969 5.792969 2.25 6 2.25 C 6.207031 2.25 6.375 2.417969 6.375 2.625 L 6.375 2.910156 C 6.375 3.578125 7.183594 3.910156 7.65625 3.4375 L 7.855469 3.238281 C 8.003906 3.09375 8.238281 3.09375 8.386719 3.238281 C 8.53125 3.386719 8.53125 3.621094 8.386719 3.769531 L 8.1875 3.96875 C 7.714844 4.441406 8.046875 5.25 8.714844 5.25 L 9 5.25 C 9.207031 5.25 9.375 5.417969 9.375 5.625 C 9.375 5.832031 9.207031 6 9 6 Z M 6.75 6 C 6.542969 6 6.375 6.167969 6.375 6.375 C 6.375 6.582031 6.542969 6.75 6.75 6.75 C 6.957031 6.75 7.125 6.582031 7.125 6.375 C 7.125 6.167969 6.957031 6 6.75 6 Z M 6.75 6 "/>
												</g>
												</svg>
											</div>
											<%}else{ %>
											<div style="margin-right: 19px; margin-top:3px; float: left;">
												<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="12pt" height="13pt" viewBox="0 0 12 13" version="1.1">
												<g id="surface1">
												<path style=" stroke:none;fill-rule:nonzero;fill:#03A9F4;fill-opacity:1;" d="M 1.714844 5.6875 L 2.074219 5.6875 C 2.738281 7.121094 4.242188 8.125 6 8.125 C 7.757812 8.125 9.261719 7.121094 9.925781 5.6875 L 10.285156 5.6875 C 10.519531 5.6875 10.714844 5.503906 10.714844 5.28125 L 10.714844 2.84375 C 10.714844 2.621094 10.519531 2.4375 10.285156 2.4375 L 9.925781 2.4375 C 9.261719 1.003906 7.757812 0 6 0 C 4.242188 0 2.738281 1.003906 2.074219 2.4375 L 1.714844 2.4375 C 1.480469 2.4375 1.285156 2.621094 1.285156 2.84375 L 1.285156 5.28125 C 1.285156 5.503906 1.480469 5.6875 1.714844 5.6875 Z M 2.785156 3.453125 C 2.785156 2.890625 3.363281 2.4375 4.070312 2.4375 L 7.929688 2.4375 C 8.636719 2.4375 9.214844 2.890625 9.214844 3.453125 L 9.214844 4.0625 C 9.214844 5.40625 8.0625 6.5 6.644531 6.5 L 5.355469 6.5 C 3.9375 6.5 2.785156 5.40625 2.785156 4.0625 Z M 4.714844 5.28125 L 5.035156 4.367188 L 6 4.0625 L 5.035156 3.757812 L 4.714844 2.84375 L 4.394531 3.757812 L 3.429688 4.0625 L 4.394531 4.367188 Z M 8.773438 8.160156 C 7.972656 8.652344 7.023438 8.9375 6 8.9375 C 4.976562 8.9375 4.027344 8.652344 3.226562 8.160156 C 1.417969 8.339844 0 9.773438 0 11.539062 L 0 11.78125 C 0 12.453125 0.574219 13 1.285156 13 L 3.429688 13 L 3.429688 11.375 C 3.429688 10.925781 3.8125 10.5625 4.285156 10.5625 L 7.714844 10.5625 C 8.1875 10.5625 8.570312 10.925781 8.570312 11.375 L 8.570312 13 L 10.714844 13 C 11.425781 13 12 12.453125 12 11.78125 L 12 11.539062 C 12 9.773438 10.582031 8.339844 8.773438 8.160156 Z M 7.285156 11.375 C 7.050781 11.375 6.855469 11.558594 6.855469 11.78125 C 6.855469 12.003906 7.050781 12.1875 7.285156 12.1875 C 7.519531 12.1875 7.714844 12.003906 7.714844 11.78125 C 7.714844 11.558594 7.519531 11.375 7.285156 11.375 Z M 4.714844 11.375 C 4.480469 11.375 4.285156 11.558594 4.285156 11.78125 L 4.285156 13 L 5.144531 13 L 5.144531 11.78125 C 5.144531 11.558594 4.949219 11.375 4.714844 11.375 Z M 4.714844 11.375 "/>
												</g>
												</svg>
											</div>
											<%} %>
												<sub class="comment-writer"><input class="BackCommentWrit" value="<%=hbc.getHealthBoardCommentWriter()%>" disabled="disabled"/>
													 |
												</sub>
												<sub class="comment-date">
													<%=hbc.getHealthBoardCommentDate()%>
												</sub>
												<br />
												<%=hbc.getHealthBoardCommentContent()%>
											</td>
											
											<td id="comment-btnDel">
												<%if(userLoggedIn!=null||hospLoggedIn!=null){ %>
												<button class="btn-reply" value="<%=hbc.getHealthBoardCommentNo()%>">답글</button>
												<%} %>
												<%if(userLoggedIn!=null && (userLoggedIn.getUserId().equals(hbc.getHealthBoardCommentWriter())
													|| userLoggedIn.getUserRole().equals(MemberService.MEMBER_ROLE_ADMIN))){ %>
												<button class="btn-delete" value="<%=hbc.getHealthBoardCommentNo()%>">삭제</button>
											
												<%}else if(hospLoggedIn!=null && hospLoggedIn.getHospId().equals(hbc.getHealthBoardCommentWriter())){ %>
												<button class="btn-delete" value="<%=hbc.getHealthBoardCommentNo()%>">삭제</button>
												<%} %>
											</td>
											
										</tr>
									<%  }else{%>
										<!-- 대댓글 -->
										<tr class="level2" >
											<td style="text-indent: -35px; font-size: 14.9px">
											
											<%if(hbc.getHealthBoardCommentWriter().contains("admin")){ %>
											<div style="margin-right: 23px; margin-top:3px; float: left;">
												<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="12pt" height="12pt" viewBox="0 0 12 12" version="1.1">
												<g id="surface1">
												<path style=" stroke:none;fill-rule:nonzero;fill:red;fill-opacity:1;" d="M 5.25 4.5 C 5.042969 4.5 4.875 4.667969 4.875 4.875 C 4.875 5.082031 5.042969 5.25 5.25 5.25 C 5.457031 5.25 5.625 5.082031 5.625 4.875 C 5.625 4.667969 5.457031 4.5 5.25 4.5 Z M 10.933594 1.960938 L 6.433594 0.0859375 C 6.296875 0.0351562 6.148438 0.00390625 6 0 C 5.851562 0.00390625 5.707031 0.0351562 5.570312 0.0859375 L 1.070312 1.960938 C 0.648438 2.136719 0.375 2.546875 0.375 3 C 0.375 7.652344 3.058594 10.867188 5.566406 11.914062 C 5.84375 12.027344 6.15625 12.027344 6.429688 11.914062 C 8.441406 11.078125 11.625 8.1875 11.625 3 C 11.625 2.546875 11.351562 2.136719 10.933594 1.960938 Z M 9 6 L 8.714844 6 C 8.046875 6 7.714844 6.808594 8.1875 7.28125 L 8.386719 7.480469 C 8.53125 7.628906 8.53125 7.863281 8.386719 8.011719 C 8.238281 8.15625 8.003906 8.15625 7.855469 8.011719 L 7.65625 7.8125 C 7.183594 7.339844 6.375 7.671875 6.375 8.339844 L 6.375 8.625 C 6.375 8.832031 6.207031 9 6 9 C 5.792969 9 5.625 8.832031 5.625 8.625 L 5.625 8.339844 C 5.625 7.671875 4.816406 7.339844 4.34375 7.8125 L 4.144531 8.011719 C 3.996094 8.15625 3.761719 8.15625 3.613281 8.011719 C 3.46875 7.863281 3.46875 7.628906 3.613281 7.480469 L 3.816406 7.28125 C 4.285156 6.808594 3.953125 6 3.285156 6 L 3 6 C 2.792969 6 2.625 5.832031 2.625 5.625 C 2.625 5.417969 2.792969 5.25 3 5.25 L 3.285156 5.25 C 3.953125 5.25 4.285156 4.441406 3.8125 3.96875 L 3.613281 3.769531 C 3.46875 3.621094 3.46875 3.386719 3.613281 3.238281 C 3.761719 3.09375 3.996094 3.09375 4.144531 3.238281 L 4.34375 3.441406 C 4.816406 3.910156 5.625 3.578125 5.625 2.910156 L 5.625 2.625 C 5.625 2.417969 5.792969 2.25 6 2.25 C 6.207031 2.25 6.375 2.417969 6.375 2.625 L 6.375 2.910156 C 6.375 3.578125 7.183594 3.910156 7.65625 3.4375 L 7.855469 3.238281 C 8.003906 3.09375 8.238281 3.09375 8.386719 3.238281 C 8.53125 3.386719 8.53125 3.621094 8.386719 3.769531 L 8.1875 3.96875 C 7.714844 4.441406 8.046875 5.25 8.714844 5.25 L 9 5.25 C 9.207031 5.25 9.375 5.417969 9.375 5.625 C 9.375 5.832031 9.207031 6 9 6 Z M 6.75 6 C 6.542969 6 6.375 6.167969 6.375 6.375 C 6.375 6.582031 6.542969 6.75 6.75 6.75 C 6.957031 6.75 7.125 6.582031 7.125 6.375 C 7.125 6.167969 6.957031 6 6.75 6 Z M 6.75 6 "/>
												</g>
												</svg>
											</div>
											<%}else{ %>
											<div style="margin-right: 17px; margin-top:3px; float: left;">
												<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="11pt" height="12pt" viewBox="0 0 11 12" version="1.1">
												<g id="surface1">
												<path style=" stroke:none;fill-rule:nonzero;fill:#009688;fill-opacity:1;" d="M 7.84375 7.5 L 5.5 9.734375 L 3.15625 7.5 C 1.402344 7.574219 0 8.945312 0 10.636719 C 0 11.390625 0.640625 12 1.429688 12 L 9.570312 12 C 10.359375 12 11 11.390625 11 10.636719 C 11 8.945312 9.597656 7.574219 7.84375 7.5 Z M 5.5 7.125 C 7.234375 7.125 8.644531 5.78125 8.644531 4.125 L 8.644531 1.542969 C 8.644531 1.230469 8.441406 0.949219 8.132812 0.839844 L 6.050781 0.09375 C 5.695312 -0.03125 5.304688 -0.03125 4.949219 0.09375 L 2.867188 0.839844 C 2.558594 0.949219 2.355469 1.230469 2.355469 1.542969 L 2.355469 4.125 C 2.355469 5.78125 3.765625 7.125 5.5 7.125 Z M 4.519531 1.679688 C 4.519531 1.613281 4.574219 1.5625 4.640625 1.5625 L 5.171875 1.5625 L 5.171875 1.054688 C 5.171875 0.988281 5.226562 0.9375 5.296875 0.9375 L 5.703125 0.9375 C 5.773438 0.9375 5.828125 0.988281 5.828125 1.054688 L 5.828125 1.5625 L 6.359375 1.5625 C 6.425781 1.5625 6.480469 1.613281 6.480469 1.679688 L 6.480469 2.070312 C 6.480469 2.136719 6.425781 2.1875 6.359375 2.1875 L 5.828125 2.1875 L 5.828125 2.695312 C 5.828125 2.761719 5.773438 2.8125 5.703125 2.8125 L 5.296875 2.8125 C 5.226562 2.8125 5.171875 2.761719 5.171875 2.695312 L 5.171875 2.1875 L 4.640625 2.1875 C 4.574219 2.1875 4.519531 2.136719 4.519531 2.070312 Z M 3.535156 3.75 L 7.464844 3.75 L 7.464844 4.125 C 7.464844 5.160156 6.585938 6 5.5 6 C 4.414062 6 3.535156 5.160156 3.535156 4.125 Z M 3.535156 3.75 "/>
												</g>
												</svg>
											</div>
											<%} %>
												<sub class="comment-writer"><input class="BackCommentWrit" value="<%=hbc.getHealthBoardCommentWriter()%>" disabled="disabled"/>
													 |
												</sub>
												<sub class="comment-date">
													<%=hbc.getHealthBoardCommentDate()%>
												</sub>
												<br />
												<%=hbc.getHealthBoardCommentContent()%>
											</td>
											<td>
												<%if(userLoggedIn !=null && (userLoggedIn.getUserId().equals(hbc.getHealthBoardCommentWriter())
														|| userLoggedIn.getUserRole().equals(MemberService.MEMBER_ROLE_ADMIN))){ %>
												<button class="btn-delete" value="<%=hbc.getHealthBoardCommentNo()%>">삭제</button>
												<%
												  }else if(hospLoggedIn!=null && hospLoggedIn.getHospId().equals(hbc.getHealthBoardCommentWriter())){ %>
												<button class="btn-delete" value="<%=hbc.getHealthBoardCommentNo()%>">삭제</button>
												<%}%>
											</td>
										</tr>
								<%  	}
									}
								} %>
							</table>
					</div>
					<div class="paging3" style="text-align: center;">
						<%=pageBar%>
					</div>
				</div>
			</th>
		</tr>
		
	</table>
	<br />
	
</section>
<%if(userLoggedIn!=null||hospLoggedIn!=null){%>
	<form name="deleteBoardFrm" action="<%=request.getContextPath()%>/healthBoard/healthBoardDelete" method="post">
		<input type="hidden" name="boardNo" value="<%=hb.getBoardNo()%>" />
		<input type="hidden" name="fileName" value="<%=hb.getBoardRenamedFileName()!=null?hb.getBoardRenamedFileName():""%>" />
	</form>
	<form name="deleteCommentFrm" action="<%= request.getContextPath()%>/healthBoard/healthBoardCommentDelete" method="post">
		<input type="hidden" name="boardCommentNo" value="" />
		<input type="hidden" name="boardNo" value="<%=hb.getBoardNo()%>" />
	</form>
	<script>
		function deleteBoard() {
			if(!confirm('게시글을 정말 삭제하시겠습니까?')){
				return;
			}
			$("[name=deleteBoardFrm]").submit();
		}
	</script>
	<%} %>
	
<%@ include file="/WEB-INF/views/common/footer.jsp"%>