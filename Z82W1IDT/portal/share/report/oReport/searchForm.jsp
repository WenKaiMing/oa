<%@ page contentType="text/html; charset=UTF-8" errorPage="/portal/share/error.jsp" %>
<%@ include file="/portal/share/common/head.jsp"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.dynaform.view.html.ViewHtmlBean"%>
<%@include file="/portal/share/common/lib.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
	
	//初始化HtmlBean
	ViewHtmlBean htmlBean = new ViewHtmlBean();
	htmlBean.setHttpRequest(request);
	htmlBean.setWebUser((WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER));
	request.setAttribute("htmlBean", htmlBean);
%>


<%@page import="cn.myapps.core.dynaform.document.ejb.Document"%>
<html oncontextmenu="return false">
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<s:url value='/resource/css/main-front.css'/>" type="text/css" />
<link rel="stylesheet" href="<s:url value='/resource/css/dialog.css'/>" type="text/css"  media="all" />
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/ViewHelper.js"/>'></script>
<%@include file="/portal/share/common/js_base.jsp"%>
<%@include file="/portal/share/common/js_component.jsp"%>
<!-- View页面常用function,注意先后顺序,先common后view -->
<script type="text/javascript">
var contextPath = '<%= request.getContextPath()%>' ;
var isedit = '';
var enbled='';
</script>
<script src='<s:url value='/portal/share/component/view/common.js' />'></script>
<script src='<s:url value='/portal/share/component/view/view.js' />'></script>
<script src='<s:url value="/portal/dwz/resource/document/obpm.ui.js"/>'></script>
<script src='<s:url value="/portal/share/script/document/document.js"/>'></script>
<title>list column by view</title>
<script>
function doCancel(){
    parent.document.oReport.cancelSearchFormDialog();
}

function doQuery(){
    parent.document.oReport.querySearchFormDialog(dy_getValuesMap(false));
}
</script>

<script type="text/javascript">
jQuery(document).ready(function(){
	//表单控件jquery重构
	jqRefactor();
});
	window.onload = function(){
		var isIE=navigator.userAgent.toUpperCase().indexOf("MSIE")==-1?false:true;
		if(!isIE){
			for(var i=0;i<10;i++){
				var divId = "searchFormIFrame"+i;
				var iframeId = "iframe_searchFormIFrame"+i;
				var div = parent.document.getElementById(divId);
				var iframe = parent.document.getElementById(iframeId);
				var detailIframeH = 0;
				var detailIframeW = 0;
				var detailIframe = parent.parent.document.getElementById("detail");
				if(detailIframe!=null){
					detailIframeH = detailIframe.offsetHeight;
					detailIframeW = detailIframe.offsetWidth;
				}else{
					detailIframeH = parent.document.body.offsetHeight;
					detailIframeW = parent.document.body.offsetWidth;
				}
				if(div != null && iframe != null){
					var divLeft = (detailIframeW-746)/2 + 13;
					var divTop = (detailIframeH-340)/2 + 33;
					iframe.style.width = "100%";
					iframe.style.height = "100%";
					div.style.width = 720+"px";
					div.style.height = 295+"px";
					div.style.left = divLeft+"px";
					div.style.top = divTop+"px";
				}
			}
		}
	}
</script> 

</head>
<body>
<div id="dspview_divid" style="width:99%;" width="99%">
<s:form id="formList" name="formList" action="subFormView" method="post" theme="simple">
	<%@include file="/common/list.jsp"%>
	<s:url id="backURL" action="subFormView" >
		<s:param name="_viewid" value="#parameters._viewid" />
		<s:param name="parentid" value="#parameters.parentid" />
		<s:param name="_currpage" value="datas.pageNo"/>
		<s:param name="isSubDoc" value="true"/>
		<s:param name="isRelate" value="#parameters.isRelate"/>
	</s:url>
	<s:textarea name="message" value="%{#request.message.content}" cssStyle="display:none" />
	<input type="hidden" name="_backURL" value="<%=request.getAttribute("backURL") %>" />
	<div id="closeWindow_DIV" class="black_overlay"></div>
	<s:hidden name="isedit" value="%{#parameters.isedit}" />
	<input type="hidden" name="divid" value="<%=request.getParameter("divid")%>" />
	<s:hidden name="parentid" value="%{#parameters.parentid}" />
	<s:hidden name="content.openType" />
	
	<%@include file="/portal/share/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<s:hidden name="isRelate" value="%{#parameters.isRelate}" />
	<table class="display_view-table" id="acttable" border="0" cellpadding="0" cellspacing="0" width="100%">
		<s:hidden name="_viewid" />
		<s:hidden name="_sortCol" />
		<s:hidden name="_orderby" />
		<s:hidden name="_sortStatus" />
		<s:hidden name="_isSubDoc" value="true" />
		
		<tr>
			<td align="center" id="_formHtml">
			<!-- 是否显示查询表单 -->
			<s:if test="#request.htmlBean.showSearchForm">
				<!-- 输出查询表单HTML -->
				<s:property value="#request.htmlBean.toSearchFormHtml()" escape="false"/>
			</s:if>
			<s:else>
				<br/><br/>{*[none]*}{*[SearchForm]*}<br/><br/>
			</s:else>
			</td>
		</tr>
		<tr>
		<td  align="center">
			<!-- 是否显示查询表单按钮 -->
			<table>
				<tr>
			<s:if test="#request.htmlBean.showSearchFormButton">
				
				<td nowrap="nowrap" style="background-color:#ddd;">
					<span class="button-cmd"><a href="###" onClick="doQuery()"><span><img align="middle" src="<s:url value='/resource/imgv2/front/main/query.gif' />">{*[Query]*}</span></a></span>
				</td>
				
			</s:if>
			<td nowrap="nowrap" style="background-color:#ddd;">
				<span class="button-cmd"><a href="###" onClick="doCancel()"><span><img align="middle" src="<s:url value='/resource/imgv2/front/main/reset.gif' />">{*[Cancel]*}</span></a></span>
			</td>
			</tr>
				</table>
			</td>
		</tr>
	</table>
</s:form></div>

</body>
<script>
//jQuery(window).resize(function(){
//	ev_onload();
//});

document.ondblclick=handleDbClick; 

function on_unload() {
	ev_reloadParent();
}

function handleDbClick() {
if(event.srcElement.onclick){
}else if(event.srcElement.type!=null&&(event.srcElement.type.toUpperCase()=='SUBMIT'
||event.srcElement.type.toUpperCase()=='BUTTON'
||event.srcElement.type.toUpperCase()=='CHECKBOX'
||event.srcElement.type.toUpperCase()=='RADIO'
||event.srcElement.type.toUpperCase()=='SELECT'
||event.srcElement.type.toUpperCase()=='IMG'))
{
  
}
else{
	zoompage();
}
}

function zoompage() {
 	var typeflage = typeof(dialogArguments);
 	if(typeflage != 'undefined' ) {    
    	
    } else if(window.opener) {
    	
    } else {
   
        window.top.IsResize();
    } 
    // ev_onload();
}
</script>
<script src='<s:url value="/portal/share/component/dateField/datePicker/WdatePicker.js" />' ></script>

</o:MultiLanguage></html>
