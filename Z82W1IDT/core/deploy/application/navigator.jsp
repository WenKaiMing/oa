<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%
    request.setCharacterEncoding("UTF-8");
    String contextPath = request.getContextPath();
    String hostAddres = request.getScheme()+"://"+ request.getServerName() + ":"+ request.getServerPort() + contextPath;
   %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>navigator</title>
<script src='<s:url value="/script/AC_OETags.js"/>'></script>
<script type="text/javascript">
var application = '<%=request.getParameter("application")%>';
var contextPath = '<%=contextPath%>';
function init(){
	inittab();
}

function hrefModule(moduleid,type){
	var moduleURL = '<s:url value="/core/deploy/module/displayFormAndView.jsp"/>?application=' + application + "&moduleid=" + moduleid+"&type="+type;
	window.location.href=moduleURL;
}

</script>
</head>
<body style="margin:0px" onload="init()">
<s:textfield name="tab" cssStyle="display:none;" value="5" />
<s:textfield name="selected" cssStyle="display:none;" value="" />
<table cellpadding="0" cellspacing="0" width="100%">
	<tr class="nav-td" style="height:27px;">
		<td rowspan="2"><div style="width:345px"><%@include file="/common/commontab.jsp"%></div></td>
		<td class="nav-td" width="100%">&nbsp;</td>
	</tr>
	<tr class="nav-s-td" >
		<td class="nav-s-td" align="right">
		</td>
	</tr>
 </table>
 			<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
					id="ApplicationNavigation" width="100%" height="100%"
					codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
					<param name="movie" value="ApplicationNavigation.swf" />
					<param name="quality" value="high" />
					<param name="bgcolor" value="#fcfbfb" />
					<param name="FlashVars" value="hostAddres=<%=hostAddres %>&applicationid=<%=request.getParameter("application") %>"/>
					<param name="allowScriptAccess" value="sameDomain" />
					<embed src="ApplicationNavigation.swf" quality="high" bgcolor="#fcfbfb"
						width="100%" height="100%" name="ApplicationNavigation" align="middle"
						play="true"
						loop="false"
						quality="high"
						FlashVars="hostAddres=<%=hostAddres %>&applicationid=<%=request.getParameter("application") %>"
						allowScriptAccess="sameDomain"
						type="application/x-shockwave-flash"
						pluginspage="http://www.adobe.com/go/getflashplayer">
					</embed>
			</object>
</body>
</o:MultiLanguage>
</html>