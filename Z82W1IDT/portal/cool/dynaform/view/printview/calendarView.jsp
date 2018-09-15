<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="/portal/share/error.jsp"%>
<%@include file="/portal/share/common/lib.jsp"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.dynaform.view.html.ViewHtmlBean"%>
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
<html style="height:100%;">
<head>
	<title><%=title%></title>
	<%@include file="/portal/share/common/js_base.jsp" %>
	<%@include file="/portal/share/common/js_component.jsp" %>
	<jsp:include page='../../../resource/document/style.jsp' flush="true">
		<jsp:param name="styleid" value="<%= htmlBean.getViewStyle()%>" />
	</jsp:include>
	<script type="text/javascript">
		var contextPath = '<%= request.getContextPath()%>';
		function doPrint() {
			window.print();
		}
	</script>
<script src='<s:url value='/portal/share/component/view/common.js' />'></script>
<script src='<s:url value='/portal/share/component/view/view.js' />'></script>
</head>
	
<body class="body-front front-scroll-auto front-bgcolor1" style="height:100%;padding: 0px;">
	<!-- <s:hidden name="_viewid" /> -->
	<!-- <s:hidden name="parentid" value="%{#parameters.parentid}" /> -->
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
	<!-- 
	<s:url id="backURL" action="displayView" >
		<s:param name="_viewid" value="#parameters._viewid" />
		<s:param name="_currpage" value="datas.pageNo"/>
		<s:param name="parentid" value="#parameters.parentid" />
		<s:param name="treedocid" value="#parameters.treedocid" />
		<s:param name="isinner" value="#parameters.isinner" />
	</s:url>
	 -->
	
		<!-- 一些供javascript使用的参数 document.getElementById来获取 -->
		<s:hidden name="_viewid" />
		<s:hidden name="parentid" value="%{#parameters.parentid}" />
		<s:hidden name="year" /> 
		<s:hidden name="month" /> 
		<s:hidden name="week" />
		<s:hidden name="day" /> 
		<s:hidden name="viewMode" /> 
		<s:hidden name="content.openType" />
		
		<input type="hidden" name="application" value="<%=htmlBean.getApplicationid()%>" />
		
	<div class="front-boder front-scroll-auto">
	<input type="hidden" id="backURL" name="_backURL" value="<%=request.getAttribute("backURL")%>" />
	
	<script type="text/javascript">
		jQuery(function(){
			jQuery("#cal_viewcontent").width(jQuery("body").width()-10);
			jQuery("#cal_viewcontent").height(jQuery("body").height()-35);
			jQuery("#cal_viewcontent").css("overflow","auto");
		});
		
		function createDoc(activityid) {
			// 查看/script/view.js
			if('<s:property value="content.openType"/>' == 277){
				var action = activityAction + "?_activityid=" + activityid;
				openWindowByType(action,'{*[Select]*}', VIEW_TYPE_SUB,activityid);
			} else {
				var action = activityAction + "?_activityid=" + activityid;
				openWindowByType(action,'{*[Select]*}', VIEW_TYPE_NORMAL,activityid);
			}
		}
	</script>
	<div id="dataTable" class="front-scroll-auto front-bgcolor2">
	<table class="front-font-viewdata front-table-full-width front-scroll-auto">
		<tr><td>
		<div id="cal_viewcontent" style="overflow: auto;background-color: #F8F8F8;">		
			<%=html%>
		</div>
		</td></tr>
	</table>
	</div>
	</div>
	</form>
	</body>
	<script type="text/javascript">
		function viewDoc(docid, formid ,signatureExist) {
			// 查看/script/view.js
			var url = docviewAction;
			url += '?_docid=' + docid;
			if (formid) {
				url += '&_formid=' +  formid;
			}
			if(signatureExist){
				url += '&signatureExist=' +  signatureExist;
			}
			
			openWindowByType(url,'{*[Select]*}', VIEW_TYPE_NORMAL); 
		}
	</script>
	<script src='<s:url value="/portal/share/component/dateField/datePicker/WdatePicker.js" />'></script>
	</html>
</o:MultiLanguage>
