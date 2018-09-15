<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
</script>
<body>
<fieldset >
<legend>{*[cn.myapps.core.sysconfig.version_manag.version_manage]*}</legend>
<table>
	<tr>
		<td>{*[cn.myapps.core.sysconfig.km.invocation]*}：</td>
		<td><s:checkbox id="checkoutConfig" name="checkoutConfig.invocation" theme="simple"></s:checkbox></td>
	</tr>
</table>
</fieldset>
</body>
</html>