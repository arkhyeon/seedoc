<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>x
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/Login.css">
<script>
$(function() {
	$("#hospLoginFrm").submit(function() {
		let $hospId = $("#hospId");
		let $hospPwd = $("#hospPwd");
		
		if($hospId.val().length == 0) {
			alert("아이디를 입력하세요");
			$hospId.focus();
			return false;
		}
		if($hospPwd.val().length == 0) {
			alert("비밀번호를 입력하세요");
			$hospPwd.focus();
			return false;
		}
		
		return true;
	});
	$("#memberLoginFrm").submit(function() {
		let $userId = $("#userId");
		let $userPwd = $("#userPwd");
		
		if($userId.val().length == 0) {
			alert("아이디를 입력하세요");
			$userId.focus();
			return false;
		}
		if($userPwd.val().length == 0) {
			alert("비밀번호를 입력하세요");
			$userPwd.focus();
			return false;
		}
		return true;
	});
});
</script>
<section>
        <article>
            <div class="login">
                <h1 id="title">로그인</h1>
                <div class="login-type">
                    <div class="member-btn">회 원</div>
                    <div class="doctor-btn off">병 원</div>
                </div>
                 <form action="<%=request.getContextPath()%>/member/login" id="memberLoginFrm" method="post">
	                <div class="member">
	                    <input type="text" placeholder="아이디" class="user-input" name="userId" id="userId" value="<%=saveUserIdChecked?saveUserIdValue:""%>">
	                    <input type="password" placeholder="비밀번호" class="user-input" name="userPwd" id="userPwd">
	                    <div class="login-check">
	                        <input type="checkbox" name="saveUserId" id="saveUserId" <%=saveUserIdChecked ? "checked" : "" %> >
	                        <label for="">아이디 저장</label>
	                    </div>
	                    <div id="search">
	                        <a href="<%=request.getContextPath()%>/member/SearchServlet">아이디 찾기</a>
	                        <a href="<%=request.getContextPath()%>/member/SearchPwdServlet">비밀번호 찾기</a>
	                    </div>
	                    <input type="submit" value="로그인" class="submit-btn"/>
	                </div>
                
                </form>
				<form action="<%=request.getContextPath()%>/hospital/login" id="hospLoginFrm" method="post">
	                <div class="doctor" style="display: none;">
	                    <input type="text" placeholder="아이디" class="user-input" name="hospId" id="hospId"
	                    	value="<%= saveHospIdChecked ? saveHospIdValue : ""%>">
	                    <input type="password" placeholder="비밀번호" class="user-input" name="hospPwd" id="hospPwd">
	                    <div class="login-check">
	                        <input type="checkbox" name="saveHospId" id="saveHospId" <%=saveHospIdChecked ? "checked" : "" %> />
	                        <label for="saveHospId">아이디 저장</label>
	                    </div>
	                    <div id="search">
	                        <a href="#">아이디 찾기</a> |
	                        <a href="#">비밀번호 찾기</a>
	                    </div>
	                    <input type="submit" value="로그인" class="submit-btn"/>
	                    <!-- <a href="#">
	                        <div class="submit-btn">
	                            로그인
	                        </div>
	                    </a> -->
	                </div>
                </form>
            </div>
            <br>
            <div class="sign">
                <a href="<%=request.getContextPath()%>/member/register">SeeDoc 회원가입</a>
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
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>