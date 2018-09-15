<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/tags.jsp"%>
<html><o:MultiLanguage>
<head>
<title>Script Editor</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
var sFieldName = '<s:property value="#parameters.fieldName" />';

var oField;

function ev_updatefield() {
	if (oField) {
		oField.value = document.JsEditorApplet.getScriptText();
	}
}

function ev_onload() {
	var sScriptText;

	oField = parent.document.getElementsByName(sFieldName)[0];
		
	if (oField) {
		sScriptText = oField.value;
	}
	   
	if (sScriptText) {
		document.JsEditorApplet.loadScriptText(sScriptText);

	}
	
}

</script>
</HEAD>
<BODY onload='ev_onload()' leftmargin=0 rightmargin=0 topmargin=0 bottommargin=0>
<form name="formItem" method="post" >
<table border=0 cellpadding=0 cellspacing=0 width="100%">
	<tr align=center>
		<td bgcolor="#FFFFFF" width="100%">
		<script>
		document.writeln('<applet');
		document.writeln(' codebase = "."');
		document.writeln(' code="cn.myapps.core.macro.editor.JavaScriptEditorApplet.class"');
		document.writeln(' archive = "Editor.jar,MinML.jar"');
		document.writeln(' name="JsEditorApplet"');
		document.writeln(' width="100%"');
		document.writeln(' height="310"');
		document.writeln(' hspace="0"');
		document.writeln(' vspace="0"');
		document.writeln(' align="top">');
		document.writeln('</applet>');
		</script>
		</td>
	</tr>
</table>
</form>
</body>
</o:MultiLanguage></html>
