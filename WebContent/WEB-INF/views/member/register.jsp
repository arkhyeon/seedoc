<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" href="../css/register.css">
<script>
$(function() {
	$("#emailDirect").hide();
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
	$("[name=memberEnrollFrm]").submit(function() {
		//성별확인
		if(!$("[name=userGender]").is(':checked')){
			alert("성별을 선택해주세요");
			return false;			
		}
		/* else {
			confirm("선택하신 성별이 남성이 맞습니까?");
		} */
		//아이디 중복검사 여부
		let $isIdValid = $("#isIdValid");
		console.log($isIdValid.val());
		if($isIdValid.val()==0) {
			alert("아이디 중복검사 해주세요");
			return false;
		}
		//아이디검사
		let $userId = $("#userId_");
		if(!/^[\w]{4,}$/.test($userId.val())) {
			alert("아이디가 유효하지 않습니다.");
			$userId.focus();
			return false;
		}
		var newdate = new Date();
		
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
		if($("#memberCheck-1").is(":checked") == false) {
			alert("이용약관에 동의해주세요.");
			return false;			
		}
		if($("#memberCheck-2").is(":checked")== false){
			alert("개인정보 취급방침에 동의해주세요.");
			return false;			
		}
		
		return true;
	});
	
	$("#hospPwdCheck").keyup(function () {
		//console.log("실행");
		let $pwd1 = $("#hospPwd");
		let $pwd2 = $("#hospPwdCheck");
	    
	    if($pwd1.val() == $pwd2.val()){
	        $('#p-pwdCheck').css('opacity', '0');
	        return true;
	    }
	    else{
	        $('#p-pwdCheck').css('opacity', '1');
	        //alert("비밀번호가 일치하지 않습니다.");
	        // pwd.select();
	        return false;
	    }
	});
	
	$("[name=hospEnrollFrm]").submit(function() {

		//아이디 중복검사 여부
		let $isIdValid = $("#isIdValid");
		console.log($isIdValid.val());
		if($isIdValid.val()==0) {
			alert("아이디 중복검사 해주세요");
			return false;
		}
		if($isIdValid.val()==2) {
			//alert("사용할 수 없는 아이디입니다.");
			return false;
		}
		//아이디검사
		let $hospId = $("#hospId_");
		if(!/^[\w]{4,}$/.test($hospId.val())) {
			alert("아이디가 유효하지 않습니다.");
			$hospId.focus();
			return false;
		}
		//비밀번호검사
		let $pwd1 = $("#hospPwd");
		let $pwd2 = $("#hospPwdCheck");
		if($pwd1.val() !== $pwd2.val()) {
			//alert("비밀번호가 일치하지 않습니다.");
			$pwd1.focus();
			return false;
		}
		if($("#hospCheck-1").is(":checked") == false) {
			alert("이용약관에 동의해주세요.");
			return false;			
		}
		if($("#hospCheck-2").is(":checked")== false){
			alert("개인정보 취급방침에 동의해주세요.");
			return false;			
		}
		
		return true;
	});
});

function checkIdDuplicate() {
	let $hospId = $("#hospId_");
	if(!/^[\w]{4,}$/.test($hospId.val())) {
		alert("유효한 아이디를 입력해주세요");
		$hospId.select();
		return;
	}
	
	$.ajax({
		url: "<%= request.getContextPath() %>/hospital/checkIdDuplicate",
		method: "GET",
		dataType: "json",
		data: {
			hospId: $hospId.val()
			},
		success: function(res) {
			//console.log(res);
			//table#celeb-result
			if(res) {
				//alert("사용가능한 아이디입니다.");
				$('#p-hospId1').css('opacity', '1');
				$('#p-hospId2').css('opacity', '0');
				$("#isIdValid").val(1);
			} else {
				//alert("이미 사용중이거나 탈퇴한 아이디입니다.");
				$('#p-hospId1').css('opacity', '0');
				$('#p-hospId2').css('opacity', '1');
				$("#isIdValid").val(2);
				$hospId.select();
			}
		},
		error: function(xhr, status, err) {
			console.log(xhr, status, err);
		}
	});
}

function openPopup() {
	//팝업생성
	let url = "<%= request.getContextPath()%>/jusoPopup";
	let title = "jusoPopup";
	let spec = "width=600px, height=500px";
	open(url, title, spec);

}

function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){

    // 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
	//console.log(roadFullAddr);
	$("#hospAddr").val(roadFullAddr); // 도로명주소

	//$("#addr-detail").val(addrDetail); // 상세주소

	//$("#addr-no").val(zipNo); // 우편번호

	self.close();

}
function checkIdDuplicate1() {
	let $userId = $("#userId_");
	if(!/^[\w]{4,}$/.test($userId.val())) {
		alert("유효한 아이디를 입력해주세요");
		$userId.select();
		return;
	}
	$.ajax({
		url: "<%= request.getContextPath() %>/member/checkIdDuplicate",
		method: "GET",
		dataType: "json",
		data: {
			userId: $userId.val()
			},
		success: function(res) {
			if(res) {
				$('#p-userId1').css('opacity', '1');
				$('#p-userId2').css('opacity', '0');
				$("#isIdValid").val(1);
			} else {
				$('#p-userId1').css('opacity', '0');
				$('#p-userId2').css('opacity', '1');
				$("#isIdValid").val(2);
				$userId.select();
			}
		},
		error: function(xhr, status, err) {
			console.log(xhr, status, err);
		}
	});
}
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
//성별 확인

</script>
<section>
        <article>
            <div class="register">
                <h1 id="title">회원가입</h1>
                <div class="reg-type">
                    <div class="member-btn">회 원</div>
                    <div class="doctor-btn off">병 원</div>
                </div>
                <div class="member">
	                <form name="memberEnrollFrm" action="<%=request.getContextPath()%>/member/memberEnroll" method="post" >
	                	<input type="hidden" id="isIdValid" value="0"/>
	                	<p id="required">* 표시 항목은 필수 항목입니다.</p>
	                    <label class="text-label">아이디<span>*</span></label>
	                    <input type="text" class="user-input check-input" name="userId" id="userId_" placeholder="아이디 4글자이상" required>
	                    <div class="check-btn" onclick="checkIdDuplicate1();">중복확인</div>
	                    <p id="p-userId1">사용가능한 아이디입니다.</p>
	                    <p id="p-userId2">이미 사용중이거나 탈퇴한 아이디입니다.</p>
	
	                    <label class="text-label">비밀번호<span>*</span></label>
	                    <input type="password" class="user-input" name="userPwd" id="userPwd" placeholder="4자이상" required>
	                    <input type="password" placeholder="비밀번호 확인" class="user-input" name="userPwdCheck" id="userPwdCheck" required>
	                    <p id="p-pwdCheck">비밀번호가 일치하지 않습니다.</p>
	
	                    <label class="text-label">이름 (실명 입력)<span>*</span></label>
	                    <input type="text" class="user-input" name="userName" required>
	
	                    <label class="text-label">이메일<span>*</span></label>
	                    <input type="text" class="user-input check-input2" name="userEmail" placeholder="qwerty" required>
					    <select name="userEmail2" id="email" class="user-input check-input3" required>
					        <option value="">선택하시오.</option>
					        <option value="@naver.com">@naver.com</option>
					        <option value="@gmail.com">@gmail.com</option>
					        <option value="@yahoo.co.kr">@yahoo.co.kr</option>
					        <option value="@nate.com">@nate.com</option>
					        <option value="@hanmail.net">@hanmail.net</option>
					        <option value="1">직접입력</option>
					    </select>
	                   
	                    <input type="text" name="emailDirect" id="emailDirect" class="user-input check-input4" placeholder="@aaaa.com" />
	                    
	                    <label class="text-label" style="clear: both;">휴대전화번호<span>*</span></label>
	                    <input type="text" class="user-input" name="userPhone" placeholder="'-'를 제외하고적으시오" required>
						
						<div style="width: 60%; float: left;">
		                    <label class="text-label" style="width: 80%">생년월일<span>*</span></label>
		                    <input type="date" class="user-input check-input1" id="" name="userBirth" required>
						</div>
	                    
	                    <div class="gender-Check">
		                    <label class="text-label">성별<span>*</span></label>
		                    <div style="margin-top: 15px">
			                    <input type="radio" name="userGender" value="M" id="userGenderM">
			                    <label class="reg-label" for="userGenderM">남성</label>
			                    <input type="radio" name="userGender" value="F" id="userGenderF">
			                    <label class="reg-label" for="userGenderF">여성</label>
		                    </div>
	                    </div>
	                    <label class="text-label" style="clear: both;">주소</label>
	                    <input type="text" class="user-input check-input" name="userAddr" id="memberAddr2">
	                    <div class="check-btn1" onclick="openPopup1();">우편번호 검색</div>
						
						<label class="text-label">주요 증상</label>
	                    <textarea name="userSymptom" id="userSymptom" class="user-input" cols="30" rows="30" style="padding:9px 9px; resize: none; height: 100px;" placeholder="많이 아픈걸 적으시오"></textarea>
						
	                    <div class="agree-wrap use-agree">
	                        <input type="checkbox" name="agreement" id="memberCheck-1">
	                        <label class="reg-label" for="memberCheck-1">이용약관 동의</label>
	                        <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="11px"
	                            height="7px">
	                            <path fill-rule="evenodd" fill="rgb(55, 59, 68)"
	                                d="M5.082,6.261 L0.255,1.433 C0.033,1.211 0.033,0.851 0.255,0.629 C0.477,0.407 0.838,0.407 1.060,0.629 L5.887,5.456 C6.109,5.678 6.109,6.038 5.887,6.261 C5.665,6.483 5.305,6.483 5.082,6.261 Z" />
	                            <path fill-rule="evenodd" fill="rgb(55, 59, 68)"
	                                d="M5.082,6.261 C4.860,6.038 4.860,5.678 5.082,5.456 L9.910,0.629 C10.132,0.407 10.492,0.407 10.714,0.629 C10.936,0.851 10.936,1.211 10.714,1.433 L5.887,6.261 C5.665,6.483 5.305,6.483 5.082,6.261 Z" />
	                        </svg>
	                        <p>
	                            <br><span>제 1 조 (목적)</span><br><br>
	                            이 약관은 주식회사 KH (이하 회사라 함)가 제공하는 서비스(SeeDoc)와 관련하여 회사와 회원의 권리, 의무, 이용조건, 이용절차 등 기본적인 사항을
	                            규정합니다.
	
	                            <br><br><span>제 2 조 (정의)</span><br><br>
	
	
	                            ① 이 약관에서 사용하는 용어의 정의는 다음과 같습니다.
	                            <br><br>
	
	                            1. 서비스라 함은 구현되는 장치(PC, 휴대형장치 등의 각종 유무선 장치를 포함)와 상관없이 회원이 이용할 수 있는 씨닥(SeeDoc)의 관련 제반
	                            서비스를 의미합니다.
	                            <br><br>
	                            2. 회원이라 함은 회원등록 시 설정한 아이디(ID)로 사이트에 자유롭게 접속하여 사이트의 정보를 지속적으로 제공받을 수 있거나 사이트가 제공하는 서비스를 계속적으로
	                            이용할 수 있는 자를 말합니다.
	                            <br><br>
	                            3. 아이디(ID)라 함은 회원의 식별, 정보 제공 및 서비스 이용을 위하여 회원이 설정하고 회사가 승인하여 사이트에 등록된 전자우편주소(e-mail)를 말합니다.
	                            <br><br>
	                            4. 비밀번호라 함은 회원이 부여 받은 아이디와 일치 되는 회원임을 확인하고 비밀보호를 위해 회원 문자, 특수문자, 숫자 중 하나 이상의 조합입니다.
	                            <br><br>
	                            5. 장치라 함은 서비스에 접속하기 위해 회원이 이용하는 개인용 컴퓨터, PDA, 휴대전화, 태블릿PC 등의 전산장치를 말합니다.
	                            <br><br>
	                            6. 해지라 함은 회사 또는 회원이 이용계약을 해약하는 것을 말합니다.
	                            <br><br>
	                            7. 게시물이라 함은 회원이 서비스를 이용함에 있어 서비스상에 게시한 부호ㆍ문자ㆍ음성ㆍ음향ㆍ화상ㆍ동영상 등의 정보 형태의 글, 사진, 동영상 및 각종 파일과 링크
	                            등을 의미합니다.
	                            <br><br>
	
	                            ② 이 약관에서 사용하는 용어의 정의는 제1항에서 정하는 것을 제외하고는 관계 법령 및 각 서비스 별 안내에서 정하는 바에 의합니다. 관계 법령과 각 서비스 별
	                            안내에서 정하지 않은 것은 일반적인 상관례에 의합니다.
	                        </p>
	                    </div>
	                    <div class="agree-wrap personal-agree">
	                        <input type="checkbox" name="agreement" id="memberCheck-2">
	                        <label class="reg-label" for="memberCheck-2">개인정보 취급방침 동의</label>
	                        <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="11px"
	                            height="7px">
	                            <path fill-rule="evenodd" fill="rgb(55, 59, 68)"
	                                d="M5.082,6.261 L0.255,1.433 C0.033,1.211 0.033,0.851 0.255,0.629 C0.477,0.407 0.838,0.407 1.060,0.629 L5.887,5.456 C6.109,5.678 6.109,6.038 5.887,6.261 C5.665,6.483 5.305,6.483 5.082,6.261 Z" />
	                            <path fill-rule="evenodd" fill="rgb(55, 59, 68)"
	                                d="M5.082,6.261 C4.860,6.038 4.860,5.678 5.082,5.456 L9.910,0.629 C10.132,0.407 10.492,0.407 10.714,0.629 C10.936,0.851 10.936,1.211 10.714,1.433 L5.887,6.261 C5.665,6.483 5.305,6.483 5.082,6.261 Z" />
	                        </svg>
	                        <p>
	                            <br><span>[개인정보처리방침]</span><br><br>
	
	                            주식회사 KH(이하 "회사")는 이용자의 개인정보를 매우 중요하게 생각하며, 『개인정보 보호법』, 『정보통신망 이용촉진 및 정보보호 등에 관한 법률』등 개인정보와
	                            관련된 법령 상의 개인정보보호 규정을 준수하고 있습니다.
	                            <br><br>
	                            회사는 아래와 같이 개인정보처리방침을 명시하여 이용자가 회사에 제공한 개인정보가 어떠한 용도와 방식으로 이용되고 있으며 개인정보보호를 위해 어떠한 조치를 취하는지
	                            알려드립니다.
	                            <br><br>
	                            회사의 개인정보처리방침은 법령 및 고시 등의 변경 또는 회사의 약관 및 내부 정책에 따라 변경될 수 있으며 이를 개정하는 경우 회사는 변경사항에 대하여 서비스 화면에
	                            게시하거나 이용자에게 고지하고 있습니다.
	                            <br><br>
	                            본 개인정보처리방침은 회사가 제공하는 “홈페이지(www.seedoc.com 등 씨닥(SeeDoc) 서비스 도메인)” (이하에서는 홈페이지 및 어플리케이션을 이하
	                            "서비스"라 합니다.) 이용에 적용되며 다음과 같은 내용을 담고 있습니다.
	
	                        </p>
	                    </div>
							<input type="submit" value="회원가입" class="submit-btn"/>
	                </form>
                </div>
                <div class="doctor" style="display: none;">
                	<form name="hospEnrollFrm" action="<%=request.getContextPath()%>/hospital/hospitalEnroll" method="post" enctype="multipart/form-data">
						<input type="hidden" id="isIdValid" value="0"/>
						<p id="required">* 표시 항목은 필수 항목입니다.</p>
                    	<label class="text-label">아이디<span>*</span></label>
	                    <input type="text" class="user-input check-input" name="hospId" id="hospId_" required>
	                    <div class="check-btn" onclick="checkIdDuplicate();">중복확인</div>
	                    <p id="p-hospId1">사용가능한 아이디입니다.</p>
	                    <p id="p-hospId2">이미 사용중이거나 탈퇴한 아이디입니다.</p>
	
	                    <label class="text-label">비밀번호<span>*</span></label>
	                    <input type="password" class="user-input" name="hospPwd" id="hospPwd" required>
	                    <input type="password" placeholder="비밀번호 확인" class="user-input" name="hospPwdCheck" id="hospPwdCheck" required>
	                    <p id="p-pwdCheck">비밀번호가 일치하지 않습니다.</p>
	
	                    <label class="text-label">병원이름<span>*</span></label>
	                    <input type="text" class="user-input" name="hospName" id="hospName" required>
	
	                    <label class="text-label">병원전화번호 ('-'포함)<span>*</span></label>
	                    <input type="text" class="user-input" name="hospTel" id="hospTel" required>
	
	                    <label class="text-label">주소<span>*</span></label>
	                    <input type="text" class="user-input check-input" name="hospAddr" id="hospAddr" required>
	                    <div class="check-btn" onclick="openPopup();">우편번호 검색</div>
	
	                    <label class="text-label">병원소개글</label>
	                    <textarea name="hospInfo" id="hospInfo" class="user-input" cols="30" rows="30" style="padding:9px 9px; resize: none; height: 100px;"></textarea>
	                    
	                    <fieldset>
	                    <legend>병원사진</legend>
							<label for="up_file">로고이미지</label>
		                    <input type="file" name="upFile1" id="up_file" class="upload-hidden"><br />
                			<label for="up_file2">대표이미지</label>
	                    	<input type="file" name="upFile2" id="up_file2" class="upload-hidden">
	                    </fieldset>
	                    
	                    <fieldset>
	                    <legend>편의시설</legend>
	                    <input type="checkbox" name="HospConv" id="wifi" value="무선인터넷" />
	                    <label for="wifi">무선인터넷</label>
	                    <input type="checkbox" name="HospConv" id="conv" value="장애인 편의시설" />
	                    <label for="conv">장애인 편의시설</label><br />
	                    <input type="checkbox" name="HospConv" id="toilet" value="남/녀 화장실 구분" />
	                    <label for="toilet">남/녀 화장실 구분</label>
	                    <input type="checkbox" name="HospConv" id="parking" value="주차" />
	                    <label for="parking">주차</label><br />
	                    <input type="checkbox" name="HospConv" id="valet" value="발렛파킹" />
	                    <label for="valet">발렛파킹</label>
	                    </fieldset>
	                    
	                    <fieldset>
	                    <legend>진료시간</legend>
	                   	<div class="hosp-time">
	                   	    <% String[] weekDay = {"mon", "tue", "wed", "thu", "fri", "sat", "sun" };
					         String[] openTime = {"9:00","9:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00"}; 
					         String[] closeTime = {"18:00","18:30","19:00","19:30","20:00","20:30","21:00"}; 
					         String[] week = {"월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"}; %>
					        
					        <% for(int i=0; i<7; i++) {%>
					        	<label for="<%= weekDay[i] %>"><%= week[i] %></label>
					        	<select name="<%= weekDay[i] %>-open" id="">
					        		<option value="">오픈시간</option>
					        	<% for(int j=0; j<openTime.length; j++) {%>
					        		<option value="<%=openTime[j]%>"><%=openTime[j]%></option>
					           	<% } %>
					           	</select>~
					        	<select name="<%= weekDay[i] %>-close" id="">
					        		<option value="">마감시간</option>
					           	<% for(int k=0; k<closeTime.length; k++) {%>
					        		<option value="<%=closeTime[k]%>"><%=closeTime[k]%></option>
					           	<% } %>
					           	</select><br />
					        <% } %>
	                   	<label for="">점심시간</label>
					        <select name="lunch-open" id="lunch-open">
					            <option value="">시작</option>
					            <option value="11:00">11:00</option>
					            <option value="11:30">11:30</option>
					            <option value="12:00">12:00</option>
					            <option value="12:30">12:30</option>
					            <option value="13:00">13:00</option>
					        </select>~
					        <select name="lunch-close" id="lunch-close">
					            <option value="">끝</option>
					            <option value="12:00">12:00</option>
					            <option value="12:30">12:30</option>
					            <option value="13:00">13:00</option>
					            <option value="13:30">13:30</option>
					            <option value="14:00">14:00</option>
					        </select>
					        </div>
					        </fieldset>
                    <div class="agree-wrap use-agree">
                        <input type="checkbox" name="agreement" id="hospCheck-1">
                        <label class="reg-label" for="hospCheck-1">이용약관 동의</label>
                        <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="11px"
                            height="7px">
                            <path fill-rule="evenodd" fill="rgb(55, 59, 68)"
                                d="M5.082,6.261 L0.255,1.433 C0.033,1.211 0.033,0.851 0.255,0.629 C0.477,0.407 0.838,0.407 1.060,0.629 L5.887,5.456 C6.109,5.678 6.109,6.038 5.887,6.261 C5.665,6.483 5.305,6.483 5.082,6.261 Z" />
                            <path fill-rule="evenodd" fill="rgb(55, 59, 68)"
                                d="M5.082,6.261 C4.860,6.038 4.860,5.678 5.082,5.456 L9.910,0.629 C10.132,0.407 10.492,0.407 10.714,0.629 C10.936,0.851 10.936,1.211 10.714,1.433 L5.887,6.261 C5.665,6.483 5.305,6.483 5.082,6.261 Z" />
                        </svg>
                        <p>
                            <br><span>제 1 조 (목적)</span><br><br>
                            이 약관은 주식회사 KH (이하 회사라 함)가 제공하는 서비스(SeeDoc)와 관련하여 회사와 회원의 권리, 의무, 이용조건, 이용절차 등 기본적인 사항을
                            규정합니다.

                            <br><br><span>제 2 조 (정의)</span><br><br>


                            ① 이 약관에서 사용하는 용어의 정의는 다음과 같습니다.
                            <br><br>

                            1. 서비스라 함은 구현되는 장치(PC, 휴대형장치 등의 각종 유무선 장치를 포함)와 상관없이 회원이 이용할 수 있는 씨닥(SeeDoc)의 관련 제반
                            서비스를 의미합니다.
                            <br><br>
                            2. 회원이라 함은 회원등록 시 설정한 아이디(ID)로 사이트에 자유롭게 접속하여 사이트의 정보를 지속적으로 제공받을 수 있거나 사이트가 제공하는 서비스를 계속적으로
                            이용할 수 있는 자를 말합니다.
                            <br><br>
                            3. 아이디(ID)라 함은 회원의 식별, 정보 제공 및 서비스 이용을 위하여 회원이 설정하고 회사가 승인하여 사이트에 등록된 전자우편주소(e-mail)를 말합니다.
                            <br><br>
                            4. 비밀번호라 함은 회원이 부여 받은 아이디와 일치 되는 회원임을 확인하고 비밀보호를 위해 회원 문자, 특수문자, 숫자 중 하나 이상의 조합입니다.
                            <br><br>
                            5. 장치라 함은 서비스에 접속하기 위해 회원이 이용하는 개인용 컴퓨터, PDA, 휴대전화, 태블릿PC 등의 전산장치를 말합니다.
                            <br><br>
                            6. 해지라 함은 회사 또는 회원이 이용계약을 해약하는 것을 말합니다.
                            <br><br>
                            7. 게시물이라 함은 회원이 서비스를 이용함에 있어 서비스상에 게시한 부호ㆍ문자ㆍ음성ㆍ음향ㆍ화상ㆍ동영상 등의 정보 형태의 글, 사진, 동영상 및 각종 파일과 링크
                            등을 의미합니다.
                            <br><br>

                            ② 이 약관에서 사용하는 용어의 정의는 제1항에서 정하는 것을 제외하고는 관계 법령 및 각 서비스 별 안내에서 정하는 바에 의합니다. 관계 법령과 각 서비스 별
                            안내에서 정하지 않은 것은 일반적인 상관례에 의합니다.
                        </p>
                    </div>
                    <div class="agree-wrap personal-agree">
                        <input type="checkbox" name="agreement" id="hospCheck-2">
                        <label class="reg-label" for="hospCheck-2">개인정보 취급방침 동의</label>
                        <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="11px"
                            height="7px">
                            <path fill-rule="evenodd" fill="rgb(55, 59, 68)"
                                d="M5.082,6.261 L0.255,1.433 C0.033,1.211 0.033,0.851 0.255,0.629 C0.477,0.407 0.838,0.407 1.060,0.629 L5.887,5.456 C6.109,5.678 6.109,6.038 5.887,6.261 C5.665,6.483 5.305,6.483 5.082,6.261 Z" />
                            <path fill-rule="evenodd" fill="rgb(55, 59, 68)"
                                d="M5.082,6.261 C4.860,6.038 4.860,5.678 5.082,5.456 L9.910,0.629 C10.132,0.407 10.492,0.407 10.714,0.629 C10.936,0.851 10.936,1.211 10.714,1.433 L5.887,6.261 C5.665,6.483 5.305,6.483 5.082,6.261 Z" />
                        </svg>
                        <p>
                            <br><span>[개인정보처리방침]</span><br><br>

                            주식회사 KH(이하 "회사")는 이용자의 개인정보를 매우 중요하게 생각하며, 『개인정보 보호법』, 『정보통신망 이용촉진 및 정보보호 등에 관한 법률』등 개인정보와
                            관련된 법령 상의 개인정보보호 규정을 준수하고 있습니다.
                            <br><br>
                            회사는 아래와 같이 개인정보처리방침을 명시하여 이용자가 회사에 제공한 개인정보가 어떠한 용도와 방식으로 이용되고 있으며 개인정보보호를 위해 어떠한 조치를 취하는지
                            알려드립니다.
                            <br><br>
                            회사의 개인정보처리방침은 법령 및 고시 등의 변경 또는 회사의 약관 및 내부 정책에 따라 변경될 수 있으며 이를 개정하는 경우 회사는 변경사항에 대하여 서비스 화면에
                            게시하거나 이용자에게 고지하고 있습니다.
                            <br><br>
                            본 개인정보처리방침은 회사가 제공하는 “홈페이지(www.seedoc.com 등 씨닥(SeeDoc) 서비스 도메인)” (이하에서는 홈페이지 및 어플리케이션을 이하
                            "서비스"라 합니다.) 이용에 적용되며 다음과 같은 내용을 담고 있습니다.

                        </p>

                    </div>
							<input type="submit" value="회원가입" class="submit-btn"/>
	                    </form>
	                   	</div>
                    <!-- <textarea name="hospConv" id="hospConv" class="user-input" cols="30" rows="10"></textarea> -->

                    	
                </div>
        </article>
    </section>
</body>
<script>
    let $membtn = $('.member-btn');
    let $docbtn = $('.doctor-btn');
    let $mem = $(".member");
    let $doc = $(".doctor");
    let title = document.getElementById("title");
    $docbtn.click(function () {
        $docbtn.removeClass("off");
        $membtn.addClass("off");
        $doc.css("display", "");
        $mem.css("display", "none");
    });
    $membtn.click(function () {
        $docbtn.addClass("off");
        $membtn.removeClass("off");
        $mem.css("display", "");
        $doc.css("display", "none");
    });

    let uesCount = 0;
    let personalCount = 0;
    $(".use-agree svg").click(function () {
        if (uesCount == 0) {
            uesCount++;
            $(".use-agree").css("height", "1120px");
        } else {
            uesCount--;
            $(".use-agree").css("height", "20px");
        }
    });

    $(".personal-agree svg").click(function () {
        if (personalCount == 0) {
            personalCount++;
            $(".personal-agree").css("height", "590px");
        } else {
            personalCount--;
            $(".personal-agree").css("height", "20px");
        }
    });
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>