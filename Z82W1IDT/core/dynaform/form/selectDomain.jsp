<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/tags.jsp"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>选择域</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
<script type="text/javascript" src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script type="text/javascript">
function ev_save(){
	if(document.getElementById("domainName").value==""){
		alert("{*[please.select]*}{*[Domain]*}");
	}else{
		OBPM.dialog.doReturn(document.getElementById("domainName").value);
		//parent.window.returnValue = document.getElementById("domainName").value;
		//parent.window.close();
	}
}

function ev_delete(){
	OBPM.dialog.doReturn('canel');
	//parent.window.returnValue = 'canel';
	//parent.window.close();
}
</script>
</head>
<body style="margin:0px;">
<DIV  class="ui-layout-north">
	<table border=0 cellpadding="0" cellspacing="1">
		<tr>
		    <td valign="top">
			<button type="button" class="button-image" onclick="ev_save()"><img border=0 alt="{*[synchronouslyData]*}" src="<s:url value='/resource/image/synchronouslyData.png'/>"/>{*[synchronouslyData]*}</button>
			</td>
			<td valign="top">
			<button type="button" class="button-image" onClick="ev_delete();"><img
				src="<s:url value="/resource/image/cancel.gif"/>">{*[Cancel]*}</button>
			</td>
		</tr>
	</table>
</DIV>
<DIV class="ui-layout-center">
<table width="100%">
<tr>
<td class="commFont">{*[Domain]*}:</td>
</tr>
<tr>
<td>
<s:bean id="fh" name="cn.myapps.core.dynaform.form.action.FormHelper" />
<s:select cssClass="input-cmd" id="domainName" name="content.domainName" list="#fh.getDomainByApplication(#parameters.application)"
									theme="simple"  cssStyle="width:90%"/></td>
</tr>
</table>
</DIV>
</body>
</o:MultiLanguage>
</html>