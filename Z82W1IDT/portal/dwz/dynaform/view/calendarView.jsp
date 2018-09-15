<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="/portal/share/error.jsp"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.dynaform.view.ejb.View"%>
<%@include file="/portal/share/common/lib.jsp"%>
<%@page import="cn.myapps.core.dynaform.view.html.ViewHtmlBean"%>
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
<html>
<head>
	<title><%=title%></title>
	<%@include file="/portal/share/common/js_base.jsp" %>
	<%@include file="/portal/share/common/js_component.jsp" %>
	<!-- 视图样式 -->
	<link rel="stylesheet" href='<o:Url value="/dynaform/view/css/calendarView.css"/>' type="text/css" />
	<!-- 样式库样式 -->
	<jsp:include page='../../resource/css/styleLib.jsp' flush="true">
		<jsp:param name="styleid" value="<%= htmlBean.getViewStyle()%>" />
	</jsp:include>
	<script src='<s:url value='/portal/share/component/view/common.js' />'></script>
	<script src='<s:url value='/portal/share/component/view/view.js' />'></script>
	<script src='<o:Url value="/resource/document/obpm.ui.js"/>'></script>
	<script src='<s:url value="/portal/share/component/dateField/datePicker/WdatePicker.js" />'></script>
	<script src='<s:url value='/portal/share/component/view/obpm.calendarView.js' />'></script>
	<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
	<script type="text/javascript">
		var watermark = {
			show : <%=show%>,
			content : '<%=content%>'
		};
		var contextPath = '<%= request.getContextPath()%>';
		var openType = '<s:property value="content.openType"/>';	//createDoc()
		var selectStr = '{*[Select]*}';	//createDoc() viewDoc()
		
		jQuery(document).ready(function(){
			dy_lock();	//在方法加载完之前锁定操作
			if(watermark.show){
				$("#bodyDiv").watermark({
					texts : [watermark.content], //水印文字,[]数组形式
			    });
			};
			initCaleComm();	//日历视图公用初始化方法
			//禁用日历视图刪除按鈕
			jQuery(".button-dis").each(function(){
				jQuery(this).children(".doRemove").attr("disabled","true");
				jQuery(this).children(".doRemove").attr("onclick","return false");
				jQuery(this).children(".doRemove").css("color","gray");
		    });
			dy_unlock();	//方法加载完之后解锁操作
		});
	</script>
</head>
	
<body class="body-front front-scroll-auto front-bgcolor1" style="padding: 0px;">
	<!-- 遮挡层 -->
	<div id="loadingDivBack" style="position: absolute; z-index: 50; width: 100%; height: 100%; top: 0px; left: 0px; background-color:#ccc; filter: alpha(opacity = 0.1); opacity: 0.1;">
		<div style="position: absolute;top: 35%;left: 45%;width: 128px;height: 128px;z-index: 100;">
			<img src="<o:Url value='/resource/main/images/loading1.gif'/>"/>
		</div>
	</div>
	<!-- <s:hidden name="_viewid" /> -->
	<!-- <s:hidden name="parentid" value="%{#parameters.parentid}" /> -->
	<s:form name="formList" method="post" action="displayView" theme="simple">
	<!-- 
	<s:url id="backURL" action="displayView" >
		<s:param name="_viewid" value="#parameters._viewid" />
		<s:param name="_currpage" value="datas.pageNo"/>
		<s:param name="parentid" value="#parameters.parentid" />
		<s:param name="divid" value="%{#parameters.divid}" />
		<s:param name="treedocid" value="#parameters.treedocid" />
		<s:param name="isinner" value="#parameters.isinner" />
		<s:param name="isRelate" value="#parameters.isRelate" />
	</s:url>
	 -->
	
		<!-- 一些供javascript使用的参数 document.getElementById来获取 -->
		<s:hidden name="_viewid" />
		<s:hidden name="divid" value="%{#parameters.divid}" />
		<s:hidden name="parentid" value="%{#parameters.parentid}" />
		<s:hidden name="isRelate" value="%{#parameters.isRelate}" />
		<s:hidden name="year" /> 
		<s:hidden name="month" /> 
		<s:hidden name="week" />
		<s:hidden name="day" /> 
		<s:hidden name="viewMode" /> 
		<input type="hidden" name="_openType" value='<s:property value="content.openType"/>' />
		<s:hidden name="_fieldid" value="%{#parameters._fieldid}" />
		<s:hidden name="isedit" value="%{#parameters.isedit}"/>
		<!-- 当前视图对应的菜单编号 -->
		<s:hidden id="resourceid" name="_resourceid" value="%{#parameters._resourceid}" />
		<s:hidden name="application" value="%{#parameters.application[0]}" />
		
		<!-- 电子签章参数 -->
		<s:hidden name="signatureExist" id="signatureExist"
		value="%{#request.htmlBean.isSignatureExist()}"></s:hidden>
		
		
		
	<div  id="bodyDiv" class="front-boder front-scroll-hidden front-bgcolor2"  style="width:99%\9;">
	<input type="hidden" id="backURL" name="_backURL" value="<%=request.getAttribute("backURL")%>" />
	<div id="activityTable" class="front-border-bottom front-bgcolor2">
	<table class="front-table-act front-table-full-width">
		<tr valign="middle">
			<td>
			<!-- 输出视图操作HTML -->
			<s:property value="#request.htmlBean.toActHtml()" escape="false"/>
			</td>
			<td align="right"><%=title%></td>
		</tr>
	</table>
	</div>
	
	<!-- 是否显示查询表单 -->
	<s:if test="#request.htmlBean.showSearchForm">
	<div id="searchFormTable" class="front-scroll-hidden" style="padding: 10px;">
	<table class="front-table-full-width">
		<tr>
			<td>
			<!-- 输出查询表单HTML -->
			<s:property value="#request.htmlBean.toSearchFormHtml()" escape="false"/>
			</td>
			
			<!-- 是否显示查询表单按钮 -->
			<s:if test="#request.htmlBean.showSearchFormButton">
			<td style="width: 150px;">
			<table>
				<tr>
					<td ><span class="button-cmd"><a
						href="###" onclick="document.forms[0].submit();"><span><img
						align="middle"
						src="<o:Url value='/resource/document/query.gif' />">{*[Query]*}</span></a></span>
					</td>
				</tr>
				<tr>
					<td >
						<span class="button-cmd">
							<a href="#" onclick="ev_resetAll()">
								<span>
									<img align="middle" src="<o:Url value='/resource/document/reset.gif' />">{*[Reset]*}
								</span>
							</a>
						</span>
					</td>
				</tr>
			</table>
			</td>
			</s:if>
		</tr>
	</table>
	</div>
	</s:if>
	<div id="dataTable" class="front-scroll-auto calendar-table">
	<table class="front-font-viewdata front-table-full-width front-scroll-auto">
		<tr><td>
		<div id="cal_viewcontent">		
			<%=html%>
		</div>
		</td></tr>
	</table>
	</div>
	</div>
	</s:form>
	</body>
	</html>
</o:MultiLanguage>
