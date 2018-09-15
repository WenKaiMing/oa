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
		oField.value = document.getElementById('advanceScript').value;
	}
}

function ev_onload() {
	var sScriptText;

	oField = parent.document.getElementsByName(sFieldName)[0];
	//alert(oField.value);
	if (oField) {
		sScriptText = oField.value;
	}
	   
	if (sScriptText) {
		document.getElementById('advanceScript').value=sScriptText;

	}
	
}

</script>
</HEAD>
<BODY onload='ev_onload()' leftmargin=0 rightmargin=0 topmargin=0 bottommargin=0>
<form name="formItem" method="post" >
<table border=0 cellpadding=0 cellspacing=0 width="100%">
	<tr align=center>
		<td bgcolor="#FFFFFF" width="100%">
        <s:textarea  cssStyle="width:100%" rows="19" cssClass="input-cmd" id="advanceScript" name="advanceScript" theme="simple"/>
		</td>
	</tr>

</table>
</form>
</body>
</o:MultiLanguage></html>
