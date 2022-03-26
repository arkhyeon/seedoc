<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰작성</title>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-3.5.1.js"></script>
	<style>
	*{
		margin:0;
		padding:0;
	}
	.review-top{
		width:100%;
		height:50px;
		background-color:#4286f4;
		text-align:center;
		color:white;
		font-weight:800;
		font-size:18px;
		line-height:50px;
	}
	.title{
		margin-top:20px;
	}
	.point-text{
		color:red;
		font-size:14px;
		margin-bottom:10px;
	}
	.review-text{
		padding-top: 10px;
		border-top:1px solid #cdcdcd;
	}
	p{
		text-align:center;
		font-weight:800;
		font-size:18px;
	}
.bg {
    width: 250px;
    height: 58px;
    display: block;
    overflow: hidden;
    background: url("../img/star0.png");
    margin: 5px auto;
}
em {
    height: 58px;
    display: block;
    overflow: hidden;
    background: url("../img/star5.png");
}
#rank-wrap{
	width:250px;
	height:58px;
	margin:-58px auto 0px;
}
#rank-wrap a{
	width:50px;
	height:58px;
	display:inline-block;
}
textarea{
	width: 480px;
    outline: none;
    border: 1px solid #cdcdcd;
    background-color: #ebebeb;
    margin: 15px auto;
    display: block;
    resize:none;
}
#write-btn{
	background-color: #4286f4;
    outline: none;
    border: 1px solid #cdcdcd;
    width: 480px;
    height: 50px;
    margin: 0 auto;
    display: block;
    font-size: 22px;
    font-weight: 800;
    color: white;
}
	</style>
	<script>
	$(function(){
		
		let rank = document.getElementById("rank-wrap").childNodes;
		let star = document.getElementById("star");
		let point = document.getElementById("point");
		let value = document.getElementsByName("reviewRank");
		let text = document.getElementById("text");
		let $rank = $("input[name=reviewRank]");
		rank[1].onclick = function(){
			star.style.width = "23%";
			$rank.val('1');
			point.innerHTML= "1점";
			text.innerHTML = "최악입니다";
		}
		rank[2].onclick = function(){
			star.style.width = "42%";
			$rank.val('2');
			point.innerHTML= "2점";
			text.innerHTML = "별로에요";
		}
		rank[3].onclick = function(){
			star.style.width = "60%";
			$rank.val('3');
			point.innerHTML= "3점";
			text.innerHTML = "괜찮아요";
		}
		rank[4].onclick = function(){
			star.style.width = "79%";
			$rank.val('4');
			point.innerHTML= "4점";
			text.innerHTML = "만족합니다";
		}
		rank[5].onclick = function(){
			star.style.width = "100%";
			$rank.val('5');
			point.innerHTML= "5점";
			text.innerHTML = "최고에요";
		}
		$('#reviewCon').keyup(function (e){
			var content = $(this).val();
	        $('#counter').html(content.length + '/300자');
	        if(content.length>300){
        		alert("300자 제한입니다.");
	        	$(this).val($(this).val().substr(0, 300));
	        	$('#counter').html(300 + '/300자');
	        	$('#counter').css("color","black");
	        }
	      });
	      $('#reviewCon').keyup();
	      
	    
	});
	
	</script>
</head>
<body>
	<div class="review-top">리뷰작성하기</div>
	<p class="title">진료는 만족하셨나요?</p>
	<div class="review-wrap">
		<!-- 댓글 작성폼 -->
		<div class="review">
			<form action="<%=request.getContextPath()%>/board/writeReview"
				method="post" name="writeReviewFrm">
				<span class="bg"> <em id="star" class="value"></em></span>
				<div id="rank-wrap">
					<a></a><a></a><a></a><a></a><a></a>
				</div>
				<p class="point-text"><span id="point">5점</span>&nbsp;(<span id="text">최고에요</span>)</p>
				<p class="review-text">어떤 점이 리뷰를 작성하게 했나요?</p>
				<input type="hidden" name="reviewRank" value="5" /> 
				<input type="hidden" name="reviewWriter" value="hong" /> 
				<input type="hidden" name="reviewLevel" value="1" />
				<input type="hidden" name="reviewRef" value="0" />
				<textarea name="reviewCon" id="reviewCon" cols="60" rows="10" placeholder="10자 이상 작성해주세요!"></textarea>
				<span id="counter">###</span>
				<input type="submit" value="등록" id="write-btn" />
			</form>
		</div>
	</div>
</body>
</html>
