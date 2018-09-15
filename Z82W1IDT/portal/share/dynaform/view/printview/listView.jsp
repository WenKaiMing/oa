<%@ page contentType="text/html; charset=UTF-8" errorPage="/portal/share/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.dynaform.view.html.ViewHtmlBean"%>
<%@include file="/portal/share/common/lib.jsp"%>

<%
   	// 初始化HtmlBean
	ViewHtmlBean htmlBean = new ViewHtmlBean();
    htmlBean.setHttpRequest(request);
    WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	if("true".equals(request.getAttribute("_isPreview"))){
		webUser = (WebUser)session.getAttribute(Web.SESSION_ATTRIBUTE_PREVIEW_USER);
	}
    htmlBean.setWebUser(webUser);
    request.setAttribute("htmlBean", htmlBean);
%>


<%@page import="cn.myapps.core.dynaform.document.ejb.Document"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html style="height:100%;">
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/portal/share/common/js_base.jsp" %>
<%@include file="/portal/share/common/js_component.jsp" %>
<link rel="stylesheet" href="<s:url value='/portal/share/css/print.css'/>" type="text/css" />
<link rel="stylesheet" href="<s:url value='/portal/share/css/viewPrint.css'/>" type="text/css" />
<!-- 视图样式 -->
<link rel="stylesheet" href='<o:Url value="/dynaform/view/css/listView.css"/>' type="text/css" />
<!-- 样式库样式 -->
<jsp:include page='../../../../cool/resource/css/styleLib.jsp' flush="true">
	<jsp:param name="styleid" value="<%= htmlBean.getViewStyle()%>" />
</jsp:include>
	<!-- View页面常用function,注意先后顺序,先common后view 22-->
<script src='<o:Url value="/resource/document/obpm.ui.js"/>'></script>
<script src='<s:url value='/portal/share/component/view/common.js' />'></script>
<script src='<s:url value='/portal/share/component/view/view.js' />'></script>
<script src='<s:url value='/portal/share/component/view/obpm.listView.js' />'></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/ViewHelper.js"/>'></script>
<script src='<s:url value="/portal/share/component/dateField/datePicker/WdatePicker.js" />' ></script>
<!-- 图片滑动控件样式 -->
	<link rel="stylesheet" href="<s:url value='/portal/share/css/slider.css' />" type="text/css" />
<style>
.btnCls {
	background:#e5edf8;
	color: #1268a5;
	border: 1px solid #b4ccee;
	padding: 6px 10px;
	margin: 10px;
	cursor: pointer;
}
</style>
<script>
var contextPath = '<%= request.getContextPath()%>';
var operation = '<s:property value="%{#parameters.operation}" />';
var isOpenAbleScriptShow = '{*[page.core.dynaform.forddin]*}';	//judgeOperating()
var isedit = '';
var enbled='';
var isprint='<s:property value="%{#parameters.isprint}" />';
var typeName= '<s:property value="%{#request.message.typeName}" />';	//showPromptMsg()
var urlValue= '<s:url value="%{#request.ACTIVITY_INSTNACE.actionUrl}"><s:param name="_activityid" value="%{#request.ACTIVITY_INSTNACE.id}" /></s:url>';	//showPromptMsg()
var selectStr = '{*[Select]*}';	//createDoc(),viewDoc
var someInformation= '{*[cn.myapps.core.workflow.input_audit_remark]*}';	//on_doflow
var okMessage = '{*[OK]*}';	//on_doflow()
var cancelMessage = '{*[Cancel]*}';	//on_doflow()
var openDownWinStr = '<s:property value="%{#request.excelFileName}"/>';	//openDownloadWindow()
var totalRows = '<s:property value="totalRowText" />';  //refreshMenuTotalRows()

	//回选列表数据
	function selectData4Doc(){
		var checkboxs = document.getElementsByName("_selects");
		<s:iterator value="_selects">
			for (var i=0; i<checkboxs.length; i++) {
				var checkedId = '<s:property />';
				if (checkboxs[i].value == checkedId) {
					checkboxs[i].checked = true;
				}
			}
		</s:iterator>
	}
	
	jQuery(window).resize(function(){
		listViewAdjustLayout();
	});

	jQuery(document).ready(function(){
		dy_lock();	//在方法加载完之前锁定操作
		initListComm();	//列表视图公用初始化方法
		adjustDataIteratorSize();
		setTimeout(function(){
			listViewAdjustLayout();
		},10);	//调整当前窗口布局
		dy_unlock();	//方法加载完之后解锁操作
		setTimeout(function(){
			$("#dataTable").height($(window).height()-$("#oLayer").height()-15);
			$("table#dataTable").css("table-layout", "auto")
		},100);	//调整大印窗口的内容高度
		
	});
	var _zoom = 100
	
	function doPageZoomIn(){
		_zoom = _zoom + 10
		if(_zoom > 100){
			_zoom = 100
		}
		$("table#dataTable").width(_zoom+"%");
	}

	function doPageZoomOut(){
		_zoom = _zoom - 10
		if(_zoom < 10){
			_zoom = 10
		}
		$("table#dataTable").width(_zoom+"%");
	}
	function doPrint() {
		window.print();
	}
</script>
<title>ListView</title>
</head>
<body class="body-front" style="height:100%;overflow-x:auto;overflow-y:hidden;">
<!-- 遮挡层 -->
<div id="loadingDivBack" style="position: absolute; z-index: 50; width: 100%; height: 100%; top: 0px; left: 0px; background-color:#ccc; filter: alpha(opacity = 0.1); opacity: 0.1;">
	<div style="position: absolute;top: 35%;left: 45%;width: 128px;height: 128px;z-index: 100;">
		<img src="<o:Url value='/resource/main/images/loading1.gif'/>"/>
	</div>
</div>
<s:form id="formList" name="formList" action="displayView" method="post" theme="simple">
	<table width="100%" border="1" cellspacing="0" cellpadding="0" id="oLayer">
		<tr valign='top'>
			<td>
			<table width="100%" border=0 cellpadding="0" cellspacing="5">
				<tr>
					<td class="line-position" width="100%">&nbsp;</td>		
					<td align="right">
					<input id="button_zoomin" class="btnCls" type="button" alt="放大" value="放大" onclick="doPageZoomIn()"/>
					</td><td align="right">
					<input id="button_zoomout" class="btnCls" type="button" alt="缩小" value="缩小" onclick="doPageZoomOut()"/>		
					</td>	
					<td align="right"><input id="button_act" class="btnCls" type="button"
						class="button-document" alt="print" value="{*[Print]*}"
						onclick="doPrint()" /></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
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
		<s:param name="_currpage" value="datas.pageNo"/>
		<s:param name="parentid" value="#parameters.parentid" />
		<s:param name="treedocid" value="#parameters.treedocid" />
		<s:param name="isinner" value="#parameters.isinner" />
		<s:param name="_resourceid" value="#parameters._resourceid" />
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
	<s:set name="sinfo" value="#request.htmlBean.getSignatureInfo(datas)"/>
	<s:hidden name="FormID" id="FormID" value="%{#sinfo.FormID}" ></s:hidden>
	<s:hidden name="ApplicationID" id="ApplicationID" value="%{#sinfo.ApplicationID}" ></s:hidden>
	<s:hidden name="DocumentID" id="DocumentID" value="%{#sinfo.DocumentID}" ></s:hidden>
	<s:hidden name="mGetBatchDocumentUrl" id="mGetBatchDocumentUrl" value="%{#sinfo.mGetBatchDocumentUrl}" ></s:hidden>
	<s:hidden name="mLoginname" id="mLoginname" value="%{#session.FRONT_USER.loginno}"></s:hidden>
	
	<s:textarea name="message" value="%{#request.message.content}" cssStyle="display:none" />
	<input type="hidden" name="_backURL" value="<%=request.getAttribute("backURL") %>" />
	<!-- <s:hidden name="isedit" value="%{#parameters.isedit}" /> -->
	<input type="hidden" name="_pageCount" value='<s:property value="datas.pageCount"/>' />
	<s:hidden name="_isdiv" value="%{#parameters.isDiv}" />
	<input type="hidden" name="divid" value="{#parameters.divid}" />
	<s:hidden name="tabid" id="tabid" value=""/>
	<s:hidden name="currentDate" value="%{#parameters.currentDate}" />
	<s:hidden name="viewEvent" value="%{#parameters.viewEvent}" />
	<input type="hidden" name="_openType" value='<s:property value="content.openType"/>' />
	<s:hidden name="_fieldid" value="%{#parameters._fieldid}" />
	<!-- 父表单ID参数 -->
	<s:hidden name="parentid" value="%{#parameters.parentid}" />
	<!-- 树形视图参数 -->
	<s:hidden id="treedocid" name="treedocid" value="%{#parameters.treedocid}" />
	<!-- 内嵌视图参数 -->
	<s:hidden id="isinner" name="isinner" value="%{#parameters.isinner}" />
<div id="container" class="front-visibility-hidden front-scroll-hidden"  style="width:100%;">
	<%@include file="/portal/share/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div id="activityTable" class="front-border-bottom" style="width:100%;">
	</div>
	
	
	<!-- 数据表格 -->
	<div id="dataTable" class="front-scroll-auto front-bgcolor2" style="width:100%;">
		<textarea id='_remark' type='text' style='display:none;' name='_remark'></textarea>
		<div id='doFlowRemarkDiv' style='display:none;width:280px;' title='{*[cn.myapps.core.dynaform.view.input_audit_remark]*}'>
		<textarea id='temp_remark' rows='12' cols='35' name='temp_remark' style='width:97%;'></textarea></div>
		<%
		out.print(htmlBean.toHTMLText());
		%>
	</div>
</div>
</s:form>
</body>
</o:MultiLanguage>
</html>
