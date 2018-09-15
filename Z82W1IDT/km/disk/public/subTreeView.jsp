<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="cn.myapps.km.org.ejb.NUser"%>
<%@page import="cn.myapps.km.permission.ejb.PermissionHelper"%>
<%@ include file="/km/disk/head.jsp"%> 
<%@page import="cn.myapps.km.permission.ejb.PermissionHelper"%><html>
<%
	NUser user = (NUser)session.getAttribute(NUser.SESSION_ATTRIBUTE_FRONT_USER);
	boolean isPublicDiskAdmin = user.isPublicDiskAdmin();
	boolean isDirManager = true;
	if(!isPublicDiskAdmin){
		isDirManager = PermissionHelper.verifyDirManagePermission(request.getParameter("ndirid"),user);
	}
%>
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[cn.myapps.km.disk.km_name]*}</title>
<link href='<s:url value="/km/disk/css/layout.css" />' rel="stylesheet" type="text/css"/>
<link href='<s:url value="/km/disk/css/km.css" />' rel="stylesheet" type="text/css"/>

<script src='<s:url value="/km/disk/script/share.js"/>'></script>
<script src='<s:url value="/km/disk/script/myDisk.js"/>'></script>
<script src='<s:url value="/km/script/json/json2.js"/>'></script>
</head>
<script type="text/javascript">
var copyToUrl = "<s:url value='/km/disk/copyTo.jsp'><s:param name='ndiskid' value='ndiskid' /></s:url>";
var moveToUrl = "<s:url value='/km/disk/moveTo.jsp'><s:param name='ndiskid' value='ndiskid' /></s:url>";
var isPublicDiskAdmin = '<%=isPublicDiskAdmin%>'=="true"?true:false;
var isDirManager = '<%=isDirManager%>'=="true"?true:false;


/*
 *列头排序
 */
function orderbyColumn(fieldName){
	var _sort = document.getElementById("_sortStatus");
	document.getElementById("orderbyfield").value = fieldName;
	if(_sort.value != null && _sort.value != ''){
		if(_sort.value == 'ASC'){
			document.getElementById("_sortStatus").value = 'DESC';
		}else if(_sort.value == 'DESC'){
			document.getElementById("_sortStatus").value = 'ASC';
		}
	}else {
		document.getElementById("_sortStatus").value = 'DESC';
	}
	
	document.forms[0].action = contextPath + '/km/disk/viewndir.action';
	document.forms[0].submit();
}

function authorizeListW(_fileId,_fileType) {
	var url = contextPath + "/km/permission/list.action?_fileId="+_fileId+"&_fileType="+_fileType;
	OBPM.dialog.show({
				opener : window.top,
				width : 610,
				height : 450,
				url : url,
				args : {},
				title : "{*[cn.myapps.km.disk.user_authorization]*}",
				maximized: false, // 是否支持最大化
				close : function() {
				}
	});
}

//获取文件后缀名
function getSuffix(){
	jQuery(".fileViewAction").each(function(){
	    var fileName = jQuery(this).html();
		 if(fileName){
			 var suffix = fileName.substr(fileName.lastIndexOf(".") + 1,fileName.length);
			 var  $iconSpan = jQuery(this).parent().siblings(".icon-file-s");
			 if(suffix.toLowerCase()=="doc" || suffix.toLowerCase()=="docx" || suffix.toLowerCase()=="wps"){
				 $iconSpan.addClass("icon-file-doc");
			 }else if(suffix.toLowerCase()=="xls" || suffix.toLowerCase()=="xlsx" || suffix.toLowerCase()=="et"){
				 $iconSpan.addClass("icon-file-xls");
			 }else if(suffix.toLowerCase()=="pdf"){
				 $iconSpan.addClass("icon-file-pdf");
			 }else if(suffix.toLowerCase()=="rar"){
				 $iconSpan.addClass("icon-file-rar");
			 }else if(suffix.toLowerCase()=="zip"){
				 $iconSpan.addClass("icon-file-zip");
			 }else if(suffix.toLowerCase()=="txt"){
				 $iconSpan.addClass("icon-file-txt");
			 }else if(suffix.toLowerCase()=="ppt" || suffix.toLowerCase()=="pptx" || suffix.toLowerCase()=="dps"){
				 $iconSpan.addClass("icon-file-ppt");
			 }else if(suffix.toLowerCase()=="htm" || suffix.toLowerCase()=="html"){
				 $iconSpan.addClass("icon-file-html");
			 }else if(suffix.toLowerCase()=="mov"){
				 $iconSpan.addClass("icon-file-mov");
			 }else if(suffix.toLowerCase()=="gif" || suffix.toLowerCase()=="png" ||
					 suffix.toLowerCase()=="apng" || suffix.toLowerCase()=="bmp" ||
					 suffix.toLowerCase()=="jpeg" || suffix.toLowerCase()=="jpg"){
				 $iconSpan.addClass("icon-file-png");
			 }else if(suffix.toLowerCase()=="folder"){
				 $iconSpan.addClass("icon-file-folder");
			 }else{
				 $iconSpan.addClass("icon-file-unknown");
			 }
		 }
	});
}

jQuery(document).ready(function(){
	getSuffix();
	permission.init();
    setDoNewFolderStyle(); 	//设置新建按钮的样式
    showNumHtml(); //输出每页显示数量
    resizeTbData_box(); //调整显示列表的iframe高度
});
</script>
<body>
<s:bean name="cn.myapps.km.permission.ejb.PermissionHelper" id="permissionHelper"></s:bean>
<s:hidden name="showpage" id="showpage" value="{*[cn.myapps.km.disk.page_show]*}" />
<s:form action="" method="post" theme="simple">
<s:bean name="cn.myapps.km.permission.ejb.PermissionHelper" id="permissionHelper"></s:bean>
<s:hidden name="back" id="back" value="{*[cn.myapps.km.disk.back]*}" />
<s:hidden name="allfile" id="allfile" value="{*[cn.myapps.km.disk.all]*}" />
<s:hidden name="movetotitle" id="movetotitle" value="{*[cn.myapps.km.disk.move_to]*}" />
<s:hidden name="deletetip" id="deletetip" value="{*[cn.myapps.km.disk.delete_tip]*}" />
<s:hidden name="adminAuthorizetitle" id="adminAuthorizetitle" value="{*[cn.myapps.km.disk.set_administrator]*}" />
<s:hidden name="ndiskid" id="ndiskid" value="%{#request.ndiskid}" />
<s:hidden name="ndirid" id="ndirid" value="%{#request.ndirid}" />
<s:hidden name="_currpage" id="_currpage" value="%{#request.datas.pageNo}"/>
<s:hidden name="_rowcount" id="_rowcount" value="%{#request.datas.rowCount}" />
<s:hidden name="naviJson" id="naviJson" value="%{#request.naviJson}" />
<s:hidden name="_type" id="_type" />
<s:hidden name="_sortStatus" id="_sortStatus" value="%{#request._sortStatus}"/>
<s:hidden name="orderbyfield" id="orderbyfield" value="%{#request.orderbyfield}"/>
<s:hidden name="viewType" id="viewType" value="2"></s:hidden>
		<div>
			<h3 class="shareSystem" style="display:none;"><a>{*[cn.myapps.km.disk.knowledge_sharing_system]*}</a></h3>
			<ul class="crumbs clearfix"><li class="directory" >{*[cn.myapps.km.disk.all]*}</li><li class="loadNumDiv">{*[cn.myapps.km.disk.load_tip]*}<a class="loadNum"><s:property value="%{#request.datas.datas.size()}" /></a>{*[cn.myapps.km.disk.load_tip2]*}</li></ul>
			<table class="table1 table_cls1" id="tableTitle" style="position: relative;z-index: 1;">
				<tr class="thead" style="border:1px solid #ECECEC;">
					<td class="checkbox tdCheckedAll"><input type="checkbox" name="checkAll" class="checkAll" /></td>
					<td class="fileName checkHidden " style="cursor:hand;" onclick="orderbyColumn('name')">
						<span>{*[cn.myapps.km.disk.file_name]*}</span>
						<s:if test="#request.orderbyfield == 'name' && #request._sortStatus == 'ASC'">
							<img border="0" src="<s:url value='/km/disk/images/up.gif' />"></img>
						</s:if>
						<s:elseif test="#request.orderbyfield == 'name' && #request._sortStatus == 'DESC'">
							<img border="0" src="<s:url value='/km/disk/images/down.gif' />"></img>
						</s:elseif>
					</td>
					<td align="center" class="size checkHidden" style="cursor:hand;" onclick="orderbyColumn('filesize')">
						<span>{*[cn.myapps.km.disk.size]*}</span>
						<s:if test="#request.orderbyfield == 'filesize' && #request._sortStatus == 'ASC'">
							<img border="0" src="<s:url value='/km/disk/images/up.gif' />"></img>
						</s:if>
						<s:elseif test="#request.orderbyfield == 'filesize' && #request._sortStatus == 'DESC'">
							<img border="0" src="<s:url value='/km/disk/images/down.gif' />"></img>
						</s:elseif>
					</td>
					<td align="center" class="dateTime checkHidden" style="cursor:hand;" onclick="orderbyColumn('createdate')">
						<span>{*[cn.myapps.km.disk.time]*}</span>
						<s:if test="#request.orderbyfield == 'createdate' && #request._sortStatus == 'ASC'">
							<img border="0" src="<s:url value='/km/disk/images/up.gif' />"></img>
						</s:if>
						<s:elseif test="#request.orderbyfield == 'createdate' && #request._sortStatus == 'DESC'">
							<img border="0" src="<s:url value='/km/disk/images/down.gif' />"></img>
						</s:elseif>
					</td>
					<!--<td align="center" class="state checkHidden">状态</td>-->
					<td align="center" class="uploadPerson checkHidden">{*[cn.myapps.km.disk.uploader]*}</td>
					<td class="checkShow" style="display:none;" colspan="4">
						<div class="shareDiv">
							<div>{*[cn.myapps.km.disk.checked]*}<span id="checkedNum"></span>{*[cn.myapps.km.disk.file_folder]*}</div>
							<div>
								<p class="button_left"></p>
								<p align="center" class="button_center ie6Css" style="width:55px"><a class="delete" id="delBtn">{*[cn.myapps.km.disk.delete]*}</a></p>
								<p class="button_right"></p>
							</div>
							<div class="more" id="mBtn">
								<p class="button_left"></p>
								<p class="button_center ie6Css" style="_padding-top:7px;"><a>{*[cn.myapps.km.disk.more]*}</a><img src="<s:url value='/km/disk/images/more_icon.gif'/>" /></p>
								<p class="button_right"></p>
								<ul class="pull_down_menu">
									<li onclick="moveTo()" class="no_border_top"><a class="move_to">{*[cn.myapps.km.disk.move_to]*}</a></li>
									<!-- li><a onclick="copyTo()">复制到</a></li> -->
									<li><a class="renaming" id="renaming">{*[cn.myapps.km.disk.rename]*}</a></li>
									<li><a id="authorizeBtn">{*[cn.myapps.km.disk.authorization]*}</a></li>
									<li><a id="adminAuthorizeBtn">{*[cn.myapps.km.disk.set_administrator]*}</a></li>
								</ul>
							</div>
						</div>
					</td>
					</tr>
				</table>
				<div class="tableData_box">
					<table class="table2 table_cls2" id="tableData" cellspacing="0">
					<s:iterator value="datas.datas" id="status">
						<s:if test="#status.fileType==\"1\"">
						<tr class="tr">
							<td align="center" class="checkbox tdChecked">
								<input type="checkbox" name="_dirSelects" value="<s:property value="id"/>" permissions='<s:property escape="false" value="#permissionHelper.getPermissonsWithJson(1,1,id,#request.ndirid,#session.KM_FRONT_USER)"/>'/>
							</td>
							<td class="newFileName fileName">
								<div style="position:relative;">
									<div class="imgContent icon-file-s icon-file-folder"></div>
									<div class="doView viewEllipsis">
										<a title="<s:property value="name" />" class="fileView" href="javascript:doViewTree('<s:property value="id"/>','<s:property value="name" />');"><s:property value="name" /></a>
									</div>
									<div class="more_btn" style="position:absolute;top:0px;right:0px;">
										<div class="more_authorize goAuthorize"></div>
										 <div class="more_sfile" id="more_sfile">
											<div class="more_div"></div>
											<ul class="more_sfile_inner">
												<li onclick="moveTo()" class="no_border_top"><a  class="move_to">{*[cn.myapps.km.disk.move_to]*}</a></li>
												<!-- li><a onclick="copyTo()">复制到</a></li> -->
												<li><a class="renaming">{*[cn.myapps.km.disk.rename]*}</a></li>
												<li><a class="delete">{*[cn.myapps.km.disk.delete]*}</a></li>
												<li title="{*[cn.myapps.km.disk.administrator_authorization]*}"><a class="adminAuthorize">{*[cn.myapps.km.disk.set_administrator]*}</a></li>
											</ul>
											<div class="clear"></div>
										</div>
										<div class="clear"></div>
									</div>
								</div>
							</td>
							<td align="center" class="size">-</td>
							<td class="dateTime" align="center"><s:date name="#status.createDate" format="yyyy-MM-dd"/></td>
							<!--<td class="state"></td>-->
							<td align="center" class="">-</td>
						</tr>
						</s:if>
						<s:elseif test="#status.fileType==\"2\"">
						<tr class="tr">
							<td align="center" class="checkbox tdChecked">
								<input type="checkbox" name="_fileSelects" value="<s:property value="id"/>" permissions='<s:property escape="false" value="#permissionHelper.getPermissonsWithJson(1,2,id,#request.ndirid,#session.KM_FRONT_USER)"/>'/>
							</td>
							<td class="newFileName fileName">
								<div style="position:relative;">
									<span title="" class="icon-file-s"></span>
									<div class="doView viewEllipsis">
											<a title="<s:property value="name" />" class="fileView fileViewAction" id ="<s:property value='id'/>" ><s:property value="name" /></a>
									</div>
									<div class="more_btn" style="position:absolute;top:0px;right:0px;">
											<div class="more_authorize goAuthorize"></div>
											 <div class="more_sfile" id="more_sfile">
												<div class="more_div"></div>
												<ul class="more_sfile_inner">
													<li onclick="moveTo()" class="no_border_top"><a class="move_to">{*[cn.myapps.km.disk.move_to]*}</a></li>
													<!-- li><a onclick="copyTo()">复制到</a></li> -->
													<li><a class="renaming">{*[cn.myapps.km.disk.rename]*}</a></li>
													<li><a class="delete">{*[cn.myapps.km.disk.delete]*}</a></li>
													<li title="{*[cn.myapps.km.disk.enterprise_domain_authorization]*}"><a class="adminAuthorize">{*[cn.myapps.km.disk.set_administrator]*}</a></li>
												</ul>
												<div class="clear"></div>
											</div>
											<div class="clear"></div>
										</div>
								</div>
							</td>
							<td class="size" align="center"><s:property value="#status.getFileSize()"/></td>
							<td class="dateTime" align="center"><s:date name="#status.createDate" format="yyyy-MM-dd"/></td>
							<!--<td class="state"></td>-->
							<td align="center" class="uploadPerson checkHidden"><s:property value="creator" /></td>
						</tr>
						</s:elseif>
					</s:iterator>
					
					</table>
				</div>
				<div class="pageNav" style="width:100%;">
					<div class="pageNumber">
						<a href="javascript:showFirstPage();" class="first"><img src="<s:url value='/km/disk/images/first.gif'/>"/></a>
						<a href="javascript:showPreviousPage();" class="pre"><img src="<s:url value='/km/disk/images/pre.gif'/>"/></a>
						<span>(<s:property value="%{#request.datas.pageNo}"/>/<s:property value="%{#request.datas.getPageCount()}"/>)</span>
						<a href="javascript:showNextPage();" class="next"><img src="<s:url value='/km/disk/images/next.gif'/>"/></a>
						<a href="javascript:showLastPage();" class="last"><img src="<s:url value='/km/disk/images/last.gif'/>"/></a>
					</div>
					<div class="showNum"></div>
				</div>
			<div class="clear"></div>
		</div>
</s:form>
</body>
</o:MultiLanguage></html>