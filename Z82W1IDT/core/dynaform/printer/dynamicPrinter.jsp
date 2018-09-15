<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<style>
body { margin: 0px; overflow:hidden }
</style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<!--  <meta http-equiv="Pragma" content="no-cache">-->
<title></title>
</head>
<script type="text/javascript">


function flexSave(strxml){
	return parent.flexSave(strxml);
}

function flexGetTemplate(){
	var template = parent.document.getElementsByName("content.template")[0].value;
	return template;
}

function doGetFormid(){
	return parent.document.getElementsByName("content.relatedForm")[0].value;
}
</script>

<body>
<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
			id="DynamicPrinter" width="100%" height="100%"
			codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
			<param name="movie" value="DynamicPrinter.swf" />
			<param name="quality" value="high" />
			<param name="wmode" value="opaque">
			<param name="bgcolor" value="#869ca7" />
			<param name="allowScriptAccess" value="sameDomain" />
			<embed src="DynamicPrinter.swf" quality="high" bgcolor="#869ca7"
				width="100%" height="100%" name="DynamicPrinter" align="middle" wmode="opaque"
				play="true"
				loop="false"
				quality="high"
				allowScriptAccess="sameDomain"
				type="application/x-shockwave-flash"
				pluginspage="http://www.adobe.com/go/getflashplayer">
			</embed>
	</object>
</body>
</html>