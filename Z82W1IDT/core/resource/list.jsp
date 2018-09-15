<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html><o:MultiLanguage>
<head>
<style type="text/css">
	.curPage_lTree{
		padding-left: 5px;
		padding-top: 5px;
		overflow: auto;
		width: 200px;
		height:95%
		}
	.curPage_td_border{border: 2px solid #D8DADC;}
</style>
<%
	String app=(String) session.getAttribute("currentApplication");
%>
<title>{*[Menu_List]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<link rel="stylesheet" href='<s:url value="/script/dtree/dtree.css" />' type="text/css">
<script src="<s:url value='/script/dtree/dtree.js'/>"></script>
<script src="<s:url value="/script/list.js"/>"></script>

<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/ResourceUtil.js"/>'></script>
<script>
var d = new dTree('d','<s:url value="/script/dtree"/>','menusCheckbox', false);
var app='<%=app%>';

function ev_load(){
	if ('<s:property value="#parameters['refreshs']" />'=='true') {
		parent.frames[0].location.reload();
	}
	inittab();
}

function init_MenuTree(){
	d = new dTree('d','<s:url value="/script/dtree"/>','menusCheckbox');
	var root = app;
	var rightFunction;
	rightFunction="treeRightFunction('"+app+"','0')";
	d.add(root, '-1', '{*[cn.myapps.core.resource.tree_menu]*}', '', '', 'applicationframe', null, null, null, rightFunction);
	ResourceUtil.getResourcesByApp(app, function(data){
		if(data!=null){
			var resources=data;
			for(var i=0; i<resources.length;i++){
				var url = '<s:url value="/core/resource/edit.action"/>?application=' + 
				app + "&id=" + resources[i].id;
				rightFunction="treeRightFunction('"+app+"','"+resources[i].id+"')";
				if(resources[i].superior==null || resources[i].superior.id==""){
					d.add(resources[i].id, root, resources[i].description, url, resources[i].description, 'contentFrame', '', '', '', rightFunction);
				}else{
					d.add(resources[i].id, resources[i].superior.id, resources[i].description, url, resources[i].description, 'contentFrame', '', '', '', rightFunction);
				}
			}
		}
		jQuery("#leftTree").html(""+d);
	});
}

function treeRightFunction(appid,nodeid){
	//alert("appid-->"+appid+"    nodeid-->"+nodeid);
}

jQuery(document).ready(function(){
	ev_load();
	cssListTable();
	window.top.toThisHelpPage("application_info_generalTools_menu_list");
	init_MenuTree();
});

function doCopy(){
	var url='<s:url action="toCopyResource"/>?application='+app;
	jQuery("#contentFrame").attr("src",url);
}

function doNew(){
	var url='<s:url action="new"/>?application='+app;
	jQuery("#contentFrame").attr("src",url);
}

function setSelectsVal(){
	var menuids = "";
	var form = document.getElementById("menusCheckbox");
	for (var i=0; i<form.elements.length; i++) {
		var element = form.elements[i];
		if (element.name == "id" && element.type=='checkbox'){
			if( element.checked == true ){
				menuids = menuids + element.value + ";";
			}
		}
	}	
	menuids=menuids.substring(0,menuids.length-1);	
	jQuery("#selects").attr("value",menuids);

}

function doDelete(){
	jQuery("#applicationframe",parent.document).addClass("hasMenu");
	setSelectsVal();
	if(jQuery("#selects").val()==''){
		alert("请勾选要删除的菜单");
		return;
	}
	var listform = document.forms["formList"];	
    listform.action='<s:url action="delete"/>?application='+app;
    listform.submit();
}

function getSelects(){
	setSelectsVal();
	if(jQuery("#selects").val()==''){
		return false;
	}
	return jQuery("#selects").val();
}
function adjustViewLayout(){
	var documentH=parent.document.body.offsetHeight;
	jQuery("body").height(documentH);
	var tab_tableH=jQuery("#tab_table").height();
	if(navigator.userAgent.indexOf("MSIE")>0){ 
		jQuery("#leftTree").height(documentH-tab_tableH-45);
	}else if(isFirefox=navigator.userAgent.indexOf("Firefox")>0){
		jQuery("#leftTree").height(documentH-tab_tableH-85);
	}else if(isChrome=navigator.userAgent.indexOf("Chrome")>0){
		jQuery("#leftTree").height(documentH-tab_tableH-62);
  	} 
}
jQuery(window).load(function(){
	adjustViewLayout();
}).resize(function(){
	adjustViewLayout();
});
</script>
</head>
<body id="application_info_generalTools_menu_list" class="body-back" >

	<%@include file="/common/list.jsp"%>
	<table id='act' cellpadding="0" cellspacing="0" width="100%">
		<tr class="nav-td" style="height:27px;">
			<td rowspan="2"><div class="appsUsualIncludeTab"><%@include file="/common/commontab.jsp"%></div></td>
			<td class="nav-td" width="100%">&nbsp;</td>
		</tr>
		<tr class="nav-s-td">
			<td class="nav-s-td" align="right">
				<table width="100%" border=0 cellpadding="0" cellspacing="0">
					<tr>
						<td valign="top" align="right">
							<img align="middle" style="height:23px;" src="<s:url value='/resource/imgv2/back/main/nav_sep.gif' />" />
							<button type="button" class="button-image" onClick="doNew()"><img src="<s:url value="/resource/imgnew/act/act_2.gif"></s:url>">{*[New]*}</button>
							<button type="button" class="button-image" onClick="doDelete()"><img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
							<button type="button" class="button-image" onClick="doCopy()"><img
								src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[cn.myapps.core.resource.copy_menu]*}</button>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
 
	<script>
	/*
		jQuery(function(){
			if(jQuery.browser.msie)
			{
				jQuery("#leftTree").height(jQuery("body").height()-jQuery("#act").height()-22);
			}
			else if(jQuery.browser.mozilla)
			{
				jQuery("#leftTree").height(684-jQuery("#act").height()-22);
			}
			
			jQuery("#contentFrame").height(jQuery("#leftTree").height()+16);
			//jQuery("#contentFrame").width(jQuery("body").width()-jQuery("#leftTree").width()-12);
			jQuery("#leftTree").css("overflow","auto");
		});
	*/
	</script>
 <div class="navigation_title">{*[cn.myapps.core.resource.menu]*}</div>
	<table class="table_noborder" style="height:94%"><tr><td nowrap="nowrap" class="curPage_td_border" style="width:200px;" valign="top">
		<div style="border-bottom: 1px solid #D8DADC;"><a href="javascript: d.openAll();">{*[cn.myapps.core.resource.open_all]*}</a> | <a href="javascript: d.closeAll();">{*[cn.myapps.core.resource.close_all]*}</a></div>
		<div id="leftTree" class="curPage_lTree"></div>
		</td>
		<td valign="top" class="curPage_td_border" style="border-left: 0px;">

			<%@include file="/common/msg.jsp"%>
			<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>

		<iframe frameborder="0" id="contentFrame" width="100%" height="100%" name="contentFrame" src=""></iframe>
	</td></tr></table>

<!-- 
	 <div class="table_noborder" style="height:91.5%">
	 	<div  style="border: 2px solid #D8DADC;width:200px;float:left;height:100%" >
			<div style="border-bottom: 1px solid #D8DADC;width:200px"><a href="javascript: d.openAll();">{*[Open]*}{*[All]*}</a> | <a href="javascript: d.closeAll();">{*[Close]*}{*[All]*}</a></div>
			<div id="leftTree" style="padding-left: 5px;padding-top: 5px;overflow: auto;width: 200px;height:96.5%"></div>
		</div>
		<div style="border: 2px solid #D8DADC;border-left: 0px;">
			<%--<%@include file="/common/msg.jsp"%>--%>
			<iframe frameborder="0" id="contentFrame" width="100%" height="100%" name="contentFrame" src="" ></iframe>
		</div>
	</div>
 -->
 
 <!-- 下面的ww原来放在body之下，由于ff会为hidden分配空间,所以放在最下面 -->
	<s:form name="formList" theme="simple" action="list" method="post">
	<input type="hidden" name="menus" id="selects" value="">
	</s:form>
	
	
</body>
</o:MultiLanguage></html>








