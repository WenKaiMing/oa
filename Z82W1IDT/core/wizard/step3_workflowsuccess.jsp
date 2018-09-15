<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<html><o:MultiLanguage>
<head>
<META HTTP-EQUIV="pragma" CONTENT="no-cache">   
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache,must-revalidate">
<META HTTP-EQUIV="expires" CONTENT="0">

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
-->
</style>
</head>

<script>

 function ev_next(){

    document.forms[0].action='tostep4.action';
    document.forms[0].submit();
 }

 function editworkflow(){
   var url='<s:url value="/core/workflow/billflow/defi/editWorkFlow.action"><s:param name="ISEDIT" value="\'TRUE\'"/><s:param name="s_module" value="content.moduleid"/><s:param name="id" value="content.w_workflowid"/></s:url>';
   //showframe("editworkflow",url);
   window.open(url,"editWorkFlow","");
 }
</script>

<body>
<s:form action="tostep2forminfo" method="post">
<s:hidden name="content.w_workflowid" />
<%@include file="/common/page.jsp"%>
<%@include file="/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<table width="99%">
	<tr style="height:100px;">
		<td>
			<%@include file="wizard_guide.jsp" %>
		</td>
		<td rowspan="2" style="width:200px;"><s:include value="wizard_common.jsp"><s:param name="step" value="34"/></s:include></td>
		
	</tr>
	<tr style="height:400px; vertical-align: top;">
		<td style="text-align: center;">
		<table width="100%" border="0" class="marAuto">
       		<tr>
       			<td colspan="2" class="commFont" align="center">{*[page.wizard.step3.success]*}</td>
       		</tr>
        	<tr>
        		<td class="commFont" colspan="2" align="center">{*[page.wizard.step3.success.adjust]*} {*[Click]*}<a href="javascript:editworkflow();"><u>{*[cn.myapps.core.deploy.application.here]*}</u></a></td>
        	</tr>
       		<tr>
       			<td align="center" colspan="2">
       				<button type="button" onClick="ev_next();">{*[Next]*}</button> 
       			</td>
       		</tr>
		</table>
		</td>
	</tr>
</table>
</s:form>
</body>
</o:MultiLanguage></html>
