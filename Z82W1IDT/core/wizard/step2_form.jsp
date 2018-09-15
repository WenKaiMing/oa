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
   function typeChange(type) { //style type
     	switch (type) {
		case '00':
		    document.all("content.f_Type")[0].checked = true;
		 	break;
		case '01':
		    document.all("content.f_Type")[1].checked = true;
		 	break;
		
		default:
			document.all("content.f_Type")[0].checked = true;
		 	break;
		}
}
function ev_init(){
    typeChange('<s:property value="content.f_Type"/>');
}
 
function typeChoose(type) {
	var div00 = document.getElementById("div00");
	var div01 = document.getElementById("div01");
	switch(type.value) {
		case "00":
			div00.style.display = "";
			div01.style.display = "none";
			jQuery("#25").css("display","none");
			jQuery("#26").css("display","none");
			jQuery("#27").css("display","none");
			jQuery("#28").css("display","none");
			break;
		case "01":
			div00.style.display = "none";
			div01.style.display = "";
			jQuery("#25").css("display","block");
			jQuery("#26").css("display","block");
			jQuery("#27").css("display","block");
			jQuery("#28").css("display","block");
			break;
		default:
			div00.style.display = "";
			div01.style.display = "none";
	}
}
</script>

<body onload="ev_init()">
<s:form action="tostep2forminfo" method="post">
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
		<td rowspan="2" style="width:200px;"><s:include value="wizard_common.jsp"><s:param name="step" value="21"/></s:include></td>
	</tr>
	<tr style="height:400px; vertical-align: top;">
		<td style="text-align: center;">
			<table cellpadding="5" cellspacing="0" class="marAuto">
       		<tr>
       			<td colspan="2" class="commFont" >{*[FormType]*}</td>
       		</tr>
       		<tr>
       			<td><img src="<s:url value="/resource/image/singleform.gif"/>"></td>
       			<td><img src="<s:url value="/resource/image/mdetail.gif"/>"></td>
       		</tr>
       		<tr>
       			<td class="commFont" align="center"><input type="radio" id="type00" name="content.f_Type" value="00" onclick="typeChoose(this)">{*[Single]*}</td>
       			<td class="commFont" align="center"><input type="radio" name="content.f_Type" id="type01" value="01" onclick="typeChoose(this)">{*[Master/Detail]*}</td>
       		</tr>
        	<tr><td colspan="2">
        			<div id="div00" class="commFont">{*[page.wizard.step2.formtype.single]*}</div>
        			<div id="div01" class="commFont" style="display:none;width:500px;">{*[page.wizard.step2.formtype.master]*}</div>
        		</td>
        	</tr>
        	<tr><td valign="top" colspan="2" align="center">
        		<button type="button" onClick="forms[0].action='<s:url action="backToStep1"></s:url>';forms[0].submit();">{*[Back]*}</button>&nbsp;
       			<button type="button" onClick="forms[0].action='<s:url action="toStep2FormInfo"></s:url>';forms[0].submit();">{*[Next]*}</button> 
       		</td>
       		</tr>
			</table>
		</td>
	</tr>
</table>
</s:form>
</body>
</o:MultiLanguage></html>
