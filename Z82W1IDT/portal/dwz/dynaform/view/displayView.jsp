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
<!DOCTYPE html>
<html style="height:100%;">
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 视图样式 -->
<link rel="stylesheet" href='<o:Url value="/dynaform/view/css/displayView.css"/>' type="text/css" />
<!-- 样式库样式 -->
<jsp:include page='../../resource/css/styleLib.jsp' flush="true">
	<jsp:param name="styleid" value="<%= htmlBean.getViewStyle()%>" />
</jsp:include>

<link rel="stylesheet" href="<s:url value='/portal/share/css/dialog.css'/>" type="text/css"  media="all" />
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/ViewHelper.js"/>'></script>
<script src='<o:Url value="/resource/document/obpm.ui.js"/>'></script>
<!-- View页面常用function,注意先后顺序,先common后view -->
<script src='<s:url value='/portal/share/component/view/common.js' />'></script>
<script src='<s:url value='/portal/share/component/view/view.js' />'></script>
<script src='<s:url value='/portal/share/component/view/obpm.displayView.js' />'></script>
<script src='<s:url value="/portal/share/component/dateField/datePicker/WdatePicker.js" />' ></script>
<script src='<s:url value='/portal/share/script/jquery.watermark.js' />'></script>
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

<title>list column by view</title>
</head>
<body style="overflow:auto; height:100%;">
<div id="dspview_divid" class="thisDisplay" style="overflow:hidden;width:99%;">
<div class="<%= divid%>_waterMark" show="<%=show%>" content="<%=content%>" style="display:none;"></div> 
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
	
	<%@include file="/portal/share/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<s:hidden name="isRelate" value="%{#parameters.isRelate}" />
	<table class="display_view-table" id="acttable" border="0" cellpadding="0" cellspacing="0" width="100%">
		<!-- style="display: none" -->
		<tr id="act">
			<td align="left" colspan="2">
				<table class="act_table2" style="table-layout: fixed;border-bottom:1px solid #b5b8c8;" width="100%" cellpadding="0" cellspacing="0" border="0">
				<tr>
				<td>
				<!-- 输出视图操作HTML -->
				<s:property value="#request.htmlBean.toActHtml()" escape="false"/>
				<s:if test="#request.htmlBean.showSearchForm">
					<div class="actBtn">
						<span class="button-document">
							<a id="searchBtn" title="{*[Query]*}">
								<span><img style="border:0px solid blue;vertical-align:middle;" src="<s:url value='/portal/share/images/imgnew/query.gif' />">{*[Query]*}</span>
							</a>
						</span>
					</div>
					<div class="actBtn">
						<span class="button-document">
							<a id="resetBtn" title="{*[Reset]*}">
								<span><img style="border:0px solid blue;vertical-align:middle;" src="<s:url value='/portal/share/images/imgnew/reset.gif' />">{*[Reset]*}</span>
							</a>
						</span>
					</div>
				</s:if>
				</td>
				
				<!-- 分页开始 -->
				<td style="width:360px;text-align:right;vertical-align: top; padding-top: 4px;padding-bottom: 4px; padding-right:3px;">
					<s:if test="_isPagination == 'true' || _isShowTotalRow == 'true'">
					<s:if test="_isPagination == 'true'">
						<s:if test="datas.pageNo  > 1">
							<a class="showFirstPage"><img src="<s:url value='/portal/share/images/imgnew/pg_first.gif' />" alt="{*[FirstPage]*}" style="border:0px;cursor:pointer;"></a>&nbsp;
							<a class="showPreviousPage"><img src="<s:url value='/portal/share/images/imgnew/pg_previous.gif' />" alt="{*[PrevPage]*}" style="border:0px;cursor:pointer;"></a>&nbsp;
						</s:if>
						<s:else>
							<img src="<s:url value='/portal/share/images/imgnew/pg_first_d.gif' />" style="border:0px;cursor:pointer;" alt="{*[FirstPage]*}">&nbsp;
							<img src="<s:url value='/portal/share/images/imgnew/pg_previous_d.gif' />" style="border:0px;cursor:pointer;" alt="{*[PrevPage]*}">&nbsp;
						</s:else>
						<img src="<s:url value='/portal/share/images/imgnew/act_seperate.gif' />"/>&nbsp;
						<s:property value='datas.pageNo' />{*[Page]*}&nbsp;{*[Total]*}<s:property value='datas.pageCount' />{*[Page]*}
						<img src="<s:url value='/portal/share/images/imgnew/act_seperate.gif' />"/>&nbsp;
						<s:if test="datas.pageNo < datas.pageCount">
							<a class="showNextPage" ><img src="<s:url value='/portal/share/images/imgnew/pg_next.gif' />" alt="{*[NextPage]*}" style="border:0px;cursor:pointer;"></a>&nbsp;
							<a  class="showLastPage"><img src="<s:url value='/portal/share/images/imgnew/pg_last.gif' />" alt="{*[EndPage]*}" style="border:0px;cursor:pointer;"></a>&nbsp;
						</s:if>
						<s:else>
							<img src="<s:url value='/portal/share/images/imgnew/pg_next_d.gif' />" alt="{*[NextPage]*}">&nbsp;
							<img src="<s:url value='/portal/share/images/imgnew/pg_last_d.gif' />" alt="{*[EndPage]*}">&nbsp;
						</s:else>
						<img src="<s:url value='/portal/share/images/imgnew/act_seperate.gif' />"/>&nbsp;
	                    <span>
							<input type="text" name="_jumppage" class="img_go" style="width:30px"  />	
							<input type="button" class="btn-jumppage" value="跳转" />								
						</span>
					</s:if>
					<s:if test="_isShowTotalRow == 'true'">
						{*[TotalRows]*}:(<s:property value="totalRowText" />)
					</s:if>
					
					
                    
                    
					
					</s:if>
				</td>
				<!-- 分页结束 -->
				</tr>
				</table>
			</td>
		</tr>
		
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
	</table>
	<div id="table_container" style="width:100%;overflow:auto;">
	<%
		out.print(htmlBean.toHTMLText());//与列表(detail)视图调用相同的方法
	%>
	</div>
</s:form></div>
</body>
</o:MultiLanguage></html>
