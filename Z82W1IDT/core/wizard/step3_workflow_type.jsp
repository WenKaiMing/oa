<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<html><o:MultiLanguage>
<head>
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
   function typeChange(type) { //workflow type
    var obj;
     for (var i=1;i<4;i++){
		obj=document.getElementById("workflow0"+i);
		obj.style.display="none";
	  }
	  switch (type) {
		case '01':
		  document.getElementById("workflow01").style.display="";
		  
			break;
		case '02':
			document.getElementById("workflow02").style.display="";
			break;
		case '03':
			document.getElementById("workflow03").style.display="";
			break;
		default:
			document.getElementById("workflow01").style.display="";
			break;
		}
	
}
function ev_init(){
  typeChange('<s:property value="content.w_flowType"/>');
}
</script>

<body onload="ev_init()">
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
		<td rowspan="2" style="width:200px;"><s:include value="wizard_common.jsp"><s:param name="step" value="32"/></s:include></td>
	</tr>
	<tr style="height:400px; vertical-align: top;">
		<td style="text-align: center;">
			<div style="width:90%; text-align: center;">
				{*[Workflow]*}{*[Type]*}: <s:select name="content.w_flowType" list="#{'01':'{*[Normal]*}','02':'{*[page.wizard.step3.branch_integrate]*}','03':'{*[Branch]*}'}"	onchange="typeChange(this.value)" theme="simple"></s:select>
			</div>
			<table style="width:90%; text-align: center;" id="workflow01">
				<tr><td style="text-align:center"><img src="<s:url value="/resource/image/workflow01.gif"/>"></td></tr>
				<tr><td>*{*[page.wizard.step3.type.description1]*}</td></tr>
			</table>
			<table style="width:90%; text-align: center;" id="workflow02">
				<tr><td style="text-align:center"><img src="<s:url value="/resource/image/workflow02.gif"/>"></td></tr>
				<tr><td>*{*[page.wizard.step3.type.description2]*}</td></tr>
			</table>
			<table style="width:90%; text-align: center;" id="workflow03">
				<tr><td style="text-align:center"><img src="<s:url value="/resource/image/workflow03.gif"/>"></td></tr>
				<tr><td>*{*[page.wizard.step3.type.description3]*}</td></tr>
			</table>
			<div style="width:90%; text-align: center;padding-top: 10px;">
				<button type="button" onClick="forms[0].action='<s:url action="tonewflow"></s:url>';forms[0].submit();">{*[Back]*}</button>&nbsp;
   				<button type="button" onClick="forms[0].action='<s:url action="toworkflowRole"></s:url>';forms[0].submit();">{*[Next]*}</button>
			</div>
		</td>
	</tr>
</table>
</s:form>

</body>
</o:MultiLanguage></html>
