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
<script>
function on_submit(){
	var v_type = document.all("content.v_type");
    var i = 0;
    while(i<v_type.length){
		if(v_type[i].value=="all" ){
			v_type[i].disabled = "";
		}
		i++;
    }
}
</script>
</head>

<body>
<s:form action="save" method="post" >
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
		<td rowspan="2" style="width:200px;"><s:include value="wizard_common.jsp"><s:param name="step" value="52"/></s:include></td>
		
	</tr>
	<tr style="height:400px; vertical-align: top;">
		<td style="text-align: center;">
			<table class="marAuto">
		   <tr><td class="commFont"><input type="checkbox" disabled="disabled"  checked="checked" name="content.v_type" value="all">{*[page.wizard.step5.type.all]*}</td></tr>
	       <tr><td class="commFont"><input type="checkbox" name="content.v_type" value="pending">{*[page.wizard.step5.type.pending]*}</td></tr>
	       <tr><td valign="top" colspan="2"  align="center"><button type="button" onClick="forms[0].action='<s:url action="backtostep5"></s:url>';forms[0].submit();">{*[Back]*}</button>&nbsp;<button type="button" onClick="forms[0].action='<s:url action="toviewcolumn"></s:url>';on_submit();forms[0].submit();">{*[Next]*}</button></td></tr>
		</table><br/>
		<table style="margin:auto;">
			<tr>
				<td>
					*{*[page.wizard.step5.type.description1]*}
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</s:form>
</body>
</o:MultiLanguage></html>
