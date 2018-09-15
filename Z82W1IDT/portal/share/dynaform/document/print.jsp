<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" errorPage="/portal/share/error.jsp"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@ page import="cn.myapps.core.dynaform.activity.ejb.*"%>
<%@ page import="cn.myapps.core.dynaform.document.ejb.Document"%>
<%@ page import="cn.myapps.core.dynaform.document.html.DocumentHtmlBean"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.workflow.engine.StateMachineHelper"%>
<%@page import="cn.myapps.core.dynaform.document.action.DocumentHelper"%>
<s:bean name="cn.myapps.core.privilege.operation.action.OperationHelper" id="oh" />

<%
	boolean isEdit = true;
	String contextPath = request.getContextPath();
	
	Document doc = (Document) request.getAttribute("content");
	WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	String _templateForm = request.getParameter("_templateForm");
	
	DocumentHtmlBean dochtmlBean = new DocumentHtmlBean();
	dochtmlBean.setHttpRequest(request);
	dochtmlBean.setHttpResponse(response);
	dochtmlBean.setWebUser((WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER));
    request.setAttribute("dochtmlBean", dochtmlBean);
    //use in signatureobject.jsp
    String mDoCommandUrl=dochtmlBean.getMDoCommandUrl();
    isEdit=dochtmlBean.isEditCurrDoc();
    //dochtmlBean.isOpenAble();
%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<o:Url value='/resource/css/main-front.css'/>"/>
<link rel="stylesheet" href="<o:Url value='/css/common.css'/>"/><!--蓝色皮肤样式-->
<link rel="stylesheet" href="<s:url value='/portal/share/css/print.css'/>" type="text/css" />
<jsp:include page='../../script/bootstrap/css/styleLib.jsp' flush="true">
	<jsp:param name="styleid" value="<%= dochtmlBean.getStyleRepositoryId()%>" />
</jsp:include>
<script type="text/javascript">
var contextPath = '<%= request.getContextPath() %>';
var queryString = "<%= request.getQueryString() %>";
var typeName = '<s:property value="%{#request.message.typeName}" />';	//showPromptMsg()
OBPM(document).ready(function(){
	jQuery("div[moduleType='flowHistoryField']").obpmFlowHistoryField();//渲染流程历史控件
	loadPedding();	//待办
	jQuery("input[moduleType='qrcodefield']").obpmQRCodeField();//二维码控件
	// 电子签章判断
	if(document_content.SignatureControl!=null){
		document_content.SignatureControl.ShowSignature('<s:property value="content.id" />');
	} else {}

	showPromptMsg();
	$("#contentTable").find(".isignature-box").Isignature();
});

function doPrint() {
	window.print();
}

function doPageSet(){ 
	WB.ExecWB(8,1) 
} 

function doPreview(){ 
	WB.ExecWB(7,1) 
} 

/**
 * 显示提示信息
 */
function showPromptMsg(){
	var funName = typeName;
	var msg = document.getElementsByName("message")[0].value;
	if (msg) {
		eval("do" + funName + "(msg);");
	}
}

function doAlert(msg){
	alert(msg);
}

var _zoom = 100

function doPageZoomIn(){
	_zoom = _zoom + 10
	if(_zoom > 100){
		_zoom = 100
	}
	$("table#toAll").width(_zoom+"%");
}

function doPageZoomOut(){
	_zoom = _zoom - 10
	if(_zoom < 10){
		_zoom = 10
	}
	$("table#toAll").width(_zoom+"%");
}
</script>
</head>
<body style="padding: 0;margin: 0;">
<div id="doc_divid" class="front-align-top">
<!-- 影响Word控件样式"front-visibility-hidden" class="front-scroll-hidden front-boder front-visibility-hidden" -->
<s:form name='document_content' action="save" method="post" theme="simple">

<table width="100%" border="1" cellspacing="0" cellpadding="0" id="oLayer">
	<tr valign='top'>
		<td>
		<table width="100%" border=0 cellpadding="0" cellspacing="5">
			<tr>
				<td class="line-position" width="100%">&nbsp;</td>		
				<td align="right">
				<input id="button_zoomin" type="button" alt="放大" value="放大" onclick="doPageZoomIn()" style="background:#e5edf8;color: #1268a5;border: 1px solid #b4ccee;padding: 6px 10px;margin: 10px;cursor: pointer;"/>
				</td><td align="right">
				<input id="button_zoomout " type="button" alt="缩小" value="缩小" onclick="doPageZoomOut()" style="background:#e5edf8;color: #1268a5;border: 1px solid #b4ccee;padding: 6px 10px;margin: 10px;cursor: pointer;"/>		
				</td>			
				<td align="right"><input id="button_act" type="button" alt="print" value="{*[Print]*}" onclick="doPrint()" style="background:#e5edf8;color: #1268a5;border: 1px solid #b4ccee;padding: 6px 10px;margin: 10px;cursor: pointer;"/></td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<div id="container" style="width: 100%;">
	<div id="install" style="display:none">
	     <a id="hreftest" href="<s:url value='/portal/share/component/signature/iSignatureHTML.zip'/>"><font color="red"><b>&nbsp;&nbsp;&nbsp;点击下载金格iSignature电子签章HTML版软件</b></font></a> 
	</div>
	<!-- 电子签章 -->
	<s:if test="#request.dochtmlBean.isSignatureExist()">
		<%@include file="/portal/share/dynaform/document/printSignatureobject.jsp"%>
	</s:if>
	<!-- 打印效果输出 -->
	<div id="contentTable" style="border-right: 0px;border-left: 0px;">
		<table width="100%" border="0" id="toAll" style="position:relative;z-index:1;">
			<tr>
				<td width="100%" valign="top" colspan="2" style="border:0px">
				<%
					if(_templateForm != null && _templateForm.trim().length() > 0){
						out.print(dochtmlBean.getTemplateFormPrintHTML());
					}else{
						out.print(dochtmlBean.getFormPrintHTML());
					}
				%>
				<div class="isignature-box"></div>
				</td>
			</tr>
			<s:if test="#parameters._flowid[0] != null && #parameters._flowid[0] != ''">
				<tr valign='top'>
					<td width="5%" style="commFont">
						{*[Approve]*}{*[History]*}:
					</td>
					<td width="90%">
						<%=StateMachineHelper.toHistoryHtml(doc, 4)%>
					</td>
				</tr>
			</s:if>
		</table>
	</div>
	
	<%@include file="/common/page.jsp"%>
	<s:token name="document.token" />
	<s:hidden name="content.applicationid" />
	<s:if test="#parameters._viewid != null">
		<s:hidden id="_viewid" name="view_id" value="%{#parameters._viewid}" />
		<s:hidden id="view_id" name="view_id" value="%{#parameters._viewid}" />
	</s:if>
	<s:else>
		<input type="hidden" id="view_id" name="view_id" value='<s:property value="params.getParameterAsArray('view_id')[0]" />' />
	</s:else>

	<!-- 隐藏属性 -->
	<s:hidden name="signatureExist" id="signatureExist" value="%{#request.dochtmlBean.isSignatureExist()}"></s:hidden>
	<s:hidden name="formid" id="formid" value="%{#parameters._formid}"></s:hidden>
	<s:hidden name="applicationid" id="applicationid" value="%{#request.content.applicationid}"></s:hidden>
	<s:hidden name="mGetDocumentUrl" id="mGetDocumentUrl" value="%{#request.dochtmlBean.getMGetDocumentUrl()}"></s:hidden>
	<s:hidden name="mLoginname" id="mLoginname" value="%{#session.USER.loginno}"></s:hidden>
	<s:textarea name="message" value="%{#request.message.content}"	cssStyle="display:none" />
	<s:if test="#parameters._docid!=null && #parameters._docid!=''">
		<s:hidden name="_docid" id="_docid" value="%{#parameters._docid}" />
	</s:if>
	<s:else>
		<s:hidden name="_docid" id="_docid" value="%{#request.content.id}" />
	</s:else>
	<s:hidden name="_formid" id="_formid" value="%{#parameters._formid}" />
	<s:hidden name="domainid" value="%{#parameters.domain}" />
	
	<s:hidden name="parentid" value="%{#parameters.parentid}" />
	<s:hidden name="_templateForm" value="%{#parameters._templateForm}" />
	<s:hidden name="content.sign" />
</div>
</s:form>
</div>
<OBJECT classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 height=0 id=WB width=0></object>
</body>
</html>
</o:MultiLanguage>