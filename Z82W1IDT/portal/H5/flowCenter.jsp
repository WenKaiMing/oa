<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="myapps" prefix="o"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="edge" />
<link rel="stylesheet" href="resource/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="resource/css/myapp.css" />
<link rel="stylesheet" type="text/css" href="resource/css/flowcenter.css" />
<script src="resource/js/jquery-1.11.3.min.js"></script> 
<script src="resource/script/bootstrap.min.js"></script>
<script type="text/javascript">
$(function(){

	closeActiveTab = function() {
		var $LiActive = $("#act").find("ul>li.active");
		$("#con_right iframe").remove();
		$LiActive.find("a>span").trigger("click");
	};
	
	//切换页签
	$("#act").find("ul>li").bind("click",function(){
		$(this).siblings().removeClass("active").end().addClass("active");
	});
	
	$("#act").find("li>a")
		.click(
			function() {
				$("#act li.active").removeClass(
						"active");
				$(this).parent().addClass("active");
				var url = $(this).attr("_url");
				var id = "iframe_"
						+ $(this).parent().attr("id");
				$("iframe").hide();
				if ($("#" + id).size() <= 0) {
					$(
							"<iframe id='"
									+ id
									+ "' style='border:0px solid red' width='100%' height='100%' frameborder='no' border='0'></iframe>")
							.appendTo($("#con_right")).attr(
									"src", url).show();
				} else {
					$("#" + id).show();
				}
			});

		//选择第一个
		$("#launch>a>span").trigger("click");
		$(window).resize(function() {$("#con_right").css("width",$(window).width()-145);});
        $("#con_right").css("width",$(window).width()-145);
});
	</script>
</head>
<body>
<div id="right" style="background:none;  height: 100%; min-height:100%">
    <div id="act" class="act w130 fl">
        <div class="title">Action</div>
        <div class="content">
            <ul class="nav nav-stacked">
			    <li id="launch"><a _url="startFlow.jsp" target="fc"><i class="iconfont-h5">&#xe039;</i><span>{*[flow.start]*}{*[New]*}</span></a></li>
			    <li id="pending"><a _url="pending.jsp" target="fc"><i class="iconfont-h5">&#xe03b;</i><span>{*[flow.my]*}{*[flow.Pending]*}</span></a></li>
			    <li id="processed"><a _url="processing.jsp" target="fc"><i class="iconfont-h5">&#xe038;</i><span>{*[flow.processing]*}跟踪</span></a></li>
			    <li id="finished"><a _url="finished.jsp" target="fc"><i class="iconfont-h5">&#xe036;</i><span>{*[History]*}查询</span></a></li>
			    <li id="dashboard"><a _url="dashboard.jsp" target="fc"><i class="iconfont-h5">&#xe032;</i><span>{*[flow.instrument]*}{*[flow.analyze]*}</span></a></li>
            </ul>
        </div>
    </div>
    <div id="con_right" class="con_right fr">
    </div>
    <div class="clear"></div>
</div>
</body>
</html>
</o:MultiLanguage>