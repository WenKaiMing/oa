<%@ page contentType="text/html; charset=UTF-8" errorPage="/portal/share/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.dynaform.view.ejb.View"%>
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

    View view = htmlBean.getView();
    Boolean showWaterMark = view.getShowWaterMark();
    boolean show = showWaterMark != null ? showWaterMark : false;
    String content = htmlBean.getWaterMark();
    content = content != null ? content : "";
%>


<%@page import="cn.myapps.core.dynaform.document.ejb.Document"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html style="height:100%;">
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/portal/share/common/js_base.jsp" %>
<%@include file="/portal/share/common/js_component.jsp" %>
<!-- 视图样式 -->
<link rel="stylesheet" href='<o:Url value="/dynaform/view/css/listView.css"/>' type="text/css" />
<!-- 样式库样式 -->
<jsp:include page='../../resource/css/styleLib.jsp' flush="true">
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
<script src='<s:url value="/portal/share/script/zoom/js/zoom.js" />' ></script>
<script src="<s:url value='/portal/share/script/base64.js'/>"></script>
<link rel="stylesheet" href="<s:url value='/portal/share/script/zoom/css/zoom.css' />" type="text/css" />
<!-- 图片滑动控件样式 -->
	<link rel="stylesheet" href="<s:url value='/portal/share/css/slider.css' />" type="text/css" />
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
var isprint='<s:property value="%{#parameters.isprint}" />';
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
	    if(watermark.show){
			$("body").watermark({
	            texts : [watermark.content] //水印文字,[]数组形式
	        })
		};
		dy_lock();	//在方法加载完之前锁定操作
		initListComm();	//列表视图公用初始化方法
		adjustDataIteratorSize();
		setTimeout(function(){
			listViewAdjustLayout();
		},10);	//调整当前窗口布局
		dy_unlock();	//方法加载完之后解锁操作
	});
</script>
<title>{*[cn.myapps.core.dynaform.view.list_view]*}</title>
</head>
<body class="body-front" style="height:100%;background-color:#ffffff;overflow-x:auto;overflow-y:hidden;">
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
	<div id="activityTable" class="front-border-bottom front-bgcolor2" style="width:100%;">
		<table class="front-table-act front-table-full-width">
			<tr valign="middle">
			<td>
			<!-- 输出视图操作HTML -->
			<s:property value="#request.htmlBean.toActHtml()" escape="false"/>
			
			<s:hidden id="viewid" name="_viewid" />
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
	<div id="searchFormTable" class="front-scroll-hidden" style="width100%;padding: 10px;">
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
									<a onclick="modifyActionBack();">
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
									<a onclick="ev_resetAll()">
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
	
	<!-- 数据表格 -->
	<div id="dataTable" class="front-scroll-auto" style="width:100%;">
		<textarea id='_remark' type='text' style='display:none;' name='_remark'></textarea>
		<div id='doFlowRemarkDiv' style='display:none;width:280px;' title='{*[cn.myapps.core.dynaform.view.input_audit_remark]*}'>
		<textarea id='temp_remark' rows='12' cols='35' name='temp_remark' style='width:97%;'></textarea></div>
		<div id="viewHtml">
		<%
		out.print(htmlBean.toHTMLText());
		%>
		</div>
	</div>
	<!-- 分页导航(page navigate) -->
	<s:if test="_isPagination == 'true' || _isShowTotalRow == 'true'">
	<div id="pageTable" class="front-scroll-hidden">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr class="page-nav"><td>
			<s:if test="_isPagination == 'true'">
				<s:if test="datas.pageNo  > 1">
					<a href='javascript:showFirstPage(null, listAction)'><img src="<o:Url value='/resource/document/pg_first.gif' />" alt="{*[FirstPage]*}"></a>&nbsp;
					<a href='javascript:showPreviousPage(null, listAction)'><img src="<o:Url value='/resource/document/pg_previous.gif' />" alt="{*[PrevPage]*}"></a>&nbsp;
				</s:if>
				<s:else>
					<img src="<o:Url value='/resource/document/pg_first_d.gif' />" alt="{*[FirstPage]*}">&nbsp;
					<img src="<o:Url value='/resource/document/pg_previous_d.gif' />" alt="{*[PrevPage]*}">&nbsp;
				</s:else>
				<img src="<o:Url value='/resource/document/act_seperate.gif' />"/>&nbsp;
				<s:property value='datas.pageNo' />{*[Page]*}&nbsp;{*[Total]*}<s:property value='datas.pageCount' />{*[Page]*}
				<img src="<o:Url value='/resource/document/act_seperate.gif' />"/>&nbsp;
				<s:if test="datas.pageCount > 1">
				{*[cn.myapps.core.dynaform.activity.type.jump]*}&nbsp;<input type="text" style="width:25px;height:19px;margin:1px" name="_jumppage" />
				<button type="button" onclick='javascript:jumpPage(listAction);' style="height:20px;line-height:17px;margin:3px">{*[cn.myapps.core.dynaform.activity.type.jump]*}</button>&nbsp;
				</s:if>
				<img src="<o:Url value='/resource/document/act_seperate.gif' />"/>&nbsp;
				<s:if test="datas.pageNo < datas.pageCount">
					<a href='javascript:showNextPage(null, listAction)'><img src="<o:Url value='/resource/document/pg_next.gif' />" alt="{*[NextPage]*}"></a>&nbsp;
					<a href='javascript:showLastPage(null, listAction)'><img src="<o:Url value='/resource/document/pg_last.gif' />" alt="{*[EndPage]*}"></a>&nbsp;
				</s:if>
				<s:else>
					<img src="<o:Url value='/resource/document/pg_next_d.gif' />" alt="{*[NextPage]*}">&nbsp;
					<img src="<o:Url value='/resource/document/pg_last_d.gif' />" alt="{*[EndPage]*}">&nbsp;
				</s:else>
				<img src="<o:Url value='/resource/document/act_seperate.gif' />"/>&nbsp;
			</s:if>
			<s:if test="_isShowTotalRow == 'true'">
				<td align="right">{*[TotalRows]*}:(<s:property value="totalRowText" />)</td>
			</s:if>
		</td></tr>
	</table>
	</div>
	</s:if>
	<!-- 分页导航结束(end of page navigate) -->
</div>
</s:form>
	<%
	out.println(htmlBean.toContextMenuHtml());
	%>
</body>
</o:MultiLanguage>
</html>
