<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ taglib uri="/struts-tags" prefix="s"%><%@ taglib uri="myapps" prefix="o"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[core.error.tip]*}</title>
<script type="text/javascript">
	window.onload = function() {
		window.parent.showLoading();
		var msg = '<s:property value="#request.error"/>';
		alert(msg == '' ? '505  你懂的！' : msg);
		window.history.back();
	};
</script>
</head>
<body>
</body>
</o:MultiLanguage></html>