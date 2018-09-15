<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<o:MultiLanguage>
<head>
<title>{*[Import]*}</title>
<link rel="stylesheet" href='<s:url value="/resource/css/main.css"/>' type="text/css" />
<script type="text/javascript">
function ev_imp() {
	var forms = document.forms;
	forms[0].action = '<s:url value="/core/sysconfig/import.action"/>';
	forms[0].submit();
}
</script>
</head>
<body>
<table width="100%">
	<tr>
		<td width="10" class="image-label">
			<img src="<s:url value="/resource/image/email2.jpg"/>" />
		</td>
		<td width="3">&nbsp;</td>
		<td width="200" class="text-label">{*[Import]*}</td>
		<td></td>
	</tr>
	<tr>
		<td colspan="4"
			style="border-top: 1px solid dotted; border-color: black;">
		&nbsp;</td>
	</tr>
</table>
<%@include file="/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<form action="" method="post" enctype="multipart/form-data">
<table width="100%">
	<tr>
		<td align="right">{*[import.file]*}：</td>
		<td align="left"><s:file name="xmlConfig" theme="simple" cssStyle="width:280px;" /></td>
		<td align="left"><button type="button" onclick="ev_imp();">{*[Import]*}</button></td>
		<td align="left"><button type="button" onclick="OBPM.dialog.doReturn();">{*[Exit]*}</button></td>
	</tr>
</table>
</form>
<table width="100%">
	<tr>
		<td align="center">
			<button type="button" onclick="OBPM.dialog.doReturn('refresh');">{*[exit.and.refresh]*}</button>
		</td>
	</tr>
</table>
</body>
</o:MultiLanguage>
</html>