<%@ page contentType="text/html; charset=UTF-8" errorPage="/portal/share/error.jsp"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.dynaform.view.ejb.View"%>
<%@page import="cn.myapps.core.dynaform.view.html.MapViewHtmlBean"%>
<%@include file="/portal/share/common/lib.jsp"%>
<%
	//初始化HtmlBean
	MapViewHtmlBean htmlBean = new MapViewHtmlBean();
	htmlBean.setHttpRequest(request);
	 WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
		if("true".equals(request.getAttribute("_isPreview"))){
			webUser = (WebUser)session.getAttribute(Web.SESSION_ATTRIBUTE_PREVIEW_USER);
		}
	    htmlBean.setWebUser(webUser);
	request.setAttribute("htmlBean", htmlBean);
%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/portal/H5/resource/common/include_view_css.jsp" %>
<!-- 视图样式 -->
<link rel="stylesheet" href='<o:Url value="/dynaform/view/css/mapView.css"/>' type="text/css" />
<link rel="stylesheet" href='<o:Url value="/resource/css/view.css"/>' type="text/css" />
<!-- 样式库样式 -->
<jsp:include page='../../resource/css/styleLib.jsp' flush="true">
	<jsp:param name="styleid" value="<%= htmlBean.getViewStyle()%>" />
</jsp:include>

<title>{*[cn.myapps.core.dynaform.view.map_view]*}</title>
</head>
<body class="body-front front-scroll-hidden front-bgcolor1 front-margin1" style="height:100%;">
<!-- 遮挡层 -->
<div id="loadingMask" class="obpm-mask_transparent">
    <div class="obpm-loading">
        <img src="<o:Url value='/resource/main/images/loading1.gif'/>"/>
    </div>
</div>
<s:form id="formList" name="formList" action="displayView" method="post" theme="simple">
<!-- 电子签章 -->
<div id="install" style="display:none">
     <a id="hreftest2" href="<s:url value='/portal/share/component/signature/iSignatureHTML.zip'/>"><font color="red"><b>&nbsp;&nbsp;&nbsp;点击下载金格iSignature电子签章HTML版软件</b></font></a> 
</div>
<%
    if(htmlBean.isSignatureExist()) {
%>
	<%@include file="/portal/share/dynaform/view/batchSignatureObject.jsp"%>
<%
    }
%>
	<%@include file="/common/list.jsp"%>
	<s:url id="backURL" action="displayView" >
		<s:param name="_viewid" value="#parameters._viewid" />
		<s:param name="parentid" value="#parameters.parentid" />
		<s:param name="divid" value="%{#parameters.divid}" />
		<s:param name="_currpage" value="datas.pageNo"/>
		<s:param name="application" value="#parameters.application[0]" />
	</s:url>
	
	<!-- 一些供javascript使用的参数 document.getElementById来获取 -->
	<s:hidden name="isedit" value="%{#parameters.isedit}" />
	<s:hidden name="isenbled" value="%{#parameters.isenbled}" />
	<!-- 当前视图对应的菜单编号 -->
	<s:hidden id="resourceid" name="_resourceid" value="%{#parameters._resourceid}" />
	
	<!-- 电子签章参数 -->
	<s:hidden name="signatureExist" id="signatureExist"
	value="%{#request.htmlBean.isSignatureExist()}"></s:hidden>
	<!-- 电子签章参数 -->
	<s:set name="sinfo" value="#request.htmlBean.getSignatureInfo(datas)"/>
	<s:hidden name="FormID" id="FormID" value="%{#sinfo.FormID}" ></s:hidden>
	<s:hidden name="ApplicationID" id="ApplicationID" value="%{#sinfo.ApplicationID}" ></s:hidden>
	<s:hidden name="DocumentID" id="DocumentID" value="%{#sinfo.DocumentID}" ></s:hidden>
	<s:hidden name="mGetBatchDocumentUrl" id="mGetBatchDocumentUrl" value="%{#sinfo.mGetBatchDocumentUrl}" ></s:hidden>
	<s:hidden name="mLoginname" id="mLoginname" value="%{#session.FRONT_USER.loginno}"></s:hidden>
	
	<s:textarea name="message" value="%{#request.message.content}" cssStyle="display:none" />
	<input type="hidden" name="_backURL" value="<%=request.getAttribute("backURL") %>" />
	<s:hidden name="isedit" value="%{#parameters.isedit}" />
	<input type="hidden" name="_pageCount" value='<s:property value="datas.pageCount"/>' />
	<s:hidden name="_isdiv" value="%{#parameters.isDiv}" />
	<s:hidden name="parentid" value="%{#parameters.parentid}" />
	<s:hidden name="currentDate" value="%{#parameters.currentDate}" />
	<s:hidden name="viewEvent" value="%{#parameters.viewEvent}" />
	<input type="hidden" name="_openType" value='<s:property value="content.openType"/>' />
	<s:hidden name="_fieldid" value="%{#parameters._fieldid}" />
<div id="right" style="background:none">
	<div class="crm_right">
	<%@include file="../../resource/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
        <div id="activityTable" style="position: fixed;z-index: 10;top: 0;left: 15px; right:15px; background-color: #fff;">
            <div class="searchDiv">
                <ul class=" nav-pills">
					<!-- 输出视图操作HTML -->
					<s:property value="#request.htmlBean.toActHtml()" escape="false"/>
					
					<s:hidden name="_viewid" />
					<s:hidden name="divid" value="%{#parameters.divid}" />
					<s:hidden name="_sortCol" />
					<s:hidden name="_orderby" />
					<s:hidden name="_sortStatus" />
					<!-- 查询按钮 -->
	                <s:if test="#request.htmlBean.showSearchForm">
	                <button type="button" class="btn btn-info " style="float:right;margin-right:15px;" onclick="isSearch();"><span class="glyphicon glyphicon-search" aria-hidden="true"></span></button>
	            	</s:if>
                </ul>
            </div>
        </div>
        <div id="mt" style="padding-top:10px;margin-top:56px;"></div>
	<!-- 是否显示查询表单 -->
	<s:if test="#request.htmlBean.showSearchForm">
	<div class="searchDiv" id="searchFormTable" style="margin-bottom:10px;">
	<!-- 要在BackURL传递的参数放在 searchFormTable-->
        <div class="container-fluid" style="margin-top:45px;">
        	<form>
				<!-- 输出查询表单HTML -->
				<s:property value="#request.htmlBean.toSearchFormHtml()" escape="false"/>
                <div class="row">
                    <div class="col-xs-12 text-center">
                        <button type="button" class="btn btn-primary" onclick="document.getElementsByName('_currpage')[0].value=1;document.forms[0].submit();">{*[Query]*}</button>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <button type="button" class="btn btn-default btn-reset" onclick="ev_resetAll()">{*[Reset]*}</button>
                    </div>
                </div>
            </form>
		</div>
	</div>
	</s:if>
	
	<div id="dataTable" class="dataTable" style="margin-bottom:0px;">
		<!-- 地图视图后台java输出HTML-->
		<% 
			out.print(htmlBean.toHTMLText4Map());
		%>
		
	</div>
	<!-- page navigate -->
	<s:if test="_isPagination == 'true' || _isShowTotalRow == 'true'">
	<div id="pageTable" class="front-scroll-hidden">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr class="page-nav"><td>
			<s:if test="_isShowTotalRow == 'true'">
				<td align="right">{*[TotalRows]*}:(<s:property value="totalRowText" />)</td>
			</s:if>
		</td></tr>
	</table>
	</div>
	</s:if>
	<!-- end of page navigate -->
	</div>
</div>
</s:form>

<%@ include file="/portal/H5/resource/common/include_view_js.jsp" %>
<script src='<o:Url value='/resource/component/view/obpm.mapView.js' />'></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/ViewHelper.js"/>'></script>

<script>
var contextPath = '<%= request.getContextPath()%>';
var operation = '<s:property value="%{#parameters.operation}" />';
var isedit = '';
var enbled='';
var openDownWinStr = '<s:property value="%{#request.excelFileName}"/>';
var selectStr = '{*[Select]*}';	//viewDoc() createDoc()
var typeName = '<s:property value="%{#request.message.typeName}" />';	//showPromptMsg()
var urlValue = '<s:url value="%{#request.ACTIVITY_INSTNACE.actionUrl}">'+
	'<s:param name="_activityid" value="%{#request.ACTIVITY_INSTNACE.id}" /></s:url>';	//showPromptMsg()

jQuery(window).resize(function(){
	mapViewAdjustLayout();	//调整视图布局
});

jQuery(function(){
	showLoading();	//在方法加载完之前锁定操作
	initMapComm();		//地图视图公用初始化方法
	mapViewAdjustLayout();	//调整视图布局
	adjustDataIteratorSize();	//调整数据迭代器大小
	
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
});
</script>
</body>
</html>
</o:MultiLanguage>