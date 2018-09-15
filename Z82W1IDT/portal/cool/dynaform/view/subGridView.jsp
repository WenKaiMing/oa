<%@ page contentType="text/html; charset=UTF-8" errorPage="/portal/share/error.jsp" %>
<%@ page import="cn.myapps.core.dynaform.view.ejb.View"%>
<%@ page import="cn.myapps.core.dynaform.activity.ejb.*"%>
<%@ page import="cn.myapps.core.dynaform.document.ejb.Document"%>
<%@ page import="cn.myapps.base.action.ParamsTable"%>
<%@ page import="cn.myapps.util.StringUtil"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.core.macro.runner.*"%>
<%@page import="cn.myapps.core.dynaform.view.html.ViewHtmlBean"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@include file="/portal/share/common/lib.jsp"%>
<%
	ViewHtmlBean htmlBean = new ViewHtmlBean();
	htmlBean.setHttpRequest(request);
	WebUser user = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	if("true".equals(request.getAttribute("_isPreview"))){
		user = (WebUser)session.getAttribute(Web.SESSION_ATTRIBUTE_PREVIEW_USER);
	}
    htmlBean.setWebUser(user);
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
%>


<%@page import="cn.myapps.core.dynaform.form.ejb.ValidateMessage"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html style="height:100%;">
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/portal/share/common/js_base.jsp" %>
<%@include file="/portal/share/common/js_component.jsp" %>
<!-- 视图样式 -->
<link rel="stylesheet" href='<o:Url value="/dynaform/view/css/subGridView.css"/>' type="text/css" />
<!-- 样式库样式 -->
<jsp:include page='../../resource/css/styleLib.jsp' flush="true">
	<jsp:param name="styleid" value="<%= htmlBean.getViewStyle()%>" />
</jsp:include>

<script src='<s:url value="/dwr/interface/DocumentUtil.js"/>'></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/ViewHelper.js"/>'></script>
<script src='<s:url value="/portal/share/component/view/grid.js"/>'></script>
<script src='<s:url value='/portal/share/component/view/common.js' />'></script>
<script src='<o:Url value="/resource/document/obpm.ui.js"/>'></script>
<script src='<s:url value="/portal/share/component/dateField/datePicker/WdatePicker.js" />' ></script>
<script src='<s:url value='/portal/share/component/view/obpm.subGridView.js' />'></script>

<!-- 图片滑动控件样式 -->
<link rel="stylesheet" href="<s:url value='/portal/share/css/slider.css' />" type="text/css" />

<script>
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

jQuery(document).ready(function(){
	dy_lock();	//在方法加载完之前锁定操作
	initGridComm();		//网格视图公用初始化方法
	var checkboxs = document.getElementsByName("_selects");
	<s:iterator value="_selects">
		for (var i=0; i<checkboxs.length; i++) {
			var checkedId = '<s:property />';
			if (checkboxs[i].value == checkedId) {
				checkboxs[i].checked = true;
			}
		}
	</s:iterator>
	dy_unlock();	//方法加载完之后解锁操作
});
</script>
<title>list column by view</title>
</head>
<body style="height:100%;">
<!-- 遮挡层 -->
<div id="loadingDivBack" style="position: absolute; z-index: 50; width: 100%; height: 100%; top: 0px; left: 0px; background-color:#ccc; filter: alpha(opacity = 0.1); opacity: 0.1;">
	<div style="position: absolute;top: 35%;left: 45%;width: 128px;height: 128px;z-index: 100;">
		<img src="<o:Url value='/resource/main/images/loading1.gif'/>"/>
	</div>
</div>
<input type="hidden" id="obpm_subGridView" />
<div id="dspview_divid" style="overflow:hidden;">
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
		<s:param name="isSubDoc" value="true"/>
		<s:param name="application" value="#parameters.application[0]" />
	</s:url>
	
	<%@include file="/portal/share/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<table class="display_view-table" id="acttable" border="0" cellpadding="0" cellspacing="0" width="100%">
		<s:textarea name="message" value="%{#request.message.content}" cssStyle="display:none" />
		<input type="hidden" name="_backURL" value="<%=request.getAttribute("backURL") %>" />
		<!-- 翻页使用--start -->
		<input type="hidden" name="_pageCount" value='<s:property value="datas.pageCount"/>' />
		<!-- 翻页使用--end -->
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
		<s:hidden name="signatureExist" id="signatureExist"
		value="%{#request.htmlBean.isSignatureExist()}"></s:hidden>
		<s:set name="sinfo" value="#request.htmlBean.getSignatureInfo(datas)"/>
		<s:hidden name="FormID" id="FormID" value="%{#sinfo.FormID}" ></s:hidden>
		<s:hidden name="ApplicationID" id="ApplicationID" value="%{#sinfo.ApplicationID}" ></s:hidden>
		<s:hidden name="DocumentID" id="DocumentID" value="%{#sinfo.DocumentID}" ></s:hidden>
		<s:hidden name="mGetBatchDocumentUrl" id="mGetBatchDocumentUrl" value="%{#sinfo.mGetBatchDocumentUrl}" ></s:hidden>
		<s:hidden name="mLoginname" id="mLoginname" value="%{#session.FRONT_USER.loginno}"></s:hidden>
		<div id="table-gridView-selects" style="display:none"></div>
		<!-- style="display: none" -->
		<tr id="act">
			<td align="left" colspan="2">
			<table class="act_table2" style="border-bottom:1px solid #b5b8c8;" width="100%" cellpadding="0" cellspacing="0" border="0">
			<tr>
			<td>
				<!-- 输出视图操作HTML -->
				<s:property value="#request.htmlBean.toActHtml()" escape="false"/>
			</td>
			
			<s:if test="_isPagination == 'true' || _isShowTotalRow == 'true'">
			<td style="text-align:right;width:340px;">
			</s:if>
			<s:else>
			<td>
			</s:else>
			<s:if test="_isPagination == 'true' || _isShowTotalRow == 'true'">
			<s:if test="_isPagination == 'true'">
				<s:if test="datas.pageNo  > 1">
					<a href='javascript:showFirstPage()'><img src="<s:url value='/portal/share/images/imgnew/pg_first.gif' />" alt="{*[FirstPage]*}" style="border:0px;cursor:pointer;"></a>&nbsp;
					<a href='javascript:showPreviousPage()'><img src="<s:url value='/portal/share/images/imgnew/pg_previous.gif' />" alt="{*[PrevPage]*}" style="border:0px;cursor:pointer;"></a>&nbsp;
				</s:if>
				<s:else>
					<img src="<s:url value='/portal/share/images/imgnew/pg_first_d.gif' />" style="border:0px;cursor:pointer;" alt="{*[FirstPage]*}">&nbsp;
					<img src="<s:url value='/portal/share/images/imgnew/pg_previous_d.gif' />" style="border:0px;cursor:pointer;" alt="{*[PrevPage]*}">&nbsp;
				</s:else>
				<img src="<s:url value='/portal/share/images/imgnew/act_seperate.gif' />"/>&nbsp;
				<s:property value='datas.pageNo' />{*[Page]*}&nbsp;{*[Total]*}<s:property value='datas.pageCount' />{*[Page]*}
				<img src="<s:url value='/portal/share/images/imgnew/act_seperate.gif' />"/>
				
				<s:if test="datas.pageCount > 1">
				<input type="text" style="width:20px;height:19px;" name="_jumppage" value="<s:property value='datas.pageNo' />"/>
				<button type="button" onclick='javascript:jumpPage();' style="height:20px;line-height:17px;">{*[cn.myapps.core.dynaform.activity.type.jump]*}</button>
				</s:if>
				
				<s:if test="datas.pageNo < datas.pageCount">
					<a href='javascript:showNextPage()'><img src="<s:url value='/portal/share/images/imgnew/pg_next.gif' />" alt="{*[NextPage]*}" style="border:0px;cursor:pointer;"></a>&nbsp;
					<a href='javascript:showLastPage()'><img src="<s:url value='/portal/share/images/imgnew/pg_last.gif' />" alt="{*[EndPage]*}" style="border:0px;cursor:pointer;"></a>&nbsp;
				</s:if>
				<s:else>
					<img src="<s:url value='/portal/share/images/imgnew/pg_next_d.gif' />" alt="{*[NextPage]*}">&nbsp;
					<img src="<s:url value='/portal/share/images/imgnew/pg_last_d.gif' />" alt="{*[EndPage]*}">&nbsp;
				</s:else>
				<img src="<s:url value='/portal/share/images/imgnew/act_seperate.gif' />"/>&nbsp;
			</s:if>
			<s:if test="_isShowTotalRow == 'true'">
				{*[TotalRows]*}:(<s:property value="totalRowText" />)
			</s:if>
			</s:if>
	</td>
	<!-- end of page navigate -->
			</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td>
			<s:if test="#request.htmlBean.showSearchForm">
	<div id="searchFormTable" class="front-scroll-hidden front-bgcolor2" style="padding: 10px;">
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
									<a href="#" onclick="modifyActionBack();">
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
			</td>
		</tr>
	</table>
	</s:form>
	<!-- page navigate -->
	<div id="table_gridView" class="front-bgcolor2" style="width:100%;overflow:auto;">
	<!-- 后台java代码输出网格视图数据 -->
	<%
		out.print(htmlBean.toHTMLText4Grid());
	%>
	</div>
</div>
</body>
</o:MultiLanguage></html>
