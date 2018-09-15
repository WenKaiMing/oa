<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%
String contextPath = request.getContextPath();
WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
String domainid=webUser.getDomainid();
String hostAddress = "http://" + request.getServerName() + ":"
		+ request.getServerPort() + request.getContextPath();
hostAddress.trim();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<o:MultiLanguage>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src='<s:url value='/portal/share/component/view/view.js' />'></script>
<script src='<s:url value='/portal/share/component/view/common.js' />'></script>
<script type="text/javascript">
var dataMap = "";

jQuery(document).ready(function(){
	dataMap = thisMovie("DataMap");
	setTimeout('myrefresh()',60000);
});

function thisMovie(movieName) {
    if (navigator.appName.indexOf("Microsoft") != -1) {
        return window[movieName];
    } else {
        return document[movieName];
    }
}

/**
 * 保存模板
 */
function ev_save() {
	var falsh = document.getElementsByName('xxx')[0];
	if (falsh){
		var xmlContent = falsh.doSynTemplate();
		document.getElementsByName("template.template")[0].value = xmlContent;
	}
	
	var temp = document.getElementById('template.template').value;
	if(temp == ''){
		showMessage("error", '{*[page.content.notexist]*}');
		return false;
	}
	var url ='<s:url value="/portal/datamap/runtime/save.action"/>';
	document.forms[0].action = url;
	document.forms[0].submit();
}

/*
 * 从flex打开表单
 */
 function viewDoc(docid,formid,application){
	 /*var docid = '11e2-296e-c569749d-a046-e1599f18e295';
	var application = '11de-ef9e-c010eee1-860c-e1cadb714510'; */
	var url = docviewAction;
	url += '?_docid=' + docid;
	if(formid){
		url += '&_formid=' + formid;
	}
	var openType = OPEN_TYPE_DIV;
	var parameters = getDataQueryString();
	resetBackURL();
	if(openType == OPEN_TYPE_DIV) {
		url += "&" + parameters + "&openType=" + openType;
		url = appendApplicationid(url,application);
		showfrontframe({
			title : "测试",
			url : url,
			w : 800,
			h : 600,
			windowObj : window.parent,
			callback : function(result) {
			}
		}); 
	}
}

 /**
  * 获取查询表单中的参数
  * 
  * @return {}
  */
 function getDataQueryString() {
 	var parameters = "";
 	if (parent.document.getElementsByName("_viewid")[0]) {
 		parameters += "_viewid="
 				+ parent.document.getElementsByName("_viewid")[0].value;
 	}
 	if (parent.document.getElementsByName("parentid")[0]) {
 		parameters += "&parentid="
 				+ parent.document.getElementsByName("parentid")[0].value;
 	}
 	return parameters;
 }

 function appendApplicationid(url,application) {
		if (url.indexOf("application") < 0) {
			if (url.indexOf("?") >= 0) {
				url += "&application=" +application;
			} else {
				url += "?application=" +application;
			}
		}
		return url;
	}

/*
 * 从flash同步线索字段值
 */
function ev_synCuleField(value) {
	document.getElementsByName("template.culeField")[0].value = value;
}

function ev_getDataMapContent(datamapCfgId,culeField) {
	
}

function myrefresh() 
{
	if(dataMap != "" || dataMap != null){
		dataMap.refreshReport();
	}else{
		dataMap = thisMovie("DataMap");
		dataMap.refreshReport();
	}
	setTimeout('myrefresh()',60000);
} 

</script>
</head>
<body id="application_module_print_info" class="contentBody">
	<%@include file="/portal/share/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div style="width: 100%;height:100%" id="clientdiv" class="contentMainDiv">
	<s:form name="dataMapTemplate"	action="" theme="simple" method="post">
		<%@include file="/common/page.jsp"%>
		<s:hidden name="template.datamapCfgId" />
		<s:hidden name="template.culeField" />
		<s:textarea name="template.template"
							cssClass="input-cmd" theme="simple" 
							  cssStyle="display: none" />
		<s:textarea name="template.content"
							cssClass="input-cmd" theme="simple" 
							  cssStyle="display: none" />
		<s:hidden name="template.applicationid" value="%{#parameters.application}"/>
		<s:hidden name="template.domainid" value="%{#parameters.domainid}"/>
		<table width="100%" height="99%" style="overflow: hidden">
			<tr >
				<td>
					<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
						id="DataMap" width="100%" height="100%"
						codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
						<param name="movie" value="DataMap.swf" />
						<param name="quality" value="high" />
						<param name="bgcolor" value="#869ca7" />
						<param name="allowScriptAccess" value="sameDomain" />
						<param name="FlashVars" value="application=<%=request.getParameter("application") %>&domainid=<%=domainid %>&isEdit=<%=request.getParameter("isEdit") %>&title=<%=request.getParameter("title") %>&_datamapCfgId=<%=request.getParameter("_datamapCfgId") %>&hostAddress=<%= hostAddress%> "/>
						<embed src="DataMap.swf" quality="high" bgcolor="#869ca7" flashVars="application=<%=request.getParameter("application") %>&domainid=<%=domainid %>&isEdit=<%=request.getParameter("isEdit") %>&title=<%=request.getParameter("title") %>&_datamapCfgId=<%=request.getParameter("_datamapCfgId") %>&hostAddress=<%= hostAddress%>  "
							width="100%" height="100%" name="DataMap" align="middle"
							play="true"
							loop="false"
							quality="high"
							allowScriptAccess="sameDomain"
							type="application/x-shockwave-flash"
							pluginspage="http://www.adobe.com/go/getflashplayer">
						</embed>
				</object>
				</td>
			</tr>
			</table>
	</s:form>
	</div>
</body>
</o:MultiLanguage>
</html>