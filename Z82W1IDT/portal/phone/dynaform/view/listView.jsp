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
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<title title="listView"><%=htmlBean.getViewTitle()%></title>
<script>
var operation = '<s:property value="%{#parameters.operation}" />';
var typeName= '<s:property value="%{#request.message.typeName}" />';	//showPromptMsg()
var urlValue= '<s:url value="%{#request.ACTIVITY_INSTNACE.actionUrl}">'
		+ '<s:param name="_activityid" value="%{#request.ACTIVITY_INSTNACE.id}" /></s:url>';	//showPromptMsg()
var openDownWinStr = '<s:property value="%{#request.excelFileName}"/>';	//openDownloadWindow()
var totalRows = '<s:property value="totalRowText" />';  //refreshMenuTotalRows()
var watermark = {
		show : <%=show%>,
		content : '<%=content%>'
	};

$(function() {
	if(watermark.show){
		var curPage = ajaxPage.getCurPage();
		curPage.find("#listView").find(".card_app").watermark({
            texts : [watermark.content] //水印文字,[]数组形式
        });
	};
	initListComm();	//列表视图公用初始化方法
});
</script>
<div class="reimburse">
	<div data-role="page" class="jqm-demos jqm-home" id="listView">
		<div class="card_app">
		<%
			out.print(htmlBean.toHTMLText());
			%>
			<div class="ui-content dataTableDiv" name="dataTableDiv" style="overflow:auto">
			</div>
		</div>

		<!-- 分页导航(page navigate)1 -->
		<nav id="footer" class="text-center">
			<s:if test="_isPagination == 'true' || _isShowTotalRow == 'true'">
			<ul class="pagination"  style="margin:0;">
				<s:if test="_isPagination == 'true'">
					<s:if test="datas.pageNo  > 1">
						<li><a href='javascript:showFirstPage(null, listAction)'><span title="{*[FirstPage]*}">&lt;&lt;</span></a></li>
						<li><a href='javascript:showPreviousPage(null, listAction)'><span title="{*[PrevPage]*}">&lt;</span></a></li>
					</s:if>
					<s:else>
						<li class="disabled"><a href='javascript:showFirstPage(null, listAction)'><span title="{*[FirstPage]*}">&lt;&lt;</span></a></li>
						<li class="disabled"><a href='javascript:showPreviousPage(null, listAction)'><span title="{*[PrevPage]*}">&lt;</span></a></li>
					</s:else>
					<li><a href='javascript:showFirstPage(null, listAction)'><s:property value='datas.pageNo' />&nbsp;/&nbsp;<s:property value='datas.pageCount' /></a></li>
					<s:if test="datas.pageNo < datas.pageCount">
						<li><a href='javascript:showNextPage(null, listAction)'><span title="{*[NextPage]*}">&gt;</span></a></li>
						<li><a href='javascript:showLastPage(null, listAction)'><span title="{*[EndPage]*}">&gt;&gt;</span></a></li>
					</s:if>
					<s:else>
						<li class="disabled"><a href='javascript:showNextPage(null, listAction)'><span title="{*[NextPage]*}">&gt;</span></a></li>
						<li class="disabled"><a href='javascript:showLastPage(null, listAction)'><span title="{*[EndPage]*}">&gt;&gt;</span></a></li>
					</s:else>
				</s:if>
				<s:if test="_isShowTotalRow == 'true'">
					<!-- <span>{*[TotalRows]*}:(<s:property value="totalRowText" />)</span> -->
				</s:if>
			</ul>
			</s:if>
	    </nav>
		<!-- 分页导航结束(end of page navigate) -->

		<div style="height:66px"></div>
		<div class="card_space_fix zindex10">
	    	<table width="100%"  cellspacing="10">
	        	<tr>
	        		<s:property value="#request.htmlBean.toActHtml()" escape="false"/>
					<s:if test="#request.htmlBean.showSearchForm">
					<td>
						<a id="_searchForm" class="btn btn-primary btn-block" title="查询">查询</a>
					</td>
					</s:if>
	         	</tr>
	       	</table>
	  	</div>
		<!-- 消息提醒--start -->
		<div id="msg" class="transparent_message animated">
			<div class="msg-box">
				<div id="tip" class="tip"><!-- (<span>3</span>)(鼠标悬停暂停隐藏) --></div>
				<s:if test="hasFieldErrors()">
					<div class="msgSub" msgType="error">
						<s:iterator value="fieldErrors">
							*<s:property value="value[0]" />&nbsp;&nbsp;
						</s:iterator>
					</div>
				</s:if>
				<s:elseif test="hasActionMessages()">
					<div class="msgSub" msgType="notice">
						<s:iterator value="actionMessages">
							<s:property />
						</s:iterator>
					</div>
				</s:elseif>
			</div>
		</div>
		<div id="msgBack" class="msg-toast"></div>
		<!-- 消息提醒--end -->
	</div>
</div>
<div class="tab_parameter" name="params">
	<div data-role="page" id="_searchPanel" class="modal modal-iframe">
		<header class="bar bar-nav">
			<a class="icon icon-left-nav pull-left" id="btn-modal-close"></a>
			<h1 class="title">查询</h1>
		</header>
		<div class="content" <s:if test="#request.htmlBean.showSearchFormButton">style="margin-bottom:57px;"</s:if>>
			<div role="main" class="ui-content" id="searchFormTable">
				<s:if test="#request.htmlBean.showSearchForm">
				<!-- 要在BackURL传递的参数放在 searchFormTable-->
					<!-- 输出查询表单HTML -->
				<div class="card_app">
				    <div class="contact-form">	
						<s:property value="#request.htmlBean.toSearchFormHtml()" escape="false"/>
				   	</div>
			  	</div>
			  	<div style="height:57px"></div>
				</s:if>
			</div>
		</div>	
		<!-- 是否显示查询表单按钮 -->
		<s:if test="#request.htmlBean.showSearchFormButton">
		<div class="card_space_fix zindex10">
	    	<table width="100%"  cellspacing="10">
	        	<tr>	
	         		<td>
	         			<a onclick="modifyActionBack();" class="btn btn-primary btn-block" title="{*[Query]*}">{*[Query]*}</a>
					</td>
	         		<td>
	         			<a onclick="ev_resetAll();" class="btn btn-block" title="{*[Reset]*}">{*[Reset]*}</a>
	         		</td>
	         	</tr>
	         </table>
        </div>
		</s:if>
	</div>
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

	<s:hidden id="viewid" name="_viewid" />
	<s:hidden name="_sortCol" />
	<s:hidden name="_orderby" />
	<s:hidden name="_sortStatus" />
	
	<!-- 数据表格 -->
	<div id='doFlowRemarkDiv' style='display:none;'>
		<textarea id='_remark' type='text' style='display:none;' name='_remark'></textarea>
		<textarea id='temp_remark' rows='4' cols='35' name='temp_remark' placehoder='{*[cn.myapps.core.dynaform.view.input_audit_remark]*}'></textarea>
	</div>
</div>
</o:MultiLanguage>
