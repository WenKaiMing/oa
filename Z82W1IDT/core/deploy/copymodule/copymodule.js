var cancelAction = contextPath + "/core/deploy/copymodule/cancel.action"; 
function doCancel(){
 	parent.frames['nav'].location.reload();
	document.forms[0].action= cancelAction;
	document.forms[0].submit();
}