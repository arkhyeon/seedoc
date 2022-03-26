<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/views/common/header.jsp"%>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/search.css">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" Contenet="text/html; charset="UTF-8">
<script src="<%= request.getContextPath() %>/js/jquery-3.5.1.js"></script>

</head>
<body>
		
	<section>
	<article> 
	<form name="searchFrm">
		<input type="hidden" name="userName">	
		<input type="hidden" name="userEmail">
		<input type="hidden" name="userPhone">
	</form>
	
	<div id="div1">
	<h3>아이디 찾기</h3>
	
	<table class="table" style="margin:0 auto; width:700px">
		<tr>
			<td> <label class="text-label">이름<span>*</span></label></td>
			<td><input type="text" name="userName" id="userName" class="from-control" placeholder="이름을 입력하시오"></td>
	
		</tr>
		<br>
		<tr>
		<td> <label class="text-label">이메일<span>*</span></label></td>
			<td><input type="text" name="userEmail" id="userEmail" class="from-control" placeholder="이메일을 입력하시오"></td>
		</tr>
		<br>
		<tr>
			<td> <label class="text-label">전화번호<span>*</span></label></td>
			<td><input type="text" name="userPhone" id="userPhone" class="from-control" placeholder="전화번호룰 입력하시오"></td>
		</tr>
		</table>
		<button type="button" id="searchBtn" class="btn btn-outline-info btn sm" onclick="searchId()">아이디 찾기</button>
		</div>
		</article>
	</section>	
	
	<script>
        function searchId(){
            var userName = document.getElementById("userName").value;
            var userEmail = document.getElementById("userEmail").value;
            var userPhone = document.getElementById("userPhone").value;
            if(userName == "" && userEmail =="" && userPhone ==""){
                alert("모든 정보를 입력해주세요");
                return;
            }
            var url = "<%=request.getContextPath()%>/searchId";

            var title = "searchId";

            var status = "left=500px, top=100px, width=500px, height=200px, menubar-no, status=no, scrollbar=yes";

            //var popup = window.open("",title, status)

            searchFrm.userName.value=userName;
            searchFrm.userEmail.value=userEmail;
            searchFrm.userPhone.value=userPhone;

            searchFrm.taget = title;

            searchFrm.action = url;
            searchFrm.method="post";

            searchFrm.submit();

        }
	
	</script>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>