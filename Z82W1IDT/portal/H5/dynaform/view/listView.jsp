<%@page import="cn.myapps.util.StringUtil"%>
<%@ page contentType="text/html; charset=UTF-8" errorPage="/portal/share/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.dynaform.view.ejb.View"%>
<%@ page import="cn.myapps.core.dynaform.view.html.ViewHtmlBean"%>
<%@ page import="cn.myapps.core.dynaform.document.ejb.Document"%>
<%@ include file="/portal/share/common/lib.jsp"%>
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
<meta charset="UTF-8">

<%@ include file="/portal/H5/resource/common/include_view_css.jsp" %>
<!-- 样式库样式 -->
<jsp:include page='../../resource/css/styleLib.jsp' flush="true">
	<jsp:param name="styleid" value="<%= htmlBean.getViewStyle()%>" />
</jsp:include>
<title><%=(StringUtil.isBlank(htmlBean.getView().getDescription())? htmlBean.getView().getName():htmlBean.getView().getDescription())%></title>
</head>
<body  class="bgcolor-white">
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
<%if(htmlBean.isSignatureExist()) {%>
	<%@include file="/portal/share/dynaform/view/batchSignatureObject.jsp"%>
<%}%>

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
<s:hidden name="signatureExist" id="signatureExist" value="%{#request.htmlBean.isSignatureExist()}"></s:hidden>
<s:set name="sinfo" value="#request.htmlBean.getSignatureInfo(datas)"/>
<s:hidden name="FormID" id="FormID" value="%{#sinfo.FormID}" ></s:hidden>
<s:hidden name="ApplicationID" id="ApplicationID" value="%{#sinfo.ApplicationID}" ></s:hidden>
<s:hidden name="DocumentID" id="DocumentID" value="%{#sinfo.DocumentID}" ></s:hidden>
<s:hidden name="mGetBatchDocumentUrl" id="mGetBatchDocumentUrl" value="%{#sinfo.mGetBatchDocumentUrl}" ></s:hidden>
<s:hidden name="mLoginname" id="mLoginname" value="%{#session.FRONT_USER.loginno}"></s:hidden>
<s:textarea name="message" value="%{#request.message.content}" cssStyle="display:none" />
<input type="hidden" name="_backURL" value="<%=request.getAttribute("backURL") %>" />
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

<div id="container">
	<%@include file="../../resource/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
		<%@include file="/portal/share/common/msgbox/msg.jsp"%>
	</s:if>
	<div id="activityTable">
		<s:property value="#request.htmlBean.toActHtml()" escape="false"/>	
		<s:hidden id="viewid" name="_viewid" />
		<s:hidden name="_sortCol" />
		<s:hidden name="_orderby" />
		<s:hidden name="_sortStatus" />
		<!-- 查询按钮 -->
		<s:if test="#request.htmlBean.showSearchForm">
		<div class="search-active-panel form-inline pull-right searchBtn">
			<div class="form-group search-btns"></div>
		</div>
		
		</s:if>
	</div>
       
	<div class="contentPanel">
		<!-- 是否显示查询表单 -->
		<s:if test="#request.htmlBean.showSearchForm">
		<!-- 要在BackURL传递的参数放在 searchFormTable-->
		<div class="searchDiv" id="searchFormTable" style="display:none;">
			<!-- 输出查询表单HTML -->
			<s:property value="#request.htmlBean.toSearchFormHtml()" escape="false"/>
			<div class="row">
			    <div class="col-xs-12 text-center">
			        <button type="button" class="btn btn-primary" onclick="modifyActionBack();">{*[Query]*}</button>
					<button type="button" class="btn btn-default btn-reset" onclick="ev_resetAll()">{*[Reset]*}</button>
				</div>
			</div>
		</div>
		</s:if>
		
		<!-- 数据表格 -->
    <div id="dataTable-box">
    
    
    
    
		<div class="dataTable text-center">
			<textarea id='_remark' type='text' style='display:none;' name='_remark'></textarea>
			<div id='doFlowRemarkDiv' style='display:none;width:280px;' title='{*[cn.myapps.core.dynaform.view.input_audit_remark]*}'>
			<textarea id='temp_remark' rows='12' cols='35' name='temp_remark' style='width:97%;'></textarea></div>
			<div id="viewHtml">
				<%
				out.print(htmlBean.toHTMLText());
				%>
			</div>
			<!-- 分页导航(page navigate) -->
		    <div id="isPagination">
		    	<div id="pagination-panel" data-options="
		    		{'_isPagination': '<s:property value="%{_isPagination}"/>',
					'_isShowTotalRow': '<s:property value="%{_isShowTotalRow}"/>',
					'_datasPageNo': '<s:property value="%{datas.pageNo}"/>',
					'_datasPageCount': '<s:property value="%{datas.pageCount}"/>',
					'_totalRowText': '<s:property value="%{totalRowText}"/>',
					'_isShowItem': 'false'}"></div>
		    </div>
			<!-- 分页导航结束(end of page navigate) -->
	    </div>
	</div>
		
		
	</div>
   
	
</div>
</s:form>
<%
//out.println(htmlBean.toContextMenuHtml());
%>

<%@ include file="/portal/H5/resource/common/include_view_js.jsp" %>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/ViewHelper.js"/>'></script>
<script src='<o:Url value="/resource/component/view/obpm.listView.js" />'></script>
<script>
var watermark = {
	show : <%=show%>,
	content : '<%=content%>'
};
var WebUser = {
		id:'<%=webUser.getId()%>',
		name:'<%=webUser.getName()%>',
		loginNo:'<%=webUser.getLoginno()%>',
		domainId:'<%=webUser.getDomainid()%>'
	};
var contextPath = '<%= request.getContextPath()%>';
var operation = '<s:property value="%{#parameters.operation}" />';
var isOpenAbleScriptShow = '{*[page.core.dynaform.forddin]*}';	//judgeOperating()
var isedit = '';
var enbled='';
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
    
	setTimeout(function(){
		var tab = $(window.parent.document).find("li.navbar-tabs-item.selected .nav-title");
		if(tab && "..."==tab.text()){
			var title = $("title").text()
			tab.text(title);
		}
	}, 10);
	showLoading();	//在方法加载完之前锁定操作
	initListComm();	//列表视图公用初始化方法
	listViewAdjustLayout();
	if($("input[name='_pageCount']").val()>0){
		Common.Util.renderPagination();
	}

	/**
	adjustDataIteratorSize();
	setTimeout(function(){
		listViewAdjustLayout();
	},10);	//调整当前窗口布局
	**/
	hideLoading();	//方法加载完之后解锁操作
	$('.form_date').datetimepicker({
        language:  'zh-CN',
        weekStart: 1,
        todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 2,
		forceParse: 0
    });
	if(watermark.show){
		$("body").watermark({
            texts : [watermark.content] //水印文字,[]数组形式
        });
	};
});
</script>
</body>
</html>
</o:MultiLanguage>