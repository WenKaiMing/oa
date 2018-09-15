<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/km/disk/head.jsp"%>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>企业管理员</title>
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<link rel="stylesheet" href="./css/bootstrap.min.css">
<link rel="stylesheet" href="./css/swiper.css">
<link rel="stylesheet" href="./css/admin.css">
</head>
<body>
<div id="indexIng">	
	<div class="swiper-container">
		<div class="swiper-wrapper">
			<div class="swiper-slide swiper-no-swiping">
					<div class="stepContent">
						<h4>点击开始全文索引重建</h4>
						<p class="desc">描述...</p>
					</div>
				<div class="stepbtn"><button class="changeSwiper btn btn-info startToBuilt">开始</button></div>	
			</div>
			<div class="swiper-slide swiper-no-swiping">
				<div class="stepContent progress_div">
					<h4>全文索引重建中</h4>
					<p class="desc">请稍后</p>
					<div class="progress">
					  <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;">
					
					  </div>
					</div>
				</div>
				<div class="finishContent" style="display:none;">
					<div><img src="./images/Group6.png"/></div>
					<p class="desc">索引重建完成</p>
					<div id="stepFinish"><button class="changeSwiper btn btn-info">完成</button></div>
				</div>
			</div>
		</div>
	</div>
</div>
	<script src="./js/jquery-2.1.4.js"></script>
	<script src="./js/swiper.min.js"></script>
	<script>
		$(function(){
			var mySwiper = new Swiper('.swiper-container',{
				preventClicksPropagation:false,
				noSwiping :true
			})
			$('#indexIng').on("click",".changeSwiper",function(){
				var a = mySwiper.realIndex;
				if(a < 1){
					$(".startToBuilt").attr("disabled",true);
					mySwiper.slideNext();
					rebuiltIndex(function(result){
						$(".finishContent .desc").text(result.message);
					});
					setTimeout(function(){
			 			$(".progress_div").hide();
			 			$(".finishContent").show();
			 		},30000);
				}else{
					mySwiper.slideTo(0);
					OBPM.dialog.doExit();
				}
			})
		});
		function rebuiltIndex(callback){
			$.ajax({
				  type: 'POST',
				  url: "../../km/index/rebuild.action",
				  dataType:"json",
				  async:false,
				  success: function(result){
					  if(1==result.status){
							if(callback && typeof callback == "function"){
								callback(result);
							}
						}else{
							alert(result.data);
						}
				  },
				});
		}
	</script>

</body>
</html>