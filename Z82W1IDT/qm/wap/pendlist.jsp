<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
<title>调查问卷模块</title>
<link href="style/weui.min.css" rel="stylesheet">
<link href="style/font-awesome.min.css" rel="stylesheet">
<link href="style/global.css" rel="stylesheet">
</head>
<body ontouchstart>
<div id="loadingToast" class="weui_loading_toast" style="display:none;">
	<div class="weui_mask_transparent"></div>						
	<div class="weui_toast">
		<div class="weui_loading">							
		<div class="weui_loading_leaf weui_loading_leaf_0"></div>
		<div class="weui_loading_leaf weui_loading_leaf_1"></div>
		<div class="weui_loading_leaf weui_loading_leaf_2"></div>
		<div class="weui_loading_leaf weui_loading_leaf_3"></div>
		<div class="weui_loading_leaf weui_loading_leaf_4"></div>
		<div class="weui_loading_leaf weui_loading_leaf_5"></div>
		<div class="weui_loading_leaf weui_loading_leaf_6"></div>
		<div class="weui_loading_leaf weui_loading_leaf_7"></div>
		<div class="weui_loading_leaf weui_loading_leaf_8"></div>
		<div class="weui_loading_leaf weui_loading_leaf_9"></div>
		<div class="weui_loading_leaf weui_loading_leaf_10"></div>
		<div class="weui_loading_leaf weui_loading_leaf_11"></div>
		</div>
		<p class="weui_toast_content">数据加载中</p>
	</div>
</div>
<div class="container" id="container"></div>
<script type="text/html" id="tpl_qm_pendlist">
	<div class="page">
		<div class="qm-list">
			<div class="search-panel">
    			<div class="search-box">
					<input class="search" type="text" placeholder="搜索标题">
					<button class="btn search-btn"><i class="fa fa-search" aria-hidden="true"></i></button>
				</div>
    		</div>
			<div class="qm-list-box"><ul></ul></div>
		</div>
	</div>
</script>

<script type="text/html" id="tpl_qm_write"></script>
<script type="text/html" id="tpl_qm_msg">
    <!--消息内容开始-->
	<div class="page">
		<div class="weui_msg">
			<div class="weui_icon_area"><i class="weui_icon_success weui_icon_msg"></i></div>
			<div class="weui_text_area">
				<h2 class="weui_msg_title">提交成功</h2>
			</div>
			
			<div class="weui_extra_area">
				<div class="weui_opr_area">
					<p class="weui_btn_area">
						<a href="pendlist.jsp" class="weui_btn weui_btn_default">返回</a>
					</p>
				</div>
			</div>
		</div>
	</div>
	<!--消息内容结束-->
</script>

<script src="../js/jquery-1.11.3.min.js"></script>
<script src="../../script/json/json2.js"></script>
<script src="script/weui.router.js"></script>
<script src="script/qm.core.js"></script>
<script src="script/qm.router.js"></script>
<script src="script/qm.service.js"></script>
<script src="script/qm.util.js"></script>
<script>
var contextPath = '<%=request.getContextPath()%>';
var active = '<%=request.getParameter("active")%>';
var id = '<%=request.getParameter("id")%>';
//微信url不支持#
if(active && active != 'null' && id && id != 'null'){
	window.location.href = '#/'+active+'/:'+id; 
}else if(window.location.hash == ""){
	window.location.href = '#/';
}
$(function(){
	QM.Util.controlLoading("show");
	setTimeout(function(){
		QM.Router.pendlist();
		QM.Util.controlLoading("hide");
	},500);
})
</script>
</body>
</html>