<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ taglib uri="/struts-tags" prefix="s"%><%@ taglib uri="myapps" prefix="o"%>
<script type="text/javascript">
window.onload = function() {
	if ('<s:property value="hasFieldErrors()" />' == 'true') {
		showError(getErrorString());
	} else if ('<s:property value="hasActionMessages()" />' == 'true') {
		showMsg(getMsgString());
	}
};

function getErrorString() {
	var error = '';
	<s:iterator value="fieldErrors">error += '<s:property value="value[0]" />' + " ";</s:iterator>
	return error;
}
function getMsgString() {
	var msg = '';
	<s:iterator value="actionMessages">msg += '<s:property value="value[0]" />' + " ";;</s:iterator>
	return msg;
}

function showError(error) {
	//var div = parent.frames["topFrame"].document.getElementById("dvErrorMsg");
	//div.style.display = "";
	//var text = parent.frames["topFrame"].document.getElementById("spnErrorText");
	//text.innerHTML = error;
}

function showMsg(msg) {
	//var div = parent.frames["topFrame"].document.getElementById("dvSuccessMsg");
	//div.style.display = "";
	//var text = parent.frames["topFrame"].document.getElementById("spnSuccessText");
	//text.innerHTML = msg;
}
</script>