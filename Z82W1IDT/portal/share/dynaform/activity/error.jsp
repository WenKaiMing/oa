<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<%@ include file="/portal/share/common/head.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function doAlert(msg){
		alert(msg);
		window.history.back();
		//不带任何提示关闭窗口
		//window.opener=null;
		//window.open('','_self');
		//window.close();
	}

	jQuery(document).ready(function(){
		var funName = '<s:property value="%{#request.message.typeName}" />';
		var msg = document.getElementsByName("message")[0].value;
		if (msg) {
			eval("do" + funName + "(msg);");
		}
	});
</script>
</head>
<body>
<s:form method='post' name='temp' action=''>
<s:hidden name="message" value="%{#request.message.content}" />
<table style="width:100%; height:100%;">
	<tr>
		<td>
			<!-- 
			<textarea style="width:90%; height:90%;">
				<%
 				//out.println(exception.getLocalizedMessage());
 				%>
			</textarea>
			 -->
		</td>
	</tr>
</table>
</s:form>
</body>
</html>