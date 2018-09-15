<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<%
  response.setHeader("Pragma","no-cache");
  response.setHeader("Cache-Control","no-store");
  response.setDateHeader("Expires",-1);
%>
<html><o:MultiLanguage>
<head>
<META HTTP-EQUIV="pragma" CONTENT="no-cache">   
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache,must-revalidate">
<META HTTP-EQUIV="expires" CONTENT="0">

<script language="javascript">
function ev_confirm()
{
  
   document.forms[0].action ='<s:url action="confirm" />';
   document.forms[0].submit();
}


</script>

<title>{*[Module]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
<style type="text/css">
<!--
.STYLE2 {
	font-size: 16px;
	color: #000000;
}
.STYLE3 {color: #000000}
.style4 {font-size:12px;
		font-family:"Tahoma";
}
-->
</style>
</head>

<body>

<s:form action="save" method="post">
<%@include file="/common/page.jsp"%>
<%@include file="/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<s:hidden name="refresh" value="leftFrame" />
<table width="99%">
	<tr style="height:100px;">
		<td>
			<%@include file="wizard_guide.jsp" %>
		</td>
		<td rowspan="2" style="width:200px;"><s:include value="wizard_common.jsp"><s:param name="step" value="55"/></s:include></td>
		
	</tr>
	<tr style="height:400px; vertical-align: top;">
		<td style="text-align: center;">
		<table class="marAuto">
	  		 <tr><td class="commFont">{*[page.wizard.step5.success.description]*}</td>
		</tr>
        <tr><td class="style4">
		<button type="button" onClick="forms[0].action='<s:url action="toviewfilter"></s:url>';forms[0].submit();">{*[Back]*}</button>&nbsp;
		<button type="button" onClick="ev_confirm()">{*[Confirm]*}</button></td></tr>
		</table>
		</td>
	</tr>
</table>
</s:form>
</body>
</o:MultiLanguage></html>
