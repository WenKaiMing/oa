<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="/portal/share/error.jsp"%>
<%@include file="/portal/share/common/lib.jsp"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.dynaform.view.html.ViewHtmlBean"%>
<s:url id="backURL" action="dialogView">
	<s:param name="_viewid" value="#parameters._viewid" />
	<s:param name="parentid" value="#parameters.parentid" />
</s:url>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<%
		ViewHtmlBean htmlBean = new ViewHtmlBean();
	    htmlBean.setHttpRequest(request);
	    htmlBean.setWebUser((WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER));
	    request.setAttribute("htmlBean", htmlBean);
	
		String title = "{*[Month]*}{*[View]*}";
		String viewMode = request.getParameter("viewMode");
		if ("WEEKVIEW".equals(viewMode)) {
			title = "{*[Week]*}{*[View]*}";
		} else if ("DAYVIEW".equals(viewMode)) {
			title = "{*[Day]*}{*[View]*}";
		}
		String html = (String) session.getAttribute("toHtml");
		
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html style="height:100%;*overflow-x:hidden;">
	<head>
	<title><%=title%></title>
	<%@include file="/portal/share/common/js_base.jsp"%>
	<%@include file="/portal/share/common/js_component.jsp"%>
	<link rel="stylesheet" href="<o:Url value='/resource/css/main-front.css'/>" type="text/css" />
	<jsp:include page='/resource/css/style.jsp' flush="true">
		<jsp:param name="styleid" value="<%= htmlBean.getViewStyle()%>" />
	</jsp:include>
	<script type="text/javascript">
		var contextPath = '<%= request.getContextPath()%>';
		var isEdit = '<%=request.getParameter("isEdit")%>';
		var type='<%=request.getParameter("_isdiv")%>';
		
		function createDoc(activityid) {
			// 查看/script/view.js
			var action = activityAction + "?_activityid=" + activityid
			openWindowByType(action,'{*[Select]*}', VIEW_TYPE_SUB); 
		}

		function ev_doClear(){
			OBPM.dialog.doClear();
		}
		function doPrint() {
			window.print();
		}
	</script>
<script src='<s:url value='/portal/share/component/view/common.js' />'></script>
<script src='<s:url value='/portal/share/component/view/view.js' />'></script>
<body  scroll="no">
	<form name="formList" method="post" action="">
		<table width="100%" border="1" cellspacing="0" cellpadding="0" id="oLayer">
		<tr valign='top'>
			<td>
			<table width="100%" border=0 cellpadding="0" cellspacing="5">
				<tr>
					<td class="line-position" width="100%">&nbsp;</td>
					
					<td align="right"><input id="button_act" type="button"
						class="button-document" alt="print" value="{*[Print]*}"
						onclick="doPrint()" /></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
		<s:hidden name="_viewid" />
		<s:hidden name="parentid" value="%{#parameters.parentid}" />
		<s:hidden name="year" />
		<s:hidden name="month" />
		<s:hidden name="week" />
		<s:hidden name="day" /> 
		<s:hidden name="viewMode" />
		<s:hidden name="content.openType" />
		
		<input type="hidden" id="backURL" name="_backURL" value="<%=request.getAttribute("backURL")%>" />
		<s:hidden name="isEdit" value="%{#parameters.isEdit}" />
	
	<div style="margin-left: 40%; width: 50%;"
		align="center">
		<table align="center" width="100%">
			<tr align="center">
					<td nowrap="nowrap">
						<span class="button-cmd"><a href="###" onClick="ev_doClear()"><span><img
							align="middle"
							src="<s:url value='/resource/imgv2/front/main/reset.gif' />">{*[Clear]*}</span></a></span>
					</td>
			</tr>
		</table>
	</div>
	<div id="dataTable" class="front-scroll-auto front-bgcolor2"><%=html%></div>
	</form>
	</body>
	<script src='<s:url value="/portal/share/component/dateField/datePicker/WdatePicker.js" />'></script>
	</html>
</o:MultiLanguage>
