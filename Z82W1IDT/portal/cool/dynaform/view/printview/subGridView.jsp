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
	htmlBean.setWebUser((WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER));
	request.setAttribute("htmlBean", htmlBean);
	View view = ((View) request.getAttribute("content"));
	
	WebUser user = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
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
<jsp:include page='../../../resource/document/style.jsp' flush="true">
	<jsp:param name="styleid" value="<%= htmlBean.getViewStyle()%>" />
</jsp:include><script src='<s:url value="/dwr/interface/DocumentUtil.js"/>'></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/ViewHelper.js"/>'></script>
<script src='<s:url value='/portal/share/component/view/common.js' />'></script>

<title>list column by view</title>
<script>
var contextPath = '<%= request.getContextPath()%>' ;
var downloadURL = contextPath + '/portal/share/download.jsp'; // Excel下载URL
var isedit = '';
var enbled='';
function doPrint() {
	window.print();
}
</script>
</head>
<body style="height:100%;">
<div id="dspview_divid">
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
		<s:param name="isSubDoc" value="true"/>
	</s:url>
	
	<%@include file="/portal/share/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<table class="display_view-table" id="acttable" border="0" cellpadding="0" cellspacing="0" width="100%">
		<s:textarea name="message" value="%{#request.message.content}" cssStyle="display:none" />
		<input type="hidden" name="_backURL" value="<%=request.getAttribute("backURL") %>" />
		<s:hidden name="isedit" value="%{#parameters.isedit}" />
	
		<input type="hidden" name="divid" value="<%=request.getParameter("divid")%>" />
		<s:hidden name="parentid" value="%{#parameters.parentid}" />
		<s:hidden name="isRelate" value="%{#parameters.isRelate}" />
		<s:hidden name="_viewid" value="#parameters._viewid" />
		<s:hidden name="_sortCol" />
		<s:hidden name="_orderby" />
		<s:hidden name="_sortStatus" />
		<s:hidden name="_isSubDoc" value="true" />
			<!-- 当前视图对应的菜单编号 -->
		<s:hidden id="resourceid" name="_resourceid" value="%{#parameters._resourceid}" />
			<!-- 电子签章参数 -->
		<s:hidden name="signatureExist" id="signatureExist"
		value="%{#request.htmlBean.isSignatureExist()}"></s:hidden>
		
		<!-- style="display: none" -->
		<tr>
			<td>
				&nbsp;
			</td>
		</tr>
	</table>

	<table id="gridTable" class="display_view-table" style="table-layout:fixed; border-top:1px solid #b5b8c8;position:relative; z-index:1;" border="0" cellpadding="0" cellspacing="0" width="100%">	
		<!-- table-header -->
		<tr class="dtable-header">
						
			<s:iterator value="content.columns" status="colstatus" id="columnVO">
				<s:if test="visible && !#request.htmlBean.isHiddenColumn(top)">
					<s:if test="width != \"0\"">
						<td class="column-head" width='<s:property value="width"/>'><input id="<s:property value="name" />_showType" value="<s:property value="showType" />" type="hidden">
						<s:if test="#columnVO.type=='COLUMN_TYPE_FIELD'">
							<s:if test="_sortCol!=null">
								<s:if test="_sortCol!='' && _sortCol==fieldName">
									<a style='cursor:pointer' href="#" onclick="sortTable('<s:property value="fieldName" />')">{*[<s:property value="name" />]*}
										<s:if test="_sortStatus=='ASC'">
											<img border="0" src='<o:Url value="/resource/imgv2/front/main/up.gif"/>'/>
										</s:if>
										<s:elseif test="_sortStatus=='DESC'">
											<img border="0" src='<o:Url value="/resource/imgv2/front/main/down.gif"/>'/>
										</s:elseif>
										<s:else>
											<!-- 可排序图标 -->
										</s:else>
									</a>
								</s:if>
								<s:else>
									<s:if test="#columnVO.isOrderByField!=null && #columnVO.isOrderByField!='' && #columnVO.isOrderByField=='true' ">
										<a style='cursor:pointer' href="#" onclick="sortTable('<s:property value="fieldName" />')">{*[<s:property value="name" />]*}
										</a>
									</s:if>
									<s:else>
										{*[<s:property value="name" />]*}<!-- 不勾选排序 -->
									</s:else>
								</s:else>
							</s:if>
							<s:else>
								<s:if test="#columnVO.isOrderByField!=null && #columnVO.isOrderByField!='' && #columnVO.isOrderByField=='true' ">
									<a style='cursor:pointer' href="#" onclick="sortTable('<s:property value="fieldName" />')">{*[<s:property value="name" />]*}
										<s:if test="#columnVO.orderType=='ASC'">
											<img border="0" src='<o:Url value="/resource/imgv2/front/main/up.gif"/>'/>
										</s:if>
										<s:else>
											<img border="0" src='<o:Url value="/resource/imgv2/front/main/down.gif"/>'/>
										</s:else>
									</a>
								</s:if>
								<s:else>
									{*[<s:property value="name" />]*}<!-- 不勾选排序 -->
								</s:else>
							</s:else>
						</s:if>
						<s:else>
							{*[<s:property value="name" />]*}<!-- 脚本不需要排序 -->
						</s:else>
						</td>
					</s:if>
					<s:else>
						<td class="column-head" style="display:none;"><s:property value="name" /></td>
					</s:else>
				</s:if>
			</s:iterator>
			<s:if test="!content.columns.empty">
			<td class="column-head" style="width:120px">
				{*[Actions]*}
			</td>
			</s:if>
		</tr>
		<!-- end of table-header -->
		
		<tbody id="dataBody">
		<!-- data iterator -->
		<s:iterator value="datas.datas" status="rowStatus">
		<s:set name="doc" id="doc" scope="page" />
		<%
			Document doc = (Document) pageContext.getAttribute("doc");
			jsrun.initBSFManager(doc, params, user, new ArrayList<ValidateMessage>());
			out.print(view.printToRowHtml(doc, jsrun, user,isEdit));
		%> 
		</s:iterator>
		
		<!-- 字段值汇总 -->
		<s:if test="content.sum">
		<tr class="table-tr" onmouseover="this.className='table-tr-onchange';" onmouseout="this.className='table-tr';">
				<td class="table-td">
					&nbsp;
				</td>
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
			<td>
				&nbsp;
			</td>
		</tr>
		</s:if>
		
		<% 
			out.print(view.toRefreshFunction());
		%>
		</tbody>
	</table>

	<!-- page navigate -->
	</s:form>
</div>

</body>
</o:MultiLanguage></html>
