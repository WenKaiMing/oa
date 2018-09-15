<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
 String contextPath = request.getContextPath();
 String hostAddress = request.getScheme()+"://"+ request.getServerName() + ":"+ request.getServerPort() + request.getContextPath();
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css" media="screen">
html,body {
	height: 100%;
}

body {
	margin: 0;
	padding: 0;
	overflow: auto;
	text-align: center;
	background-color: #ffffff;
}

#flashContent {
	display: none;
}
</style>

<script type="text/javascript" src="swfobject.js"></script>
<script src='<s:url value="/script/AC_OETags.js"/>'></script>
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
            var swfUrlStr = "../../../common/flash/IscriptEditor.swf";
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

		function doGetIscriptContent(){
			var args = OBPM.dialog.getArgs();
			var field = args['fieldName'];
			var p = args['parent'];
			var iscontent = p.document.getElementsByName(field)[0].value;
			return iscontent;
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
			var args = OBPM.dialog.getArgs();
			var field = args['fieldName'];
			var feedbackMsg = args['feedbackMsg'];
			var p = args['parent'];
			if(code){
				p.document.getElementsByName(field)[0].value = code;
			}else
				p.document.getElementsByName(field)[0].value ='';
			if(feedback){
				return feedbackMsg;
			}
		}

		function ev_onload() {
			if(document.body.clientWidth>100||document.body.clientHeight>100){
				OBPM.dialog.resize(document.body.clientWidth, document.body.clientHeight);
			}
		}

		/**
		 * 预编译方法
		 */
		function doCompile(code){
			var b = new Base64();
			var str2 = b.decode(code);
			code = str2.replace(/\n/gi,"\\n");

			DWREngine.setAsync(true);

			CompileHelper && CompileHelper.compile && CompileHelper.compile(code, function(str){
				alert(str);
			});
			DWREngine.setAsync(false);
		}

		function doReturn(iscript){
			if(iscript) OBPM.dialog.doReturn(iscript);
		}
		
		function doExit(){
			OBPM.dialog.doExit();
		}
        	
        </script>
</head>
<body width="100%" height="100%" onload="ev_onload()" style="overflow:hidden">
	<div id="flashContent">
		<script type="text/javascript"> 
				var pageHost = ((document.location.protocol == "https:") ? "https://" :	"http://"); 
				document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='" 
								+ pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" ); 
			</script>
	</div>
</body>
</html>
