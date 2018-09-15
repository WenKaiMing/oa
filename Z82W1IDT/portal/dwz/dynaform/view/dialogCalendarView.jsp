<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="/portal/share/error.jsp"%>
<%@include file="/portal/share/common/lib.jsp"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.dynaform.view.ejb.View"%>
<%@page import="cn.myapps.core.dynaform.view.html.ViewHtmlBean"%>
<s:url id="backURL" action="dialogView">
	<s:param name="_viewid" value="#parameters._viewid" />
	<s:param name="parentid" value="#parameters.parentid" />
	<s:param name="application" value="#parameters.application[0]" />
</s:url>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<%
		ViewHtmlBean htmlBean = new ViewHtmlBean();
	    htmlBean.setHttpRequest(request);
	    WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
		if("true".equals(request.getAttribute("_isPreview"))){
			webUser = (WebUser)session.getAttribute(Web.SESSION_ATTRIBUTE_PREVIEW_USER);
		}
	    htmlBean.setWebUser(webUser);
	    request.setAttribute("htmlBean", htmlBean);
	
		String title = "{*[Month]*}{*[View]*}";
		String viewMode = request.getParameter("viewMode");
		String defaultSize = request.getParameter("_defaultSize");
		if ("WEEKVIEW".equals(viewMode)) {
			title = "{*[Week]*}{*[View]*}";
		} else if ("DAYVIEW".equals(viewMode)) {
			title = "{*[Day]*}{*[View]*}";
		}
		String html = (String) session.getAttribute("toHtml");

	    View view = htmlBean.getView();
	    Boolean showWaterMark = view.getShowWaterMark();
	    boolean show = showWaterMark != null ? showWaterMark : false;
	    String content = htmlBean.getWaterMark();
	    content = content != null ? content : "";
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html style="height:100%;">
	<head>
	<title><%=title%></title>
	<%@include file="/portal/share/common/js_base.jsp" %>
	<%@include file="/portal/share/common/js_component.jsp" %>
	<jsp:include page='../../resource/document/style.jsp' flush="true">
		<jsp:param name="styleid" value="<%= htmlBean.getViewStyle()%>" />
	</jsp:include>
	<script src='<o:Url value="/resource/document/obpm.ui.js"/>'></script>
	<script type="text/javascript">
		var watermark = {
			show : <%=show%>,
			content : '<%=content%>'
		};
		var contextPath = '<%= request.getContextPath()%>';
		var isEdit = '<%=request.getParameter("isEdit")%>';
		var type='<%=request.getParameter("_isdiv")%>';
		
		function createDoc(activityid) {
			// 查看/script/view.js
			var action = activityAction + "?_activityid=" + activityid
			openWindowByType(action,'{*[Select]*}', VIEW_TYPE_SUB,activityid); 
		}

		function ev_doClear(){
			OBPM.dialog.doClear();
		}

		jQuery(document).ready(function(){
			dy_lock();	//在方法加载完之前锁定操作
			if(watermark.show){
				$("body").watermark({
		            texts : [watermark.content] //水印文字,[]数组形式
		        })
			};
			//表单控件jquery重构
			jqRefactor();
			var defalutSize = <%=defaultSize%>;
			//Resize dialog, set the dialog window size as the body size.
			if(defalutSize == "true"){//后台显示大小为默认时，允许页面根据内容设置弹出层大小
				OBPM.dialog.resize(600, document.body.scrollHeight);
			}
			dy_unlock();	//方法加载完之后解锁操作
		});
	</script>
<script src='<s:url value='/portal/share/component/view/common.js' />'></script>
<script src='<s:url value='/portal/share/component/view/view.js' />'></script>
<body style="height:100%;" >
	<!-- 遮挡层 -->
	<div id="loadingDivBack" style="position: absolute; z-index: 50; width: 100%; height: 100%; top: 0px; left: 0px; background-color:#ccc; filter: alpha(opacity = 0.1); opacity: 0.1;">
		<div style="position: absolute;top: 35%;left: 45%;width: 128px;height: 128px;z-index: 100;">
			<img src="<o:Url value='/resource/main/images/loading1.gif'/>"/>
		</div>
	</div>
	<form name="formList" method="post" action="">
		<s:hidden name="_viewid" />
		<s:hidden name="parentid" value="%{#parameters.parentid}" />
		<s:hidden name="year" />
		<s:hidden name="month" />
		<s:hidden name="week" />
		<s:hidden name="day" /> 
		<s:hidden name="viewMode" />
		<input type="hidden" name="_openType" value='<s:property value="content.openType"/>' />
		<s:hidden name="_fieldid" value="%{#parameters._fieldid}" />
		<!-- 当前视图对应的菜单编号 -->
		<s:hidden id="resourceid" name="_resourceid" value="%{#parameters._resourceid}" />
		
		<!-- 电子签章参数 -->
		<s:hidden name="signatureExist" id="signatureExist"
		value="%{#request.htmlBean.isSignatureExist()}"></s:hidden>
		
		<input type="hidden" id="backURL" name="_backURL" value="<%=request.getAttribute("backURL")%>" />
		<s:hidden name="isEdit" value="%{#parameters.isEdit}" />
	
	<s:if test="#request.htmlBean.showSearchForm">
	<div id="searchFormTable" class="front-scroll-hidden front-bgcolor2" style="padding: 10px;">
	<table class="front-table-full-width">
		<tr>
			<td>
			<!-- 输出查询表单HTML -->
			<s:property value="#request.htmlBean.toSearchFormHtml()" escape="false"/>
			</td>
			
			<td style="width: 150px;">
			<table>
				<tr>
					<td ><span class="button-cmd"><a
						href="###" onclick="document.forms[0].submit();"><span><img
						align="middle"
						src="<s:url value='/portal/share/images/imgnew/query.gif' />">{*[Query]*}</span></a></span>
					</td>
				</tr>
				<tr>
					<td ><span class="button-cmd"><a
						href="###" onclick="ev_resetAll()"><span> <img
						align="middle"
						src="<s:url value='/portal/share/images/imgnew/reset.gif' />">{*[Reset]*}</span></a></span>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	</div>
	</s:if>
	<div style="margin-left: 40%; width: 50%;"
		align="center">
		<table align="center" width="100%">
			<tr align="center">
					<td >
						<span class="button-cmd"><a href="###" onClick="ev_doClear()"><span><img
							align="middle"
							src="<s:url value='/portal/share/images/imgnew/reset.gif' />">{*[Clear]*}</span></a></span>
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
