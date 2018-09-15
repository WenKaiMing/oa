<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ page import="java.io.*,cn.myapps.util.property.DefaultProperty,java.net.*,cn.myapps.core.user.action.WebUser" %>
<%
request.setCharacterEncoding("UTF-8");
String hostAddres=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
String contextPath = request.getContextPath();
String maximumSize = "10485760";
String savePath = this.getServletConfig().getServletContext().getRealPath("")+File.separator+"networkdisk";
String userid = ((WebUser)request.getSession().getAttribute("USER")).getId();
String domainid = request.getParameter("domainid");
String separator = File.separator;
%>
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title>networkdisk</title>
<script src='<s:url value="/script/AC_OETags.js"/>'></script>
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
			id="NetworkDiskAdmin" width="100%" height="90%"
			codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
			<param name="movie" value="../common/flash/networkdiskAdmin.swf" />
			<param name="quality" value="high" />
			<param name="bgcolor" value="#869ca7" />
			<param name="FlashVars" value="hostAddress=<%=hostAddres %>&contextPath=<%=contextPath %>&maximumSize=<%=maximumSize %>&savePath=<%=savePath %>&userId=<%=userid %>&domainId=<%=domainid %>&separator=<%=separator %>&applicationid=<s:property value="#parameters.application"/>"/>
			<param name="allowScriptAccess" value="sameDomain" />
			<embed src="../common/flash/networkdiskAdmin.swf" quality="high" bgcolor="#869ca7"
				width="100%" height="90%" name="NetworkDiskAdmin" align="middle"
				play="true" 
				loop="false"
				quality="high"
				flashVars="hostAddress=<%=hostAddres %>&contextPath=<%=contextPath %>&maximumSize=<%=maximumSize %>&savePath=<%=savePath %>&userId=<%=userid %>&domainId=<%=domainid %>&separator=<%=separator %>&applicationid=<s:property value="#parameters.application"/>"
				allowScriptAccess="sameDomain"
				type="application/x-shockwave-flash"
				pluginspage="http://www.adobe.com/go/getflashplayer">
			</embed>
	</object>
</body>
</o:MultiLanguage>
</html>