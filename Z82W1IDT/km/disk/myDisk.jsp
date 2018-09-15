<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="cn.myapps.km.org.ejb.NUser"%>
<%@ include file="/km/disk/head.jsp"%>
<%
	NUser user = (NUser)session.getAttribute(NUser.SESSION_ATTRIBUTE_FRONT_USER);
	request.setAttribute("user", user);
%>
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[cn.myapps.km.disk.km_name]*}</title>
<link href='<s:url value="/km/disk/css/layout.css" />' rel="stylesheet" type="text/css"/>
<link href='<s:url value="/km/disk/css/km.css" />' rel="stylesheet" type="text/css"/>

<script src='<s:url value="/km/disk/script/share.js"/>'></script>
<script src='<s:url value="/km/script/json/json2.js"/>'></script>
</head>
<script type="text/javascript">
var copyToUrl = "<s:url value='/km/disk/copyTo.jsp'><s:param name='ndiskid' value='ndiskid' /></s:url>";
var moveToUrl = "<s:url value='/km/disk/moveTo.jsp'><s:param name='ndiskid' value='ndiskid' /></s:url>";
var viewMode = 1; 	//1:listView;2:treeView;
var newFolderMode = 1;	//1:enabled;2:unabled;
	
//切换视图模式
function switchViewMode(){
	var actionName = "listView";
	var viewFrame = document.getElementById("viewFrame");
	viewFrame.contentWindow.location.href = "<s:url value='/km/disk/"+actionName+".action'><s:param name='_type' value='%{#parameters._type}'/></s:url>";
	if(viewMode == 2){
		actionName = "treeview";
		viewFrame.contentWindow.document.forms[0].action = contextPath + '/km/disk/' + actionName + '.action';
		viewFrame.contentWindow.document.forms[0].submit();
	}
}
	//切换新建文件夹按钮操作模式
function setNewFolderStyle(mode){
	var $newFolder = jQuery("#doNewFolder");
	if(newFolderMode != mode) newFolderMode = mode;
	if(newFolderMode == 1){
		$newFolder.css("color","#000");
	}else if(newFolderMode == 2){
		$newFolder.css("color","gray");
	}
}

/** 
 * 点击新建文件夹
 */
function createNewFolder(){
	var viewFrame = document.getElementById("viewFrame");
	if(viewMode == 1){
		viewFrame.contentWindow.doNewFolder();
	}else if(viewMode == 2){
		var dirFrame = viewFrame.contentWindow.document.getElementById("dirFrame");
		dirFrame.contentWindow.doNewFolder2();
	}
	setNewFolderStyle(2); //设置新建文件夹按钮操作模式
}

/**
 * 搜索
 */
function query(){
	var queryString = document.getElementsByName("queryString")[0].value;
	if(queryString == ""){
		alert("{*[cn.myapps.km.disk.search_tip]*}");
		return;
	}
	document.forms[0].action = "<s:url value='/km/disk/file/query.action' ><s:param name='_type' value='_type' /></s:url>";
	document.forms[0].submit();
}

jQuery(document).ready(function(){
	//点击切换到列表模式
	jQuery("#listViewMode").click(function(){
		viewMode = 1;
		switchViewMode();
		jQuery(this).removeClass("subListViewMode").addClass("listViewMode");
		jQuery("#treeViewMode").removeClass("subTreeViewMode").addClass("treeViewMode");
	});
	//点击切换到树型模式
	jQuery("#treeViewMode").click(function(){
		viewMode = 2;
		switchViewMode();
		jQuery(this).removeClass("treeViewMode").addClass("subTreeViewMode");
		jQuery("#listViewMode").removeClass("listViewMode").addClass("subListViewMode");
	});

	jQuery("#doNewFolder").bind("click",function(){
		createNewFolder();	//新建文件夹
	});

	jQuery("#fileUpload").click(function(){
		ev_upload(); 	//文件上传的方法
	});

	//按回车键进行搜索
	jQuery("#search_keyword").keydown(function(event){
	 if(event.keyCode==13){
		 query();
	 }
	});
});

/**
 * 文件上传的方法
 */
function ev_upload(){
	var url = "<s:url value='/km/disk/file/new.action' ><s:param name='_type' value='_type' /></s:url>";
	var viewFrame = document.getElementById("viewFrame");
	var nDirId ="";
	if(viewMode==1){//列表视图
		nDirId += viewFrame.contentWindow.document.getElementById("ndirid").value;
	}else if(viewMode==2){//树型视图
		var dirFrame = viewFrame.contentWindow.document.getElementById("dirFrame");
		nDirId += dirFrame.contentWindow.document.getElementById("ndirid").value;
	}
	url +="&_nDirId="+nDirId;

	OBPM.dialog.show({
		opener : window,
		width : 800,
		height : 640,
		url : url,
		args : {},
		title : "{*[cn.myapps.km.disk.upload]*}",
		close : function(rtn) {
			if(rtn && rtn=='success'){
				if(viewMode==1 ){
					viewFrame.contentWindow.document.forms[0].action = contextPath + '/km/disk/viewndir.action';
					viewFrame.contentWindow.document.forms[0].submit();
				}else if(viewMode==2){
					viewFrame.contentWindow.document.forms[0].action = contextPath + '/km/disk/treeview.action';
					viewFrame.contentWindow.document.forms[0].submit();
				}
			}
		}
	});
	//location.href = url;
}

function getDimensions(){
	var documentH = jQuery(document).height();
	var bodyW = jQuery(document).width()-20;
	var mainRightW = jQuery(".mainRight").width();
	jQuery(".mainLeft").width(bodyW - mainRightW-20);
	jQuery(".mainLeft").height(documentH-1);
	jQuery(".mainRight").height(documentH - 18);//18是padding和border
}

function setIframeHeight(){
	var mainLeftH = jQuery(".mainLeft").height();
	var dbank_titleH = jQuery(".dbank_title").height();
	var controlH = jQuery(".control").height();
	jQuery("#iframeContent").height(mainLeftH - dbank_titleH - controlH );
}

jQuery(window).resize(function(){
	getDimensions();
	setIframeHeight();
});

jQuery(document).ready(function(){
	getDimensions();
	setIframeHeight();
});

function ev_openMyLogs(){
	var url = '<s:url value="/km/logs/logs_personal.jsp?tab=share"/>';
	OBPM.dialog.show({
		opener : window.top,
		width : 860,
		height : 505,
		url : url,
		args : {},
		title : "{*[cn.myapps.km.disk.operation_logs]*}",
		close : function() {
		}
	});
}
</script>
<body>
<s:form action="" method="post" theme="simple">
	<div id="content" class="content" >
		<div id="mainLeft" class="mainLeft">
			<h3 class="dbank_title">
				<a href="<s:url value='/km/disk/view.action'><s:param name='_type' value='%{#parameters._type}'/></s:url>">
				<s:if test='_type=="1"'>
				{*[cn.myapps.km.disk.public_disk]*}
				</s:if>
				<s:elseif test='_type=="2"'>
				{*[cn.myapps.km.disk.my_disk]*}
				</s:elseif>
				<s:elseif test='_type=="5"'>
				{*[cn.myapps.km.disk.archive_disk]*}
				</s:elseif>
				</a>
			</h3>
			<div class="control">
				<div class="operate">
				<s:if test=' _type=="1" '>
					<div class="upload">
						<div class="upload_left"></div>
						<div class="upload_center"><a id="fileUpload" ><img src="<s:url value='/km/disk/images/upload_icon.gif' />" />{*[cn.myapps.km.disk.upload]*}</a></div>
						<div class="upload_right"></div>
						<div class="clear"></div>
					</div>
					
					<div class="newCreat">
						<div class="newCreat_left"></div>
						<div class="newCreat_center"><a id="doNewFolder"><img src="<s:url value='/km/disk/images/new_create.gif' />" />{*[cn.myapps.km.disk.new_folder]*}</a></div>
						<div class="newCreat_right"></div>
						<div class="clear"></div>
					</div>
					<div class="clear"></div>
				</s:if>
				<s:elseif test=' _type==2 '>
					<div class="upload">
						<div class="upload_left"></div>
						<div class="upload_center"><a id="fileUpload" ><img src="<s:url value='/km/disk/images/upload_icon.gif' />" />{*[cn.myapps.km.disk.upload]*}</a></div>
						<div class="upload_right"></div>
						<div class="clear"></div>
					</div>
					
					<div class="newCreat">
						<div class="newCreat_left"></div>
						<div class="newCreat_center"><a id="doNewFolder"><img src="<s:url value='/km/disk/images/new_create.gif' />" />{*[cn.myapps.km.disk.new_folder]*}</a></div>
						<div class="newCreat_right"></div>
						<div class="clear"></div>
					</div>
					<div class="clear"></div>
				</s:elseif>
				
				</div>

				<div class="setType">
					<div class="listViewMode" title="{*[cn.myapps.km.disk.list_mode]*}" id="listViewMode"></div>
					<div class="treeViewMode" title="{*[cn.myapps.km.disk.tree_mode]*}" id="treeViewMode"></div>
				</div>
				<div class="clear"></div>
			</div>
			<div id="iframeContent" style="width:100%;">
			<%@include file="/common/msg.jsp"%>
				 <iframe id="viewFrame" src="<s:url value='/km/disk/listView.action'><s:param name='_type' value='%{#parameters._type}'/><s:param name='_sortStatus' value='%{#parameters._sortStatus}'/><s:param name='orderbyfield' value='%{#parameters.orderbyfield}'/><s:param name='ndiskid' value='%{#parameters.ndiskid}'/><s:param name='ndirid' value='%{#request.ndirid}'/><s:param name='viewType' value='1'/></s:url>" width="100%" height="100%" scrolling="no" frameborder="0"></iframe>
			</div>
		</div>
		<div id="mainRight" class="mainRight">
			<!--  <div class="search_box">
				<div class="search_type" align="center">
					文献分类
				</div>
				<input class="search_input" type="text"/>
				<img class="search_img" alt="" src="<s:url value='/km/disk/images/select.gif' />"/>
			</div>
			<div class="search_box">
				<div class="search_type" align="center">
					类型分类
				</div>
				<input class="search_input" type="text"/>
				<img class="search_img" alt="" src="<s:url value='/km/disk/images/select.gif' />">
			</div>
			-->
			<div class="search_box">
				<input class="search_input2"  type="text" name="queryString"  id="search_keyword"/>
				<img class="search_img2" alt="" src="<s:url value='/km/disk/images/magnifier.gif' />" onclick="query()" /> 
			</div>
			<img class="dividing" alt="" src="<s:url value='/km/disk/images/dash.gif' />">
			<table class="opTable">
				<!--<tr class="fTr" >
					<td>
						<img alt="" src="<s:url value='/km/disk/images/library.gif' />">
						<s:if test='_type=="1"'>
					<a href="<s:url value='/km/disk/view.action'><s:param name='_type' value='2'/></s:url>">我的网盘</a>
					</s:if>
					<s:elseif test='_type=="2"'>
					<a href="<s:url value='/km/disk/view.action'><s:param name='_type' value='1'/></s:url>">公共网盘</a>
					</s:elseif>
						
					</td>
				</tr>-->
				<s:if test='_type!="5"'>
					<tr>
						<td>
							<img alt="" src="<s:url value='/km/disk/images/shareC_icon.gif' />">
							<a href="#" onclick="ev_openMyLogs()">{*[cn.myapps.km.disk.my_logs]*}</a>
						</td>
					</tr>
				</s:if>
				<!-- <tr>
					<td>
						<img alt="" src="<s:url value='/km/disk/images/shareC_icon.gif' />">
						<a>我的共享</a>
					</td>
				</tr>
				<tr>
					<td>
						<img alt="" src="<s:url value='/km/disk/images/earth.gif' />">
						<a>知识地图</a>
					</td>
				</tr>
				<tr>
					<td>
						<img alt="" src="<s:url value='/km/disk/images/ellipsis.gif' />">
						<a>其他</a>
					</td>
				</tr> -->
			</table>
		</div>
		<div class="clear"></div>
	</div>
</s:form>
</body>
</o:MultiLanguage></html>