<%@ page contentType="text/html; charset=UTF-8" errorPage="/portal/share/error.jsp" %>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.dynaform.view.ejb.View"%>
<%@page import="cn.myapps.core.dynaform.view.html.ViewHtmlBean"%>
<%@include file="/portal/share/common/lib.jsp"%>
<%
	//初始化HtmlBean
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
    String divid = request.getParameter("divid");
%>


<%@page import="cn.myapps.core.dynaform.document.ejb.Document"%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 视图样式 -->
<!-- 注释旧样式
<link rel="stylesheet" href='<o:Url value="/dynaform/view/css/displayView.css"/>' type="text/css" />
 -->
<!-- 样式库样式 -->
<jsp:include page='../../resource/css/styleLib.jsp' flush="true">
	<jsp:param name="styleid" value="<%= htmlBean.getViewStyle()%>" />
</jsp:include>

<link rel="stylesheet" href="<s:url value='/portal/share/css/dialog.css'/>" type="text/css"  media="all" />
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/ViewHelper.js"/>'></script>
<!-- View页面常用function,注意先后顺序,先common后view -->
<script src='<o:Url value='/resource/component/view/common.js' />'></script>
<script src='<o:Url value='/resource/component/view/view.js' />'></script>
<script src='<o:Url value='/resource/component/view/obpm.displayView.js' />'></script>
<!-- 图片滑动控件样式 -->
	<link rel="stylesheet" href="<s:url value='/portal/share/css/slider.css' />" type="text/css" />
	
<script type="text/javascript">
var contextPath = '<%= request.getContextPath()%>' ;
var isedit = '';
var enbled='';
var openDownWinStr = '<s:property value="%{#request.excelFileName}"/>';
var selectStr = '{*[Select]*}';	//viewDoc()
var newStr = '{*[New]*}';	//createDoc()
var typeName = '<s:property value="%{#request.message.typeName}" />';	//showPromptMsg()
var urlValue = '<s:url value="%{#request.ACTIVITY_INSTNACE.actionUrl}">'+
	'<s:param name="_activityid" value="%{#request.ACTIVITY_INSTNACE.id}" /></s:url>';	//showPromptMsg()
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
</script>

<title>list column by view34</title>
</head>
<body style="overflow:auto; height:100%;">
<div id="right" class="thisDisplay" style="background-color:#fff;-webkit-box-shadow:0 5px 10px rgba(231, 231, 231, .5);  -moz-box-shadow:0 5px 10px rgba(231, 231, 231, .5);  box-shadow:0 5px 10px rgba(231, 231, 231, .5);-webkit-filter: blur(-6px);-moz-filter: blur(-6px);-o-filter: blur(-6px);-ms-filter: blur(-6px);filter: blur(-6px);">
	<div class="<%= divid%>_waterMark" show="<%=show%>" content="<%=content%>" style="display:none;"></div>   
	<div class="crm_right">
<s:if test="#request.htmlBean.showSearchForm">
	<div id="searchFormTable">
		<s:property value="#request.htmlBean.toSearchFormHtml()" escape="false"/>
	</div>
</s:if>
<s:form id="formList" name="formList" action="subFormView" method="post" theme="simple">
	<%@include file="/common/list.jsp"%>
	<s:url id="backURL" action="subFormView">
		<s:param name="_viewid" value="#parameters._viewid" />
		<s:param name="parentid" value="#parameters.parentid" />
		<s:param name="_currpage" value="datas.pageNo"/>
		<s:param name="isSubDoc" value="true"/>
		<s:param name="divid" value="%{#parameters.divid}" />
		<s:param name="isRelate" value="#parameters.isRelate"/>
		<s:param name="isedit" value="#parameters.isedit"/>
		<s:param name="application" value="#parameters.application[0]" />
	</s:url>
	<s:textarea name="message" value="%{#request.message.content}" cssStyle="display:none" />
	<input type="hidden" name="_backURL" value="<%=request.getAttribute("backURL") %>" />
	<div id="closeWindow_DIV" class="black_overlay"></div>
	<s:hidden name="isedit" value="%{#parameters.isedit}" />
	<s:hidden name="ApplicationID" id="ApplicationID" value="%{#parameters.application[0]}" ></s:hidden>
	<s:hidden name="parentid" value="%{#parameters.parentid}" />
	<s:hidden name="treedocid" value="%{#parameters.treedocid}" />
	<input type="hidden" name="_openType" value='<s:property value="content.openType"/>' />
	<!-- 内嵌视图参数 -->
	<s:hidden id="isinner" name="isinner" value="%{#parameters.isinner}" />
	<s:hidden name="_fieldid" value="%{#parameters._fieldid}" />
	
	<%@include file="../../resource/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<s:hidden name="isRelate" value="%{#parameters.isRelate}" />
	
    <div id="acttable" style="z-index: 10;width: 100%;background-color: #fff;">
        <div class="searchDiv">
            <ul class="nav nav-pills">
				<!-- 输出视图操作HTML -->
				<div style="float: left;">
				<s:property value="#request.htmlBean.toActHtml()" escape="false"/>
				<s:if test="#request.htmlBean.showSearchForm">
					<a id="searchBtn" class="vbtn btn btn-default" title="{*[Query]*}">
						{*[Query]*}
					</a>
                    &nbsp;&nbsp;&nbsp;&nbsp;
					<a id="resetBtn" class="vbtn btn btn-default btn-reset" title="{*[Reset]*}">
						{*[Reset]*}
					</a>
				</s:if>
				</div>



				<s:if test="_isPagination == 'true' || _isShowTotalRow == 'true'">
				<div style="float: right;">
					<s:if test="_isPagination == 'true'">
						<ul class="pagination" style="margin: 0px;vertical-align: bottom;">
						<s:if test="datas.pageNo  > 1">
							<li><a class="showFirstPage"><span aria-hidden="true" title="{*[FirstPage]*}">&lt;&lt;</span></a></li>
							<li><a class="showPreviousPage"><span aria-hidden="true" title="{*[PrevPage]*}">&lt;</span></a></li>
						</s:if>
						<s:else>
							<li class="disabled"><a class="showFirstPage"><span aria-hidden="true" title="{*[FirstPage]*}">&lt;&lt;</span></a></li>
							<li class="disabled"><a class="showPreviousPage"><span aria-hidden="true" title="{*[PrevPage]*}">&lt;</span></a></li>
						</s:else>
							<li><a><s:property value='datas.pageNo' />{*[Page]*}&nbsp;{*[Total]*}<s:property value='datas.pageCount' />{*[Page]*}</a></li>
						<s:if test="datas.pageNo < datas.pageCount">
							<li><a class="showNextPage"><span aria-hidden="true" title="{*[NextPage]*}">&gt;</span></a></li>
							<li><a class="showLastPage"><span aria-hidden="true" title="{*[EndPage]*}">&gt;&gt;</span></a></li>
						</s:if>
						<s:else>
							<li class="disabled"><a class="showNextPage"><span aria-hidden="true" title="{*[NextPage]*}">&gt;</span></a></li>
							<li class="disabled"><a class="showLastPage"><span aria-hidden="true" title="{*[EndPage]*}">&gt;&gt;</span></a></li>
						</s:else>
  						</ul>

						<div class="input-group" style="display: inline-table;width: 120px;vertical-align: bottom;">
							<input type="text" name="_jumppage"  class="form-control" style="width:51px;">
							<span class="input-group-btn">
								<input type="button" class="btn btn-default btn-jumppage" value="跳转" />
							</span>
						</div>
					</s:if>
					<s:if test="_isShowTotalRow == 'true'">
						<span style="height: 34px;padding: 6px 12px;border: 1px solid #ccc;display: inline-block;border-radius: 4px;">{*[TotalRows]*}:(<s:property value="totalRowText" />)</span>
					</s:if>
				</div>
				</s:if>
            </ul>
			<s:hidden name="_viewid" />
			<s:hidden name="divid" value="%{#parameters.divid}" />
			<s:hidden name="_sortCol" />
			<s:hidden name="_orderby" />
			<s:hidden name="_sortStatus" />
			<s:hidden name="_isSubDoc" value="true" />
			<!-- 当前视图对应的菜单编号 -->
			<s:hidden id="resourceid" name="_resourceid" value="%{#parameters._resourceid}" />
			
			<!-- 电子签章参数 -->
			<s:hidden name="signatureExist" id="signatureExist"
			value="%{#request.htmlBean.isSignatureExist()}"></s:hidden>
        </div>
    </div>
	<div id="table_container" class="dataTable" style="width:100%;overflow:auto;">
	<%
		out.print(htmlBean.toHTMLText());//与列表(detail)视图调用相同的方法
	%>
	</div>
</s:form>
</div>
</div>

</body>
</html>
</o:MultiLanguage>
