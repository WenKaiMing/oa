<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@include file="/common/tags.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String applicationid = request.getParameter("applicationid");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<o:MultiLanguage>
<head>
<title>{*[Resources]*}</title>
<link rel="stylesheet" type="text/css"	href="<s:url value='/resource/css/main.css' />" />
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<link rel="stylesheet" href='<s:url value="/resource/css/dtree.css" />' type="text/css">
<link rel="stylesheet" href='<s:url value="/resource/css/popupmenu.css" />' type="text/css">
<%@include file="/common/head.jsp" %>
<!-- 树形插件 -->
<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/tree/_lib/jquery.cookie.js'/>"></script>
<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/tree/_lib/jquery.hotkeys.js'/>"></script>
<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/tree/jquery.jstree.js'/>"></script>
<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/tree/plugins/jquery.jstree.checkbox.js'/>"></script>
<script type="text/javascript" src="<s:url value='/script/json/json2.js'/>"></script>
<script src="<s:url value='/core/permission/dtree_perssiom.js'/>"></script>
<!-- 布局插件 -->
<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/layout/jquery.layout.js'/>"></script>
<script type="text/javascript" src='<s:url value="/script/tabField/ddtabmenu.js"/>'></script>
<script src='<s:url value="permission.js"/>'></script>
<script src='<s:url value="/dwr/interface/OperationHelper.js"/>'></script>
<script type="text/javascript">
var menuroot = '{*[cn.myapps.core.permission.all_menu]*}';
var moduleroot = '{*[All]*}{*[Module]*}';
var folderroot = '{*[All]*}{*[Folder]*}';
var selectedResourceid = "";
var selectedResourceName = "";
var selectedResourceType = "";
/**
 * 旧数据结构 {resourceid: {"resourcetype":resourcetype, "resourcename":resourcename, "operations": [operationid]}};
 * 新数据结构 {resourceid: [{"operationid": 操作ID1, "resourcetype":资源类型1, "resourcename":资源名称1, "allow": 是否允许使用操作}, 
 * {"operationid": 操作ID2, "resourcetype":资源类型2, "resourcename":资源名称2, "allow": 是否允许使用操作}]};
 * 数据结构使用json格式,不能使用单引号,只能使用双引号,不然使用jQuery的parseJSON方法会出错
 */
var permissionJSON = new PermissionMap();

function doSave(){
	document.forms[0].submit();
}

function batchAuth(){
	jQuery.ajax({
		type: "POST",
		url: 'batchAuth.jsp',
		cache: false,
		data: 'applicationid=<s:property value="#parameters.applicationid"/>&excludeRoleid=<s:property value="#parameters.roleid"/>',
		dataType:"html",
		success: function(html){
			jQuery("#batchAuth").attr('innerHTML', '');
			jQuery("#batchAuth").attr('innerHTML', html);
			initRolesSelected();
		}
	});
}

/*
 * 菜单资源的checkbox点击触发动作
 * 每次点击都会触发修改permissionJSON
 */
function changePermissionByMenu(checkBox){
	var val = jQuery(checkBox).val();
	if (val) {
		var vals = val.split("@");
		if (vals.length == 3) {
			var resourceid = vals[0];
			var resourcename = vals[1];
			var resourcetype = new Number(vals[2]);
			var allow = checkBox.checked;

			var perm = jQuery.parseJSON(jQuery("#permissionJSON").val());
			var permArr = perm[resourceid];
			if(permArr && permArr instanceof Array){
				/*
				* 如果permissionJSON中有该值operationid,renew当前operationid的权限值allow
				*/
				var operationid = permArr[0]['operationid'];
				renewPermssionJSON(resourceid, operationid, resourcetype, resourcename, allow);
			} else {
				/*
				* 如果permissionJSON无该值operationid(即该菜单还没初始化权限),则通过异步获取operationid
				*/
				var applicationid = jQuery("#app").val();
				var operationcode = 1002;
				DWREngine.setAsync(false);
				OperationHelper.getOperationIdByCode(resourceid, resourcetype, operationcode, applicationid, 
						function(operationid){
					renewPermssionJSON(resourceid, operationid, resourcetype, resourcename, allow);
				});
			}
		}
	}
}

/*
 * 模块资源的checkbox点击触发动作
 * 每次点击都会触发修改permissionJSON
 */
function changePermissionByModule(checkBox){
	//
	var resourceid = jQuery(checkBox).attr('resourceid');
	var operationid = jQuery(checkBox).val();
	var resourcename = jQuery(checkBox).attr('resourcename');
	var resourcetype = new Number(jQuery(checkBox).attr('resourcetype'));
	var allow = checkBox.checked;
	//
	renewPermssionJSON(resourceid, operationid, resourcetype, resourcename, allow);
}

/*
 * 文件资源的checkbox点击触发动作
 * 每次点击都会触发修改permissionJSON
 */
function changePermissionByFolder(checkBox){
	var val = jQuery("#folderpermission #folder").val();
	var resourceMap = getResourceMap(val);
	if (resourceMap){
		//
		var resourceid = resourceMap['resourceid'];
		var resourcetype = resourceMap['resourcetype'];
		var resourcename = resourceMap['resourcename'];
		var operationid = jQuery(checkBox).val();
		var allow = checkBox.checked;
		//
		renewPermssionJSON(resourceid, operationid, resourcetype, resourcename, allow);
	}
}
/**
 * renew权限json数据,savePermissionJSON隐藏区域的值会得到更新
 */
function renewPermssionJSON(resourceid, operationid, resourcetype, resourcename, allow){
	var val = jQuery("#savePermissionJSON").val();
	if(val == '' || val == null)
		jQuery("#savePermissionJSON").attr("value", '{}');
	var permJSON = eval("(" + jQuery("#savePermissionJSON").val() + ")");
	if(permJSON == ''){
		permJSON = {};
	}
	var exist = false;
	if(resourceid){
		var permissionArray = permJSON[resourceid];
		if(permissionArray && permissionArray instanceof Array){
			for(var i=0;i<permissionArray.length;i++){
				if(permissionArray[i]['operationid'] == operationid){
					permissionArray[i]['allow'] = allow;
					exist = true;
					break;
				}
			}
		}else{
			permJSON[resourceid] = [];
		}
		if(!exist){
			permJSON[resourceid].push({'operationid': operationid, 'resourcetype':resourcetype, 'resourcename':resourcename, 'allow': allow});
		}
		jQuery("#savePermissionJSON").attr("value",JSON.stringify(permJSON));
	}
}
jQuery(window).resize(function(){
	setSize4Div();
});
jQuery(document).ready(function () {
	// 初始化JSON对象
	jQuery("#savePermissionJSON").attr("value", '{}');
	permissionJSON.setJson(jQuery.parseJSON(jQuery("#permissionJSON").val()));
	window.top.toThisHelpPage("application_info_generalTools_resources_info_chooseResources");
	jQuery('body').layout({ 
		applyDefaultStyles: true
	});
	treeload();
	setSize4Div();
	ddtabmenu.definemenu("tabs", "menu-tab");
});

//设置DIV的布局
function setSize4Div(){
	var bodyH = jQuery("body").height();
	var divH = jQuery(".ui-layout-north").height();
	var tabsH = jQuery("#tabs").height();
	jQuery("#contents").height(bodyH-divH-tabsH-18);
	var contentsH = jQuery("#contents").height();
	jQuery(".tab-content-left").height(contentsH);
	var leftH = jQuery(".tab-content-left").height();
	jQuery("#menutreeDivS").height(leftH-15);
	jQuery("#menutreeDivS").width(253);
	jQuery("#foldertreeDivS").height(leftH-15);
	jQuery("#foldertreeDivS").width(253);
	jQuery("#moduletreeDivS").height(leftH-15);
	jQuery("#moduletreeDivS").width(253);
	jQuery("#modulepermission").height(contentsH-20);
}
</script>
<style type="text/css">


body {
	margin: 0px;
	background-color: #FFFFFF;
	font-size:12px;

}
.tab-content-left{width:254px;float: left;border: 1px solid gray;border-bottom:0;border-left:0;}
.tab-content-right{overflow: auto;border: 1px solid gray;padding: 10px;}
</style>
</head>
<body>
<DIV class="ui-layout-north" >
	<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>&nbsp;&nbsp;</td>
			<td class="line-position2">
				<a href="###" onClick="doSave()" style="text-decoration:none;"><img border="0" src="<s:url value="/resource/image/save.gif"/>">{*[Save]*}</a>
			</td>
			<td>&nbsp;&nbsp;</td>
			<td class="line-position2">
				<a href="###" onClick="resourcesExit()" style="text-decoration:none;"><img border="0" src="<s:url value="/resource/image/cancel2.gif"/>">{*[Cancel]*}</a>
			</td>
		</tr>
	</table>
</DIV>
<!--  
<DIV class="ui-layout-west">
	<div id="tree" style="overflow: auto; height: 400px;"></div>
</DIV>
-->
<DIV class="ui-layout-center">
<%@include file="/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div id="tabs" class="basictab">
		<ul>
			<li><a id="menu-tab" href="###" rel="tabs-menu">{*[cn.myapps.core.permission.menu_resource]*}</a></li>
			<li><a id="module-tab" href="###" rel="tabs-module">{*[Module]*}{*[Resource]*}</a></li>
			<!--<li><a id="folder-tab" href="###" rel="tabs-folder">{*[Folder]*}{*[Resource]*}</a></li>-->
			<!-- <li><a id="batchAuth-tab" href="javascript:batchAuth()" rel="batchAuth">{*[Batch.Author]*}</a></li> -->
		</ul>
	</div>
	<div id="contents">
		<div id="tabs-menu">
			<!-- 菜单资源 -->
			<div class="tab-content-left" >
				<div style="border-bottom: 1px solid gray; padding-left: 3px; height:14px;">
					<a href="javascript: menutree.openAll();">{*[Open]*}{*[All]*}</a> | <a href="javascript: menutree.closeAll();">{*[Close]*}{*[All]*}</a>
				</div>
				<div id="menutreeDivS" style="overflow:auto;h: 250px;position: relative;">
					<div id="menutreeDiv" style="padding-left: 3px; width: 250px; float: left;"></div>
				</div>
			</div>
			<div class="tab-content-right"></div>
		</div>
		<div id="tabs-module" style="display:none;">
			<!-- 模块资源 -->
			<div class="tab-content-left">
				<div style="border-bottom: 1px solid gray; padding-left: 3px; height:14px;">
					<a href="javascript: moduletree.openAll();">{*[Open]*}{*[All]*}</a> | <a href="javascript: moduletree.closeAll();">{*[Close]*}{*[All]*}</a>
				</div>
				<div id="moduletreeDivS" style="overflow:auto;position: relative;">
					<div id="moduletreeDiv" style="padding-left: 3px; width:250px; float: left;"></div>
				</div>
			</div>
			<div id="modulepermission" class="tab-content-right"></div>
		</div>
		<div id="tabs-folder" style="display:none;">
			<!-- 文件夹资源 -->
			<div class="tab-content-left">
				<div style="border-bottom: 1px solid gray; padding-left: 3px; height:14px;">
					<a href="javascript: foldertree.openAll();">{*[Open]*}{*[All]*}</a> | <a href="javascript: foldertree.closeAll();">{*[Close]*}{*[All]*}</a>
				</div>
				<div id="foldertreeDivS" style="overflow:auto;position: relative;">
					<div id="foldertreeDiv" style="width:250px; float: left;"></div>
				</div>
			</div>
			<div id="folderpermission" class="tab-content-right"></div>
		</div>
		<!-- 批量授权 
		<div id="tabs-batchAuth">
			<div id="batchAuth" class="tab-content-right"></div>
		</div>
		 -->
	</div>
</DIV>
<s:form name="permissionForm"  namespace="/core/permission" action="save"  theme="simple" method="post">
<!-- permissionJSON回显时用 -->
<s:textarea name="permissionJSON" id="permissionJSON" cssStyle="display:none;"></s:textarea>
<!-- savePermissionJSON保存时用 -->
<s:textarea name="savePermissionJSON" id="savePermissionJSON" cssStyle="display:none;"></s:textarea>
<s:hidden id="app" name="applicationid" value="%{#parameters.applicationid}"/>
<s:hidden name="roleid" value="%{#parameters.roleid}"/>
</s:form>
</body>
</o:MultiLanguage>
</html>