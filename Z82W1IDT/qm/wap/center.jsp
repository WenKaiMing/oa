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

<script type="text/html" id="tpl_qm_center">
    <!--问卷中心开始-->
    <div class="page">
    	<div class="qm-list">
    		<div class="search-panel">
    			<div class="search-box">
					<input class="search" type="text" placeholder="搜索标题">
					<button class="btn search-btn"><i class="fa fa-search" aria-hidden="true"></i></button>
				</div>
				<div class="search-box-filter text-center">
					<div class="search-box-filter-item" data-filter="my">
						我参与的 <i class="fa fa-caret-down" aria-hidden="true"></i>
					</div>
					<div class="search-box-filter-item" data-filter="filter">
						筛选 <i class="fa fa-filter" aria-hidden="true"></i>
					</div>
				</div>
				<div class="search-box-my" style="display:none">
					<ul>
						<li data-type="1" class="active">我参与的 <i class="fa fa-check" aria-hidden="true"></i></li>
						<li data-type="0">我发布的 <i class="fa fa-check" aria-hidden="true"></i></li>
					</ul>
				</div>
    		</div>
			<div class="search-box-filter panel panel-cover" style="display:block">
				<div class="content-block">
					<div class="panel-right-title">状态</div>
					<div class="panel-right-content panel-status">
						<span class="panel-right-tag panel-right-status" data-status="1">进行中</span>
						<span class="panel-right-tag panel-right-status" data-status="2">已完成</span>
					</div>
					
				</div>
				<div class="panel-right-btn">
					<a class="btn weui_btn_default panel-right-reset">清空筛选</a>
					<a class="btn weui_btn_primary panel-right-submit">确定</a>
				</div>
			</div>
			<div class="qm-list-box-masks"  style="display:none"></div>
			<div class="qm-list-box"><ul></ul></div>
		</div>
	</div>
	<!--问卷中心结束-->
</script>

<script type="text/html" id="tpl_qm_show"></script>
<script type="text/html" id="tpl_qm_showInput"></script>
<script type="text/html" id="tpl_qm_write"></script>
<script type="text/html" id="tpl_qm_answerName"></script>
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
						<a href="center.jsp" class="weui_btn weui_btn_default">返回</a>
					</p>
				</div>
			</div>
		</div>
	</div>
	<!--消息内容结束-->
</script>

<script src="../js/jquery-1.11.3.min.js"></script>
<script src="../js/echarts.min.js"></script>
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
		QM.Router.center();
		QM.Util.controlLoading("hide");
	},500);
})
</script>
</body>
</html>