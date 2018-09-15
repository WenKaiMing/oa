<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib uri="myapps" prefix="o"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<%
  	String contextPath = request.getContextPath();
	String actionUrl = (String)request.getAttribute("_ActionUrl");
	if(actionUrl !=null){
		actionUrl = actionUrl.replaceAll("[\"\']", "");
	}
	if(actionUrl.indexOf("newMessageCount")>0){	//站内短信定时更新的action
		actionUrl = "";
	}
%>
<html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/js/jquery-1.8.3.js'/>"></script>
<!-- 弹出层插件--start -->
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/jquery.artDialog.source.js?skin=aero'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/plugins/iframeTools.source.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/obpm-jquery-bridge.js'/>"></script>
<!-- 弹出层插件--end -->
	<title>TimeOut</title>
</head>
<script >
var frameSize = jQuery(top.document).find("iframe[name='OpentimeOut']").size();
if(frameSize==0 && typeof(body) != "undefined"){
	var url = "<s:url value='/portal/share/security/loginInDialog.jsp'/>";
	OBPM.dialog.show({
				opener:window.top,
				width: 750,
				height: 550,
				url: url,
				args: {},
				id : 'timeOut',
				title: '{*[Login]*}',
				maximized: false,
				close: function(rtn) {
					var form1 = document.getElementById("_timeOutTmp");
					if(form1.getAttribute("action")==null ){	//站内短信定时更新的action跳转时返回上一页
						window.history.back();
					}else {
						form1.submit();
					}
					return true;
				}
		});
}else{
	var form1 = document.getElementById("_timeOutTmp");
	if(form1==null)
		top.window.location = "<s:url value='/portal/share/security/login.jsp'/>";
}
</script>
<body align="center">
<div style="display:none">
<form id="_timeOutTmp" name="_timeOutTmp" method="post" action="">
TimeOut.jsp
<%
Enumeration e = request.getParameterNames();
while (e.hasMoreElements()) {
	String name = (String)e.nextElement();
	String[] values = request.getParameterValues(name);
	
	for (int i=0; i < values.length; i++) {
			out.println("<textarea name='"+name+"'>"+values[i]+"</textarea>");
	}
}

%>
<input type="submit" value="submit" />
</form>
</div>
</body>
</o:MultiLanguage></html>