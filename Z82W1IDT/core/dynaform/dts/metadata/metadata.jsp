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
function doSynForm(){
	var form = document.forms[0];
	form.action = '<s:url value="/core/dynaform/dts/datasource/synFormTable.action"/>' + 
	'?datasourceId=<s:property value="tableMetadata.datasource.id"/>' + 
	'&formId=<s:property value="tableMetadata.form.id"/>';
	form.submit();
}
function adjustViewLayout(){
	var documentH=parent.document.body.offsetHeight;
	jQuery("body").height(documentH);
	if(navigator.userAgent.indexOf("MSIE")>0)
	{ 
		jQuery("#main").height(documentH-212);
	}
if(isFirefox=navigator.userAgent.indexOf("Firefox")>0)
	{
	jQuery("#main").height(documentH-218);
   	}
if(isChrome=navigator.userAgent.indexOf("Chrome")>0)
  {
	jQuery("#main").height(documentH-218);
  } 
}
jQuery(window).load(function(){
	adjustViewLayout();	
});
parent.jQuery(window).resize(function(){
	adjustViewLayout();
});
</script>
</head>
<body style="margin-top: 5px;margin-bottom: 5px;">
<%@include file="/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<form action="" method="post" style="margin: 0px;"></form>
<table width="100%" class="table_noborder">
	<tr height="20">
		<td width="100">{*[Metadate]*}：</td>
		<td><s:property value="tableMetadata._table" /></td>
	</tr>
	<tr height="20">
		<td>{*[Type]*}：</td>
		<td>{*[User.defined.form.data]*}</td>
	</tr>
	<tr height="20">
		<td>{*[cn.myapps.core.dynaform.dts.metadata.correponding_form]*}：</td>
		<td><s:property value="tableMetadata.form.name" /></td>
	</tr>
	<tr height="20">
		<td>{*[Description]*}：</td>
		<td><s:property value="tableMetadata.form.discription" /></td>
	</tr>
	<tr>
		<td colspan="2">{*[cn.myapps.core.dynaform.dts.metadata_field_details]*}：</td>
		<td align="right"><button type="button" id="syn" onclick="doSynForm();">{*[Sys.form.data.structure]*}</button></td>
	</tr>
</table>
<div id="main" style="overflow: auto">
<table width="100%" class="table_noborder">
	<tr height="20">
		<th class="column-head">{*[cn.myapps.core.dynaform.form.field_name]*}</th>
		<th class="column-head">{*[cn.myapps.core.dynaform.form.corresponding_formField]*}</th>
		<th class="column-head">{*[cn.myapps.core.dynaform.form.formField_type]*}</th>
		<th class="column-head">{*[Type]*}</th>
		<th class="column-head">{*[Description]*}</th>
	</tr>
	<s:iterator value="tableMetadata._columnMetadatas.datas" status="index">
		<s:if test="#index.even==true">
			<tr height="20" class="table-tr-even">
				<td><s:property value="column" /></td>
				<td><s:property value="field" /></td>
				<td><s:property value="fieldType" /></td>
				<td><s:property value="type" /></td>
				<td><s:property value="des" /></td>
			</tr>
		</s:if>
		<s:else>
			<tr height="20" class="table-tr-odd">
				<td><s:property value="column" /></td>
				<td><s:property value="field" /></td>
				<td><s:property value="fieldType" /></td>
				<td><s:property value="type" /></td>
				<td><s:property value="des" /></td>
			</tr>
		</s:else>
	</s:iterator>
</table>
</div>
</body>
</o:MultiLanguage>
</html>