<%@ include file="/portal/share/common/head.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ page import="java.io.*,cn.myapps.util.property.DefaultProperty,java.net.*,cn.myapps.core.user.action.WebUser" %>
<%
request.setCharacterEncoding("UTF-8");
String hostAddres=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
String contextPath = request.getContextPath();
WebUser webUser = ((WebUser)request.getSession().getAttribute("FRONT_USER"));
String userId = webUser.getId();
String domainid = webUser.getDomainid();
String applicationid = request.getParameter("application");
String savePath = this.getServletConfig().getServletContext().getRealPath("")+ File.separator + "networkdisk";
String separator = File.separator;
%>
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title>networkdisk</title>
<script src='<s:url value="/portal/share/script/AC_OETags.js"/>'></script>
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
			id="NetworkDisk" width="100%" height="100%"
			codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
			<param name="movie" value="networkdisk.swf" />
			<param name="quality" value="high" />
			<param name="bgcolor" value="#869ca7" />
			<param name="FlashVars" value="hostAddress=<%=hostAddres %>&userId=<%=userId %>&contextPath=<%=contextPath %>&domainId=<%=domainid %>&applicationId=<%=applicationid %>&savePath=<%=savePath %>&separator=<%=separator %>"/>
			<param name="allowScriptAccess" value="sameDomain" />
		    <param name="wmode" value="opaque">
			<embed src="networkdisk.swf" quality="high" bgcolor="#869ca7"
				width="100%" height="100%" name="NetworkDisk" align="middle" wmode="opaque"
				play="true"
				loop="false"
				quality="high"
				flashVars="hostAddress=<%=hostAddres %>&userId=<%=userId %>&contextPath=<%=contextPath %>&domainId=<%=domainid %>&applicationId=<%=applicationid %>&savePath=<%=savePath %>&separator=<%=separator %>"
				allowScriptAccess="sameDomain"
				type="application/x-shockwave-flash"
				pluginspage="http://www.adobe.com/go/getflashplayer">
			</embed>
	</object>
</body>
</o:MultiLanguage>
</html>