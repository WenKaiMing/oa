<%@ page contentType="text/html; charset=UTF-8" errorPage="/portal/share/error.jsp" %>
<%@ page import="cn.myapps.core.dynaform.view.ejb.View"%>
<%@ page import="cn.myapps.core.dynaform.activity.ejb.*"%>
<%@ page import="cn.myapps.core.dynaform.document.ejb.Document"%>
<%@ page import="cn.myapps.base.action.ParamsTable"%>
<%@ page import="cn.myapps.util.StringUtil"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.core.macro.runner.*"%>
<%@ page import="cn.myapps.core.dynaform.view.html.ViewHtmlBean"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.dynaform.view.ejb.View"%>
<%@ page import="cn.myapps.core.dynaform.form.ejb.ValidateMessage"%>
<%@ include file="/portal/share/common/lib.jsp"%>
<%
	ViewHtmlBean htmlBean = new ViewHtmlBean();
	htmlBean.setHttpRequest(request);
	WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	if("true".equals(request.getAttribute("_isPreview"))){
		webUser = (WebUser)session.getAttribute(Web.SESSION_ATTRIBUTE_PREVIEW_USER);
	}
    htmlBean.setWebUser(webUser);
	request.setAttribute("htmlBean", htmlBean);
	View view = ((View) request.getAttribute("content"));
	
	ParamsTable params = ParamsTable.convertHTTP(request);

	IRunner jsrun = JavaScriptFactory.getInstance(
			params.getSessionid(), view.getApplicationid());

	Document parent = (Document) request.getAttribute("parent");

	String viewid = request.getParameter("_viewid");
	String imageid = "";
	boolean isHeddienPage = true;
	request.setAttribute("runner", jsrun);
	
	boolean isEdit = !StringUtil.isBlank(request.getParameter("isedit")) ? Boolean.parseBoolean(request.getParameter("isedit")) : true;
    Boolean showWaterMark = view.getShowWaterMark();
    boolean show = showWaterMark != null ? showWaterMark : false;
    String content = htmlBean.getWaterMark();
    content = content != null ? content : "";
%>



<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/portal/H5/resource/common/include_view_css.jsp" %>
<link rel="stylesheet" href="<s:url value='/portal/share/css/slider.css' />" type="text/css" />
<!-- 图片滑动控件样式 -->
<link rel="stylesheet" href="<s:url value='/portal/H5/dynaform/view/css/subGridView.css' />" type="text/css" />

<!-- 样式库样式 -->
<jsp:include page='../../resource/css/styleLib.jsp' flush="true">
	<jsp:param name="styleid" value="<%= htmlBean.getViewStyle()%>" />
</jsp:include>

<title>list column by view</title>
</head>
<body class="bgcolor-white">
<!-- 遮挡层 -->
<div id="loadingMask" class="obpm-mask_transparent" style="display:none">
    <div class="obpm-loading">
        <img src="<o:Url value='/resource/main/images/loading1.gif'/>"/>
    </div>
</div>


<%if(htmlBean.isSignatureExist()) {%>
<!-- 电子签章 -->
<div id="install" style="display:none">
	<a id="hreftest2" href="<s:url value='/portal/share/component/signature/iSignatureHTML.zip'/>"><font color="red"><b>&nbsp;&nbsp;&nbsp;点击下载金格iSignature电子签章HTML版软件</b></font></a> 
</div>
<%@include file="/portal/share/dynaform/view/batchSignatureObject.jsp"%>
<%}%>


<s:if test="#request.htmlBean.showSearchForm">
<!-- 要在BackURL传递的参数放在 searchFormTable-->
	<div class="searchDiv" id="searchFormTable" style="display:none;">
		<!-- 输出查询表单HTML -->
		<s:property value="#request.htmlBean.toSearchFormHtml()" escape="false"/>
	</div>
</s:if>

<div id="gridview-container" class="obpm-flex obpm-flex-column">
	<div class="activity__bd">
		<!-- 输出视图操作HTML -->
		<s:property value="#request.htmlBean.toActHtml()" escape="false"/>
		<s:if test="#request.htmlBean.showSearchForm">
			<!-- 要在BackURL传递的参数放在 searchFormTable-->			
			<div class="search-active-panel form-inline pull-right searchBtn">
				<a id="searchBtn" class="btn btn-info" title="{*[Query]*}">
					<i class="fa fa-search"></i>
				</a>
			</div>
		</s:if>
	</div>
	<div class="gridView__bd obpm-flex__item obpm-flex obpm-flex-column">
		<div id="gridView__box" class="gridView__box obpm-flex__item obpm-flex obpm-flex-column"></div>
		<div id="isPagination">
		<s:if test="_isPagination == 'true' || _isShowTotalRow == 'true'">
		<!-- 分页导航(page navigate) -->
	    	<div id="pagination-panel"></div>
		<!-- 分页导航结束(end of page navigate) -->
		</s:if>
		</div>
	</div>
</div>

<div id="container-params">
	<input id="obpm_subGridView" name="obpm_subGridView" type="hidden" />
	<input id="isedit" name="isedit" type="hidden" value="<%=isEdit %>" />
	<input id="_backURL" name="_backURL" type="hidden" value="<%=request.getAttribute("backURL") %>" />
	<s:url id="backURL" action="displayView" >
		<s:param name="_viewid" value="#parameters._viewid" />
		<s:param name="parentid" value="#parameters.parentid" />
		<s:param name="divid" value="%{#parameters.divid}" />
		<s:param name="_currpage" value="datas.pageNo"/>
		<s:param name="isSubDoc" value="true"/>
		<s:param name="application" value="#parameters.application[0]" />
	</s:url>
	<s:hidden name="isedit" value="%{#parameters.isedit}" />		
	<s:hidden name="parentid" value="%{#parameters.parentid}" />
	<s:hidden name="isRelate" value="%{#parameters.isRelate}" />
	<s:hidden name="_viewid" />
	<s:hidden name="divid" value="%{#parameters.divid}" />
	<s:hidden name="_sortCol" />
	<s:hidden name="_orderby" />
	<s:hidden name="_sortStatus" />
	<s:hidden name="_isSubDoc" value="true" />
	<s:hidden name="_fieldid" value="%{#parameters._fieldid}" />
	<!-- 当前视图对应的菜单编号 -->
	<s:hidden id="resourceid" name="_resourceid" value="%{#parameters._resourceid}" />
	<!-- 电子签章参数 -->
	<s:hidden name="signatureExist" id="signatureExist" value="%{#request.htmlBean.isSignatureExist()}" />
	
	<s:set name="sinfo" value="#request.htmlBean.getSignatureInfo(datas)"/>
	<s:hidden name="FormID" id="FormID" value="%{#sinfo.FormID}" />
	<s:hidden name="ApplicationID" id="ApplicationID" value="%{#sinfo.ApplicationID}" />
	<s:hidden name="DocumentID" id="DocumentID" value="%{#sinfo.DocumentID}" />
	<s:hidden name="mGetBatchDocumentUrl" id="mGetBatchDocumentUrl" value="%{#sinfo.mGetBatchDocumentUrl}" />
	<s:hidden name="mLoginname" id="mLoginname" value="%{#session.FRONT_USER.loginno}" />
	<s:textarea name="message" value="%{#request.message.content}" cssStyle="display:none" />
	<%@include file="/common/list.jsp"%>
</div>
<%@ include file="/portal/H5/dynaform/document/content-tmlp.jsp"%>
<%@ include file="/portal/H5/resource/common/include_view_js.jsp" %>
<script type="text/html" id="atp-gridview-td">
<div id="{{showId}}" class="grid-column-show">{{#showHtml}}</div>
<div id="{{editId}}" class="grid-column-edit" style="display:none;">{{#editHtml}}</div>
</script>

<script type="text/html" id="atp-gridview-table">
<div class="obpm-view__table-hd_scroll">
<div class="obpm-view__table-hd">
	<table class="table table-bordered table-hover text-center">
		<colgroup>	
			{{if isSelect}}
			<col/>
			{{/if}}
			{{each columns as hd}}
			<col/>
			{{/each}}
		</colgroup>	
		<tbody><tr>
		{{if isSelect}}
		<td data-id="selectAll">
	    	<input type="checkbox" class="obpm-check" data-active="selectAll" >
		</td>
		{{/if}}
		{{each columns as hd}}
		<td class="{{hd.colIsHideCls}}" data-id="{{hd.field}}" colName="{{hd.colName}}" coltext="{{hd.colText}}" coltype="{{hd.colType}}" data-width="{{hd.colWidth}}">{{hd.colText}}</td>
		{{/each}}
	</tbody></tr></table>
</div>
</div>
<div class="obpm-view__table-bd_scroll obpm-flex__item obpm-flex-column__item_fix">
<div class="obpm-view__table-bd ">
	<table class="table table-bordered table-hover text-center">
		<colgroup>	
			{{if isSelect}}
			<col/>
			{{/if}}
			{{each columns as hd}}
			<col/>
			{{/each}}
		</colgroup>	
		<tbody id="obpm-view__table">
		{{each data as bd}}
		<tr id="{{bd.docId}}">
			{{if isSelect}}
			<td>
	    		<input type="checkbox" class="obpm-check" id="{{bd.docId}}_select" name="_selects" value="{{bd.docId}}" />
			</td>
			{{/if}}
			{{each columns as hd}}
			<td class="{{#bd[hd.field].colIsEditCls}} {{#bd[hd.field].colIsHideCls}}" data-width="{{bd[hd.field].colWidth}}" style="background:{{#bd[hd.field].colGroundColor}};color:{{#bd[hd.field].colColor}};font-size:{{#bd[hd.field].colFontSize}}px">{{#bd[hd.field].colContent}}</td>
			{{/each}}
		</tr>
		{{/each}}
		
		{{each sumTrData as sumBd}}
		<tr id="{{sumBd.docId}}">
			<td>
			</td>
			{{each columns as hd}}
			<td class="{{#sumBd[hd.field].colIsHideCls}}">{{#sumBd[hd.field].colContent}}</td>
			{{/each}}
		</tr>
		{{/each}}

		</tbody>
	</table>
</div>
</div>
</script>

<script src='<s:url value="/dwr/interface/DocumentUtil.js"/>'></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/ViewHelper.js"/>'></script>

<script src='<o:Url value='/resource/component/view/obpm.subGridView.js' />'></script>
<script>
var watermark = {
	show : <%=show%>,
	content : '<%=content%>'
};
var contextPath = '<%= request.getContextPath()%>' ;
var importURL = contextPath + '/portal/share/dynaform/dts/excelimport/importbyid.jsp'; //import Excel
var downloadURL = contextPath + '/portal/share/download.jsp'; // Excel下载URL
var isedit = '';
var enbled='';
var _viewid = '<%=viewid%>';
var isRelate = '<s:property value="#parameters.isRelate" />';
var parentid = '<s:property value="#parameters.parentid" />';
var openDownWinStr = '<s:property value="%{#request.excelFileName}"/>';	//openDownloadWindow()
var typeName = '<s:property value="%{#request.message.typeName}" />';	//showPromptMsg()
var urlValue = '<s:url value="%{#request.ACTIVITY_INSTNACE.actionUrl}">'+
	'<s:param name="_activityid" value="%{#request.ACTIVITY_INSTNACE.id}" /></s:url>';	//showPromptMsg()
var totalRows = '<s:property value="totalRowText" />';  //refreshMenuTotalRows()

$(function(){
	//showLoading();	//在方法加载完之前锁定操作
	subGridView.init();
	var checkboxs = document.getElementsByName("_selects");
	<s:iterator value="_selects">
	for (var i=0; i<checkboxs.length; i++) {
		var checkedId = '<s:property />';
		if (checkboxs[i].value == checkedId) {
			checkboxs[i].checked = true;
		}
	}
	</s:iterator>
	//hideLoading();	//方法加载完之后解锁操作
	if(watermark.show){
		$("body").watermark({
            texts : [watermark.content] //水印文字,[]数组形式
        })
	};
});
</script>
</body>
</html>
</o:MultiLanguage>
