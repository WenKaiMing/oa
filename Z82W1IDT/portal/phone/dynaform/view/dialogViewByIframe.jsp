<!DOCTYPE html>
<html style="height:100%;">
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@ page import="net.sf.json.JSONObject"%>
<%@ page import="net.sf.json.JSONArray"%>
<%@ page import="net.sf.json.util.JSONStringer"%>
<%@ page import="net.sf.json.JSON"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="cn.myapps.core.dynaform.view.ejb.View"%>
<%@ page import="cn.myapps.core.dynaform.document.ejb.*"%>
<%@ page import="cn.myapps.base.action.ParamsTable"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.core.macro.runner.*"%>
<%@ page import="cn.myapps.core.dynaform.view.ejb.Column"%>
<%@ page import="cn.myapps.core.dynaform.form.ejb.Form"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.base.dao.DataPackage" %>
<%@ page import="cn.myapps.util.StringUtil"%>
<%@ page import="cn.myapps.core.dynaform.view.action.ViewHelper"%>
<%@ page import="cn.myapps.core.dynaform.form.ejb.MapField"%>
<%@page import="cn.myapps.core.dynaform.form.ejb.TreeDepartmentField"%>
<%@page import="cn.myapps.core.dynaform.form.ejb.DepartmentField"%>
<%@page import="cn.myapps.core.dynaform.form.ejb.SuggestField"%>
<%@page import="cn.myapps.core.dynaform.form.ejb.UserField"%>
<%@page import="cn.myapps.core.dynaform.form.ejb.ImageUploadField"%>
<%@page import="cn.myapps.core.dynaform.form.ejb.AttachmentUploadField"%>
<%@page import="cn.myapps.core.dynaform.form.ejb.WeixinGpsField"%>
<%@page import="cn.myapps.core.dynaform.form.ejb.GenericWordField"%>

<%View view = ((View) request.getAttribute("content"));
	WebUser user =(WebUser)session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	ParamsTable params = ParamsTable.convertHTTP(request);
	IRunner jsrun = JavaScriptFactory.getInstance(params.getSessionid(), view.getApplicationid());
	Collection errors = new HashSet();
	Collection columns=view.getColumns();
	String viewid=request.getParameter("_viewid");
	String styleid=ViewHelper.get_Styleid(viewid);
	String type=request.getParameter("_isdiv");
	request.setAttribute("runner", jsrun);
	String selectOne = request.getParameter("selectOne");
%>

<%@page import="cn.myapps.core.dynaform.form.ejb.ValidateMessage"%>
<%@page import="cn.myapps.core.dynaform.form.ejb.FormField"%><html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<meta charset="utf-8">
<meta name="viewport" content="initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<title>list column by view</title>
<script type="text/javascript">
var USER = {
		id : "<%=user.getId()%>"
	};
$(function(){
	jqRefactor();
	tableListColumn();
	if($("div#searchForm").size()>0){
		var searchBtn = "<td><a id='searchBtn' _href='#searchForm' class='btn btn-primary btn-block' title='查询'>查询</a></td>"
		if($(this).find("#searchBtn").size()<=0){
			$(this).find("#dialog_selectBtn").parent("td").before(searchBtn);
		}
		
		$("#searchBtn").click(function(){
			$(".mDialogBox ").css("z-index","9999")
			$("#searchForm").next(".card_app").hide();
			$("#searchForm").show();
			setTimeout(function(){
				$("#searchForm").addClass("active");
			},500);
		})
		
		$("#searchForm").find("#btn-modal-close").click(function(){
			$("#searchForm").removeClass("active");
			$("#searchForm").next(".card_app").show();
			$(".mDialogBox ").css("z-index","1")
			setTimeout(function(){
				$("#searchForm").hide();
			},1000);
		})
	} 
	var footerH = $("#footer").height();
	$("#tableListColumn").parent(".dataTableDiv").height($("#iframe").height()-footerH-87);
	$(".tableList-screen").click(function(){
		$("#searchFormTable").width($("#dialongViewTable").width());
		$(".mDialogIs").width($("#dialongViewTable").width());
		$("#tableListColumn").parent(".dataTableDiv").height($("#iframe").height()-footerH-87);
		searchScroll.refresh();
	});
	if(typeof top.hideLoadingToast == "function"){
		top.hideLoadingToast();
	}
});
</script>
</head>
<body style="margin:0;padding:0;height:100%; width:98%;overflow:hidden;">
	<s:form id="formList" name="formList" cssStyle="width:100%;" action="iframeDialogView4phone" method="post" theme="simple">
		<div id="view_iframe" class="dataTableDiv">
		<input type="hidden" name="_currpage" value='<s:property value="datas.pageNo"/>' />
		<input type="hidden" name="_pagelines" value='<s:property value="content.pagelines"/>' />
		<input type="hidden" name="_rowcount" value='<s:property value="datas.rowCount"/>' />
		<input type="hidden" name="_pageCount" value='<s:property value="datas.pageCount"/>' />
		<s:hidden name="mutil" value="%{#parameters.mutil}" />
		<s:hidden name="selectOne" value="%{#parameters.selectOne}" />
		<s:hidden name="allow" value="%{#parameters.allow}" />
		<s:hidden name="className" value="%{#parameters.className}" />
		<s:hidden name="_isdiv" value="%{#parameters._isdiv}" />
		<s:hidden name="isEdit" value="%{#parameters.isEdit}" />
		<s:hidden name="_sortCol" value="%{#parameters._sortCol}" />
		<s:hidden name="_sortStatus" value="%{#parameters._sortStatus}" />
		<s:hidden name="parentid" value="%{#parameters.parentid}" />
		<s:hidden name="content.openType" />
		<s:hidden id="viewid" name="_viewid" />
		<s:hidden id="formid" name="formid" value="%{#parameters.formid}"/>
		<s:hidden id="fieldid" name="fieldid" value="%{#parameters.fieldid}"/>
		<input type="hidden" name="application" id="application" value="<%=view.getApplicationid()%>" />
		<input type="hidden" name="divid" value="%{#parameters.divid}" />
		
		<!-- 确定脚本标签 -->
		<s:hidden name="okscriptlabel" value="%{#parameters.okscriptlabel}" />
		
            
		<div id="dspview_divid">
			<%
				Form searchForm = view.getSearchForm();
					if (searchForm != null) {
			%>
			<div data-role="page" id="searchForm" class="modal modal-iframe">
				<header class="bar bar-nav">
					<a class="icon icon-close pull-right" id="btn-modal-close" _href="#searchForm"></a>
					<h1 class="title">查询</h1>
				</header>
				<div class="content" style="bottom:57px;">
					<div role="main" class="ui-content" id="searchFormTable">
						<div class="card_app">
							<div class="contact-form">	
								<%
									Document searchDoc = searchForm.createDocument(params, user);
									String ehtml = searchForm.toHtml(searchDoc, params, user, new ArrayList<ValidateMessage>());
									out.print(ehtml);
								%>
							</div>
						</div>
						<div style="height:57px"></div>
					</div>
					
				</div>
				<div class="card_space_fix zindex10">
					<table width="100%"  cellspacing="10">
						<tr>	
							<td><a onclick="queryDocument();" class="btn btn-primary btn-block" title="{*[Query]*}">{*[Query]*}</a></td>
							<td><a onclick="ev_resetAll();" class="btn btn-block" title="{*[Reset]*}">{*[Reset]*}</a></td>
						</tr>
					</table>
				</div>
			</div>
			<%
				}
			%>
			
			<div class="card_app">
			
			<div class="dataTableDiv" style="overflow:auto;">
			<table id="tableListColumn" class="table-column-toggle" data-mode="columntoggle">
				<tbody id="viewLeft">
				<tr class="listDataTh">
					<s:if test="#parameters.mutil[0] == 'true'">
						<td class="listDataThFirstTd" scope="col">
							<input type="checkbox" name="selectAll">
						</td>
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
						}else{
							isHidden = !column.isVisible();
						}
						hiddns.add(isHidden);
						if (false){
							
						}else{
							%>
						<s:if test="width != null && width != \"0\" && !#colstatus.last">
							<th class="listDataThTd" nowrap="nowrap" width='<s:property value="width"/>' isVisible='<s:property value="visible"/>' ishiddencolumn='<%=isHidden.toString()%>'>
							<a > {*[<s:property value="name" />]*} 
								<s:if test="_sortCol!=null && _sortCol!='' && _sortCol.toUpperCase()==fieldName.toUpperCase() ">
								<s:if test="_sortStatus=='ASC'">
									<img border=0 src='<s:url value="/portal/share/images/view/up.gif"/>'>
								</s:if>
								<s:elseif test="_sortStatus=='DESC'">
									<img border=0 src='<s:url value="/portal/share/images/view/down.gif"/>'>
								</s:elseif>
							</s:if> </a></th>
						</s:if>
						<s:elseif test="width == \"0\"">
							<th class="listDataThTd" isVisible='<s:property value="visible"/>' ishiddencolumn='<%=isHidden.toString()%>' style="display: none;">
								{*[<s:property value="name" />]*}
							</th>
						</s:elseif>
						<s:else>
							<th class="listDataThTd" isVisible='<s:property value="visible"/>' ishiddencolumn='<%=isHidden.toString()%>'><a style='cursor: pointer'> 
								{*[<s:property value="name" />]*}
								<s:if test="_sortCol!=null && _sortCol!=''">
								<s:if test="_sortCol.toUpperCase()==fieldName.toUpperCase()">
									<s:if test="_sortStatus=='ASC'">
										<img border=0 src='<s:url value="/portal/share/images/view/up.gif"/>'>
									</s:if>
									<s:elseif test="_sortStatus=='DESC'">
										<img border=0 src='<s:url value="/portal/share/images/view/down.gif"/>'>
									</s:elseif>
								</s:if>
							</s:if> </a></th>
						</s:else>
						<%} %>
					</s:iterator>
	
					<s:if test="#parameters.allow[0] == 'true'">
						<td class="listDataThTd">{*[View]*}</td>
					</s:if>
				</tr>
	
				<s:iterator value="datas.datas" status="docStatus">
					<tr class="listDataTr">
						<s:set name="doc" id="doc" scope="page" />
						<%
							Document doc = (Document) pageContext.getAttribute("doc");
							jsrun.initBSFManager(doc, params, user, errors);

							String trueValueMap = "{";
							String valuesMap = "{";
							String valuesStateLabel = "";
							String valuesAuditNode = "";
							String valuesAuditUser = "";
							Iterator it = columns.iterator();
							while (it.hasNext()) {
								Column key = (Column) it.next();

								Object value = key.getText(doc, jsrun, user);
								String trueValue = "";
								FormField formField = key.getFormField();
								String formType = formField.getType();
								if("attachmentupload".equals(formType)
										||"imageupload".equals(formType)){
									trueValue = key.getValue4FileUplad(doc, jsrun, user,null);
								}
								if("$StateLabel".equals(key.getFieldName()) && value.toString().indexOf("[")==0){//视图列绑定流程状态字段类型
									//解析json数据生成html
									JSONArray instances = JSONArray.fromObject(value); 
									Long[] arr=new Long[instances.size()];
									 for(int i=0;i<instances.size();i++){
											JSONObject instance = instances.getJSONObject(i);
											String instanceId = instance.getString("instanceId");
											JSONArray nodes = instance.getJSONArray("nodes");
											for(int j=0;j<nodes.size();j++){
												JSONObject node = nodes.getJSONObject(j);
												String stateLable = node.getString("stateLabel");
												valuesStateLabel += stateLable+";";
											}
									 }
									 valuesMap += "'" + key.getId() + "':'" + valuesStateLabel + "',";
									 trueValueMap += "'" + key.getId() + "':'" + valuesStateLabel + "',";
								}else if("$PrevAuditNode".equals(key.getFieldName()) && value.toString().indexOf("[")==0){//视图列绑定上一环节流程处理节点名称字段
									//解析json数据生成html
									JSONArray instances = JSONArray.fromObject(value);  
								    Long[] arr=new Long[instances.size()];  
								    for(int i=0;i<instances.size();i++){  
										JSONObject instance = instances.getJSONObject(i);
										String instanceId = instance.getString("instanceId");
										String prevAuditNode = instance.getString("prevAuditNode");
										valuesAuditNode += prevAuditNode+";";
								    }
									 valuesMap += "'" + key.getId() + "':'" + valuesAuditNode + "',";
									 trueValueMap += "'" + key.getId() + "':'" + valuesAuditNode + "',";
								}else if("$PrevAuditUser".equals(key.getFieldName()) && value.toString().indexOf("[")==0){//视图列绑定上一环节流程处理节点人名称字段
									//解析json数据生成html
									JSONArray instances = JSONArray.fromObject(value);  
								    Long[] arr=new Long[instances.size()];  
								    for(int i=0;i<instances.size();i++){  
										JSONObject instance = instances.getJSONObject(i);
										String instanceId = instance.getString("instanceId");
										String prevAuditUser = instance.getString("prevAuditUser");
										valuesAuditUser += prevAuditUser+";";
								    }
									 valuesMap += "'" + key.getId() + "':'" + valuesAuditUser + "',";
									 trueValueMap += "'" + key.getId() + "':'" + valuesAuditUser + "',";
								}else{
									valuesMap += "'" + key.getId() + "':'" + StringUtil.encodeHTMLForDialog(value.toString()) + "',";
									if("attachmentupload".equals(formType)
											||"imageupload".equals(formType)){
										trueValueMap += "'" + key.getId() + "':'" + trueValue + "',";
									}else{
										trueValueMap += "'" + key.getId() + "':'" + StringUtil.encodeHTMLForDialog(value.toString()) + "',";
									}
								}
							}
							valuesMap = valuesMap.substring(0, valuesMap.length() - 1);
							trueValueMap = trueValueMap.substring(0, trueValueMap.length() - 1);
							valuesMap += "}";
							trueValueMap += "}";
						%>
						<s:if test="#parameters.mutil[0] == 'true'">
							<td class="listDataTrFirstTd"><input type="checkbox" name="_selects"
								value="<%=doc.getId().replace("&", "_")%>" data-values="<%=valuesMap%>" /></td>
						</s:if>
	
						<%
							jsrun.initBSFManager(doc, params, user, errors);
							Iterator iter = columns.iterator();
						    Iterator hd =hiddns.iterator();
							while (iter.hasNext()) {
								Column col = (Column) iter.next();

								String _trueValue = "";
								Object result = col.getText(doc, jsrun, user);
								FormField formField = col.getFormField();
								if(formField instanceof WeixinGpsField){
									if(!StringUtil.isBlank(result.toString())){
										JSONObject resultJson = JSONObject.fromObject(result.toString());
										result = resultJson.get("address");
									}
								}else if(formField instanceof GenericWordField){
									if(!StringUtil.isBlank(result.toString())){
										String resHtml = "<img class='genericword' src='../../share/images/view/genericword.jpg'/>";
										result = resHtml;
									}
								}else if(formField instanceof MapField){
									if(!StringUtil.isBlank(result.toString())){
										String resHtml = "<TABLE style=\"width:280px;border:0;\">";
										String results="["+result+"]";
										JSONArray instances = JSONArray.fromObject(results); 
										for(int i=0;i<instances.size();i++){
											if(i+1==instances.size()){	//最后一行不显示下边框线
												resHtml += "<tr><td style=\"line-height:16px;border-right-width:0;border-bottom-width:0; border-right-style: none;\">";
											}else{
												resHtml += "<tr><td style=\"line-height:16px;border-right-width: 0px; border-right-style: none;\">";
											}
											JSONObject instance = instances.getJSONObject(i);
											String address=instance.getString("address");
											resHtml += address+"&nbsp;&nbsp;";
											resHtml += "</td></tr>";
										}
										resHtml += "</TABLE>";
										result = resHtml;
									}
								}else if((formField instanceof AttachmentUploadField) 
										|| (formField instanceof ImageUploadField)){

									_trueValue = col.getValue4FileUplad(doc, jsrun, user,null);
									if(!StringUtil.isBlank(result.toString())){
										JSONArray instances = JSONArray.fromObject(result);
									    Long[] arr=new Long[instances.size()];
									    String resHtml = "";
									    for(int i=0;i<instances.size();i++){  
											JSONObject instance = instances.getJSONObject(i);
											String _url = request.getContextPath() + instance.getString("path");
											resHtml += "<div class='images-preview' data-src='"+_url
													+"' style='display: inline-block;margin:3px;'>" +
													"<img style='max-height:50px;max-width:50px;' src='"+_url+"' />" +
													"</div>";
									    }
										result = resHtml;
									}
								}else if(formField instanceof UserField 
											 || formField instanceof SuggestField
											 || formField instanceof DepartmentField
											 || formField instanceof TreeDepartmentField){
									_trueValue = col.getValueAndText(doc, jsrun, user,null);
								}else{
									_trueValue = StringUtil.encodeHTMLForDialog(result.toString());
								}
								/**多流程状态时数据处理--start**/
								if("$StateLabel".equals(col.getFieldName()) && result.toString().indexOf("[")==0){//视图列绑定流程状态字段类型
									if(!StringUtil.isBlank(result.toString())){
										String resHtml = "<TABLE style=\"width:100%;border:0;\">";
										String valStateLabel = "";
										JSONArray instances = JSONArray.fromObject(result);  
									    Long[] arr=new Long[instances.size()];  
									    for(int i=0;i<instances.size();i++){  
											if(i+1==instances.size()){	//最后一行不显示下边框线
												resHtml += "<tr><td style=\"line-height:16px;border-right-width:0;border-bottom-width:0; border-right-style: none;\">";
											}else{
												resHtml += "<tr><td style=\"line-height:16px;border-right-width: 0px; border-right-style: none;\">";
											}
											JSONObject instance = instances.getJSONObject(i);
											String instanceId = instance.getString("instanceId");
											JSONArray nodes = instance.getJSONArray("nodes");
											for(int j=0;j<nodes.size();j++){
												JSONObject node = nodes.getJSONObject(j);
												String stateLable = node.getString("stateLabel");
												resHtml += stateLable+"&nbsp;&nbsp;";
												valStateLabel += stateLable+";";
											}
											resHtml += "</td></tr>";
											
									    }
										resHtml += "</TABLE>";
										result = resHtml;
										 _trueValue = valStateLabel;
									}
								}else if("$PrevAuditNode".equals(col.getFieldName()) && result.toString().indexOf("[")==0){//视图列绑定上一环节流程处理节点名称字段
									//解析json数据生成html
									if(!StringUtil.isBlank(result.toString())){
										String valAuditNode = "";
										String resHtml = "<TABLE style=\"width:100%;border:0;\">";
										JSONArray instances = JSONArray.fromObject(result);  
									    Long[] arr=new Long[instances.size()];  
									    for(int i=0;i<instances.size();i++){  
											JSONObject instance = instances.getJSONObject(i);
											String instanceId = instance.getString("instanceId");
											String prevAuditNode = instance.getString("prevAuditNode");
											if(i+1==instances.size()){	//最后一行不显示下边框线
												resHtml += "<tr><td title=\""+prevAuditNode+"\" style=\"line-height:16px;border-right-width:0;border-bottom-width:0; border-right-style: none;\">";
											}else{
												resHtml += "<tr><td title=\""+prevAuditNode+"\" style=\"line-height:16px;border-right-width: 0px; border-right-style: none;\">";
											}
											resHtml += prevAuditNode+"&nbsp;&nbsp;";
											resHtml += "</td></tr>";
											valAuditNode += prevAuditNode + ";";
									    }
										resHtml += "</TABLE>";
										result = resHtml;
										 _trueValue =  valAuditNode;
									}
								}else if("$PrevAuditUser".equals(col.getFieldName()) && result.toString().indexOf("[")==0){//视图列绑定上一环节流程处理节点人名称字段
									//解析json数据生成html
									if(!StringUtil.isBlank(result.toString())){
										String valAuditUser = "";
										String resHtml = "<TABLE style=\"width:100%;border:0;\">";
										JSONArray instances = JSONArray.fromObject(result);  
									    Long[] arr=new Long[instances.size()];  
									    for(int i=0;i<instances.size();i++){  
											JSONObject instance = instances.getJSONObject(i);
											String instanceId = instance.getString("instanceId");
											String prevAuditUser = instance.getString("prevAuditUser");
											if(i+1==instances.size()){	//最后一行不显示下边框线
												resHtml += "<tr><td title=\""+prevAuditUser+"\" style=\"line-height:16px;border-right-width:0;border-bottom-width:0; border-right-style: none;\">";
											}else{
												resHtml += "<tr><td title=\""+prevAuditUser+"\" style=\"line-height:16px;border-right-width: 0px; border-right-style: none;\">";
											}
											resHtml += prevAuditUser+"&nbsp;&nbsp;";
											resHtml += "</td></tr>";
											valAuditUser += prevAuditUser + ";";
									    }
										resHtml += "</TABLE>";
										result = resHtml;
										 _trueValue = valAuditUser;
									}
								}
								/**多流程状态时数据处理--end**/
								
								Boolean isHidden = (Boolean)hd.next();
								if ((col.getWidth() != null && col.getWidth().equals("0")) || !col.isVisible()) {
						%>
						<td class="listDataTrTd" style="display: none;" >
						<%
								} else {
						%>
						
						<td class="listDataTrTd">
						<s:if test="#parameters.className[0] == 'cn.myapps.core.dynaform.form.ejb.ViewDialogField'">
							<div name='truevalue' key='<%=col.getId() %>' style="display: none"><%=_trueValue %></div>
							<s:if test="#parameters.isEdit[0]">
								<a _value='<%=doc.getId()%>'><%=result%> </a>
							</s:if>
							<s:else>
								<%=result%>
							</s:else>
						</s:if>
						&nbsp;
						</td>
						<%
								}
							}
						%>
						<!-- 是否允许查看记录 -->
						<s:if test="#parameters.allow[0] == 'true'">
							<td class="listDataTrTd"><input type="image" name='btnView'
								src="<s:url value="/portal/share/images/act/act_1.gif"/>"
								onclick="viewDoc('<s:property value="id" />','<s:property value="formid" />','<%=type%>')" />
							</td>
						</s:if>
					</tr>
				</s:iterator>
				
			
	
				</tbody>
			</table>
			</div>
			</div>
			
				<!-- 分页导航(page navigate)1 -->	
<nav id="footer" class="text-center">
<s:if test="_isPagination == 'true' || _isShowTotalRow == 'true'">
	<ul class="pagination"  style="margin:0;">
		<s:if test="_isPagination == 'true'">
			<s:if test="datas.pageNo  > 1">
				<li><a href='javascript:showFirstPageByAjax()'><span title="{*[FirstPage]*}">&lt;&lt;</span></a></li>
				<li><a href='javascript:showPreviousPageByAjax()'><span title="{*[PrevPage]*}">&lt;</span></a></li>
			</s:if>
			<s:else>
				<li class="disabled"><a href='javascript:showFirstPageByAjax()'><span title="{*[FirstPage]*}">&lt;&lt;</span></a></li>
				<li class="disabled"><a href='javascript:showPreviousPageByAjax()'><span title="{*[PrevPage]*}">&lt;</span></a></li>
			</s:else>
			<li><a href='javascript:showFirstPageByAjax()'><s:property value='datas.pageNo' />&nbsp;/&nbsp;<s:property value='datas.pageCount' /></a></li>
			<s:if test="datas.pageNo < datas.pageCount">
				<li><a href='javascript:showNextPageByAjax()'><span title="{*[NextPage]*}">&gt;</span></a></li>
				<li><a href='javascript:showLastPageByAjax()'><span title="{*[EndPage]*}">&gt;&gt;</span></a></li>
			</s:if>
			<s:else>
				<li class="disabled"><a href='javascript:showNextPageByAjax()'><span title="{*[NextPage]*}">&gt;</span></a></li>
				<li class="disabled"><a href='javascript:showLastPageByAjax()'><span title="{*[EndPage]*}">&gt;&gt;</span></a></li>
			</s:else>
		</s:if>
	</ul>
</s:if>
</nav>
<!-- 分页导航结束(end of page navigate) -->
	<div style="height:57px"></div>		
		</div>
		</div>
	</s:form>
	</body>
	
</o:MultiLanguage>
</html>