<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<% out.println("<!--TARGET SERVLETPATH:"+request.getServletPath()+"-->");%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<script type="text/javascript">
var contextPath = '<%=request.getContextPath()%>';
var application = '<%= request.getParameter("application")%>';
var isCloseDialog = '<%=request.getParameter("isCloseDialog")%>';
var title_uf = '{*[UserField]*}';
var title_df = '{*[DepartmentField]*}';
var title_more = '{*[More]*}';
var title_addAuditor = '{*[cn.myapps.core.workflow.add_auditor]*}';
var title_upload = '{*[Upload]*}';
var title_map = '{*[map]*}';
var title_onlinetakephoto = '{*[OnLineTakePhotoField]*}';
var loadError = "{*[page.can.not.load.document]*}";//see ntkoofficecontrol.js
var checkBrowserSettings = '{*[page.check.browser.security.settings]*}';//see ntkoofficecontrol.js

//personalmessage.js
var personalmessage_title_sended = '{*[cn.myapps.core.workflow.notification.sended]*}';
var personalmessage_title_pending = '{*[cn.myapps.core.workflow.notification.pending]*}';
var personalmessage_title_pending_overdue = '{*[cn.myapps.core.workflow.notification.pending.overdue]*}';
var personalmessage_title_rollback = '{*[cn.myapps.core.workflow.notification.rollback]*}';
</script>
</o:MultiLanguage>
<!-- DWR--éè¦åäºjQueryå è½½ -->
<script type="text/javascript" src="<s:url value='/dwr/engine.js'/>"></script>
<script type="text/javascript" src="<s:url value='/dwr/util.js'/>"></script>

<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/js/jquery-1.8.3.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/js/jquery-obpm-extend.js'/>"></script>
<!-- å³é®æä»¶smartMenuæ ·å¼ -->
<link type="text/css" href="<s:url value='/portal/share/script/jquery-ui/css/smartMenu.css'/>" rel="stylesheet"/>
<link type="text/css" href="<s:url value='/portal/share/script/jquery-ui/css/smoothness/jquery-ui-1.9.2.custom.css'/>" rel="stylesheet" />
<script type="text/javascript" src='<s:url value='/portal/share/script/jquery-ui/js/jquery-smartMenu.js' />'></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/js/jquery-ui-1.9.2.custom.dialog.min.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/jquery.form.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/json/json2.js'/>"></script>
<!-- layout -->
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/layout/jquery.layout.js'/>"></script>
<!-- jquery-ui è§£å³ie6ä¸­divå±ä¸è½é®æ¡ä½ä¸ææ¡çé®é¢ -->
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/external/jquery.bgiframe-2.1.1.js'/>"></script>

<!-- å¼¹åºå±æä»¶--start -->
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/jquery.artDialog.source.js?skin=aero'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/plugins/iframeTools.source.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/obpm-jquery-bridge.js'/>"></script>
<!-- å¼¹åºå±æä»¶--end -->
<!-- Platform lib -->
<script type="text/javascript" src="<s:url value='/portal/share/script/util.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/list.js'/>"></script>
<script type="text/javascript" src='<s:url value="/portal/share/script/generic.js"/>'></script>
<link type="text/css" href="<s:url value='/portal/share/component/dialog/css/dialog.css'/>" rel="stylesheet"/>
<script type="text/javascript" src='<s:url value="/portal/share/component/dialog/dialog.js"/>'></script>

<script type="text/javascript" src="<s:url value='/portal/share/component/obpm.form.util.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/onlinetakephoto/obpm.onlineTakePhoto.js'/>"></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/map/obpm.baiduMap.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/checkboxField/obpm.checkboxField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/radioField/obpm.radioField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/inputField/obpm.inputField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/textareaField/obpm.textareaField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/selectField/obpm.selectField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/dateField/obpm.dateField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/departmentField/obpm.departmentField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/viewDialogField/obpm.viewDialogField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/treeDepartmentField/obpm.treeDepartmentField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/userField/obpm.userField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/upload/obpm.attachmentUpload2DataBase.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/upload/obpm.imageUpload2DataBaseField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/includedView/obpm.includedView.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/pending/obpm.pending.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/wordField/obpm.wordField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/genericWordField/obpm.genericWordField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/flowHistoryField/obpm.flowHistoryField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/qrcodeFiled/obpm.qrcodeField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/qrcodeFiled/lib/jquery.qrcode-0.12.0.min.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/weixinGpsField/obpm.weixinGpsField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/surveyField/obpm.surveyField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/flowReminderHistoryField/obpm.flowReminderHistoryField.js"/>'></script>
<link rel="stylesheet" href="<s:url value='/portal/share/component/sign/obpm.sign.css'/>" />


<!-- image&file upload -->
<script type="text/javascript" src="<s:url value='/portal/share/component/upload/upload.js'/>"></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/filemanager/obpm.fileManager.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/upload/upload2DataBase.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/upload/uploadAttachment2DataBase.js"/>'></script>

<!-- htmlEditor -->
<script type="text/javascript" src='<s:url value="/portal/share/component/htmlEditor/obpm.htmlEditorField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/htmlEditor/xheditor/xheditor-1.1.12-zh-cn.min.js"/>'></script>

<!-- informationfeedback -->
<script type="text/javascript" src='<s:url value="/portal/share/component/informationfeedbackField/obpm.informationfeedbackField.js"/>'></script>

<!-- selectAbout -->
<link rel="stylesheet" href="<s:url value='/portal/share/component/selectAboutField/css/jquery.multiselect2side.css'/>" type="text/css">
<script type="text/javascript" src='<s:url value="/portal/share/component/selectAboutField/obpm.selectAboutField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/selectAboutField/jquery.multiselect2side.js"/>'></script>

<!-- suggest -->
<script type="text/javascript" src='<s:url value="/portal/share/component/suggest/obpm.suggestField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/suggest/typeahead.min.js"/>'></script>

<!-- Tab Menu Compoment -->
<script type="text/javascript" src='<s:url value="/portal/share/component/tabField/ddtabmenu.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/tabField/obpm.tabField.js"/>'></script>
<script type="text/javascript" src='<s:url value="/portal/share/component/tabField/collapse/collapse.js"/>'></script>

<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%
	String contextPath = request.getContextPath();
	// 组装queryString，WebSphere不支持getQueryString
	String queryString = "";
	Map parameterMap = request.getParameterMap();
	String[] temp = (String [])parameterMap.get("selectOne");
	String[] mutil = (String []) parameterMap.get("mutil");
	for(Iterator it = parameterMap.entrySet().iterator(); it.hasNext();) {
		Map.Entry entry = (Map.Entry)it.next();
		String[] values = (String[])entry.getValue();
		queryString += entry.getKey() + "="+values[0]+"&";
	}
	
	if (!parameterMap.isEmpty()) {
		queryString = queryString.substring(0, queryString.length() - 1);
	}

%>
<html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<style type="text/css">
@-moz-keyframes three-quarters-loader {
  0% {
    -moz-transform: rotate(0deg);
    transform: rotate(0deg);
  }
  100% {
    -moz-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}
@-webkit-keyframes three-quarters-loader {
  0% {
    -webkit-transform: rotate(0deg);
    transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}
@keyframes three-quarters-loader {
  0% {
    -moz-transform: rotate(0deg);
    -ms-transform: rotate(0deg);
    -webkit-transform: rotate(0deg);
    transform: rotate(0deg);
  }
  100% {
    -moz-transform: rotate(360deg);
    -ms-transform: rotate(360deg);
    -webkit-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}
/* :not(:required) hides this rule from IE9 and below */
.three-quarters-loader:not(:required) {
  -moz-animation: three-quarters-loader 1250ms infinite linear;
  -webkit-animation: three-quarters-loader 1250ms infinite linear;
  animation: three-quarters-loader 1250ms infinite linear;
  border: 8px solid #38e;
  border-right-color: transparent;
  border-radius: 16px;
  box-sizing: border-box;
  display: inline-block;
  position: relative;
  overflow: hidden;
  text-indent: -9999px;
  width: 32px;
  height: 32px;
}

</style>
<script>
function ev_onload2(){
   temp.submit();
}
//window.attachEvent("onload", ev_onload2);
</script>
</head>
<body onload='ev_onload2()' align="center" style="overflow: hidden"> 
<div id="tips">
  <table width=100% height=100% align=center cellpadding=0 cellspacing=0 border=0 >
    <tr>
      <td align="center">
		<div class="cell">
	      <div class="card">
	        <span class="three-quarters-loader">Loading&#8230;</span>
	      </div>
	    </div>
	</td>
    </tr>
  </table>
</div>
<%if(mutil[0].equals("true")){ %>
	<form method='post' name='temp' action='<%= contextPath %>/portal/dynaform/view/mainDialogView.action?<%=queryString%>'>
<%} else{%>
	<form method='post' name='temp' action='<%= contextPath %>/portal/dynaform/view/dialogView.action?<%=queryString%>'>
<%} %>
<div id="strHeddin" style="display:none; height:100%">
<script>
	var args = OBPM.dialog.getArgs();
	document.write(args?args['html']:"");
</script>
</div>
</form>
</body>
</o:MultiLanguage></html>