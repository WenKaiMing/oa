<%@ page contentType="text/html; charset=UTF-8" errorPage="/portal/share/error.jsp"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html style="height:100%;">
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/portal/share/common/js_base.jsp" %>
<%@include file="/portal/share/common/js_component.jsp" %>
<!-- 视图样式 -->
<link rel="stylesheet" href='<o:Url value="/dynaform/view/css/mapView.css"/>' type="text/css" />
<!-- 样式库样式 -->
<jsp:include page='../../resource/css/styleLib.jsp' flush="true">
	<jsp:param name="styleid" value="<%= htmlBean.getViewStyle()%>" />
</jsp:include>
<script src='<o:Url value="/resource/document/obpm.ui.js"/>'></script>
<!-- View页面常用function,注意先后顺序,先common后view -->
<script src='<s:url value='/portal/share/component/view/common.js' />'></script>
<script src='<s:url value='/portal/share/component/view/view.js' />'></script>
<script src='<s:url value='/portal/share/component/view/obpm.mapView.js' />'></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/ViewHelper.js"/>'></script>
<script src='<s:url value="/portal/share/component/dateField/datePicker/WdatePicker.js" />' ></script>

<script type="text/javascript">
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

jQuery(document).ready(function(){
	dy_lock();	//在方法加载完之前锁定操作
	initMapComm();		//地图视图公用初始化方法
	mapViewAdjustLayout();	//调整视图布局
	adjustDataIteratorSize();	//调整数据迭代器大小
	dy_unlock();	//方法加载完之后解锁操作
});
</script>
<title>{*[cn.myapps.core.dynaform.view.map_view]*}</title>
</head>
<body class="body-front front-scroll-hidden front-bgcolor1 front-margin1" style="height:100%;">
<!-- 遮挡层 -->
<div id="loadingDivBack" style="position: absolute; z-index: 50; width: 100%; height: 100%; top: 0px; left: 0px; background-color:#ccc; filter: alpha(opacity = 0.1); opacity: 0.1;">
	<div style="position: absolute;top: 35%;left: 45%;width: 128px;height: 128px;z-index: 100;">
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
<div id="container" class="front-boder front-visibility-hidden front-scroll-hidden"  style="height:100%;width:100%\9;">
	<%@include file="/portal/share/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div id="activityTable" class="front-border-bottom">
		<table class="front-table-act front-table-full-width">
			<tr valign="middle">
			<td>
			<!-- 输出视图操作HTML -->
			<s:property value="#request.htmlBean.toActHtml()" escape="false"/>
			
			<s:hidden name="_viewid" />
			<s:hidden name="divid" value="%{#parameters.divid}" />
			<s:hidden name="_sortCol" />
			<s:hidden name="_orderby" />
			<s:hidden name="_sortStatus" />
			</td>
			</tr>
			</table>	
	</div>
	
	<!-- 是否显示查询表单 -->
	<s:if test="#request.htmlBean.showSearchForm">
	<!-- 要在BackURL传递的参数放在 searchFormTable-->
	<div id="searchFormTable" class="front-scroll-hidden front-bgcolor2" style="width100%;padding: 10px;">
		<table class="front-table-full-width">
			<tr>
				<td>
				<!-- 输出查询表单HTML -->
				<s:property value="#request.htmlBean.toSearchFormHtml()" escape="false"/>
				</td>
				
				<!-- 是否显示查询表单按钮 -->
				<s:if test="#request.htmlBean.showSearchFormButton">
				<td style="width:150px;">
					<table>
						<tr>
							<td >
								<span class="button-cmd">
									<a href="#" onclick="document.getElementsByName('_currpage')[0].value=1;document.forms[0].submit();">
										<span>
											<img align="middle" src="<o:Url value='/resource/document/query.gif' />">{*[Query]*}
										</span>
									</a>
								</span>
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
	
	<div id="dataTable" class="front-scroll-auto front-border-top front-bgcolor2"  style="overflow: hidden">
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
</s:form>

</body>
</o:MultiLanguage>
</html>