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
<html style="height:100%;">
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/portal/share/common/js_base.jsp" %>
<%@include file="/portal/share/common/js_component.jsp" %>
<jsp:include page='../../../resource/document/style.jsp' flush="true">
	<jsp:param name="styleid" value="<%= htmlBean.getViewStyle()%>" />
</jsp:include>
<script src='<o:Url value="/resource/document/obpm.ui.js"/>'></script>
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

//包含元素包含视图时调整iframe高度
function ev_resize4IncludeViewPar(){
	var divid = document.getElementsByName("divid")[0].value;
	var _viewid = document.getElementsByName("_viewid")[0].value;
	ev_resize4IncludeView(divid,_viewid,'MAPVIEW');
}

jQuery(document).ready(function(){
	jQuery("[moduleType='activityButton']").obpmButton(); //重构操作按钮
	ev_resize4IncludeViewPar();
	e_onload();
});
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
	var bodyH = document.body.clientHeight;
	jQuery("#container").height(bodyH);
	//jQuery("#container").width(jQuery("body").width());
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

openDownloadWindow('<s:property value="%{#request.excelFileName}"/>');
</script>
<title>detail</title>
</head>
<body class="body-front front-scroll-hidden front-bgcolor1 front-margin1" style="height:100%;">
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
								<span class="button-cmd"><a href="#" onclick="document.getElementsByName('_currpage')[0].value=1;document.forms[0].submit();"><span><img align="middle" src="<o:Url value='/resource/imgv2/front/main/query.gif' />">{*[Query]*}</span></a></span>
							</td>
						</tr>
						<!--<tr>
							<td >
								<span class="button-cmd"><a href="#" onclick="ev_resetAll()"><span><img align="middle" src="<o:Url value='/resource/imgv2/front/main/reset.gif' />">{*[Reset]*}</span></a></span>
							</td>
						</tr>-->
					</table>
				</td>
				</s:if>
			</tr>
		</table>
	</div>
	</s:if>
	
	<div id="dataTable" class="front-scroll-auto front-border-top front-bgcolor2"  style="overflow: hidden">
		<table class="front-font-viewdata front-table-full-width">
		<!-- table-header -->
		<tr class="front-table-header table-tr">
			<td class="column-head">
			<s:if test="_isRefresh == 'true' && content.searchForm != null">
					<input type="checkbox" onclick="selectAll(this.checked);">
			</s:if> 
			<s:else>
				<input type="checkbox" onclick="selectAll(this.checked)">
			</s:else>
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
				<td class="table-td">
					&nbsp;
				</td>
			<s:iterator value="content.columns" status="rowStatus">
				<s:if test="isVisible() && !isHiddenColumn(#request.htmlBean.runner)">
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

<script lanaguage="javaScript">
	function createDoc(activityid) {
		// 查看/script/view.js
		var action = activityAction + "?_activityid=" + activityid
		openWindowByType(action,'{*[Select]*}', VIEW_TYPE_NORMAL,activityid); 
	}
	
	function viewDoc(docid, formid ,signatureExist,templateForm) {
		// 查看/script/view.js
		var url = docviewAction;
		url += '?_docid=' + docid;
		if (formid) {
			url += '&_formid=' +  formid;
		}
		if (templateForm) {
			url += '&_templateForm=' +  templateForm;
		}
		if(signatureExist){
			url += '&signatureExist=' +  signatureExist;
		}
		
		openWindowByType(url,'{*[Select]*}', VIEW_TYPE_NORMAL); 
	}

jQuery(window).resize(function(){
  e_onload();
});

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