<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
 <%
 String contextPath = request.getContextPath();
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<style>
body {
        margin-left: 0px;
        margin-top: 0px;
        margin-right: 0px;
        margin-bottom: 0px;
}
html,body,#FlashID{
margin:0px;
padding:0px;
width:100%;
height:100%;
overflow:hidden;
}
</style>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!-- <meta http-equiv="Pragma" content="no-cache">  -->
<script src='<s:url value="/portal/share/script/AC_OETags.js"/>'></script>
</head>
<body width="100%" height="100%">
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
var typeName = '<s:property value="%{#request.message.typeName}" />';	//showPromptMsg()

if (!hasRequestedVersion) {
	var alternateContent = '{*[Flash_Player_Install]*} '
	   	+ '<a href=http://www.adobe.com/go/getflash/>Get Flash</a>';
	    document.write(alternateContent);  // insert non-flash content
	  }
// -->

window.onload = function(){
	showPromptMsg();
}

/**
 * 显示提示信息
 * for:default/gentle/fresh/dwz/brisk/blue
 */
function showPromptMsg(){
	var funName = typeName;
	var msg = document.getElementsByName("message")[0].value;
	if (msg) {
		try{
			eval("do" + funName + "(msg);");
		} catch(ex) {
		}
	}
}

function doAlert(msg){
	alert(msg);
}
</script>
<s:textarea name="message" value="%{#request.message.content}"	cssStyle="display:none" />
<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
			id="MyappsReport" width="100%" height="100%"
			codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
			<param name="movie" value="MyappsReport.swf" />
			<param name="quality" value="high" />
			<param name="bgcolor" value="#869ca7" />
			<param name="allowScriptAccess" value="sameDomain" />
			<param name="FlashVars" value="id=<%=request.getParameter("id") %>&_docid=<%=request.getParameter("_docid")%>&_formid=<%=request.getParameter("_formid")%>&_flowid=<%=request.getParameter("_flowid")%> "/>
			<embed src="MyappsReport.swf" flashVars="id=<%=request.getParameter("id") %>&_docid=<%=request.getParameter("_docid")%>&_formid=<%=request.getParameter("_formid")%>&_flowid=<%=request.getParameter("_flowid")%> " quality="high" bgcolor="#869ca7"
				width="100%" height="100%" name="flexreportdemo" align="middle" 
				play="true"
				loop="false"
				quality="high"
				allowScriptAccess="sameDomain"
				type="application/x-shockwave-flash"
				pluginspage="http://www.adobe.com/go/getflashplayer">
			</embed>
	</object>
</body>
</o:MultiLanguage>
</html>