<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,org.apache.commons.beanutils.DynaBean" %>
<%@ page import="org.apache.ddlutils.model.Table" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
<style type="text/css">
<!--
.cur-table { 
	width:250px 
	}
-->
</style>
<script src="<s:url value='/script/list.js'/>"></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/DWRHtmlUtil.js"/>'></script>
<script src='<s:url value="/dwr/interface/ApplicationUtil.js"/>'></script>
<script src="<s:url value='/script/util.js'/>"></script>
<title>{*[ImportList]*}</title>
</head>
<body>
<s:include value="./loading.jsp" />
<table width="98%" class="list-table">
		<tr class="list-toolbar">
			<td width="10" class="image-label"><img
				src="<s:url value="/resource/image/email2.jpg"/>" /></td>
			<td width="3"></td>
			<td width="70" class="text-label">{*[ImportList]*}</td>
			<td>
			<table id="bt_table" width="100%" border=1 cellpadding="0" cellspacing="0" class="line-position">
			<tr><td ></td>
				<td class="line-position2" width="60" valign="top" >
				<button type="button" class="back-class" onClick="forms[0].action='<s:url action="imp"></s:url>';forms[0].submit();">
				<img src="<s:url value="/resource/imgnew/act/act_2.gif"/>">{*[Import]*}</button>
				</td>
				<td class="line-position2" width="60" valign="top">
				<button type="button" class="back-class" onClick="javascript:history.go(-1)">
				<img src="<s:url value="/resource/imgnew/act/act_2.gif"/>">{*[Back]*}</button>
				</td>
			</tr></table>
			</td>
		</tr>
	</table>

<s:form name="formList" action="imp" method="post" enctype="multipart/form-data">

<s:hidden name="impFilePath" />

<table width="100%">
<s:set name="list" value="_impobj.dataList" scope="request"/>	 
<s:bean name="cn.myapps.core.deploy.module.action.ModuleHelper" id="mh"/>
	<tr><td>
	<table>
	<s:hidden name="_impobj.applicationid" value="%{#parameters.application}" />
	<tr>
		<td class="tdLabel"><label for="save_content_fieldName" class="label">Module:</label></td>
		<td><s:select  theme="simple" label="Module" name="_impobj.moduleid" list="#mh.getModuleSel(#parameters.application)" /></td>
	</tr>
	</table></td></tr>
<% 
	Map map = (Map) request.getAttribute("list");
	if (map != null) {
		Set keys = map.keySet();
		int count = 0;
		for(Iterator it = keys.iterator(); it.hasNext();) {
			String name = (String)it.next();
			String fieldName = "_impobj." + name + "Selects";
			if (count%3 == 0) {
				out.println("<tr>");
			}
				
			count++;
			out.println("<td valign='top'>");
%>			
	<DIV style='overflow-x:hidden;OVERFLOW-y:auto;WIDTH:100%;HEIGHT:200;'>
		<table class="cur-table">
		<tr class="column-head" scope="col">
	   		<td class="column-head2" width="30" ><input type="checkbox" onclick="selectAllByField(this.checked, '<%=fieldName%>')"></td>
	   		<td class="column-head" colSpan="2"><o:OrderTag field="name" css="ordertag">{*[<%=name%>]*}</o:OrderTag></td>
		</tr>
<%			
			Map values = (Map) map.get(name);
			
			
			for (Iterator itt = values.keySet().iterator(); itt.hasNext();) {
				String id = (String) itt.next();
%>
			<tr class="table-text">
		   	 <td class="table-td">
	  	 		<input type="checkbox" name='<%=fieldName%>' value='<%= id %>' /></td>
			 <td><%=values.get(id)%></td>
			</tr>
<%	
			}	
%>
		</table>
	</DIV>
<%		
			out.println("</td>");
			
			if (count%3 == 0) {
				out.println("</tr>");
			}
			
		}
	} 
%>		
</table>
</s:form>
</body>
</o:MultiLanguage></html>