<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
<html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title></title>
<script language="javascript">
var isInFrame = true;
var parentWindow;

function init() {
	window.onbeforeunload = beforclose;
}
function beforclose() {
	if(window.returnValue!=null && window.returnValue == true && window.opener!=null ) {
		window.opener.document.forms[0].submit();
	}
}
function ev_onclose(){
	if (this.returnValue==true && this.opener!=null) {
		opener.location.reload();
	}
}
function closeTips(){
	document.getElementById("tips").style.display="none";
}
</script>
</head>
<body  onload="" bgcolor="#FFFFFF" text="#000000" style="margin:0; overflow: hidden">
<div id="tips">
  <table width=100% height=100% align=center cellpadding=0 cellspacing=0 border=0 >
    <tr>
      <td align=center valign=middle>
	  	<img src='<s:url value="/resource/imgnew/loading.gif" />'>
      </td>
    </tr>
  </table>
	
</div>
<iframe align="center"  width="100%" height="100%" name="myitem" frameborder=0 border=0 onload="document.getElementById('tips').style.display='none'"></iframe>
</body>
<script language="javascript">
var arg = OBPM.dialog.getArgs();
if (arg != null) {
	if(arg.url == null){
		myitem.location = arg;
	}
	else{
		myitem.location = arg.url;
	}
	if (arg.title != null){
		document.title = arg.title;
	}
	else if (window.location.search!=null) {
		var pos = location.search.lastIndexOf("title=") + 6;
		var title = location.search.substring(pos, location.search.length);
		document.title = title;
	}
}
else{
	if(window.location.search!=null && window.location.search!="") {
		var pos = location.search.lastIndexOf("&title=") + 7;
		var title = location.search.substring(pos, location.search.length);
		document.title = title;
		myitem.location = location.search.substring(1, location.search.length);
	}
}
</script>
</o:MultiLanguage></html>
