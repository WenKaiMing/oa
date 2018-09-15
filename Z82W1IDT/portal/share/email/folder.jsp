<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%><%@ taglib uri="myapps" prefix="o"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[core.email.folder.manager]*}</title>
<%@include file="jquery-tabs.jsp" %>
<style type="text/css">
table thead tr td{
	background: #EEF0F2; 
	border: 1px solid #EEF0F2;
	line-height: 24px;
}

table tbody tr td{
	line-height: 24px;
	overflow: hidden;
}
.footer td span {
	margin-right: 6px;
}
.footer td {
	border-top: 2px solid #EEF0F2;
}
.unable {
	COLOR: #999
}
</style>
<script type="text/javascript">
jQuery(document).ready(function(){
	chageFolderHtml();
	jQuery("#addFolder").click(function(){
		addAndEditFolder("", "{*[core.email.folder.new]*}");
	});
	jQuery(".footer td a").each(function() {
		jQuery(this).click(function(){
			var currpage = document.getElementsByName("_currpage")[0];
			var className = this.className;
			var page = 1;
			if (className == "first") {
				page = 1;
			} else if (className == "prev") {
				page = <s:property value="datas.pageNo" /> - 1;
			} else if (className == "next") {
				page = <s:property value="datas.pageNo" /> + 1;
			} else if (className == "end") {
				page = <s:property value="datas.pageCount" /> + 0;
			}
			currpage.value = page;
			window.parent.showLoading();
			document.forms[0].submit();
		});
	});
	window.parent.hideLoading();
});

function doEdit(key) {
	addAndEditFolder(key, "{*[core.email.folder.edit]*}");
}

function doDelete(key) {
	var bool = confirm("{*[core.email.folder.delete.confrm]*}");
	if (bool) {
		document.forms[0].action="<s:url value='/portal/email/folder/delete.action' />?id=" + key;
		window.parent.showLoading();
		document.forms[0].submit();
	}
}

function doClear(id) {
	//var bool = confirm("你确定要清空该文件夹！");
	//if (bool) {
	//	document.forms[0].action="<s:url value='/portal/email/folder/delete.action' />?id=" + key;
	//	document.forms[0].submit();
	//}
	alert("功能正在完善！");
}

function addAndEditFolder(key, title) {
	OBPM.dialog.show({
		opener : window,
		width : 520,
		height : 300,
		url : '<s:url value='/portal/email/folder/view.action' />?id=' + key,
		args : {},
		title : title,
		close : function(result) {
			document.location.href = "<s:url value='/portal/email/folder/list.action'/>";
			chageFolderHtml();
		}
	});
}

function chageFolderHtml() {
	jQuery.ajax({
		type: "POST",
		cache: false,
		url: "<s:url value='/portal/email/folder/folderHtml.action' />",
		success:function(result) {
			if (result != "") {
				parent.document.getElementById("ulDefFolder").innerHTML = result;
				window.parent.setFolderClickEvent();
			}
		},
		error: function(result) {
			alert("{*[core.email.failure]*}");
		}
	});
}
function list(folderid) {
	window.parent.showLoading();
	window.location.href = "<s:url value='/portal/email/list.action'/>?folderid=" + folderid + "&type=0";
}
</script>
<jsp:include page="msg.jsp" />
</head>
<body><s:bean name="cn.myapps.core.email.email.action.EmailHelper" id="helper" />
<form action="<s:url value='/portal/email/folder/list.action' />" method="post"><%@include file="/common/basic.jsp" %></form>
<div style="height: 30px; border-bottom: 0px solid #cccccc;">
	<div style="float: left;">{*[core.email.folder.manager]*}</div>
	<div style="height: 30px; float: right; padding-right: 10px;">
		<img src="<s:url value="/portal/share/email/images/setting.png" />" border="0"></img>
		<a href="javascript:void(0);" id="addFolder">{*[core.email.folder.new]*}</a>
	</div>
</div>
<table width="100%" cellspacing="0">
	<thead>
		<tr>
			<td width="40%">{*[core.email.folder.system]*}</td>
			<td width="20%">{*[core.email.unread]*}</td>
			<td width="20%">{*[core.email.tatol]*}</td>
			<td width="20%"><!-- {*[Actions]*} -->&nbsp;</td>
		</tr>
	</thead>
	<tbody><s:iterator value="#request.systemFolder" status="index" id="bean">
		<tr>
			<td><a href="javascript:list('<s:property value="id" />');"><s:property value="displayName" /></a></td>
			<td><s:property value="#helper.getUnreadMessageCount(id, #session.FRONT_USER)"/></td>
			<td><s:property value="#helper.getEmailCount(#bean, #session.FRONT_USER)" /></td>
			<td><!-- [&nbsp;<a href="javascript:doClear('<s:property value="id" />');">{*[ClearFile]*}</a>&nbsp;] -->&nbsp;</td>
		</tr></s:iterator>
	</tbody>
</table>
<div style="height: 30px;">&nbsp;</div>
<table width="100%" cellspacing="0">
	<thead>
		<tr>
			<td width="40%">{*[core.email.folder.other]*}</td>
			<td width="20%">{*[core.email.unread]*}</td>
			<td width="20%">{*[core.email.tatol]*}</td>
			<td width="20%">{*[cn.myapps.core.email.customize.attr.actions]*}</td>
		</tr>
	</thead>
	<tbody><s:iterator value="datas.datas" status="index" id="bean">
		<tr>
			<td><a href="javascript:list('<s:property value="id" />');"><s:property value="displayName" /></a></td>
			<td><s:property value="#helper.getUnreadMessageCount(id, #session.FRONT_USER)"/></td>
			<td><s:property value="#helper.getEmailCount(#bean, #session.FRONT_USER)" /></td>
			<td>[&nbsp;<a href="javascript:doEdit('<s:property value="id" />');">{*[Edit]*}</a>&nbsp;]&nbsp;&nbsp;
				[&nbsp;<a href="javascript:doDelete('<s:property value="id" />');">{*[Delete]*}</a>&nbsp;]
			</td>
		</tr></s:iterator>
		<tr class="footer">
			<!-- <td colspan="2" align="right">&nbsp;</td> -->
			<td colspan="4" align="right">
				<span class="Txt"><s:property value="datas.pageNo" />&nbsp;/&nbsp;<s:property value="datas.pageCount" />{*[page]*}&nbsp;&nbsp;
					<s:if test="datas.pageNo == 1"><span class="unable">{*[FirstPage]*}</span></s:if>
					<s:else><span id="first"><a href="javascript:void(0);" class="first">{*[FirstPage]*}</a></span></s:else>
					<s:if test="datas.pageNo < 2"><span class="unable">{*[PrevPage]*}</span></s:if>
					<s:else><span id="prev"><a href="javascript:void(0);" class="prev">{*[PrevPage]*}</a></span></s:else>
					<s:if test="datas.pageNo == datas.pageCount"><span class="unable">{*[NextPage]*}</span></s:if>
					<s:else><span id="next"><a href="javascript:void(0);" class="next">{*[NextPage]*}</a></span></s:else>
					<s:if test="datas.pageNo == datas.pageCount"><span class="unable">{*[EndPage]*}</span></s:if>
					<s:else><span id="end"><a href="javascript:void(0);" class="end">{*[EndPage]*}</a></span></s:else>
				</span>
			</td>
		</tr>
	</tbody>
</table>
</body>
</o:MultiLanguage></html>