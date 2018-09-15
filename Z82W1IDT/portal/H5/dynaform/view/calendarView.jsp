<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="/portal/share/error.jsp"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.dynaform.view.ejb.View"%>
<%@include file="/portal/share/common/lib.jsp"%>
<%@page import="cn.myapps.core.dynaform.view.html.ViewHtmlBean"%>
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
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!DOCTYPE html>
<html>
<head>
	<title><%=title%></title>
	<meta charset="UTF-8">
	<%@ include file="/portal/H5/resource/common/include_view_css.jsp" %>
	<link rel="stylesheet" href="<o:Url value='/resource/css/myapp.css'/>" />
	<link rel="stylesheet" href="<o:Url value='/resource/css/view.css'/>" />
	<!-- 视图样式 -->
	<link rel="stylesheet" href='<o:Url value="/dynaform/view/css/calendarView.css"/>' type="text/css" />
	<!-- 样式库样式 -->
	<jsp:include page='../../resource/css/styleLib.jsp' flush="true">
		<jsp:param name="styleid" value="<%= htmlBean.getViewStyle()%>" />
	</jsp:include>
</head>
	
<body>
<!-- 遮挡层 -->
<div id="loadingMask" class="obpm-mask_transparent">
    <div class="obpm-loading">
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
		<s:hidden name="application" />
		
		<!-- 电子签章参数 -->
		<s:hidden name="signatureExist" id="signatureExist"
		value="%{#request.htmlBean.isSignatureExist()}"></s:hidden>
<div id="right" style="background:none">
	<div id="bodyDiv" class="crm_right">
	<input type="hidden" id="backURL" name="_backURL" value="<%=request.getAttribute("backURL")%>" />
	<div id="activityTable" style="position: fixed;z-index: 10;top: 0;">
        <div class="searchDiv">
            <ul class="nav nav-pills">
				<!-- 输出视图操作HTML -->
				<s:property value="#request.htmlBean.toActHtml()" escape="false"/>
				<!-- 查询按钮 -->
                <s:if test="#request.htmlBean.showSearchForm">
                <button type="button" class="btn btn-info " style="float:right;margin-right:15px;" onclick="isSearch();"><i class="glyphicon glyphicon-search" aria-hidden="true" ></i></button>
            	</s:if>
				<span class="fr"><%=title%></span>
            </ul>
        </div>
    </div>
	<div class="mt105"></div>
	<!-- 是否显示查询表单 -->
	<s:if test="#request.htmlBean.showSearchForm">
	<div class="searchDiv" id="searchFormTable" style="margin-bottom:10px;background-color: transparent;display:none;">
		<!-- 要在BackURL传递的参数放在 searchFormTable-->
            <div class="container-fluid">
                <form>
					<!-- 输出查询表单HTML -->
					<s:property value="#request.htmlBean.toSearchFormHtml()" escape="false"/>
                    <div class="row">
					    <div class="col-xs-12 text-center">
					        <button type="button" class="btn btn-primary" onclick="document.forms[0].submit();">{*[Query]*}</button>
							<button type="button" class="btn btn-default btn-reset" onclick="ev_resetAll()">{*[Reset]*}</button>
						</div>
                    </div>
                </form>
            </div>
    </div>
	</s:if>
	<div id="dataTable" class="dataTable">
		<div id="cal_viewcontent">		
			<%=html%>
		</div>
	</div>
	</div>
</div>
</s:form>

<%@ include file="/portal/H5/resource/common/include_view_js.jsp" %>
<script src='<o:Url value="/resource/component/view/obpm.calendarView.js" />'></script>
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
		showLoading();	//在方法加载完之前锁定操作
		initCaleComm();	//日历视图公用初始化方法
		//禁用日历视图刪除按鈕
		jQuery(".button-dis").each(function(){
			jQuery(this).children(".doRemove").attr("disabled","true");
			jQuery(this).children(".doRemove").attr("onclick","return false");
			jQuery(this).children(".doRemove").css("color","gray");
	    });
		
		$("body").niceScroll({
			cursorcolor: "#ccc",
		    cursoropacitymax: 1,
		    touchbehavior: false, 
		    cursorwidth: "7px",
		    cursorborder: "0",
		    cursorborderradius: "7px",
		    autohidemode: true
		});

		hideLoading();	//方法加载完之后解锁操作
		if(watermark.show){
			$("#bodyDiv").watermark({
				texts : [watermark.content], //水印文字,[]数组形式
		    });
		};

	});
</script>
</body>
</html>
</o:MultiLanguage>
