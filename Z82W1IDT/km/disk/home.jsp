<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="cn.myapps.km.org.ejb.NUser"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<s:bean name="cn.myapps.km.category.ejb.CategoryHelper" id="categoryHelper"></s:bean>
<%@ include file="/km/disk/head.jsp"%>

<%
	NUser user = (NUser)session.getAttribute(NUser.SESSION_ATTRIBUTE_FRONT_USER);
	boolean isPublicDiskAdmin = user.isPublicDiskAdmin();
%>
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[cn.myapps.km.disk.popular_share]*}</title>
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
var isDirManager = true;

function save2mydiskSingle(_fileId,_fileType) {
	var url = contextPath + "/km/disk/save2mydisk.jsp?_fileId="+_fileId;
	OBPM.dialog.show({
				opener : window.top,
				width : 610,
				height : 450,
				url : url,
				args : {},
				title : "{*[cn.myapps.km.disk.copy_to_private_disk]*}",
				maximized: false, // 是否支持最大化
				close : function() {
				}
	});
}

function save2mydiskMulti() {
	var url = contextPath + "/km/disk/save2mydisk.jsp"
	var _fileselects = "";
	
	jQuery(".checkbox").find("input[name='_fileSelects'][checked='checked']").each(function(){
		_fileselects += jQuery(this).attr("value") + ";";
	});
	
	if(_fileselects.length>1){
		_fileselects = _fileselects.substring(0, _fileselects.length-1);
	}
	
	var checkedJson = "{'_fileselects':'" + _fileselects + "'}";
	OBPM.dialog.show({
		opener : window.top,
		width : 610,
		height : 450,
		url : url,
		args : {'checkedJson':checkedJson},
		title : "{*[cn.myapps.km.disk.copy_to_private_disk]*}",
		maximized: false, // 是否支持最大化
		close : function() {
		}
	});
}

function changeCategory(categoryID){
	document.getElementById("categoryid").value = categoryID;
	document.getElementById("_currpage").value = "1";
	document.forms[0].submit();
}

function showCategory(categoryid){
	jQuery("#categoryList").val(categoryid);
}

//根据分类生成五个选项
function createTypeHtml(){
	var $optionObjs = jQuery("#categoryList option");
	var curId = jQuery("#categoryid").val();
	var html = "";
	html += "<li onclick=changeCategory('') class='cursor";
	if(!curId) html += " selectLi";
	html += "' >{*[cn.myapps.km.disk.all]*}</li>";
	for(var i=0;i<5;i++){
		if(jQuery($optionObjs[i]).val()){
			html += "<li onclick=changeCategory('" + jQuery($optionObjs[i]).val() + "') class='cursor";
			if(curId == jQuery($optionObjs[i]).val()) html += " selectLi";
			html += "' >"+jQuery($optionObjs[i]).html() + "</li>";
		}
	}
	jQuery(".fileTypeOption li").before(html);
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
	jQuery(".goSave2mydisk").click(function(event){
		event.stopPropagation();
		jQuery("#tableData").find("input:checkbox").removeAttr("checked");
		var $checkbox = jQuery(this).parents(".tr").find("input:checkbox");
		$checkbox.attr("checked","checked");
		var _fileId =  $checkbox.val();
		var _fileType =  $checkbox.attr("_fileType");
		save2mydiskSingle(_fileId,_fileType);
	});

	//回显分类
	var categoryid = document.getElementById("categoryid").value;
	showCategory(categoryid);

	getSuffix(); //获取文件后缀名
	createTypeHtml();	//根据分类生成五个选项
	var actionURL = '<s:property value="#request.dataType"/>'=='topShare'? contextPath + '/km/disk/listHotest.action':contextPath + '/km/disk/listNewest.action';
	showNumHtml(actionURL); //输出每页显示数量
});
</script>
<body>
<s:form action="" method="post" theme="simple">
<s:hidden name="back" id="back" value="{*[cn.myapps.km.disk.back]*}" />
<s:hidden name="allfile" id="allfile" value="{*[cn.myapps.km.disk.all]*}" />
<s:hidden name="showpage" id="showpage" value="{*[cn.myapps.km.disk.page_show]*}" />
<s:hidden name="ndiskid" id="ndiskid" value="%{#request.ndiskid}" />
<s:hidden name="ndirid" id="ndirid" value="%{#request.ndirid}" />
<s:hidden name="_currpage" id="_currpage" value="%{#request.datas.pageNo}"/>
<s:hidden name="_rowcount" id="_rowcount" value="%{#request.datas.rowCount}" />
<s:hidden name="naviJson" id="naviJson" value="%{#request.naviJson}" />
<s:hidden name="_type" id="_type"/>
<s:hidden name="_sortStatus" id="_sortStatus" value="%{#request._sortStatus}"/>
<s:hidden name="orderbyfield" id="orderbyfield" value="%{#request.orderbyfield}"/>
<s:hidden name="viewType" id="viewType" value="1"></s:hidden>
<s:hidden name="categoryid" id="categoryid" value="%{#request.categoryid}" />
	<div id="content" class="content">
		<div>
		<!--这两个只能显示一个-->
			<div class="fileTypeOption">
				<ul>
					<li style="padding-left: 30px;">
						<s:select cssClass="input-cmd" name="categoryList" id="categoryList" list="#categoryHelper.getRootCategory(#session.FRONT_USER.domainid)" listKey="id" listValue="name" headerKey="" headerValue="{*[cn.myapps.km.disk.all_file_types]*}" onchange="changeCategory(this.value)"/>
					</li>
				</ul>
			</div>
			<ul class="crumbs clearfix">
				<li class="directory"></li>
				<li class="loadNumDiv">{*[cn.myapps.km.disk.load_tip]*}<a class="loadNum"><s:property value="%{#request.datas.datas.size()}" /></a>{*[cn.myapps.km.disk.load_tip2]*}</li>
			</ul>
			<table class="table" id="tableTitle">
			<tr class="thead" style="border:1px solid #ECECEC;">
				<td class="checkbox tdCheckedAll"><input type="checkbox" name="checkAll" class="checkAll" /></td>
				<td class="fileName checkHidden ">
					<span>{*[cn.myapps.km.disk.file_name]*}</span>
				</td>
				<td align="center" class="fileCreator checkHidden ">
					<span>{*[cn.myapps.km.disk.uploader]*}</span>
				</td>
				<td align="center" class="size checkHidden">
					<span>{*[cn.myapps.km.disk.size]*}</span>
				</td>
				<td align="center" class="dateTime checkHidden" >
					<span>{*[cn.myapps.km.disk.time]*}</span>
				</td>
				<td class="checkShow" style="display:none;" colspan="4">
					<div class="shareDiv">
						<div>{*[cn.myapps.km.disk.checked]*}<span id="checkedNum"></span>{*[cn.myapps.km.disk.file_folder]*}</div>
						<div>
							<p class="button_left"></p>
							<p align="center" class="button_center ie6Css" style="width:80px"><a class="save2mydisk" onclick="save2mydiskMulti()">{*[cn.myapps.km.disk.save_to_private_disk]*}</a></p>
							<p class="button_right"></p>
						</div>
					</div>
				</td>
				</tr>
			</table>
			<table class="table2" id="tableData" cellspacing="0">
			<s:iterator value="datas.datas" id="status">
				<tr class="tr">
					<td align="center" class="checkbox tdChecked"><input type="checkbox" name="_fileSelects" _fileType="2" value="<s:property value="id"/>"/></td>
					<td class="newFileName">
						<div style="position:relative;">
							<span title="" class="icon-file-s" style="float:left;"></span>
							<div>
								<a class="fileView fileViewAction" target="main" id="<s:property  value='id' />" ><s:property value="name" /></a>
							</div>
							<div class="more_btn" style="position:absolute;top:0px;right:0px;">
								<div class="more_save2mydisk goSave2mydisk"></div>
								<div class="clear"></div>
							</div>
						</div>
					</td>
					<td class="fileCreator" align="center"><s:property value="#status.getCreator()"/></td>
					<td class="size" align="center"><s:property value="#status.getFileSize()"/></td>
					<td class="dateTime" align="center"><s:date name="#status.createDate" format="yyyy-MM-dd HH:mm:ss"/></td>
				</tr>
			</s:iterator>
			
			</table>
			<div class="pageNav">
				<div class="pageNumber">
					<a href="javascript:showFirstPageForHomePage();" class="first"><img src="<s:url value='/km/disk/images/first.gif'/>"/></a>
					<a href="javascript:showPreviousPageForHomePage();" class="pre"><img src="<s:url value='/km/disk/images/pre.gif'/>"/></a>
					<span>(<s:property value="%{#request.datas.pageNo}"/>/<s:property value="%{#request.datas.getPageCount()}"/>)</span>
					<a href="javascript:showNextPageForHomePage();" class="next"><img src="<s:url value='/km/disk/images/next.gif'/>"/></a>
					<a href="javascript:showLastPageForHomePage();" class="last"><img src="<s:url value='/km/disk/images/last.gif'/>"/></a>
				</div>
				<div class="showNum"></div>
			</div>
		</div>
		<div class="clear"></div>
	</div>
</s:form>
</body>
</o:MultiLanguage></html>