<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>IScript Help</title>
<style>
<!--
ul,li {
	list-style: none;
	margin: 0;
	padding: 0;
	padding-left: 5px;
}

a {
	cursor: pointer;
}

.helpitem {
	padding-bottom: 15px;
}

.title {
	padding: 3px;
	border: 1px solid #EBF1FD;
	font-size: 16px;
	font: bold;
	color: #316AC5;
	text-align: left;
	vertical-align: middle;
}

.content {
	border: 1px solid #EBF1FD;
	border-top: 0px solid #EBF1FD;
	padding-left: 18px;
	text-align: left;
	vertical-align: middle;
	font-size: 14px;
	color: #000080;
	text-align: left;
	vertical-align: middle;
}
-->
</style>
</head>
<link rel="stylesheet" href="<s:url value='/resource/css/helper.css'/>" type="text/css" />
<script src='<s:url value="/dwr/interface/HelpHelper.js"/>'></script>
<script type="text/javascript">

/*初始化Iscript帮助*/
function initIscriptHelp(parem){ 
	HelpHelper.getIscriptHelp("", function(data){
			jQuery("#thisTitle").html("Iscript帮助文档");
					if(data){
						jQuery("#iscriptHelpContent").html(data);
					}else{
						jQuery("#iscriptHelpContent").html("<br>此页面暂无帮助信息！");
					}
		});
}

function isShowSubHelpMenus(obj){
	var subobj=obj.next("img").next("a").next("ul");
	if(subobj.css("display")=="none"){
		subobj.css("display","");
		obj.attr("src","../../../resource/imgnew/minus.gif");
		obj.next("img").attr("src","../../../resource/imgnew/toc_open.gif");
	}else{
		subobj.css("display","none");
		obj.attr("src","../../../resource/imgnew/plus.gif");
		obj.next("img").attr("src","../../../resource/imgnew/toc_closed.gif");
	}
}

jQuery(document).ready(function(){
	initIscriptHelp("");
});

</script>

<body style="background:#fff;">

<div id="iscriptHelpContent" class="HT">
</div>

</body>
</html>

