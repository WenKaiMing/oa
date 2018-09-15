<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
 <%@ taglib uri="/struts-tags" prefix="s"%>
 <%
 String contextPath = request.getContextPath();
 String hostAddress = request.getScheme()+"://"+ request.getServerName() + ":"+ request.getServerPort() + request.getContextPath();
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<style>
body {
		scroll="no";
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

<script type="text/javascript" src="swfobject.js"></script>
<script src='<s:url value="/portal/share/script/AC_OETags.js"/>'></script>
<script src='<s:url value="iscripteditor.js"/>'></script>
<!-- dwr -->
<!-- DWR -->
<script type="text/javascript"
	src='<s:url value="/dwr/interface/CompileHelper.js"/>'></script>
	
<script type="text/javascript">
var contextPath = '<%= request.getContextPath() %>';
var hostAddress = '<%= hostAddress %>';

var swfVersionStr = "10.0.0";
var xiSwfUrlStr = "playerProductInstall.swf";
var swfUrlStr = "IscriptEditor.swf";
var flashvars = {};
var params = {};
params.quality = "high";
params.bgcolor = "#ffffff";
params.allowscriptaccess = "sameDomain";
params.allowfullscreen = "true";
params.wmode="opaque";
var attributes = {};
attributes.id = "flexiframe";
attributes.name = "flexiframe";
attributes.align = "middle";
swfobject.embedSWF(
    swfUrlStr, "flashContent", 
    "100%", "100%", 
    swfVersionStr, xiSwfUrlStr, 
    flashvars, params, attributes);
swfobject.createCSS("#flashContent", "display:block;text-align:left;");

//在窗口关闭前移除flex 禁止其调用回调方法
function removeIscriptEditor(){
	try{
			jQuery("#IscriptEditor").remove();
		}catch(e){
			jQuery("#body").remove();
		}
	}

function moveIFrame(x,y,w,h) {
    var frameRef=document.getElementById("myFrame");
    frameRef.style.left=x;
    frameRef.style.top=y;
    var iFrameRef=document.getElementById("myIFrame");	
	iFrameRef.width=w;
	iFrameRef.height=h;
}

function hideIFrame(){
    document.getElementById("myFrame").style.visibility="hidden";
}
	
function showIFrame(){
    document.getElementById("myFrame").style.visibility="visible";
}

function loadIFrame(url){
	document.getElementById("myFrame").innerHTML = "<iframe id='myIFrame' style='z-index:8000;' src='" + url + "'frameborder='0'></iframe>";
}


function doGetIscriptContent(){
	var args = OBPM.dialog.getArgs();
	var field = args['fieldName'];
	return field;
	
}
function doGetIscriptLabel(){
	var args = OBPM.dialog.getArgs();
	var lable = args['label'];
	return lable;
}

function doGetHelperLink(){
	var link = hostAddress+'/help/back/toc/index_iscript_help.jsp';
	return link;
}

function doEditorSave(code,feedback){
	var b = new Base64();
	var str2 = b.decode(code);
	code = str2.replace(/\n/gi,"\\n");
	OBPM.dialog.doReturn(code);
}

function ev_onload() {
	if(document.body.clientWidth>100||document.body.clientHeight>100){
		OBPM.dialog.resize(document.body.clientWidth, document.body.clientHeight);
	}
}

function doReturn(iscript){
	if(iscript) OBPM.dialog.doReturn(iscript);
}

function doExit(){
	OBPM.dialog.doExit();
}
</script>

<o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!-- <meta http-equiv="Pragma" content="no-cache">  -->


</head>
<body width="100%" height="100%" onload="ev_onload()" onbeforeunload="removeIscriptEditor" onunload="removeIscriptEditor()" >
<div id="flashContent">
		<script type="text/javascript"> 
				var pageHost = ((document.location.protocol == "https:") ? "https://" :	"http://"); 
				document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='" 
								+ pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" ); 
			</script>
	</div>
</body>
</o:MultiLanguage>
</html>