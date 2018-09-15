<!DOCTYPE html>
<html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.base.action.ParamsTable"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.core.macro.runner.*"%>
<%@ page import="cn.myapps.core.dynaform.view.ejb.Column"%>
<%@ page import="cn.myapps.core.dynaform.view.ejb.View"%>
<%@ page import="cn.myapps.core.dynaform.document.ejb.*"%>
<%@	include file="/portal/share/common/lib.jsp"%>
<%

	View view = ((View) request.getAttribute("content"));
	WebUser user =(WebUser)session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	ParamsTable params = ParamsTable.convertHTTP(request);
	String defaultSize = request.getParameter("_defaultSize");
	IRunner jsrun = JavaScriptFactory.getInstance(params.getSessionid(), view.getApplicationid());
	Collection errors = new HashSet();
	Collection columns=view.getColumns();
	String contextPath = request.getContextPath();
	// 组装queryString，WebSphere不支持getQueryString
	String queryString = "";
	Map parameterMap = request.getParameterMap();
	for(Iterator it = parameterMap.entrySet().iterator(); it.hasNext();) {
		Map.Entry entry = (Map.Entry)it.next();
		String[] values = (String[])entry.getValue();
		/*
		if(entry.getKey().equals("_viewid") || entry.getKey().equals("application") || entry.getKey().equals("isEdit") 
				|| entry.getKey().equals("_defaultSize") || entry.getKey().equals("allow") || entry.getKey().equals("fieldid")
				|| entry.getKey().equals("mutil") || entry.getKey().equals("parentid") || entry.getKey().equals("formid")
				|| entry.getKey().equals("_selectsText") || entry.getKey().equals("selectOne") || entry.getKey().equals("className")
				|| entry.getKey().equals("datetime") || entry.getKey().equals("_pagelines")){
			queryString += entry.getKey() + "="+values[0]+"&";
		}
		*/
		queryString += entry.getKey() + "="+values[0].replace("[\r|\n]", "")+"&";
	}
	
	if (!parameterMap.isEmpty()) {
		queryString = queryString.substring(0, queryString.length() - 1);
	}

%>
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<meta charset="utf-8">
<meta name="viewport" content="initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<title>Insert title here</title>
<%@	include file="/portal/phone/resource/common/js_base.jsp" %>
<link href='<o:Url value="/dynaform/view/css/mainDialogView.css" />'>
</head>
<body style="margin:0;padding:0;overflow:auto;">
	<div class="reimburse">
		<div class="mDialogBox">
			<div class="mDialogIs">
				<div name="iframe" id="iframe" style="width:100%;"></div>
		
				<div id="viewSelectBox">
					<div class="card_app">
						<div class="dataTableDiv">
							<table id="tableListSelect" class="table-column-toggle" data-mode="columntoggle">
								<tbody class="viewRightInfo">
									<tr class="dtable-header listDataTh">
										<s:if test="#parameters.mutil[0] == 'true'">
											<td class="column-head2 listDataThFirstTd" scope="col"><input type="checkbox"
												onClick="ev_selectAll_main(this.checked)"></td>
										</s:if>
										<%
										Collection hiddns = new ArrayList();
										%>
										<s:iterator value="content.columns" status="colstatus">
										<s:set name="column" scope="page" />
										<%
											Boolean isHidden = new Boolean(false);
											Column column = (Column) pageContext.getAttribute("column");
											StringBuffer label = new StringBuffer();
											label.append("View").append("." + view.getName()).append(".Activity(").append(column.getId())
													.append(")." + column.getName()).append(".runHiddenScript");
											jsrun.initBSFManager(new Document(), params, user, errors);
											Object result = jsrun.run(label.toString(), column.getHiddenScript());//运行脚本
											if (result != null && result instanceof Boolean) {
												isHidden = ((Boolean) result).booleanValue();
											}
											hiddns.add(isHidden);
											if (false){
												
											}else{
												%>
											<s:if test="width != null && width != \"0\" && !#colstatus.last">
												<th class="listDataThTd" nowrap="nowrap" width='<s:property value="width"/>' isVisible='<s:property value="visible"/>' ishiddencolumn='<%=isHidden.toString()%>' >
													<a>{*[<s:property value="name" />]*}</a>
												</th>
											</s:if>
											<s:elseif test="width == \"0\"">
												<th class="listDataThTd" style="display: none;" isVisible='<s:property value="visible"/>' ishiddencolumn='<%=isHidden.toString()%>' >
													<a>
													{*[<s:property value="name" />]*}
													</a>
												</th>
											</s:elseif>
											<s:else>
												<th class="listDataThTd" isVisible='<s:property value="visible"/>' ishiddencolumn='<%=isHidden.toString()%>'>
													<a>
													{*[<s:property value="name" />]*}
													</a>
												</th>
											</s:else>
											<%} %>
										</s:iterator>
						
										<s:if test="#parameters.allow[0] == 'true'">
											<td class="listDataThTd">
												<a>{*[View]*}</a>
											</td>
										</s:if>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="viewselect">
						<div class="container-fluid">
							<div class="row">
								<div class="col-xs-12">
					
								</div>
							</div>
						</div>
					</div>
					<div style="height:57px"></div>
				</div>
			</div>
		</div>
		<div id="selectListBtn" class="card_space_fix zindex10">
			<table width="100%" cellspacing="10">
			    <tbody>
				    <tr>
				    	<s:if test="(#parameters.mutil[0] == 'true'||#parameters.selectOne[0] == 'true')&&#parameters.isEdit[0] == 'true'">				
							<td><a class="btn btn-positive btn-block" data-transition="fade" 
							onClick="emptycheck()" title="{*[cn.myapps.core.dynaform.view.ClearFile]*}">{*[cn.myapps.core.dynaform.view.ClearFile]*}</a></td>
						</s:if>
						<s:if test="#parameters.isEdit[0] == 'true'">
							<td><a class="btn btn-positive btn-block" data-transition="fade" 
							onClick="deletechecked()" title="{*[cn.myapps.core.dynaform.view.delete_checked]*}">{*[cn.myapps.core.dynaform.view.delete_checked]*}</a></td>
						</s:if>	
						<td><a class="btn btn-positive btn-block" data-transition="fade" onClick="viewSelectBtn()" title="返回">返回</a></td>
					</tr>
				</tbody>
			</table>
		</div>

		<div id="selectBtn" class="card_space_fix zindex10">
			<table width="100%" cellspacing="10">
			    <tbody>
				    <tr>
				    	<s:if test="(#parameters.mutil[0] == 'true'||#parameters.selectOne[0] == 'true')&&#parameters.isEdit[0] == 'true'">				
							<td><a class="btn btn-positive btn-block" data-transition="fade" title="{*[OK]*}"
							onClick="ev_ok()">{*[OK]*}</a></td>
						</s:if>
						<s:if test="#parameters.isEdit[0] == 'true'">
							<td><a class="btn btn-positive btn-block" data-transition="fade" title="{*[Clear]*}"
							onClick="ev_doClear()">{*[Clear]*}</a></td>
						</s:if>	
						<td><a id="dialog_selectBtn" class="btn btn-positive btn-block" data-transition="fade" onClick="viewSelectBtn()" title="已选">已选</a></td>
					</tr>
				</tbody>
			</table>
		</div>	
	</div>
<%@	include file="/portal/phone/resource/common/js_component.jsp" %>
<script src='<s:url value="/dwr/interface/ViewHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<o:Url value='/resource/js/tableList.js' />'></script>
<script src='<o:Url value='/resource/js/iscroll.js' />'></script>
<script src='<o:Url value="/dynaform/view/js/mainDialogView.js" />'></script>
<script>
var rtn = {};
var rtnStr = "";
var args = top.OBPM.dialog.getArgs();
document.write(args['html']);
var importURL = "<s:url value='/portal/share/dynaform/dts/excelimport/importbyid.jsp'/>";
var downloadURL = '<s:url value="/portal/share/download.jsp" />'; // Excel下载URL
var isEdit = '<%=request.getParameter("isEdit")%>';
//改为弹出层后，此属性将失效，不需要判断打开方式
var type='<%=request.getParameter("_isdiv")%>';
var selectString = "";
var defalutSize = <%=defaultSize%>;		//ev_init使用
var initText = '<%=queryString%>';			//ev_init使用
var selectStr = '{*[Select]*}';				//viewDoc使用

$(function(){
	if(typeof top.hideLoadingToast == "function"){
		top.hideLoadingToast();
	}
	showLoadingToast();
	ev_init();
	//表单控件jquery重构
	jqRefactor();
	borwserCompatibility();
	hideLoadingToast();
});
</script>
</body>
</o:MultiLanguage>
</html>