<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@ include file="/portal/share/common/head.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>close</title>
<script>
	function doAlert(msg){
		alert(msg);
		window.history.back();
	}
	
	jQuery(document).ready(function(){
		var funName = '<s:property value="%{#request.message.typeName}" />';
		var msg = document.getElementsByName("message")[0].value;
		if (msg) {
			eval("do" + funName + "(msg);");
		}
	});
	if(parent){parent.close();}else {window.close();}
</script>
</head>
<body>
<s:form method='post' name='temp' action=''>
<s:hidden name="message" value="%{#request.message.content}" />
</s:form>
</body>
</o:MultiLanguage></html>