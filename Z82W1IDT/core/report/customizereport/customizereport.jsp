<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,cn.myapps.util.property.DefaultProperty,java.net.*" %>
<%@include file="/common/tags.jsp"%>
<%
String applicationid = request.getParameter("application");
String moduleid = request.getParameter("module");

//上下文路径
String contextPath = request.getContextPath();
String adminId = ((WebUser)request.getSession().getAttribute("USER")).getId();

String hostAddres=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+contextPath;
%>

<%@page import="java.util.Properties"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="java.util.Collection"%><html>
<o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>oReport</title>
<script type="text/javascript">
function thisMovie(movieName) {
    if (navigator.appName.indexOf("Microsoft") != -1) {
        return window[movieName];
    } else {
        return document[movieName];
    }
}

// send to flex
function getScreenSize()
{
     var size = [];
     size = getSize();
     thisMovie("oReport").setScreenSize(size[0],size[1]);
}
//get size
function getSize() {
  var myWidth = 0, myHeight = 0;
  if( typeof( window.innerWidth ) == 'number' ) {
    myWidth = window.innerWidth;
    myHeight = window.innerHeight;
  } else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
    myWidth = document.documentElement.clientWidth;
    myHeight = document.documentElement.clientHeight;
  } else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {
    myWidth = document.body.clientWidth;
    myHeight = document.body.clientHeight;
  }
  var size = []; 
 
  size[0] = myWidth;
  size[1] = myHeight;
  return size;
}

window.onload = function(){
	window.top.toThisHelpPage("application_module_customizeReport");
}
</script>
</head>
<body style="margin:0px">
<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
			id="oReport" width="100%" height="100%"
			codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
			<param name="movie" value="../../common/flash/oReport1.swf" />
			<param name="quality" value="high" />
			<param name="wmode" value="opaque">
			<param name="bgcolor" value="#869ca7" />
			<param name="allowScriptAccess" value="sameDomain" />
			<param name="FlashVars" value="applicationid=<%=applicationid %>&hostAddress=<%=hostAddres %>&contextPath=<%=contextPath %>&moduleid=<%=moduleid %>&adminId=<%=adminId %>"/>
			<embed src="../../common/flash/oReport1.swf" quality="high" bgcolor="#869ca7"
				width="100%" height="100%" name="oReport" align="middle" wmode="opaque"
				play="true" 
				loop="false"
				quality="high"
				allowScriptAccess="sameDomain"
				FlashVars="applicationid=<%=applicationid %>&hostAddress=<%=hostAddres %>&contextPath=<%=contextPath %>&moduleid=<%=moduleid %>&adminId=<%=adminId %>"
				type="application/x-shockwave-flash"
				pluginspage="http://www.adobe.com/go/getflashplayer">
			</embed>
	</object>
</body>
</o:MultiLanguage>
</html>