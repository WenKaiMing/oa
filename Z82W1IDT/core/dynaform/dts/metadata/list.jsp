<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">

<html>
<o:MultiLanguage>
<head>

<title>{*[metadata]*}</title>

<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<script type="text/javascript">
function doIndexOptimization(){
	var form = document.forms[0];
	form.action = '<s:url value="/core/dynaform/dts/metadata/optimization.action"/>' + 
	'?datasourceId=<s:property value="datasourceId"/>';
	form.submit();
}
</script>
</head>
<body style="margin-top: 5px;margin-bottom: 5px;">
<%@include file="/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<form action="" method="post" style="margin: 0px;"></form>
<table width="100%" class="table_noborder">
	<tr>
		<td colspan="2">优化索引可以提高系统性能！</td>
		<td >&nbsp</td>
	</tr>
	<tr>
		<td align="left"><button type="button" onclick="doIndexOptimization();this.disabled=!(this.disabled);">{*[core.dts.metadata.optimization]*}</button></td>
		<td align="right">&nbsp</td>
	</tr>
</table>
<div id="main" style="overflow: auto">
<table width="98%" class="table_noborder">
	<tr height="20">
		<th class="column-head">{*[core.dts.metadata.tableName]*}</th>
		<th class="column-head" width="60px">{*[core.dts.metadata.indexTotal]*}</th>
		<th class="column-head">{*[core.dts.metadata.indexCulumnName]*}</th>
		<th class="column-head" width="60px">{*[core.dts.metadata.suggest]*}</th>
	</tr>
	<s:iterator value="tables" status="index">
		<s:if test="#index.even==true">
			<tr height="20" class="table-tr-even">
				<td><s:property value="name" /></td>
				<td><s:property value="getIndexTotal()" /></td>
				<td><s:property value="getIndexColumnNames()" /></td>
				<td><s:property escape="false" value="getSuggestMsg()" /></td>
			</tr>
		</s:if>
		<s:else>
			<tr height="20" class="table-tr-odd">
				<td><s:property value="name" /></td>
				<td><s:property value="getIndexTotal()" /></td>
				<td><s:property value="getIndexColumnNames()" /></td>
				<td><s:property escape="false" value="getSuggestMsg()" /></td>
			</tr>
		</s:else>
	</s:iterator>
</table>
</div>
</body>
</o:MultiLanguage>
</html>