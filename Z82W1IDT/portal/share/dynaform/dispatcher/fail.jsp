<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<script type="text/javascript">
	function doAlert(msg){
		alert(msg);
		window.history.back();
		//不带任何提示关闭窗口
		window.opener=null;
		window.open('','_self');
		window.close();
	}

	jQuery(document).ready(function(){
		var funName = '<s:property value="%{#request.message.typeName}" />';
		var msg = document.getElementsByName("message")[0].value;
		if (msg) {
			eval("do" + funName + "(msg);");
		}
	});
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Dispatcher Result</title>
</head>
<body>
<s:form method='post' name='temp' action=''>
<s:hidden name="message" value="%{#request.message.content}" />
<table width="100%">
	<tr>
		<td align="center">
			<!-- 
			<div style="text-align:center">
			<font style="font-size: 24px;color: red;">{*[page.disptcher.fail]*}!
			</font></div>
			 -->
		</td>
	</tr>
</table>
</s:form>
</body>
</o:MultiLanguage>
</html>