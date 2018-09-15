<%@include file="/common/taglibs.jsp"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<s:bean id="rh"
	name="cn.myapps.core.resource.action.ResourceHelper" />
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" href='<s:url value="/resource/css/main.css" />' type="text/css">
<!-- <link rel="stylesheet" href="<s:url value='/core/fonts/awesome/font-awesome.min.css'/>" type="text/css" /> -->
<link rel="stylesheet" href="<s:url value='/core/fonts/custom/widget_icon_lib.css'/>" type="text/css" />

<style type="text/css">
body {
	font-size: 12px;
	padding: 0px;
	margin: 0px;
	font-family: "Microsoft YaHei","PingHei","Lucida Grande","Lucida Sans Unicode","STHeiti","Helvetica","Arial","Verdana","sans-serif";
}

.bigTable {
	border-bottom: 1px solid dotted;
	border-color: black;
	width: 98%;
	margin: 5px;
}
.canvas_td_over {
	background-color: #E7F3FE;
	cursor:pointer;	
	

	
}
.canvas_td_select {
	background-color: #70BAFE;
	cursor:pointer;	
	
	
}
.clear{
	clear:both;
}
.container {
    margin-right: auto;
    margin-left: auto;
    padding-left: 15px;
    padding-right: 15px;
}

.page-header {
    padding-bottom: 9px;
    margin: 20px 0 20px;
    border-bottom: 1px solid #eeeeee;
}
h2, .h2 {
    font-size: 30px;
}


.row {
    margin-left: -15px;
    margin-right: -15px;
}
.col-sm-4 {
    width: 20%;
    float: left;
    position: relative;
    min-height: 1px;
    padding-left: 15px;
    padding-right: 15px;
}
.fontawesome-icon-list {
    margin-top: 22px;
}
.fontawesome-icon-list .fa-hover a {
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    display: block;
    color: #222222;
    line-height: 32px;
    height: 32px;
    padding-left: 10px;
    border-radius: 4px;
}

.fontawesome-icon-list .fa-hover a.fa-select,
.fontawesome-icon-list .fa-hover a:hover {
    background-color: #1d9d74;
    color: #ffffff;
    text-decoration: none;
}
.fontawesome-icon-list .fa-hover a.fa-select .if-lib,
.fontawesome-icon-list .fa-hover a:hover .if-lib {
    font-size: 28px;
    vertical-align: -6px;
}

.alert-warning {
    background-color: #fcf8e3;
    border-color: #faebcc;
    color: #8a6d3b;
}
.alert-success {
    background-color: #f1f9f7;
    border-color: #e0f1e9;
    color: #1d9d74;
}
.alert {
    padding: 15px;
    margin-bottom: 20px;
    border: 1px solid transparent;
    border-radius: 4px;
}
.alert h4 {
    margin-top: 0;
    color: inherit;
}
h4, .h4 {
    font-size: 18px;
}
.alert-warning .alert-link {
    color: #66512c;
}
.alert .alert-link {
    font-weight: bold;
}
.alert-link {
    text-decoration: underline;
}

.margin-bottom-none {
    margin-bottom: 0px !important;
}
.padding-left-lg {
    padding-left: 22px !important;
}
.padding-left-lg  ul {
    display: block;
    list-style-type: disc;
    -webkit-margin-before: 1em;
    -webkit-margin-after: 1em;
    -webkit-margin-start: 0px;
    -webkit-margin-end: 0px;
    -webkit-padding-start: 40px;
}
.padding-left-lg  li {
    display: list-item;
    text-align: -webkit-match-parent;
}

</style>
<script language="javascript">
var temp;
var icon ='';
var application = '<%=request.getParameter("application")%>';
var _path = '<%=request.getParameter("path")%>'

jQuery(document).ready(function(){  
  jQuery(".fa-hover").find("a").on("click",function(){
	  icon = jQuery(this).find("i").attr("class");
	  jQuery(".fa-hover").find("a").removeClass("fa-select");
	  jQuery(this).addClass("fa-select");
  })
  
});

function ev_commit(){
	if(icon == ""){
		alert("请选择图标!");
		return;
	}
	OBPM.dialog.doReturn(icon);
}
function ev_exit(){
	OBPM.dialog.doExit();
}
function ev_back(){
	window.history.back(-1); 
}
</script>
</head>
<body>
	<table cellpadding="0" cellspacing="0" width="100%" style="position: fixed; z-index: 10;">
		<tr class="nav-s-td">
			<td align="right" class="nav-s-td">
				<table width="100%" border=0 cellpadding="0" cellspacing="0">
					<tr>
						<td valign="top" align="right">
							<button class="button-image" type="button"
								onClick="ev_commit();"><img
								src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[OK]*}</button>
							<button class="button-image" type="button"
								onClick="ev_exit();"><img
								src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>

<table width="100%" border="0" cellpadding="0" cellspacing="10" id="canvas" style="padding-top:20px">
</table>


<div class="container">
	<div id="icons">
		<section id="new">
			<h2 class="page-header">图标列表</h2>
			<div class="row fontawesome-icon-list">
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-xitongtongzhi"></i> e638</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-xinyongqia"></i> e639</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-tongxunmay"></i> e63b</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-fasongtongzhi"></i> e63a</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-guizhangzhidu"></i> e626</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-jiaban"></i> e62d</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-chucha"></i> e62c</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-xiaoxi"></i> e635</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-baoxiao"></i> e62b</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-huiyichaxun"></i> e62a</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-fenqitongyong"></i> e64d</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-cuxiao"></i> e64e</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-feiyongbaoxiao"></i> e64f</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-shenpi1"></i> e650</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-shenpi"></i> e651</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-2shangwuchucha"></i> e652</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-tongzhigonggao"></i> e627</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-xinwenxinxi"></i> e629</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-qingjia"></i> e628</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-jifentongyong"></i> e64c</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-shoucang"></i> e64a</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-zuixin"></i> e64b</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-riqi"></i> e649</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-youhuijuantongyong"></i> e648</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-hunbantongyongxihuankengwei44yixihuan"></i> e647</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-tongxun"></i> e646</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-tongzhi"></i> e645</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-goutong1"></i> e644</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-goutong"></i> e65c</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-wuliutongzhi"></i> e63c</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-shenhetongguo"></i> e63d</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-anchangtonggao"></i> e63e</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-tongxunguanli"></i> e63f</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-jiaotong"></i> e640</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-yongcan"></i> e641</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-putongvip"></i> e643</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-tongxunlu1"></i> e642</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-daiban"></i> e65b</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-banqia"></i> e65a</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-gongsi"></i> e659</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-gonggao"></i> e658</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-gonggao1"></i> e657</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-gongqiabuban"></i> e656</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-icondaibanpress"></i> e655</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-oabangongt"></i> e654</a></div>
				<div class="fa-hover col-md-3 col-sm-4"><a><i class="if-lib icon-conowmenuoa"></i> e653</a></div>
				<div class="clear"></div>
			</div>
		</section>
	</div>
</div>
</body>
</o:MultiLanguage>
</html>