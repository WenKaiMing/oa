<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getParameter("path");
	String dirPath = path.substring(0,path.lastIndexOf("/"))+"/swf";
	String fileName = path.substring(path.lastIndexOf("/"));
	String swfFileName = fileName.substring(0,fileName.lastIndexOf("."))+".swf";
	String swfFullPath = request.getContextPath()+dirPath+swfFileName;
%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<html>
	<head>
	<title><%=java.net.URLDecoder.decode(request.getParameter("fileName"),"utf-8") %></title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	</head>
	<body style="margin: 0px;0px;0px;0px;">
		<div style="width: 100%;height: 100%;">
			<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
				id="MyappsFlex" width="100%" height="100%"
				codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
				<param name="movie" value="<s:url value='/km/disk/flexpaper.swf'/>" />
				<param name="wmode" value="transparent" />
				<param name="quality" value="high" />
				<param name="bgcolor" value="#869ca7" />
				<param name="allowFullScreen" value="true" />
				<param name="allowScriptAccess" value="sameDomain" />
				<param name="FlashVars" value="SwfFile=<%=swfFullPath %>&StartAtPage="/>
				<embed src="<s:url value='/km/disk/flexpaper.swf'/>" quality="high" bgcolor="#869ca7" flashVars="SwfFile=<%=swfFullPath %>&StartAtPage="
					width="100%" height="100%" name="DataMap" align="middle"
					play="true"
					loop="false"
					quality="high"
					wmode="transparent"
					allowFullScreen="true"
					allowScriptAccess="sameDomain"
					type="application/x-shockwave-flash"
					pluginspage="http://www.adobe.com/go/getflashplayer">
				</embed>
			</object>
		</div>
	</body>

</html>
</o:MultiLanguage>
