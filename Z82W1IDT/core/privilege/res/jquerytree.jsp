<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@include file="/common/tags.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
request.setCharacterEncoding("utf-8");
String type = request.getParameter("type");
String str="";
if(type.equals("0")){
	str="{*[View]*}";
}else if(type.equals("1")){
	str="{*[Form]*}";
}else if(type.equals("2")){
	str="{*[menu]*}";
}else if(type.equals("3")){
	str="{*[FormField]*}";
}else if(type.equals("4")){
	str="{*[Folder]*}";
}
String applicationid = request.getParameter("applicationid");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<o:MultiLanguage>
<head>
<title>{*[Resources]*}</title>
<%@include file="/common/head.jsp"%>
<!-- 树形插件 -->
<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/tree/_lib/jquery.cookie.js'/>"></script>
<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/tree/_lib/jquery.hotkeys.js'/>"></script>
<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/tree/jquery.jstree.js'/>"></script>
<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/tree/plugins/jquery.jstree.checkbox.js'/>"></script>
<script type="text/javascript" src="<s:url value='/script/json/json2.js'/>"></script>
<!-- 布局插件 -->
<script type="text/javascript"
	src="<s:url value='/script/jquery-ui/plugins/layout/jquery.layout.js'/>"></script>
<script src='<s:url value='/script/view/view.js' />'></script>
<script src='<s:url value="/dwr/interface/ViewHelper.js"/>'></script>
<script type="text/javascript">
jQuery(document).ready(function () {
	window.top.toThisHelpPage("application_info_generalTools_resources_info_chooseResources");
	jQuery('body').layout({ 
		applyDefaultStyles: true 
	});
	treeload();
});

function treeload() {        
	treeview = jQuery("#tree").jstree({ 
		core:{
			initially_open: ['root']
		}, 
		// JSON数据插件
		"json_data" : {
			"ajax" : { 
			"url" : function (){
					return contextPath + "/core/privilege/res/resourcesTree.action?s_applicationid=<%=applicationid%>&type=<%=type%>&datetime=" + new Date().getTime();
					},
			"data" : function (node) { 
					// buildParams
					var params = {};
					if (node.attr) {
						params['parentid'] = node.attr("parentid"); // 上级ID
						params['temp'] = encodeURIComponent(node.attr("temp"));
					}
					
					return params;
				}
			}
		},"plugins" : [ "themes", "json_data", "types", "ui", "sort", "search", "adv_search","lang"]
	}).bind("select_node.jstree", function(e, data){
		var node = data.rslt.obj;
		//alert(node.attr("result"));
		if(node.attr("result")=='undefined'||node.attr("result")==null || node.attr("result")==""){
			alert("{*[selectNodeNoIs]*}<%=str%>{*[Type]*}");
		}else{
			OBPM.dialog.doReturn(node.attr("result"));
			//window.returnValue = node.attr("result");
	        //window.close();
		}
       });
}

//取消
function resourcesExit(){
	window.close();
}
//清空
function resourcesClear(){
	OBPM.dialog.doReturn("clear");
}
</script>
<style type="text/css">


body {
	margin: 0px;
	background-color: #FFFFFF;
	font-size:12px;

}

a{
	font-size:12px; 
	color:#000000;
	text-decoration: none;
}
</style>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0"
	class="line-position" >
	<tr>
	<td>&nbsp;&nbsp;</td>
	<td class="line-position2">
		<a href="#" onClick="resourcesExit()" style="text-decoration:none;"><img border="0" src="<s:url value="/resource/image/cancel2.gif"/>">{*[Cancel]*}</a>
	</td>
	<td>&nbsp;&nbsp;</td>
	<td class="line-position2">
		<a href="#" onClick="resourcesClear()" style="text-decoration:none;"><img border="0" src="<s:url value="/resource/image/qingkong.gif"/>">{*[Clear]*}{*[All]*}</a>
	</td>
	</tr>
</table>
<div id="tree"></div>
</body>
</o:MultiLanguage>
</html>