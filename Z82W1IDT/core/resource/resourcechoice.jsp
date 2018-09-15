<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" autoFlush="true"%>
<%@include file="/common/tags.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
	response.setHeader("Pragma","No-cache");    
	response.setHeader("Cache-Control","no-cache");    
	response.setDateHeader("Expires", -10);   
%>
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ResourceChoice</title>
<script src="<s:url value='/script/list.js'/>"></script>
</head>
<body>
	<s:bean name="cn.myapps.core.resource.action.ResourceHelper" id="rh" >
		<s:param name="applicationid" value="#parameters.application" />
	</s:bean>
	<table>
	<s:iterator value="#rh.deepSearchResouece(#parameters.resourceid)" status="index">
			<s:if test="(#index.count == 1)">
				<tr>
			</s:if>
			
			<td class='commFont'>
				<input type="checkbox" name="_resourcelist" value='<s:property value="id"/>' />
				<s:property value="description" />
			</td>
			
			<s:if test="(#index.count % 4 == 0)">
				</tr>
				<tr>
			</s:if>
	</s:iterator>
	</table>
</body>
</o:MultiLanguage></html>