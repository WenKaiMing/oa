<%@page import="cn.myapps.core.dynaform.form.ejb.ImageUploadField"%>
<%@page import="cn.myapps.core.dynaform.form.ejb.AttachmentUploadField"%>
<%@page import="cn.myapps.core.dynaform.form.ejb.WeixinGpsField"%>
<%@page import="cn.myapps.core.dynaform.form.ejb.GenericWordField"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>

<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.util.JSONStringer"%>
<%@page import="net.sf.json.JSON"%>
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
<%@ page import="cn.myapps.core.dynaform.view.html.ViewHtmlBean"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%View view = ((View) request.getAttribute("content"));
	ViewHtmlBean htmlBean = new ViewHtmlBean();
	htmlBean.setHttpRequest(request);
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
	Boolean showWaterMark = view.getShowWaterMark();
	boolean show = showWaterMark != null ? showWaterMark : false;
    String content = htmlBean.getWaterMark();
    content = content != null ? content : "";
%>

<%@page import="cn.myapps.core.dynaform.form.ejb.ValidateMessage"%>
<%@page import="cn.myapps.core.dynaform.form.ejb.FormField"%><html>
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="x-ua-compatible" content="ie=edge,chrome=1">
	<title>list column by view</title>
	<link rel="stylesheet" href="<s:url value='/resource/css/main-front.css'/>" type="text/css" />
	<!-- bootstrap引入 -->

	<link rel="stylesheet" href="<s:url value='/portal/share/script/bootstrap/css/bootstrap.min.css'/>" />
	<link rel="stylesheet" href="<s:url value='/portal/share/script/bootstrap/css/bootstrap-datetimepicker.min.css'/>" />
	<script src="<s:url value='/portal/share/script/bootstrap/script/bootstrap.min.js'/>"></script> 
	<script src="<s:url value='/portal/share/script/bootstrap/script/bootstrap-datetimepicker.min.js'/>"></script> 
	<script src="<s:url value='/portal/share/script/bootstrap/script/bootstrap-datetimepicker.zh-CN.js'/>"></script> 
		
	<link rel="stylesheet" href="<s:url value='/portal/share/script/bootstrap/css/myapp.css'/>" type="text/css" />
	<link rel="stylesheet" href="<s:url value='/portal/share/script/bootstrap/css/view.css'/>" type="text/css" />

	<script src='<s:url value='/portal/share/script/jquery.watermark.js' />'></script>

<script type="text/javascript">
var watermark = {
		show : <%=show%>,
		content : '<%=content%>'
	};
OBPM(document).ready(function(){
	if(watermark.show){
		$("body").watermark({
            texts : [watermark.content] //水印文字,[]数组形式
        })
	};
	jqRefactor();
});
</script>
</head>
<body style="margin:0;padding:0;height:100%; width:98%;overflow:hidden;">
	<s:form id="formList" name="formList" cssStyle="width:100%;overflow:hidden;" action="iframeDialogView" method="post" theme="simple">
		<div id="view_iframe">
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
		<!-- page navigate --> 
		<s:if test="_isPagination == 'true' || _isShowTotalRow == 'true'">
                
			<div class="searchDiv">

				<ul class="pagination fr">
	            	<s:if test="_isPagination == 'true'">
						<s:if test="datas.pageNo  > 1">						
							<a class="first page icon16" href='javascript:showFirstPageByAjax()'></a>
							<a class="pre page icon16" href='javascript:showPreviousPageByAjax()'></a>				
						</s:if>					
						<s:else>						
							<a class="first_d page icon16"></a>
							<a class="pre_d page icon16"></a>					
						</s:else>					
						<div class="pagetxt page">
							<span>
								<s:property value='datas.pageNo' />/<s:property value='datas.pageCount' />{*[Page]*}						
							</span>
							<s:if test="datas.pageCount > 1">
								<span>
									<input type="text" name="_jumppage" class="img_go" onclick='javascript:jumpPageByAjax();'/>								
								</span>
							</s:if>
						</div>
						<s:if test="datas.pageNo < datas.pageCount">						
							<a class="next page icon16" href='javascript:showNextPageByAjax()'></a>
							<a class="last page icon16" href='javascript:showLastPageByAjax()'></a>
						</s:if>
						<s:else>						
							<a class="next_d page icon16"></a>
							<a class="last_d page icon16"></a>							
						</s:else>						
					</s:if>
					<!-- 
	                <li> <a href="#" aria-label="Previous"> <span aria-hidden="true">&laquo;</span> </a> </li>
	                <li><a href="#">1</a></li>
	                <li><a href="#">2</a></li>
	                <li><a href="#">3</a></li>
	                <li><a href="#">4</a></li>
	                <li><a href="#">5</a></li>
	                <li> <a href="#" aria-label="Next"> <span aria-hidden="true">&raquo;</span> </a> </li>
	                 -->
	            </ul>

				<div class="input-group">
			 		<s:if test="_isShowTotalRow == 'true'">			 		
			 			<span style="padding-bottom: 8px; vertical-align: middle;">{*[TotalRows]*}:(<s:property value="totalRowText" />)</span>		 			
					</s:if>
					<!-- 
                    <input type="text" class="form-control" placeholder="查询值">
                    <span class="input-group-btn">
                    <button class="btn" type="button">跳转</button>
                    </span>
                     -->
                </div>

                <div class="clearfix"></div>
	            
			</div>
		</s:if> 
		<!-- end of page navigate -->
            
		<div id="dspview_divid">
			<%
				Form searchForm = view.getSearchForm();
					if (searchForm != null) {
			%>
			<div class="searchDiv">
				<div class="container-fluid">
				<%
					Document searchDoc = searchForm.createDocument(params, user);
					String ehtml = searchForm.toHtml(searchDoc, params, user, new ArrayList<ValidateMessage>());
					out.print(ehtml);
				%>
	               	<div class="row">
	                   	<div class="col-xs-12 text-center">
	                       	<button type="button" class="btn ico-search" onClick="queryDocument()">{*[Query]*}</button>
	                       	<button type="button" class="btn ico-reset" onclick="ev_resetAll()">{*[Reset]*}</button>
	                   	</div>
	               	</div>
				</div>
			</div>
			<%
				}
			%>
			<div class="dataTable">
			<table class="listDataTable text-center">
				<tbody id="viewLeft">
				<tr class="listDataTh">
					<s:if test="#parameters.mutil[0] == 'true'">
						<td class="listDataThFirstTd" scope="col"><input type="checkbox"
							onClick="ev_selectAll_Left(this.checked)"></td>
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
						if (isHidden.booleanValue()){
							
						}else{
							%>
						<s:if test="width != null && width != \"0\" && !#colstatus.last">
							<td class="listDataThTd" nowrap="nowrap" width='<s:property value="width"/>'>
							<a > {*[<s:property value="name" />]*} 
								<s:if test="_sortCol!=null && _sortCol!='' && _sortCol.toUpperCase()==fieldName.toUpperCase() ">
								<s:if test="_sortStatus=='ASC'">
									<img border=0 src='<s:url value="/portal/share/images/view/up.gif"/>'>
								</s:if>
								<s:elseif test="_sortStatus=='DESC'">
									<img border=0 src='<s:url value="/portal/share/images/view/down.gif"/>'>
								</s:elseif>
							</s:if> </a></td>
						</s:if>
						<s:elseif test="width == \"0\"">
							<td class="listDataThTd" style="display: none;">
								{*[<s:property value="name" />]*}
							</td>
						</s:elseif>
						<s:else>
							<td class="listDataThTd"><a style='cursor: pointer'> 
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
							</s:if> </a></td>
						</s:else>
						<%} %>
					</s:iterator>
	
					<s:if test="#parameters.allow[0] == 'true'">
						<td class="listDataThTd">{*[View]*}</td>
					</s:if>
				</tr>
	
				<s:iterator value="datas.datas" status="docStatus">
					<tr class="listDataTr"
						onMouseOver="this.className='listDataTr_over';"
						onMouseOut="this.className='listDataTr';">
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
								value="<%=doc.getId().replace("&", "_")%>"
								onclick="ev_select(this.value,<%=valuesMap%>,this.checked,this)" /></td>
						</s:if>
	
						<%
							Iterator iter = columns.iterator();
						    Iterator hd =hiddns.iterator();
									while (iter.hasNext()) {
										Column col = (Column) iter.next();
	
										Object result = col.getText(doc, jsrun, user);
										if(col.getFormField() instanceof WeixinGpsField){
											if(!StringUtil.isBlank(result.toString())){
												JSONObject resultJson = JSONObject.fromObject(result.toString());
												result = resultJson.get("address");
											}
										}else if(col.getFormField() instanceof GenericWordField){
											if(!StringUtil.isBlank(result.toString())){
												String resHtml = "<img class='genericword' src='../../share/images/view/genericword.jpg'/>";
												result = resHtml;
											}
										}else if(col.getFormField() instanceof MapField){
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
										}else if((col.getFormField() instanceof AttachmentUploadField) 
												|| (col.getFormField() instanceof ImageUploadField)){

											if(!StringUtil.isBlank(result.toString())){
												JSONArray instances = JSONArray.fromObject(result);
											    Long[] arr=new Long[instances.size()];
											    String resHtml = "";
											    for(int i=0;i<instances.size();i++){  
													JSONObject instance = instances.getJSONObject(i);
													String _url = request.getContextPath() + instance.getString("path");
													String _name = instance.getString("name");
													resHtml += "<div class='images-preview' data-src='"+_url
															+"' style='display: inline-block;margin:3px;'>" +
															"<span _url='"+_url+"' >"+ _name +"</span>" +
															"</div>";
											    }
												result = resHtml;
											}
										}
										/**多流程状态时数据处理--start**/
										if("$StateLabel".equals(col.getFieldName()) && result.toString().indexOf("[")==0){//视图列绑定流程状态字段类型
											if(!StringUtil.isBlank(result.toString())){
												String resHtml = "<TABLE style=\"width:100%;border:0;\">";
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
													}
													resHtml += "</td></tr>";
													
											    }
												resHtml += "</TABLE>";
												result = resHtml;
											}
										}else if("$PrevAuditNode".equals(col.getFieldName()) && result.toString().indexOf("[")==0){//视图列绑定上一环节流程处理节点名称字段
											//解析json数据生成html
											if(!StringUtil.isBlank(result.toString())){
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
											    }
												resHtml += "</TABLE>";
												result = resHtml;
											}
										}else if("$PrevAuditUser".equals(col.getFieldName()) && result.toString().indexOf("[")==0){//视图列绑定上一环节流程处理节点人名称字段
											//解析json数据生成html
											if(!StringUtil.isBlank(result.toString())){
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
											    }
												resHtml += "</TABLE>";
												result = resHtml;
											}
										}
										/**多流程状态时数据处理--end**/
										
										Boolean isHidden = (Boolean)hd.next();
										if (isHidden.booleanValue()){
											
										}else {
										if ((col.getWidth() != null && col.getWidth().equals("0")) || !col.isVisible()) {
						%>
						<td class="listDataTrTd" style="display: none;">
						<%
							} else {
						%>
						
						<td class="listDataTrTd"">
						<s:if test="#parameters.className[0] == 'cn.myapps.core.dynaform.form.ejb.ViewDialogField'">
							<div id='valuemap<s:property value="#docStatus.index" />' style="display: none"><%=trueValueMap%></div>
							<s:if test="#parameters.isEdit[0]">
								<s:if test="#parameters.selectOne[0] == 'false'">
									<a onClick="ev_selectone('<%=doc.getId().replace("&", "_")%>', document.getElementById('valuemap<s:property value="#docStatus.index" />').innerText,'<%=selectOne%>');">
									<%if(Column.COLUMN_TYPE_ROWNUM.equals(col.getType())){%>
										<s:property value="#docStatus.index + 1"/>						
									<%} else { %>
										<%=result%>
									<%} %>
								</s:if>
								<s:else>
									<a onClick="ev_selectone('<%=doc.getId().replace("&", "_")%>', '<%=StringUtil.encodeHTML((String)result)%>','<%=selectOne%>');">
									<%=result%> </a>
								</s:else>
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
							}
						%>
						<!-- 是否允许查看记录 -->
						<s:if test="#parameters.allow[0] == 'true'">
							<td class="listDataTrTd"><input type="image" name='btnView'
								src="<s:url value="/resource/imgnew/act/act_1.gif"/>"
								onclick="viewDoc('<s:property value="id" />','<s:property value="formid" />','<%=type%>')" />
							</td>
						</s:if>
					</tr>
				</s:iterator>
	
				<!-- 字段值汇总 视图选择框不显示-->
				<!--<s:if test="content.sum">
					<tr class="table-tr"
						onMouseOver="this.className='table-tr-onchange';"
						onMouseOut="this.className='table-tr';">
						<td class="table-td">&nbsp;</td>
						<s:iterator value="content.columns" status="rowStatus">
							<td class="column-td"><s:property
								value="getSumByDatas(datas, #request.htmlBean.runner, #session.FRONT_USER)" />&nbsp;
							</td>
						</s:iterator>
					</tr>
				</s:if>
				--></tbody>
			</table>
			</div>
		</div>
		</div>
	</s:form>
	</body>
	<%-- <script src='<s:url value="/portal/share/component/dateField/datePicker/WdatePicker.js"/>'></script> --%>

</o:MultiLanguage>
</html>