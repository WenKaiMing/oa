<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ include file="/portal/share/common/head.jsp"%>
<%
String contextPath = request.getContextPath();
String filePath = request.getParameter("filePath");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>在线拍照</title>
<script src='<s:url value="/portal/share/script/AC_OETags.js"/>'></script>
<script type="text/javascript">
jQuery(document).ready(function(){
	var width = document.body.scrollWidth;
	var height = document.body.scrollHeight;
	if(width < 455) width = 455;
	if(height < 318) height = 318;
	OBPM.dialog.resize(width, height);
});

function setValueToField(rtn){
	OBPM.dialog.doReturn(rtn);
}
function ev_doEmpty() {
	OBPM.dialog.doClear();
}
</script>
</head>
<body style="margin:0px">
<script language="JavaScript" type="text/javascript">
<!--
//Globals
//Major version of Flash required
var requiredMajorVersion = 9;
//Minor version of Flash required
var requiredMinorVersion = 0;
//Minor version of Flash required
var requiredRevision = 124;
// Version check for the Flash Player that has the ability to start Player Product Install (6.0r65)
// Version check based upon the values defined in globals
var hasRequestedVersion = DetectFlashVer(requiredMajorVersion, requiredMinorVersion, requiredRevision);

if (!hasRequestedVersion) {
	var alternateContent = '{*[Flash_Player_Install]*} '
	   	+ '<a href=http://www.adobe.com/go/getflash/>Get Flash</a>';
	    document.write(alternateContent);  // insert non-flash content
	  }
// -->
</script>
<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
	id="onLineTakePhoto" width="100%" height="100%"
	codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
	<param name="movie" value="onLineTakePhoto.swf" />
	<param name="quality" value="high" />
	<param name="bgcolor" value="#a6c9e2" />
	<param name="FlashVars" value="contextPath=<%=contextPath %>&filePath=<%=filePath %>"/>
	<param name="allowScriptAccess" value="sameDomain" />
	<embed src="onLineTakePhoto.swf" quality="high" bgcolor="#a6c9e2"
		width="100%" height="100%" name="onLineTakePhoto" align="middle" 
		play="true"
		loop="false"
		quality="high"
		allowScriptAccess="sameDomain"
		FlashVars="contextPath=<%=contextPath %>&filePath=<%=filePath %>"
		type="application/x-shockwave-flash"
		pluginspage="http://www.adobe.com/go/getflashplayer">
	</embed>
	</object>
</body>
</o:MultiLanguage>
</html>