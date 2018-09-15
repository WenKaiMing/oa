<%@ page contentType="text/html; charset=UTF-8" errorPage="/portal/share/error.jsp" %>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.dynaform.view.html.ViewHtmlBean"%>
<%@include file="/portal/share/common/lib.jsp"%>
<%
	//初始化HtmlBean
	ViewHtmlBean htmlBean = new ViewHtmlBean();
	htmlBean.setHttpRequest(request);
	htmlBean.setWebUser((WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER));
	request.setAttribute("htmlBean", htmlBean);
%>


<%@page import="cn.myapps.core.dynaform.document.ejb.Document"%>
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
<link rel="stylesheet" href="<s:url value='/resource/css/dialog.css'/>" type="text/css"  media="all" />
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/ViewHelper.js"/>'></script>
<!-- View页面常用function,注意先后顺序,先common后view -->
<script type="text/javascript">
var contextPath = '<%= request.getContextPath()%>' ;
var isedit = '';
var enbled='';

function doPrint() {
	window.print();
}
</script>
<script src='<s:url value='/portal/share/component/view/common.js' />'></script>
<script src='<s:url value='/portal/share/component/view/view.js' />'></script>
<title>list column by view</title>
</head>
<body>
<div id="dspview_divid">
<s:form id="formList" name="formList" action="subFormView" method="post" theme="simple">
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
	<%@include file="/common/list.jsp"%>
	<s:url id="backURL" action="subFormView" >
		<s:param name="_viewid" value="#parameters._viewid" />
		<s:param name="parentid" value="#parameters.parentid" />
		<s:param name="_currpage" value="datas.pageNo"/>
		<s:param name="isSubDoc" value="true"/>
		<s:param name="isRelate" value="#parameters.isRelate"/>
	</s:url>
	<s:textarea name="message" value="%{#request.message.content}" cssStyle="display:none" />
	<input type="hidden" name="_backURL" value="<%=request.getAttribute("backURL") %>" />
	<div id="closeWindow_DIV" class="black_overlay"></div>
	<s:hidden name="isedit" value="%{#parameters.isedit}" />
	<input type="hidden" name="divid" value="<%=request.getParameter("divid")%>" />
	<s:hidden name="parentid" value="%{#parameters.parentid}" />
	<s:hidden name="content.openType" />
	
	<%@include file="/portal/share/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<s:hidden name="isRelate" value="%{#parameters.isRelate}" />
	<table class="display_view-table" id="acttable" border="0" cellpadding="0" cellspacing="0" width="100%">
		<!-- style="display: none" -->
		<tr id="act">
			<td align="left" colspan="2">
				<table class="act_table2" style="border-bottom:1px solid #b5b8c8;" width="100%" cellpadding="0" cellspacing="0" border="0">
				<tr>
				<td>
				<!-- 输出视图操作HTML -->
				<s:property value="#request.htmlBean.toActHtml()" escape="false"/>
				</td>
				
				<!-- 分页开始 -->
				<td style="text-align:right;">
				<s:if test="_isPagination == 'true' || _isShowTotalRow == 'true'">
				<s:if test="_isPagination == 'true'">
					<s:if test="datas.pageNo  > 1">
						<a href='javascript:showFirstPage()'><img src="<s:url value='/resource/imgv2/front/main/pg_first.gif' />" alt="{*[FirstPage]*}" style="border:0px;cursor:pointer;"></a>&nbsp;
						<a href='javascript:showPreviousPage()'><img src="<s:url value='/resource/imgv2/front/main/pg_previous.gif' />" alt="{*[PrevPage]*}" style="border:0px;cursor:pointer;"></a>&nbsp;
					</s:if>
					<s:else>
						<img src="<s:url value='/resource/imgv2/front/main/pg_first_d.gif' />" style="border:0px;cursor:pointer;" alt="{*[FirstPage]*}">&nbsp;
						<img src="<s:url value='/resource/imgv2/front/main/pg_previous_d.gif' />" style="border:0px;cursor:pointer;" alt="{*[PrevPage]*}">&nbsp;
					</s:else>
					<img src="<s:url value='/resource/imgv2/front/main/act_seperate.gif' />"/>&nbsp;
					<s:property value='datas.pageNo' />{*[Page]*}&nbsp;{*[Total]*}<s:property value='datas.pageCount' />{*[Page]*}
					<img src="<s:url value='/resource/imgv2/front/main/act_seperate.gif' />"/>&nbsp;
					<s:if test="datas.pageNo < datas.pageCount">
						<a href='javascript:showNextPage()'><img src="<s:url value='/resource/imgv2/front/main/pg_next.gif' />" alt="{*[NextPage]*}" style="border:0px;cursor:pointer;"></a>&nbsp;
						<a href='javascript:showLastPage()'><img src="<s:url value='/resource/imgv2/front/main/pg_last.gif' />" alt="{*[EndPage]*}" style="border:0px;cursor:pointer;"></a>&nbsp;
					</s:if>
					<s:else>
						<img src="<s:url value='/resource/imgv2/front/main/pg_next_d.gif' />" alt="{*[NextPage]*}">&nbsp;
						<img src="<s:url value='/resource/imgv2/front/main/pg_last_d.gif' />" alt="{*[EndPage]*}">&nbsp;
					</s:else>
					<img src="<s:url value='/resource/imgv2/front/main/act_seperate.gif' />"/>&nbsp;
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
		<s:hidden name="_sortCol" />
		<s:hidden name="_orderby" />
		<s:hidden name="_sortStatus" />
		<s:hidden name="_isSubDoc" value="true" />
		
		<tr>
			<td>&nbsp;
			</td>
			
			<td style="width:150px;">&nbsp;
			</td>
		</tr>
	</table>
	
	<table class="display_view-table" style="border-top:1px solid #b5b8c8;position:relative; z-index:1" border="0" cellpadding="0" cellspacing="0" width="100%">
		<!-- table-header -->
		<tr class="dtable-header">
			<td class="column-head2" scope="col">
				<s:if test="_isRefresh == 'true' && content.searchForm != null">
					<input type="checkbox" onClick="selectAll(this.checked);">
				</s:if> 
				<s:else>
					<input type="checkbox" onClick="selectAll(this.checked)">
				</s:else>
			</td>
			
		<!-- 判断此列是否隐藏, top<Column> -->
		<s:iterator value="content.columns" status="colstatus" id="columnVO">
			<s:if test="visible && !#request.htmlBean.isHiddenColumn(top)">
				<s:if test="width != \"0\"">
					<td nowrap="nowrap" class="column-head" width='<s:property value="width"/>'>
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
		</tr>
		<!-- end of table-header -->
		
		<!-- data iterator -->
		<s:iterator value="datas.datas" status="rowStatus">
		<tr class="table-tr" onMouseOver="this.className='table-tr-onchange';" onMouseOut="this.className='table-tr';">
			<s:set name="doc" id="doc" scope="page" />
			<td class="table-td">
				<s:if test="_isRefresh == 'true' && content.searchForm != null">
					<input type="checkbox" name="_selects" value='<s:property value="id"/>'>
				</s:if> 
				<s:else>
					<input type="checkbox" name="_selects" value='<s:property value="id"/>'>
				</s:else>
			</td>
			<!-- 输出文档行HTML，top<Document> -->
			<%
			out.println(htmlBean.toRowHtml((Document)pageContext.getAttribute("doc"),null));
			%>
			<!--
			<s:property value="#request.htmlBean.toRowHtml(top)" escape="false"/>
			 -->
			</tr>
		</s:iterator>
		<!-- end of data iterator -->
		
		<!-- 字段值汇总 -->
		<s:if test="content.sum">
		<tr class="table-tr" onMouseOver="this.className='table-tr-onchange';" onMouseOut="this.className='table-tr';">
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
</s:form></div>

</body>

<script lanaguage="javaScript">
	function createDoc(activityid) {
		// 查看/script/view.js
		var action = activityAction + "?_activityid=" + activityid
		openWindowByType(action,'{*[New]*}', VIEW_TYPE_SUB); 
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
		
		openWindowByType(url,'{*[Select]*}', VIEW_TYPE_SUB); 
	}

function on_unload() {
	ev_reloadParent();
}

function handleDbClick() {
if(event.srcElement.onclick){
}else if(event.srcElement.type!=null&&(event.srcElement.type.toUpperCase()=='SUBMIT'
||event.srcElement.type.toUpperCase()=='BUTTON'
||event.srcElement.type.toUpperCase()=='CHECKBOX'
||event.srcElement.type.toUpperCase()=='RADIO'
||event.srcElement.type.toUpperCase()=='SELECT'
||event.srcElement.type.toUpperCase()=='IMG'))
{
  
}
else{
	zoompage();
}
}

function zoompage() {
 	var typeflage = typeof(dialogArguments);
 	if(typeflage != 'undefined' ) {    
    	
    } else if(window.opener) {
    	
    } else {
   
        window.top.IsResize();
    } 
     ev_onload();
}
</script>
<script src='<s:url value="/portal/share/component/dateField/datePicker/WdatePicker.js" />' ></script>

</o:MultiLanguage></html>
