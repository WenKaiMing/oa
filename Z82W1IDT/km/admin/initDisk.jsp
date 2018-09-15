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
<div id="scroller">	
<div class="role_tipsStyle">批量初始化值允许执行一次</div>
	<div class="swiper-container">
		<div class="swiper-wrapper">
			<div class="swiper-slide swiper-no-swiping">
					<div class="stepContent">
						<h4>只需三步</h4>
						<p class="desc">快速将知识文档库导入网盘</p>
						<div><img src="./images/Group2.png"/></div>
					</div>
				<div class="stepbtn"><button class="changeSwiper btn btn-info">下一步</button></div>	
			</div>
			<div class="swiper-slide swiper-no-swiping">
				<div class="stepContent">
					<h4>第一步</h4>
					<p class="desc">将文档库放在<span style="color:red;">服务器</span>指定目录下</p>
					<div class="folderPath"></div>	
				</div>
				<div class="stepbtn">
					<button class="changeSwiper btn btn-info">同步</button>
				</div>
			</div>
			<div class="swiper-slide swiper-no-swiping">
				<div class="stepContent progress_div">
					<h4>同步中</h4>
					<p class="desc">等待系统同步完成</p>
					<div class="progress-top"><img src="./images/progress_bar.png"/></div>
					<div class="progress">
					  <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;">
					
					  </div>
					</div>
				</div>
				<div class="finishContent" style="display:none;">
					<div style="margin-top: 30px;"><img src="./images/Group6.png"/></div>
					<p class="desc"></p>
					<div class="stepbtn" style="text-align: center;"><button class="changeSwiper btn btn-info">完成</button></div>
				</div>
				<div class="stepContent failedToInit" style="display:none;">
					<h4>初始化失败</h4>
					<p class="desc"></p>
					<div class="stepbtn"><button class="changeSwiper btn btn-info">关闭</button></div>
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
			$('#scroller').on("click",".changeSwiper",function(){
				var success = true;
				var num = $(".swiper-slide").length;
				var index = mySwiper.realIndex;
				switch(index){
				 	case 0 :
				 		getFolderPath(function(result){
							var folderPath = result.data;
							$(".folderPath").text(folderPath);
						});
				 		mySwiper.slideNext();
				 		break;
				 	case 1 :
				 		mySwiper.slideNext();
				 		var params = {};
						params.initPath = $(".folderPath").text();
						initDisk(params,function(result){
							if(result.status == 1){
								if(result.data){
									var finishMessage = result.data;
									$(".finishContent .desc").text(finishMessage);
									setTimeout(function(){
							 			$(".progress_div").hide();
							 			$(".finishContent").show();
							 		},1000);
								}
							}else{
								success = false;
							}
						});
						if(success == false){
							$(".progress_div").hide();
							$(".failedToInit").find(".desc").text("指定文件夹没有文件！");
							$(".failedToInit").show();
							//mySwiper.slideTo(3);
							break;
						}
						break;
				 	case 2 :
				 		OBPM.dialog.doExit();
				 	default:
				 		break;
				}
			})
		});
		function getFolderPath(callback){
			$.ajax({
				  type: 'POST',
				  url: "../../km/disk/folderPathOfInitDisk.action",
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
		function initDisk(params,callback){
			
			$.ajax({
				  type: 'POST',
				  url: "../../km/disk/initDisk.action",
				  dataType:"json",
				  data: params,
				  async:false,
				  success: function(result){
					  if(callback && typeof callback == "function"){
							callback(result);
						}
				  },
				});
		}
	</script>

</body>
</html>