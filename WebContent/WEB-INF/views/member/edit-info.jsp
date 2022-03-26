<%@page import="member.model.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<%

	User u = (User)request.getAttribute("user");

	System.out.println(u);
	String userSymptom = u.getUserSymptom()!=null?u.getUserSymptom():"";
	
	String birth = null;
	if("1".equals(u.getUserBirth().substring(7)) || "2".equals(u.getUserBirth().substring(7))){
		birth = "19"+ u.getUserBirth().substring(0, 6);
	} else {
		birth = "20"+ u.getUserBirth().substring(0, 6);
	}
	
	birth = birth.substring(0,4) + "-" + birth.substring(4,6) + "-" + birth.substring(6);

	String userEmailDirect = u.getUserEmail().substring(u.getUserEmail().lastIndexOf("@"));

%>

<link rel="stylesheet" href="../css/member-edit-info.css">
<script>

$(function () {
	$("#email").css('width','5px');
	$("#email").change(function () {
		var emailText = $("#email option:selected").text();
		if(emailText=="직접입력"){
			$("#email").css('width','5px');
			$("#emailDirect").show();
		}else{
			$("#email").css('width','184px');
			$("#emailDirect").hide();
		}
	});
	
	
	$("#userPwdCheck").keyup(function () {
		let $pwd1 = $("#userPwd");
		let $pwd2 = $("#userPwdCheck");
	    
	    if($pwd1.val() == $pwd2.val()){
	        $('#p-pwdCheck').css('opacity', '0');
	        return true;
	    }
	    else{
	        $('#p-pwdCheck').css('opacity', '1');
	        return false;
	    }
	});
	$("[name=memberUpdateFrm]").submit(function() {
		/* var newdate = new Date(); */
		
		/* if($("#userBirth") == newdate){
			alert("생년월일을 적어주세요.");
			return false;			
		} */
		/* if($("input:radio[name=userGender]:checked").val() == 'M'){
			var result = confirm("남자가 맞습니까?");
			if(result){
				
			}else{
				return false;
			}
		} */
		return true;
	});
});


function openPopup1() {
	//팝업생성
	let url = "<%= request.getContextPath()%>/jusoPopup1";
	let title = "jusoPopup";
	let spec = "width=600px, height=500px";
	open(url, title, spec);

}

function jusoCallBack1(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
	$("#memberAddr2").val(roadFullAddr); // 도로명주소
self.close();

}
function deleteMember() {
	if(!confirm("정말 탈퇴하시겠습니까?")) return;
	
	$("[name=deleteMemberFrm]").submit();
}
</script>
<section>
        <article>
            <div class="register">
                <h1 id="title">회원 정보 수정</h1>
                <div class="member">
	                <form name="memberUpdateFrm" action="<%=request.getContextPath()%>/member/memberUpdate" method="post" >
						<input type="hidden" class="user-input check-input" name="userId" id="userId" value="<%=u.getUserId()%>" readonly>
	                    <label class="text-label">비밀번호<span>*</span></label>
	                    <input type="password" class="user-input" name="userPwd" id="userPwd" placeholder="4자이상" required>
	                    <input type="password" placeholder="비밀번호 확인" class="user-input" name="userPwdCheck" id="userPwdCheck"  required>
	                    <p id="p-pwdCheck">비밀번호가 일치하지 않습니다.</p>
	
	                    <label class="text-label">이름 (실명 입력)<span>*</span></label>
	                    <input type="text" class="user-input" name="userName" value="<%=u.getUserName()%>" required>
	
	                    <label class="text-label">이메일<span>*</span></label>
	                    <input type="text" class="user-input check-input2" name="userEmail" placeholder="qwerty" 
	                    <%String email = u.getUserEmail();
	                    	int s = email.indexOf("@");
	                    	String email_id = email.substring(0, s);
	                    	String email_domain = email.substring(s+1);
	                    %>
	                    value="<%=email_id%>" required>
					    <select name="userEmail2" id="email" class="user-input check-input3"<%--  <%="".contains(email_domain)?"selected":""%> --%> required>
					        <option value="">선택하시오.</option>
					        <option value="@naver.com" <%= u.getUserEmail()!=null && u.getUserEmail().contains("@naver") ? "selected":"" %>>@naver.com</option>
					        <option value="@gmail.com" <%= u.getUserEmail()!=null && u.getUserEmail().contains("@gmail") ? "selected":"" %>>@gmail.com</option>
					        <option value="@yahoo.co.kr" <%= u.getUserEmail()!=null && u.getUserEmail().contains("@yahoo") ? "selected":"" %>>@yahoo.co.kr</option>
					        <option value="@nate.com" <%= u.getUserEmail()!=null && u.getUserEmail().contains("@nate") ? "selected":"" %>>@nate.com</option>
					        <option value="@hanmail.net" <%= u.getUserEmail()!=null && u.getUserEmail().contains("@hanmail") ? "selected":"" %>>@hanmail.net</option>
					        <option value="1"  <%= u.getUserEmail()!=null && !(u.getUserEmail().contains("@naver"))&& !(u.getUserEmail().contains("@gmail"))&& !(u.getUserEmail().contains("@yahoo"))&& !(u.getUserEmail().contains("@nate"))&& !(u.getUserEmail().contains("@hanmail")) ? "selected":""  %>>직접입력</option>
					    </select>
	                    <input type="text" name="emailDirect" id="emailDirect" class="user-input check-input4" placeholder="@aaaa.com" value="<%=userEmailDirect%>" style="width: 145px" />
	                    
	                    
	                    <label class="text-label" style="clear: both;">휴대전화번호<span>*</span></label>
	                    <input type="text" class="user-input" name="userPhone" placeholder="'-'를 제외하고적으시오" value="<%=u.getUserPhone() %>" required>
						
						<div style="width: 60%; float: left;">
		                    <label class="text-label" style="width: 80%">생년월일<span>*</span></label>
		                    <input type="date" class="user-input check-input1" id="" name="userBirth" value="<%=birth%>">
						</div>
	                    
	                    <div class="gender-Check">
		                    <label class="text-label">성별<span>*</span></label>
		                    <div style="margin-top: 15px">
			                    <input type="radio" name="userGender" value="M" id="userGender" <%="M".equals(u.getUserGender())?"checked":"" %>>
			                    <label class="reg-label" for="male">남성</label>
			                    <input type="radio" name="userGender" value="F" id="userGender" <%="F".equals(u.getUserGender())?"checked":"" %>>
			                    <label class="reg-label" for="female">여성</label>
		                    </div>
	                    </div>
	                    <label class="text-label" style="clear: both;">주소</label>
	                    <input type="text" class="user-input check-input" placeholder="우편번호 주소" name="userAddr" id="memberAddr2" 
	                    value="<%=u.getUserAddr()!=null?u.getUserAddr():""%>">
	                    <div class="check-btn1" onclick="openPopup1();">우편번호 검색</div>
						
						<label class="text-label">주요 증상</label>
	                    <textarea name="userSymptom" id="userSymptom" class="user-input" cols="30" rows="30" style="padding:9px 9px; resize: none; height: 100px;" placeholder="많이 아픈걸 적으시오"><%=userSymptom%></textarea>
						
						<input type="submit" value="정보수정" class="submit-btn"/>
						<input type="button" value="탈퇴" class="submit-btn" onclick="deleteMember();"/>
	                </form>
                   </div>
              </div>
        </article>
    </section>
     <form action="<%=request.getContextPath() %>/member/deleteMember" name="deleteMemberFrm" method="POST">
				<input type="hidden" name="userId" value="<%=u.getUserId()%>" />
				</form>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>