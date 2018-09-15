<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%><%@ taglib uri="myapps" prefix="o"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>E-Mail HomePage</title>
<link href="<s:url value='/resource/css/main-front.css'/>" type="text/css" rel="stylesheet"></link>
<script type="text/javascript">
window.onload = function() {
	//var lis = parent.document.getElementsByTagName("li");//左侧菜单
	//for (i = 0; i < lis.length; i++) {
	//	lis[i].style.background = '';
	//}
	window.parent.clearMenuStyle();
	window.parent.hideLoading();
};
function list(folderid) {
	window.parent.showLoading();
	window.location.href = "<s:url value='/portal/email/list.action'/>?folderid=" + folderid + "&type=0";
}
</script>
</head><s:bean name="cn.myapps.core.email.email.action.EmailHelper" id="emailHelper" />
<body style="margin-left: 30px;"><s:bean name="cn.myapps.core.email.folder.action.EmailFolderHelper" id="folderHelper" />
<div style="width: 100%; border-bottom: 1px solid #ebebeb;">
	<span style="line-height: 36px;"><strong><s:property value="#session.FRONT_USER.emailUser.name"/> </strong></span><br>
	<span style="line-height: 26px;"><s:property value="#emailHelper.getUnreadMessageCount(#folderHelper.getInboxEmailFolderId(#session.FRONT_USER), #session.FRONT_USER)" /> {*[core.email.feng]*} {*[core.email.unread]*}</span>
</div>
<div>
	<p><a href="javascript:list('<s:property value="#folderHelper.getInboxEmailFolderId(#session.FRONT_USER)" />');">{*[core.email.inbox]*}</a></p>
</div>
</body>
</o:MultiLanguage></html>