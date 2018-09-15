<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="cn.myapps.constans.Environment"%>
<%@include file="/common/tags.jsp"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>微信端配置</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<script src="<s:url value="/script/list.js"/>"></script>
<script type="text/javascript">

var domainId = '<s:property value="content.id" />';

</script>
<script type="text/javascript">
jQuery(function(){
	cssListTable();
});
</script>
</head>
<body id="url-list" class="listbody">
<s:form id="domainForm" theme="simple">
	<input type="hidden" name="domain" value="<s:property value='content.id' />"/>
	<input type="hidden" name="content.id" value="<s:property value='content.id' />"/>
	<div id="main">
	<table class="table_noborder">
		<tr>
			<td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[自建应用 URL 配置列表]*}</div>
			</td>
		</tr>
	</table>
		<%@include file="/common/msg.jsp"%>
		<div id="contentTable">
			<table class="table_noborder">
				<tr>
					<td class="column-head" scope="col">{*[菜单名称]*}</td>
					<td class="column-head" scope="col">{*[跳转链接]*}</td>
				</tr>
				<s:iterator value="uris" status="index">
					<tr>
					<td style="width: 13%;"><s:property value="key"/></td>
					<td style="width: auto; word-break: break-all;"><s:property value="value"/></td>
					</tr>
				</s:iterator>
			</table>
		</div>
	</div>
</s:form>
</body>
</o:MultiLanguage>
</html>