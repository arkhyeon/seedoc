<%@page import="healthBoard.model.vo.HealthBoard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%

	HealthBoard hb = (HealthBoard)request.getAttribute("healthBoard");

%>
<script>
$(function() {
    $('.BOARD_TEXT').keyup(function (e){
        var content = $(this).val();
        $('#counter').html('('+ content.length + '/2000)');
        if (content.length > 2000){
            alert("최대 2000자까지 입력 가능합니다.");
        }
    });
    $('.BOARD_TEXT').keyup();
});
</script>
<link rel="stylesheet" href="../css/healthBoard.css">
<section>
	<h1>건강상식 게시판</h1>
	<form action="<%=request.getContextPath()%>/healthBoard/healthBoardUpdate" method="post" enctype="multipart/form-data">
	<input type="hidden" name="boardNo" value="<%=hb.getBoardNo()%>" />
	<table class="bbc1">
	<tr>
		<th style="background: #9e9e9e47">제 목</th>
		<td><input type="text" name="boardTitle" id="boardTitle" value="<%=hb.getBoardTitle()%>" required style="border: 3px solid #060a1936;"></td>
	</tr>
	<tr>
		<th style="background:#9e9e9e47">작성자</th>
		<td>
			<input type="text" name="boardWriter" id="boardWriter" value="<%=hb.getBoardWriter()%>" readonly style="border: 0px;"/>
		</td>
	</tr>
	<tr>
		<th style="background: #9e9e9e47">첨부파일</th>
		<td style="position: relative;">
			<div class="filebox up_Image">
			<input class="upload-name1" value="<%=hb.getBoardOriginalFileName()!=null?hb.getBoardOriginalFileName():"파일 선택" %>" disabled="disabled" />
			<input type="hidden" name="oldOrginalFileName" value="<%=hb.getBoardOriginalFileName()!=null?hb.getBoardOriginalFileName():""%>" />
			<input type="hidden" name="oldRenamedFileName" value="<%=hb.getBoardRenamedFileName()!=null?hb.getBoardRenamedFileName():""%>" />
				<label for="up_file">업로드</label>
				<input type="file" name="upFile" id="up_file" class="upload-hidden">
				<%if(hb.getBoardOriginalFileName()!=null){ %>
				<input type="checkbox" name="delFile" id="delFile" />
				<label for="delFile">첨부파일 삭제</label>
				<%} %>
			</div>
		</td>
	</tr>
	<tr>
		<th style="background: #9e9e9e47">내 용</th>
		<td><textarea class="BOARD_TEXT" rows="5" cols="40" name="boardContent" id="boardContent" style="border:2px solid #cdcdcd; padding:8px 7px; width:95%; resize: none; font-size: 25px" placeholder="내용은 2000자 이내로 적어주세요."><%=hb.getBoardContent()%></textarea>
		<br />
		<span style="color: red" id="counter">(0/최대 2000자)</span>
		</td>
	</tr>
	<tr>
		<th colspan="2">
			<input type="submit" value="수정하기" onclick="return boardValidate();">
			<input type="button" value="취소" onclick="endBoardView();" style="float: right; margin-right: 5px">
		</th>
	</tr>
</table>
</form>
<script>
	$(document).ready(function(){
		var fileTarget = $('.filebox .upload-hidden'); 
		fileTarget.on('change', function(){
			// 값이 변경되면 
			if(window.FileReader){ // modern browser 
				var filename = $(this)[0].files[0].name; } 
			else { // old IE 
				var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출 
				} 
			// 추출한 파일명 삽입 
			$(this).siblings('.upload-name1').val(filename);
			});
		});
	var imgTarget = $('.up_Image .upload-hidden');
	imgTarget.on('change', function(){ 
		var parent = $(this).parent(); 
		parent.children('.upload_display').remove(); 
		if(window.FileReader){ //image 파일만 
			if (!$(this)[0].files[0].type.match(/image\//)) return;
		var reader = new FileReader(); 
		reader.onload = function(e){ 
			var src = e.target.result; 
			parent.prepend('<div class="upload_display"><div class="upload_wrap"><img src="'+src+'"></div></div>'); 
			} 
			reader.readAsDataURL($(this)[0].files[0]); 
		} 
		else { 
			$(this)[0].select(); 
			$(this)[0].blur(); 
			var imgSrc = document.selection.createRange().text; 
			parent.prepend('<div class="upload_display"><div class="upload_wrap"><img ></div></div>'); 
			var img = $(this).siblings('.upload_display').find('img'); 
			img[0].style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""+imgSrc+"\")"; 
		} 
	});
	function endBoardView(){
		history.go(-1);
	}
	function boardValidate(){
		let boardTitle = $("#boardTitle").val();
		let boardContent = $("#boardContent").val();
		if(boardTitle.replace(/\s|/gi,"").length==0){
			alert("제목을 입력하시오.");
			$("#boardTitle").focus();
			return false;
		}
		if(boardContent.replace(/\s|/gi,"").length==0){
			alert("내용을 입력하시오.");
			$("#boardContent").focus();
			return false;
		}
		return true;
	}
	
</script>	
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>