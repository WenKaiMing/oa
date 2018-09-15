<%@ page contentType="text/html; charset=UTF-8" errorPage="/portal/share/error.jsp"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.dynaform.view.html.MapViewHtmlBean"%>
<%@include file="/portal/share/common/lib.jsp"%>
<%
	//初始化HtmlBean
	MapViewHtmlBean htmlBean = new MapViewHtmlBean();
	htmlBean.setHttpRequest(request);
	htmlBean.setWebUser((WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER));
	request.setAttribute("htmlBean", htmlBean);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html style="height:100%;*overflow-x:hidden;">
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/portal/share/common/js_base.jsp"%>
<%@include file="/portal/share/common/js_component.jsp"%>
<link rel="stylesheet" href="<o:Url value='/resource/css/main-front.css'/>" type="text/css" />
<jsp:include page='/resource/css/style.jsp' flush="true">
	<jsp:param name="styleid" value="<%= htmlBean.getViewStyle()%>" />
</jsp:include>
<!-- View页面常用function,注意先后顺序,先common后view -->
<script type="text/javascript">
var contextPath = '<%= request.getContextPath()%>';
var operation = '<s:property value="%{#parameters.operation}" />';

var isedit = '';
var enbled='';

</script>
<script src='<s:url value='/portal/share/component/view/common.js' />'></script>
<script src='<s:url value='/portal/share/component/view/view.js' />'></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/ViewHelper.js"/>'></script>
<script>
function ev_onload() {
	/* 子文档为编辑模式时才显示activity */
	isedit = document.getElementById("isedit").value;
	if (isedit != 'null' && isedit != '') {
		if (isedit == 'true' || isedit) {
			activityTable.style.display = '';
		} else {
			activityTable.style.display = 'none';
		}
	} else {
		activityTable.style.display = '';
	}
	enbled = document.getElementById("isenbled").value;
	if (enbled != 'null' && enbled != '') {
		activityTable.style.display = 'none';
	}
}
function e_onload(){
	//ev_onload();
	var funName = '<s:property value="%{#request.message.typeName}" />';
	var url = '<s:url value="%{#request.ACTIVITY_INSTNACE.actionUrl}"><s:param name="_activityid" value="%{#request.ACTIVITY_INSTNACE.id}" /></s:url>';
	url = URLDecode(url);
	var msg = document.getElementsByName("message")[0].value;
	if (msg) {
		try{
			eval("do" + funName + "(msg , url);");
		} catch(ex) {
		}
	}
	
	ev_reloadParent();
	adjustViewLayout();
}

function adjustViewLayout(){
	var bodyH=jQuery("body").height();
	jQuery("#container").height(bodyH);
	jQuery("#container").width(jQuery("body").width());
	var activityTableH=jQuery("#activityTable").height();
	var searchFormTableH;
	if(jQuery("#searchFormTable").attr("id")=="searchFormTable"){
		searchFormTableH=jQuery("#searchFormTable").height()+18;/*20px is the padding height*/
	}else{
		searchFormTableH=0;
	}
	var pageTableH=jQuery("#pageTable").height();
	jQuery("#dataTable").height(bodyH-activityTableH-searchFormTableH-pageTableH);
}
function doPrint() {
	window.print();
}
</script>
<title>detail</title>
</head>
<body class="body-front front-scroll-hidden front-bgcolor1 front-margin1"  scroll="no">
<s:form id="formList" name="formList" action="displayView" method="post" theme="simple">
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
		<s:param name="_currpage" value="datas.pageNo"/>
	</s:url>
	
	<!-- 一些供javascript使用的参数 document.getElementById来获取 -->
	<s:hidden name="isedit" value="%{#parameters.isedit}" />
	<s:hidden name="isenbled" value="%{#parameters.isenbled}" />
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
	<input type="hidden" name="divid" value="<%=request.getParameter("divid")%>" />
	<s:hidden name="parentid" value="%{#parameters.parentid}" />
	<s:hidden name="currentDate" value="%{#parameters.currentDate}" />
	<s:hidden name="viewEvent" value="%{#parameters.viewEvent}" />
	<s:hidden name="content.openType" />
<div id="container" class="front-boder front-visibility-hidden front-scroll-hidden"  style="width:100%;height:100%">

	<div id="dataTable" class="front-scroll-auto front-border-top front-bgcolor2"  style="overflow: hidden">
		<table class="front-font-viewdata front-table-full-width">
		<!-- table-header -->
		<tr class="front-table-header table-tr">
			<td class="column-head">
			<s:property value="#request.htmlBean.mapColumnName" /></td>
		</tr>
		<!-- end of table-header -->
		
		<tr class="table-tr" onmouseover="this.className='table-tr-onchange';" onmouseout="this.className='table-tr';">
		<td width="100%" height="100%" style="margin:0px">
		
		<!-- 生成Baidu Map链接 -->
		<iframe src='<s:property value="#request.htmlBean.toBaiduMapUrl(datas)" />' style='width:100%;height:562px;' frameborder="0"></iframe>
		<div id="baiduMapData" style="display:none">
			<s:property value="#request.htmlBean.toLocationString(datas)" />
		</div>
		<div style="display:none">
			<s:iterator value="datas.datas" status="rowStatus">
				<s:set name="doc" id="doc" scope="page" />
				<s:if test="_isRefresh == 'true' && content.searchForm != null">
					<input id="<s:property value="id"/>" type="checkbox" name="_selects" value='<s:property value="id"/>'>
				</s:if> 
				<s:else>
					<input id="<s:property value="id"/>" type="checkbox" name="_selects" value='<s:property value="id"/>'>
				</s:else>
			</s:iterator>
		</div>
		</td>
		</tr>
		<!-- data iterator -->
		<!-- 字段值汇总 -->
		<s:if test="content.sum">
		<tr class="table-tr" onmouseover="this.className='table-tr-onchange';" onmouseout="this.className='table-tr';">
			<s:iterator value="content.columns" status="rowStatus">
				<s:if test="visible && !isHiddenColumn(#request.htmlBean.runner)">
					<td class="column-td">
						<s:if test="isSum() || isTotal()" >
							<s:property value="name" />:
						</s:if>
						<s:if test="isSum()">
							<s:property value="getSumByDatas(datas, #request.htmlBean.runner, #session.FRONT_USER)" />&nbsp;
						</s:if>
						<s:if test="isTotal()">
							<s:property value="getSumTotal(#session.FRONT_USER, #session.FRONT_USER.domainid)" />&nbsp;
						</s:if>
					</td>
				</s:if>
			</s:iterator>
		</tr>
		</s:if>
		</table>
	</div>

</div>
</s:form>

</body>

<script lanaguage="javaScript">
	function createDoc(activityid) {
		// 查看/script/view.js
		var action = activityAction + "?_activityid=" + activityid
		openWindowByType(action,'{*[Select]*}', VIEW_TYPE_NORMAL); 
	}
	
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

function on_unload() {
	ev_reloadParent();
}
</script>
<script src='<s:url value="/portal/share/component/dateField/datePicker/WdatePicker.js" />' ></script>
<script>
adjustDataIteratorSize();
</script>
</o:MultiLanguage>
</html>