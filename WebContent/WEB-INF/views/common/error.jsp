<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<style>
	.top-bar, .sub-bar, footer{
	display:none;
	}
	span{
		position: relative;
	}
</style>
<%
	String errorMessage = exception !=null ? exception.getMessage():Integer.toString(response.getStatus());
%>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/error.css" />

<title>404 Error</title>
  <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css?family=Assistant" rel="stylesheet">
</head>
<body style="overflow: hidden;">

<section class="jp-404" style="padding-top: 10%">

<h1><span> 404 </span>
Sorry Page Not Found!
 </h1>

<p>
The page you're looking for, doesn't exist. It may have removed or its URL has been changed. 
</p>


<a href="<%=request.getContextPath()%>" class="back-to-home"><i class="fa fa-home"></i> Back to Home </a>
<script>
$(".jp-404").on('mousemove',function(e){
	  
	  $("span").css({"top": ((e.pageY/10)-49) + "px ","left" : ((e.pageX/10)-98)+"px"});
	});
</script>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>